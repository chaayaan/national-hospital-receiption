<?php
require 'auth.php'; require 'mydb.php';

/* ---------- cancel an appointment ---------- */
if ($_SERVER['REQUEST_METHOD'] === 'POST' && isset($_POST['cancel'])) {
    $id = (int)$_POST['cancel'];
    mysqli_query($conn, "UPDATE appointments SET status='cancelled', cancelled_at=NOW(), cancelled_by=" . (int)$_SESSION['user_id'] . " WHERE id=$id AND status='confirmed'");
    header('Location: ' . $_SERVER['REQUEST_URI']); exit;
}

/* ---------- AJAX: data for the PDF (confirmed appointments of one doctor on one date) ---------- */
if (isset($_GET['ajax'])) {
    $d  = (int)($_GET['doctor'] ?? 0);
    $dt = $_GET['date'] ?? '';
    if (!preg_match('/^\d{4}-\d{2}-\d{2}$/', $dt)) $dt = date('Y-m-d');
    $doc = mysqli_fetch_assoc(mysqli_query($conn, "SELECT name, details FROM doctors WHERE id=$d"));
    $rows = [];
    $q = mysqli_query($conn, "SELECT serial_no, patient_name, patient_mobile, patient_gender, patient_age FROM appointments WHERE doctor_id=$d AND appointment_date='$dt' AND status='confirmed' ORDER BY serial_no");
    while ($r = mysqli_fetch_assoc($q)) $rows[] = $r;
    header('Content-Type: application/json');
    echo json_encode(['name' => $doc['name'] ?? '', 'details' => $doc['details'] ?? '', 'date' => date('d/m/Y', strtotime($dt)), 'rows' => $rows]);
    exit;
}

/* ---------- filters ---------- */
$date = $_GET['date'] ?? date('Y-m-d');
$all  = ($date === '' || $date === 'all');
if (!$all && !preg_match('/^\d{4}-\d{2}-\d{2}$/', $date)) { $date = date('Y-m-d'); }
$status = (($_GET['status'] ?? 'confirmed') === 'cancelled') ? 'cancelled' : 'confirmed';
$doc  = (int)($_GET['doctor'] ?? 0);
$view = (int)($_GET['view'] ?? 0);
$canPdf = (!$all && $status === 'confirmed');
function qs($x) { return http_build_query(array_merge($_GET, $x)); }

if ($view) {
    /* ---------- VIEW MORE: patients of one doctor ---------- */
    $vd = mysqli_fetch_assoc(mysqli_query($conn, "SELECT id,name FROM doctors WHERE id=$view"));
    $w2 = "a.status='$status'" . ($all ? '' : " AND a.appointment_date='$date'") . " AND a.doctor_id=$view";
    $patients = mysqli_query($conn, "SELECT a.* FROM appointments a WHERE $w2 ORDER BY a.appointment_date, a.serial_no");
    $title = 'Appointment List'; $active = 'appointment'; $crumb = 'DataTables';
    include 'navbar.php';
?>
<div class="card"><div class="card-body">
  <div class="d-flex justify-content-between align-items-start mb-3">
    <div class="pl-2">
      <div>Doctor Name : <b><?= htmlspecialchars($vd['name'] ?? '') ?></b></div>
      <div>Appointment Date : <b><?= $all ? 'All' : date('d/m/Y', strtotime($date)) ?></b></div>
    </div>
    <?php if ($canPdf): ?><button type="button" class="btn btn-primary" onclick="nchPdf(<?= $view ?>,'<?= $date ?>')">Download Pdf</button><?php endif; ?>
  </div>
  <table class="table table-bordered mb-0">
    <thead><tr><th>#SL</th><th>Serial Number</th><th>Appointment Date &amp; Time</th><th>Patient Name</th><th>Patient Mobile</th><th>Patient Age</th><th>Patient Gender</th><?php if ($status === 'confirmed'): ?><th>Action</th><?php endif; ?></tr></thead>
    <tbody>
    <?php $i = 1; while ($p = mysqli_fetch_assoc($patients)): ?>
      <tr>
        <td><?= $i++ ?></td><td><?= $p['serial_no'] ?></td>
        <td><?= date('d/m/Y', strtotime($p['appointment_date'])) ?> | <?= date('h:i A', strtotime($p['time_slot'])) ?></td>
        <td><?= htmlspecialchars($p['patient_name']) ?></td><td><?= htmlspecialchars($p['patient_mobile']) ?></td>
        <td><?= $p['patient_age'] ?></td><td><?= $p['patient_gender'] ?></td>
        <?php if ($status === 'confirmed'): ?><td>
          <form method="post" onsubmit="return confirm('Cancel this appointment?')"><button name="cancel" value="<?= $p['id'] ?>" class="btn btn-sm btn-danger">Cancel</button></form>
        </td><?php endif; ?>
      </tr>
    <?php endwhile; ?>
    </tbody>
    <tfoot><tr><th>#SL</th><th>Serial Number</th><th>Appointment Date &amp; Time</th><th>Patient Name</th><th>Patient Mobile</th><th>Patient Age</th><th>Patient Gender</th><?php if ($status === 'confirmed'): ?><th>Action</th><?php endif; ?></tr></tfoot>
  </table>
</div></div>
<?php
} else {
    /* ---------- LIST: doctors with total appointments ---------- */
    $where = "a.status='$status'" . ($all ? '' : " AND a.appointment_date='$date'") . ($doc ? " AND d.id=$doc" : '');
    $rows = mysqli_query($conn, "SELECT d.id,d.name,d.bmdc,COUNT(*) total FROM appointments a JOIN doctors d ON d.id=a.doctor_id WHERE $where GROUP BY d.id,d.name,d.bmdc ORDER BY d.name");
    $docs = mysqli_query($conn, "SELECT id,name FROM doctors ORDER BY name");
    $title = 'Appointments'; $active = 'appointment'; $crumb = 'DataTables';
    include 'navbar.php';
?>
<div class="card"><div class="card-body">
  <form method="get" class="row align-items-center mb-3">
    <input type="hidden" name="status" value="<?= $status ?>">
    <div class="col-md-4"><div class="input-group">
      <input type="date" name="date" value="<?= $all ? '' : $date ?>" class="form-control" onchange="this.form.submit()">
      <div class="input-group-append"><span class="input-group-text"><i class="fas fa-calendar-alt"></i></span></div>
    </div></div>
    <div class="col-md-5">
      <select name="doctor" class="form-control select2" onchange="this.form.submit()">
        <option value="0">Select Doctor</option>
        <?php while ($d = mysqli_fetch_assoc($docs)): ?>
          <option value="<?= $d['id'] ?>" <?= $doc == $d['id'] ? 'selected' : '' ?>><?= htmlspecialchars($d['name']) ?></option>
        <?php endwhile; ?>
      </select>
    </div>
    <div class="col-md-3 text-right"><a href="make_appointment.php" class="btn btn-primary">Make Appointment</a></div>
  </form>
  <hr>
  <table class="table table-bordered table-hover mb-0">
    <thead><tr><th>#SL</th><th>Doctor Name</th><th>Doctor BMDC</th><th>Total Appointments</th><th>Action</th></tr></thead>
    <tbody>
    <?php $i = 1; while ($r = mysqli_fetch_assoc($rows)): ?>
      <tr>
        <td><?= $i++ ?></td><td><?= htmlspecialchars($r['name']) ?></td><td><?= htmlspecialchars($r['bmdc']) ?></td><td><?= $r['total'] ?></td>
        <td><div class="dropdown"><a href="#" data-toggle="dropdown" class="text-dark px-3"><i class="fas fa-ellipsis-v"></i></a>
          <div class="dropdown-menu dropdown-menu-right">
            <?php if ($canPdf): ?><a class="dropdown-item" href="#" onclick="nchPdf(<?= $r['id'] ?>,'<?= $date ?>');return false;">Download</a><?php endif; ?>
            <a class="dropdown-item" href="?<?= qs(['view' => $r['id']]) ?>">View More</a>
          </div></div></td>
      </tr>
    <?php endwhile; ?>
    </tbody>
    <tfoot><tr><th>#SL</th><th>Doctor Name</th><th>Doctor BMDC</th><th>Total Appointments</th><th>Action</th></tr></tfoot>
  </table>
</div></div>
<?php } ?>
<?php
nch_footer(<<<'JS'
<script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf/2.5.1/jspdf.umd.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf-autotable/3.5.31/jspdf.plugin.autotable.min.js"></script>
<script>
function nchPdf(doctor, date) {
  $.getJSON('appointment_list.php', {ajax: 1, doctor: doctor, date: date}, function (r) {
    if (!r.rows.length) { alert('No appointments found for this doctor on this date.'); return; }
    var by = {}, max = 0;
    r.rows.forEach(function (x) { by[x.serial_no] = x; max = Math.max(max, +x.serial_no); });
    var body = [];
    for (var i = 1; i <= max; i++) {           // blank rows for serials with no confirmed patient
      var x = by[i];
      body.push([i, x ? x.patient_name : '', x ? x.patient_mobile : '', x ? x.patient_gender : '', x ? x.patient_age : '', x ? x.serial_no : '', '']);
    }
    var doc = new window.jspdf.jsPDF({unit: 'pt', format: 'a4'});
    var W = doc.internal.pageSize.getWidth();
    doc.setFillColor(10, 138, 58); doc.roundedRect(40, 26, 36, 28, 3, 3, 'F');       // logo
    doc.setTextColor(255); doc.setFont('helvetica', 'bold'); doc.setFontSize(10); doc.text('NCH', 58, 44, {align: 'center'});
    doc.setTextColor(0); doc.setFontSize(13); doc.text('National Hospital Chattogram & Sigma Lab Ltd.', W / 2, 45, {align: 'center'});
    doc.setFontSize(10);
    var dl = doc.splitTextToSize('Doctor: ' + r.name + (r.details ? ' (' + r.details + ')' : ''), W - 80);
    doc.text(dl, 40, 78);
    var y = 78 + dl.length * 12 + 10;
    doc.setFont('helvetica', 'normal'); doc.setTextColor(120, 53, 0);
    doc.text('Online Appointments (Website/Mobile App) Date : ' + r.date, 40, y);
    doc.autoTable({
      startY: y + 10, theme: 'grid',
      head: [['SL', 'Patient Name', 'Patient Mobile', 'Gender', 'Age', 'Serial No', 'Remarks']], body: body,
      styles: {fontSize: 8.5, cellPadding: 4, minCellHeight: 18, textColor: 0, lineColor: [200, 200, 200], lineWidth: 0.5},
      headStyles: {fillColor: [240, 240, 240], textColor: 0, fontStyle: 'bold'},
      columnStyles: {0: {cellWidth: 30}, 1: {cellWidth: 130}, 2: {cellWidth: 90}, 3: {cellWidth: 50}, 4: {cellWidth: 35}, 5: {cellWidth: 55}},
      margin: {left: 40, right: 40}
    });
    doc.save('appointments_' + r.name.replace(/[^a-z0-9]+/gi, '_') + '_' + date + '.pdf');
  }).fail(function () { alert('Could not generate the PDF. Please try again.'); });
}
</script>
JS);
?>