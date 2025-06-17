<!DOCTYPE html>
<html>
<body>



<p>Q1: The pace of this course</p><form method="post" action="/~eetaylor/quiz.php" >
  <input type="radio" name="Q1" value="A">
  <label for="A1">A: is too slow</label><br>
  <input type="radio" name="Q1" value="B">
  <label for="B1">B: is just right</label><br>
  <input type="radio" name="Q1" value="C">
  <label for="C1">C: is too fast</label><br>
  <input type="radio" name="Q1" value="D">
  <label for="D1">D: I don't know</label><br><br>

<p>Q2: The feedback from homework assignment grading</p>
  <input type="radio" name="Q2" value="A">
  <label for="A2">A: too few</label><br>
  <input type="radio" name="Q2" value="B">
  <label for="B2">B: sufficient</label><br>
  <input type="radio" name="Q2" value="C">
  <label for="C2">C: I don't know</label><br><br>

<p>Q3: Anything you like about the teaching of this course?</p>
  <textarea name="Q3" rows="10" cols="30"></textarea><br>
  <input type="submit" name="submit" value="Submit">
</form> 

</body>
</html>

<?php

if (isset ($_POST["submit"])) {
	echo "Your answers are: <br>";
	foreach (array_keys($_POST) as $x) {
		if ($x!='submit')
			echo $x .":". $_POST[$x]. "<br>";
	}
	return;
}
?>