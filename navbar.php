<?php
// Usage: set $title, $active ('dashboard' | 'appointment'), $crumb before include 'navbar.php';
$title  = $title  ?? 'Dashboard';
$active = $active ?? 'dashboard';
$crumb  = $crumb  ?? '';

function nch_footer($js = '') { ?>
</div></section></div>
<footer class="main-footer">
  <div class="float-right d-none d-sm-block"><b>Version</b> 1.0.0</div>
  <strong>Copyright &copy; National Hospital.</strong> All rights reserved.<br>
  Developed By <strong>Authentic Four Technology.</strong>
</footer>
</div>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/4.6.2/js/bootstrap.bundle.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/admin-lte/3.2.0/js/adminlte.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.13/js/select2.min.js"></script>
<script>$('.select2').select2({theme:'bootstrap4',width:'100%'});</script>
<?= $js ?>
</body></html>
<?php } ?>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8"><meta name="viewport" content="width=device-width, initial-scale=1">
<title><?= htmlspecialchars($title) ?> - National Hospital</title>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/admin-lte/3.2.0/css/adminlte.min.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.13/css/select2.min.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/select2-bootstrap4-theme/1.0.0/select2-bootstrap4.min.css">
<style>
.main-sidebar{background:#000!important}
.brand-link{border-bottom:1px solid #4b545c!important}
.brand-logo{width:34px;height:34px;border-radius:50%;background:#fff;color:#0a8a3a;font-weight:800;font-size:11px;display:inline-flex;align-items:center;justify-content:center;margin-right:8px}
.sidebar .nav-link:not(.active):hover{background:#1c1c1c!important}
.content-wrapper{background:#f4f6f9}
.slot-btn{margin:0 6px 8px 0}
</style>
</head>
<body class="hold-transition sidebar-mini">
<div class="wrapper">

<nav class="main-header navbar navbar-expand navbar-white navbar-light">
  <ul class="navbar-nav">
    <li class="nav-item"><a class="nav-link" data-widget="pushmenu" href="#"><i class="fas fa-bars"></i></a></li>
    <li class="nav-item d-none d-sm-inline-block"><a href="dashboard.php" class="nav-link">Home</a></li>
    <li class="nav-item d-none d-sm-inline-block"><a href="#" class="nav-link">Contact</a></li>
  </ul>
  <ul class="navbar-nav ml-auto">
    <li class="nav-item"><a class="nav-link" href="#"><i class="fas fa-search"></i></a></li>
    <li class="nav-item"><a class="nav-link" href="#"><i class="far fa-comments"></i><span class="badge badge-danger navbar-badge">3</span></a></li>
    <li class="nav-item"><a class="nav-link" href="#"><i class="far fa-bell"></i><span class="badge badge-warning navbar-badge">15</span></a></li>
    <li class="nav-item"><a class="nav-link" data-widget="fullscreen" href="#"><i class="fas fa-expand-arrows-alt"></i></a></li>
    <li class="nav-item"><a class="nav-link" href="#"><i class="fas fa-th-large"></i></a></li>
    <li class="nav-item"><a class="nav-link" href="index.php?logout=1" title="Logout"><i class="fas fa-sign-out-alt"></i></a></li>
  </ul>
</nav>

<aside class="main-sidebar elevation-4">
  <a href="dashboard.php" class="brand-link"><span class="brand-logo">NCH</span><span class="brand-text">National Hospital</span></a>
  <div class="sidebar"><nav class="mt-2">
    <ul class="nav nav-pills nav-sidebar flex-column" data-widget="treeview" role="menu">
      <li class="nav-item">
        <a href="dashboard.php" class="nav-link <?= $active === 'dashboard' ? 'active' : '' ?>">
          <i class="nav-icon fas fa-tachometer-alt"></i><p>Dashboard <i class="right fas fa-angle-down"></i></p>
        </a>
      </li>
      <li class="nav-item <?= $active === 'appointment' ? 'menu-open' : '' ?>">
        <a href="#" class="nav-link <?= $active === 'appointment' ? 'active' : '' ?>">
          <i class="nav-icon fas fa-calendar-check"></i><p>Appointment <i class="right fas fa-angle-left"></i></p>
        </a>
        <ul class="nav nav-treeview">
          <li class="nav-item"><a href="appointment_list.php" class="nav-link"><i class="far fa-circle nav-icon"></i><p>Appointment List</p></a></li>
          <li class="nav-item"><a href="all_appointment.php" class="nav-link"><i class="far fa-circle nav-icon"></i><p>All Appointment</p></a></li>
          <li class="nav-item"><a href="make_appointment.php" class="nav-link"><i class="far fa-circle nav-icon"></i><p>Make Appointment</p></a></li>
          <!-- <li class="nav-item"><a href="doctor_schedule.php" class="nav-link"><i class="far fa-circle nav-icon"></i><p>Doctor Schedule</p></a></li> -->
        </ul>
      </li>
    </ul>
  </nav></div>
</aside>

<div class="content-wrapper">
  <div class="content-header"><div class="container-fluid"><div class="row mb-2">
    <div class="col-sm-6"><h1 class="m-0"><?= htmlspecialchars($title) ?></h1></div>
    <div class="col-sm-6"><ol class="breadcrumb float-sm-right">
      <li class="breadcrumb-item"><a href="dashboard.php">Home</a></li>
      <li class="breadcrumb-item active"><?= htmlspecialchars($crumb) ?></li>
    </ol></div>
  </div></div></div>
  <section class="content"><div class="container-fluid">
