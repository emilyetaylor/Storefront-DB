<?php
session_start();

if (!isset($_SESSION['username'])) {
 header("LOCATION:login.php");
}
?>

<style>
table, th, td {
	border: 1px solid black;
	border-collapse: collapse;
}
</style>

<?php
require "db.php";
if (isset($_POST["Accounts"])) {
 $accounts = get_accounts($_SESSION["username"]);
?>

 <table>
 <tr>
 <th>Account</th>
 <th>Balance</th>
 </tr>


 <?php
 foreach ($accounts as $row) {
 	echo "<tr>";
 	echo "<td>" . $row[0] . "</td>";
 	echo "<td>" . $row[1] . "</td>";
 	echo "</tr>";
 }
 echo "<table>";
	
}
?>


<?php
if (isset($_POST["Transfer"])){
?>

<form method="post" action="bankoperation.php">
  <label for="from_account">From account: </label>
  <input type="text" id="from_account" name="from_account" value=""><br>
  <label for="to_account">To account: </label>
  <input type="text" id="to_account" name="to_account" value=""><br>
  <label for="amount">Amount: </label>
  <input type="text" id="amount" name="amount" value=""><br>
  <button type="submit" name="Confirm" value="Confirm">Confirm</button>
</form>

<?php
}
print_r($_POST);
if (isset($_POST["Confirm"])) {
	$from = $_POST["from_account"];
	$to = $_POST["to_account"];
	$amount = $_POST["amount"];
	$user = $_SESSION["username"];
	$result = transfer($from, $to, $amount, $user);
	echo $result;
}

?>


