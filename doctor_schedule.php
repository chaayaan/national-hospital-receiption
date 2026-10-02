<?php
require 'auth.php'; require 'mydb.php';
$days = ['Sunday','Monday','Tuesday','Wednesday','Thursday','Friday','Saturday'];
$sessions = ['Morning','Afternoon','Evening'];
$doc = (int)($_GET['doctor'] ?? 0);

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $act = $_POST['action'] ?? ''; $d = (int)($_POST['doctor_id'] ?? 0);
    if ($act === 'add') {
        $start = $_POST['start_time'] ?? ''; $end = $_POST['end_time'] ?? '';
        $slot = (int)($_POST['slot_minutes'] ?? 0); $sess = $_POST['session_name'] ?? '';
        $sel = array_filter(array_map('intval', $_POST['days'] ?? []), function ($x) { return $x >= 0 && $x <= 6; });
        if ($d && $sel && preg_match('/^\d{2}:\d{2}$/', $start) && preg_match('/^\d{2}:\d{2}$/', $end)
            && $end > $start && $slot >= 5 && $slot <= 120 && in_array($sess, $sessions)) {
            $start .= ':00'; $end .= ':00';
            $st = mysqli_prepare($conn, "INSERT IGNORE INTO doctor_schedules (doctor_id,day_of_week,session_name,start_time,end_time,slot_minutes) VALUES (?,?,?,?,?,?)");
            foreach ($sel as $dw) { mysqli_stmt_bind_param($st, 'iisssi', $d, $dw, $sess, $start, $end, $slot); mysqli_stmt_execute($st); }
            $_SESSION['flash'] = ['success', 'Schedule added.'];
        } else { $_SESSION['flash'] = ['danger', 'Please select day(s) and enter a valid time range and slot length.']; }
    } elseif ($act === 'toggle') {
        mysqli_query($conn, "UPDATE doctor_schedules SET is_active = 1 - is_active WHERE id=" . (int)$_POST['id']);
    } elseif ($act === 'delete') {
        mysqli_query($conn, "DELETE FROM doctor_schedules WHERE id=" . (int)$_POST['id']);
    } elseif ($act === 'doctor_status') {
        mysqli_query($conn, "UPDATE doctors SET status = 1 - status WHERE id=$d");
    }
    header('Location: doctor_schedule.php' . ($d ? "?doctor=$d" : '')); exit;
}

$flash = $_SESSION['flash'] ?? null; unset($_SESSION['flash']);
$docs = mysqli_query($conn, "SELECT id,name,status FROM doctors ORDER BY name");
$cur = $doc ? mysqli_fetch_assoc(mysqli_query($conn, "SELECT * FROM doctors WHERE id=$doc")) : null;
$title = 'Doctor Schedule'; $active = 'appointment'; $crumb = 'Schedule';
include 'navbar.php';
?>
<?php if ($flash): ?><div class="alert alert-<?= $flash[0] ?>"><?= $flash[1] ?></div><?php endif; ?>
<div class="card"><div class="card-body">
  <form method="get" class="row align-items-center">
    <div class="col-md-8">
      <select name="doctor" class="form-control" onchange="this.form.submit()">
        <option value="0">Select Doctor to manage schedule</option>
        <?php while ($d = mysqli_fetch_assoc($docs)): ?>
          <option value="<?= $d['id'] ?>" <?= $doc == $d['id'] ? 'selected' : '' ?>><?= htmlspecialchars($d['name']) ?><?= $d['status'] ? '' : ' [Inactive]' ?></option>
        <?php endwhile; ?>
      </select>
    </div>
  </form>
</div></div>

<?php if ($cur): ?>
<div class="card card-primary">
  <div class="card-header d-flex align-items-center">
    <h3 class="card-title"><?= htmlspecialchars($cur['name']) ?></h3>
    <form method="post" class="ml-auto">
      <input type="hidden" name="action" value="doctor_status"><input type="hidden" name="doctor_id" value="<?= $doc ?>">
      <button class="btn btn-sm bg-white text-dark"><?= $cur['status'] ? 'Active - click to deactivate' : 'Inactive - click to activate' ?></button>
    </form>
  </div>
  <form method="post">
    <input type="hidden" name="action" value="add"><input type="hidden" name="doctor_id" value="<?= $doc ?>">
    <div class="card-body">
      <label>Days</label><div class="mb-3">
        <?php foreach ($days as $i => $n): ?>
          <div class="custom-control custom-checkbox custom-control-inline">
            <input type="checkbox" class="custom-control-input" id="d<?= $i ?>" name="days[]" value="<?= $i ?>">
            <label class="custom-control-label" for="d<?= $i ?>"><?= $n ?></label>
          </div>
        <?php endforeach; ?>
      </div>
      <div class="row">
        <div class="form-group col-md-3"><label>Session</label>
          <select name="session_name" class="form-control"><?php foreach ($sessions as $s) echo "<option>$s</option>"; ?></select></div>
        <div class="form-group col-md-3"><label>Start Time</label><input type="time" name="start_time" class="form-control" required></div>
        <div class="form-group col-md-3"><label>End Time</label><input type="time" name="end_time" class="form-control" required></div>
        <div class="form-group col-md-3"><label>Slot (minutes)</label><input type="number" name="slot_minutes" class="form-control" value="20" min="5" max="120" required></div>
      </div>
    </div>
    <div class="card-footer"><button class="btn btn-primary">Add Schedule</button></div>
  </form>
</div>

<div class="card"><div class="card-body table-responsive p-0">
  <table class="table table-bordered mb-0">
    <thead><tr><th>Day</th><th>Session</th><th>Time</th><th>Slot</th><th>Status</th><th>Action</th></tr></thead>
    <tbody>
    <?php $q = mysqli_query($conn, "SELECT * FROM doctor_schedules WHERE doctor_id=$doc ORDER BY day_of_week, start_time");
    if (!mysqli_num_rows($q)) echo '<tr><td colspan="6" class="text-center text-muted">No schedule added yet.</td></tr>';
    while ($s = mysqli_fetch_assoc($q)): ?>
      <tr>
        <td><?= $days[$s['day_of_week']] ?></td><td><?= $s['session_name'] ?></td>
        <td><?= date('g:i A', strtotime($s['start_time'])) ?> - <?= date('g:i A', strtotime($s['end_time'])) ?></td>
        <td><?= $s['slot_minutes'] ?> min</td>
        <td><span class="badge badge-<?= $s['is_active'] ? 'success' : 'secondary' ?>"><?= $s['is_active'] ? 'Active' : 'Off' ?></span></td>
        <td>
          <form method="post" class="d-inline"><input type="hidden" name="doctor_id" value="<?= $doc ?>"><input type="hidden" name="id" value="<?= $s['id'] ?>">
            <button name="action" value="toggle" class="btn btn-sm btn-warning"><?= $s['is_active'] ? 'Turn off' : 'Turn on' ?></button>
            <button name="action" value="delete" class="btn btn-sm btn-danger" onclick="return confirm('Delete this schedule?')">Delete</button>
          </form>
        </td>
      </tr>
    <?php endwhile; ?>
    </tbody>
  </table>
</div></div>

<?php else: ?>
<div class="card"><div class="card-body table-responsive p-0">
  <table class="table table-bordered mb-0">
    <thead><tr><th>#SL</th><th>Doctor</th><th>Weekly Schedule</th><th>Action</th></tr></thead>
    <tbody>
    <?php $i = 1;
    $q = mysqli_query($conn, "SELECT d.id,d.name,d.status,
      GROUP_CONCAT(CONCAT(ELT(s.day_of_week+1,'Sun','Mon','Tue','Wed','Thu','Fri','Sat'),' ',TIME_FORMAT(s.start_time,'%l:%i %p'),'-',TIME_FORMAT(s.end_time,'%l:%i %p'))
        ORDER BY s.day_of_week, s.start_time SEPARATOR ', ') sched
      FROM doctors d LEFT JOIN doctor_schedules s ON s.doctor_id=d.id AND s.is_active=1
      GROUP BY d.id,d.name,d.status ORDER BY d.name");
    while ($r = mysqli_fetch_assoc($q)): ?>
      <tr class="<?= $r['status'] ? '' : 'text-muted' ?>">
        <td><?= $i++ ?></td><td><?= htmlspecialchars($r['name']) ?></td>
        <td><?= $r['sched'] ? htmlspecialchars($r['sched']) : '<span class="text-danger">No schedule</span>' ?></td>
        <td><a href="?doctor=<?= $r['id'] ?>" class="btn btn-sm btn-primary">Manage</a></td>
      </tr>
    <?php endwhile; ?>
    </tbody>
  </table>
</div></div>
<?php endif; ?>
<?php nch_footer(); ?>
