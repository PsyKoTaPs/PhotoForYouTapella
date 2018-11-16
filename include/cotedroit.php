 <h3>Navigate</h3>
                    <ul class="blocklist">
                        <li><a href="index.html">accueil</a></li>
                        <li><a href="examples.html">Exemples</a></li>
                        <li><a href="#">Produits</a></li>
                        <li><a href="#">Solutions</a></li>
                        <li><a href="#">Contact</a></li>
                    </ul>
 
 <?php 
 if(!isset($_SESSION['login']))
 {
 echo "
 <form action='index.php' method='post'>
Votre Pseudo : <input type='text' name='login'>
<br />
Votre mot de passe : <input type='password' name='pwd'><br />
<input type='submit' value='Connexion'>
</form>
";

}
 ?>
<?php
if(!isset($_SESSION['login']))
{


$tableau = $bdd->query('select * from utilisateur where Mail="'.$_POST['login'].'"');

$inscrire=$tableau->fetch(PDO::FETCH_ASSOC);
if ($inscrire['Mail'] == $_POST['login'] && $inscrire['Mdp'] == $_POST['pwd'])
{
	$_SESSION['login'] = $_POST['login'];
		$_SESSION['pwd'] = $_POST['pwd'];

		echo "Ca a marché";
		header("location:index.php"); 	

}
}
?>

