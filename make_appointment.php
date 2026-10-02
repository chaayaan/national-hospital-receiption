<?php
require 'auth.php'; require 'mydb.php';

function slots_for($conn, $doc, $date) {
    $doc = (int)$doc; $dow = (int)date('w', strtotime($date));
    $taken = [];
    $t = mysqli_query($conn, "SELECT time_slot FROM appointments WHERE doctor_id=$doc AND appointment_date='$date' AND status='confirmed'");
    while ($x = mysqli_fetch_row($t)) $taken[] = $x[0];
    $out = [];
    $r = mysqli_query($conn, "SELECT * FROM doctor_schedules WHERE doctor_id=$doc AND day_of_week=$dow AND is_active=1 ORDER BY start_time");
    while ($s = mysqli_fetch_assoc($r)) {
        $step = $s['slot_minutes'] * 60;
        for ($i = strtotime($s['start_time']); $i + $step <= strtotime($s['end_time']); $i += $step) {
            $k = date('H:i:s', $i);
            $out[] = ['v' => $k, 'taken' => in_array($k, $taken)];
        }
    }
    return $out;
}

$today = date('Y-m-d');

// AJAX: availability + schedule for the selected doctor (today)
if (isset($_GET['ajax'])) {
    $doc = (int)$_GET['doctor']; $dow = (int)date('w');
    $d = mysqli_fetch_assoc(mysqli_query($conn, "SELECT name FROM doctors WHERE id=$doc AND status=1"));
    $name = htmlspecialchars($d['name'] ?? '');
    $times = [];
    $q = mysqli_query($conn, "SELECT start_time,end_time FROM doctor_schedules WHERE doctor_id=$doc AND day_of_week=$dow AND is_active=1 ORDER BY start_time");
    while ($r = mysqli_fetch_assoc($q))
        $times[] = date('g:i A', strtotime($r['start_time'])) . ' - ' . date('g:i A', strtotime($r['end_time']));
    $free = count(array_filter(slots_for($conn, $doc, $today), function ($s) { return !$s['taken']; }));
    if (!$times)      { $ok = false; $msg = "$name is not available today"; }
    elseif (!$free)   { $ok = false; $msg = "$name is fully booked today"; }
    else              { $ok = true;  $msg = "$name is available for the appointment"; }
    header('Content-Type: application/json');
    echo json_encode(['ok' => $ok, 'msg' => $msg, 'schedule' => implode(', ', $times)]);
    exit;
}

$flash = $_SESSION['flash'] ?? null; unset($_SESSION['flash']);
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $doc = (int)$_POST['doctor_id'];
    $name = trim($_POST['patient_name']); $mob = trim($_POST['patient_mobile']);
    $gen = $_POST['patient_gender']; $age = (int)$_POST['patient_age'];
    $isDoc = mysqli_fetch_row(mysqli_query($conn, "SELECT COUNT(*) FROM doctors WHERE id=$doc AND status=1"))[0];
    $valid = $isDoc && $name && $mob && in_array($gen, ['Male','Female','Other']) && $age > 0;
    $done = false; $slot = null; $serial = 0; $uid = (int)$_SESSION['user_id'];
    if ($valid) {
        $st = mysqli_prepare($conn, "INSERT INTO appointments (doctor_id,serial_no,patient_name,patient_mobile,patient_gender,patient_age,appointment_date,time_slot,status,created_by) VALUES (?,?,?,?,?,?,?,?,'confirmed',?)");
        for ($try = 0; $try < 3 && !$done; $try++) {            // retry if someone grabbed the slot first
            $slot = null;
            foreach (slots_for($conn, $doc, $today) as $s) if (!$s['taken']) { $slot = $s['v']; break; }
            if (!$slot) break;
            $serial = (int)mysqli_fetch_row(mysqli_query($conn, "SELECT COALESCE(MAX(serial_no),0)+1 FROM appointments WHERE doctor_id=$doc AND appointment_date='$today'"))[0];
            mysqli_stmt_bind_param($st, 'iisssissi', $doc, $serial, $name, $mob, $gen, $age, $today, $slot, $uid);
            try { $done = mysqli_stmt_execute($st); } catch (mysqli_sql_exception $e) { $done = false; }
        }
    }
    $_SESSION['flash'] = $done
        ? ['success', 'Appointment created. Serial No: ' . $serial . ', Time: ' . date('g:i A', strtotime($slot))]
        : ['danger', 'Invalid data or the doctor is not available today.'];
    header('Location: make_appointment.php'); exit;
}

$docs = mysqli_query($conn, "SELECT id,name,details FROM doctors WHERE status=1 ORDER BY name");
$title = 'Appointment'; $active = 'appointment'; $crumb = 'Validation';
include 'navbar.php';
?>
<style>
#doctor{-webkit-appearance:none;-moz-appearance:none;appearance:none;padding-right:32px;
background:#fff url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='10' height='6'%3E%3Cpath d='M0 0h10L5 6z' fill='%23444'/%3E%3C/svg%3E") no-repeat right 12px center}
#avail.ok{color:green}#avail.no{color:#dc3545}
</style>
<?php if ($flash): ?><div class="alert alert-<?= $flash[0] ?>"><?= $flash[1] ?></div><?php endif; ?>
<div class="card card-primary">
  <div class="card-header d-flex justify-content-between align-items-center">
    <h3 class="card-title">Create Appointment</h3>
    <a href="appointment_list.php" class="btn bg-white text-dark ml-auto">Appointments List</a>
  </div>
  <form method="post" id="apptForm">
    <div class="card-body">
      <div class="row">
        <div class="form-group col-md-6"><label>Doctor Name</label>
          <select name="doctor_id" id="doctor" class="form-control" required>
            <option value="">Select Doctor</option>
            <?php while ($d = mysqli_fetch_assoc($docs)): ?>
              <option value="<?= $d['id'] ?>"><?= htmlspecialchars($d['name'] . ($d['details'] ? ' (' . $d['details'] . ')' : '')) ?></option>
            <?php endwhile; ?>
          </select></div>
        <div class="form-group col-md-6"><label>Appointment Date</label>
          <input type="text" class="form-control" value="<?= date('d/m/Y') ?>" readonly></div>
        <div class="form-group col-md-6"><label>Patient Name</label><input type="text" name="patient_name" class="form-control" required></div>
        <div class="form-group col-md-6"><label>Patient Mobile</label><input type="text" name="patient_mobile" class="form-control" required></div>
        <div class="form-group col-md-6"><label>Patient Gender</label>
          <select name="patient_gender" class="form-control" required>
            <option value="">Select</option><option>Male</option><option>Female</option><option>Other</option>
          </select></div>
        <div class="form-group col-md-6"><label>Patient Age</label><input type="number" name="patient_age" min="0" max="120" class="form-control" required></div>
      </div>
      <div class="form-group"><label>Doctor Availability</label><div id="avail"></div></div>
      <div class="form-group mb-0"><label>Doctor Appointment Time Schedule</label><div id="sched"></div></div>
    </div>
    <div class="card-footer"><button type="submit" id="createBtn" class="btn btn-primary" disabled>Create</button></div>
  </form>
</div>
<?php
nch_footer(<<<'JS'
<script>
$('#doctor').on('change', function () {
  $('#avail,#sched').empty().removeClass('ok no'); $('#createBtn').prop('disabled', true);
  if (!this.value) return;
  $.getJSON('make_appointment.php', {ajax: 1, doctor: this.value}, function (r) {
    $('#avail').addClass(r.ok ? 'ok' : 'no').html(r.msg);
    $('#sched').text(r.schedule);
    $('#createBtn').prop('disabled', !r.ok);
  });
});
</script>
JS);
?>
