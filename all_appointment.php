<?php
require 'auth.php'; require 'mydb.php';
$date = $_GET['date'] ?? date('Y-m-d');
if (!preg_match('/^\d{4}-\d{2}-\d{2}$/', $date)) $date = date('Y-m-d');
function cnt($conn, $w) { return mysqli_fetch_row(mysqli_query($conn, "SELECT COUNT(*) FROM appointments WHERE $w"))[0]; }
$confirmed = cnt($conn, "status='confirmed'");
$cancel    = cnt($conn, "status='cancelled'");
$filtered  = cnt($conn, "status='confirmed' AND appointment_date='$date'");
$title = 'Appointments Analytics'; $active = 'appointment'; $crumb = 'Dashboard v3';
include 'navbar.php';
?>
<div class="row">
  <div class="col-lg-3 col-6">
    <div class="small-box bg-info">
      <div class="inner"><h3><?= $confirmed ?></h3><p>Confirmed</p></div>
      <div class="icon"><i class="fas fa-user-plus"></i></div>
      <a href="appointment_list.php?date=&status=confirmed" class="small-box-footer">More info <i class="fas fa-arrow-circle-right"></i></a>
    </div>
  </div>
  <div class="col-lg-3 col-6">
    <div class="small-box bg-info mb-0">
      <div class="inner"><h3><?= $filtered ?></h3><p>Filter Appointment</p></div>
    </div>
    <form method="get" class="input-group bg-white" style="box-shadow:0 0 1px rgba(0,0,0,.125),0 1px 3px rgba(0,0,0,.2)">
      <input type="date" name="date" value="<?= $date ?>" class="form-control border-0" onchange="this.form.submit()">
      <div class="input-group-append"><span class="input-group-text border-0"><i class="fas fa-calendar-alt"></i></span></div>
    </form>
  </div>
  <div class="col-lg-3 col-6">
    <div class="small-box bg-danger">
      <div class="inner"><h3><?= $cancel ?></h3><p>Cancel</p></div>
      <div class="icon"><i class="fas fa-user-plus"></i></div>
      <a href="appointment_list.php?date=&status=cancelled" class="small-box-footer">More info <i class="fas fa-arrow-circle-right"></i></a>
    </div>
  </div>
</div>
<?php nch_footer(); ?>
