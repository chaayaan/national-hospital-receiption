<?php
if (session_status() === PHP_SESSION_NONE) { session_start(); }
$isLoginPage = basename($_SERVER['PHP_SELF']) === 'index.php';
if (!isset($_SESSION['user_id']) && !$isLoginPage) { header('Location: index.php'); exit; }
if (isset($_SESSION['user_id']) && $isLoginPage) { header('Location: dashboard.php'); exit; }
