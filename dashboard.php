<?php
require 'auth.php'; require 'mydb.php';
$total = mysqli_fetch_row(mysqli_query($conn, "SELECT COUNT(*) FROM appointments"))[0];
$title = 'Dashboard'; $active = 'dashboard'; $crumb = 'Dashboard v3';
include 'navbar.php';
?>
<div class="row">
  <div class="col-lg-3 col-6">
    <div class="small-box bg-info">
      <div class="inner"><h3><?= $total ?></h3><p>All Appointment</p></div>
      <div class="icon"><i class="fas fa-chart-bar"></i></div>
      <a href="all_appointment.php" class="small-box-footer">More info <i class="fas fa-arrow-circle-right"></i></a>
    </div>
  </div>
</div>
<?php nch_footer(); ?>
