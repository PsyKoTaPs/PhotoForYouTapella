<?php
session_start();
$titre="Connexion";

//Reception des données
$login = isset($_POST['Pseudo']) ? mysql_real_escape_string($_POST['Pseudo']) : '';
$pass= isset($_POST['Mdp']) ? mysql_real_escape_string($_POST['Mdp']) : '';
 
//Ecriture de la requete
$query = "SELECT * FROM utilisateur
WHERE login='$Pseudo'
AND
pass =PASSWORD('$Mdp')";
