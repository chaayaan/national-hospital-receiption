<?php
session_start();
if (isset($_GET['logout'])) { session_destroy(); header('Location: index.php'); exit; }
require 'auth.php';
require 'mydb.php';
$error = '';
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $email = trim($_POST['email'] ?? '');
    $stmt = mysqli_prepare($conn, "SELECT id, name, password FROM users WHERE email = ? LIMIT 1");
    mysqli_stmt_bind_param($stmt, 's', $email);
    mysqli_stmt_execute($stmt);
    $u = mysqli_fetch_assoc(mysqli_stmt_get_result($stmt));
    if ($u && password_verify($_POST['password'] ?? '', $u['password'])) {
        $_SESSION['user_id'] = $u['id'];
        $_SESSION['user_name'] = $u['name'];
        header('Location: dashboard.php'); exit;
    }
    $error = 'These credentials do not match our records.';
}
?>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8"><meta name="viewport" content="width=device-width, initial-scale=1">
<title>Login - National Hospital</title>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/4.6.2/css/bootstrap.min.css">
<style>
body{background:#f3f4f6;min-height:100vh;display:flex;align-items:center;justify-content:center;font-family:Figtree,system-ui,sans-serif}
.logo{width:100px;height:100px;background:#fff;display:flex;align-items:center;justify-content:center;margin:0 auto 20px;font-size:42px;font-weight:800;color:#0a8a3a}
.card-login{width:448px;max-width:94vw;border:0;border-radius:8px;box-shadow:0 1px 3px rgba(0,0,0,.15)}
.btn-dark{background:#1f2937;font-size:12px;font-weight:600;letter-spacing:1px;text-transform:uppercase}
</style>
</head>
<body>
<div>
  <div class="logo">NCH</div>
  <h5 class="text-center mb-4">National Hospital Chattogram &amp; Sigma Lab Ltd.</h5>
  <div class="card card-login"><div class="card-body p-4">
    <?php if ($error): ?><div class="alert alert-danger py-2"><?= htmlspecialchars($error) ?></div><?php endif; ?>
    <form method="post">
      <div class="form-group"><label>Email</label><input type="email" name="email" class="form-control" required autofocus></div>
      <div class="form-group"><label>Password</label><input type="password" name="password" class="form-control" required></div>
      <div class="text-right"><button class="btn btn-dark">Log in</button></div>
    </form>
  </div></div>
</div>
</body>
</html>
