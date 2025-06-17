<?php

function connectDB(){
	$config = parse_ini_file("/local/my_web_files/eetaylor/db.ini");
	$dbh = new PDO($config['dsn'], $config['username'], $config['password']);
	$dbh->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
	return $dbh;
}

// return number of rows matching the given user and password

function authenticate($user, $passwd){
	try{
		$dbh = connectDB();
		$statement = $dbh->prepare("SELECT count(*) FROM lab5_customer where username = :username and password = sha2(:passwd,256) ");
		$statement->bindParam(":username", $user);
		$statement->bindParam(":passwd", $passwd);
		$result = $statement->execute();
		$row=$statement->fetch();
		$dbh=null;
		
		return $row[0];
	}catch (PDOExecption $e) {
		print "Error!" . $e->getMessage() . "<br/>";
		die();
	}
}

function get_accounts($user){
	//connect to database
	// retrieve the data and display
	
	try {
		$dbh = connectDB();
		$statement = $dbh->prepare("SELECT account_no, balance, username FROM lab5_accounts where username = :username");
		$statement->bindParam(":username", $user);
		$statement->execute();
		
		return $statement->fetchAll();
		//$dbh = null;
		
	} catch (PDOException $e) {
		print "Error!" . $e->getMessage() . "<br/>";
		die();
	}
}

function transfer($from, $to, $amount, $user){
	print "entered into transfer() function";
	try{
		$dbh = connectDB();
		$dbh->beginTransaction();
	// check if there are enough balance in the from account
		$statement = $dbh->prepare("select balance from lab5_accounts where account_no=:from");
		$statement->bindParam(":from", $from);
		$result = $statement->execute();
		$row = $statement->fetch();
		if ($row) {
			$currentBalance = $row[0];
			if($currentBalance < $amount) {
				$dbh->rollBack();
				$dbh = null;
				return "Not enough balance in $from";
			}
		} else {
			$dbh->rollBack();
			$dbh = null;
			return "Account $from does not exist";
		}
		
		$statement = $dbh->prepare("update lab5_accounts set balance = balance - :amount where account_no=:from");
		$statement->bindParam(":amount", $amount);
		$statement->bindParam(":from", $from);
		$result = $statement->execute();
		$rowCount = $statement->rowCount();
		if ($rowCount != 1) {
			$dbh ->rollback();
			return "Something is not right because the total number of rows that will be affected is " . $rowCount;
		}
		
		$statement = $dbh->prepare("update lab5_accounts set balance = balance + :amount where account_no= :to");
		$statement->bindParam(":amount", $amount);
		$statement->bindParam(":to", $to);
		$result = $statement->execute();
		$rowCount = $statement->rowCount();
		if ($rowCount != 1) {
			$dbh->rollback();
			return "Something is not right because the total number of rows that will be affected is " . $rowCount;
		}
		
		$dbh->commit();
		return "Money has been transfered successfully";
	} catch (Exception $e) {
		$dbh->rollback();
		echo "Failed: " . $e->getMessage();
	}
}
