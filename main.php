<?php
session_start();

 if (!isset($_SESSION["username"])) {
 header("LOCATION:login.php");
 exit();
 } else {
 echo '<p align="right"> Welcome '. $_SESSION["username"].'</p>';
}
?>

<!DOCTYPE html>

<html>
<body>

<form method="post">
 <p align="right">
 <input type="submit" value="logout" name="logout">
<?php
if (isset($_POST["logout"])) {
 session_destroy();
 header("LOCATION:login.php");
 return;
}
?>
</p>
 </form>

<p>Welcome to our online minibank!</p><br>
<p>We can help you to transfer the money or display your accounts</p><br>
<p>What would you like to do? Please click one of the buttons</p><br>

<form method = "post" action="bankoperation.php">
  <button type="submit" name="Transfer" value="Transfer">Transfer</button>
  <button type="submit" name="Accounts" value="Accounts">Accounts</button>

</form> 

</body>
</html>