<?php
require "db.php";
session_start();
echo "<pre>";
  print_r($_POST);
  //print_r($_SESSION);
  echo "</pre>";
?>

<!DOCTYPE html>

<body>
<html>
<form method="post" action="<?php echo htmlentities($_SERVER['PHP_SELF']); ?>">
  <label for="username">Username: </label>
  <input type="text" id="username" name="username" value=""><br>
  <label for="password">Password:</label>
  <input type="text" id="password" name="password" value=""><br><br>
  <input type="submit" name="login">
</form> 

<?php
// user clicked the login button */
if ( isset($_POST["login"]) ) {
 //check the username and passwd, if correct, redirect to main.php page
 if (authenticate($_POST["username"], $_POST["password"]) ==1) {
 $_SESSION["username"]=$_POST["username"];
 header("LOCATION:main.php");
 return;
 }else {
 echo '<p style="color:red">incorrect username and password</p>';
 }
}
// user clicked logout button on main page
if (isset($_POST["logout"])) {
 session_destroy();
}
?>
</body>
</html>