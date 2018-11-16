<?php 
include'include/connect.php';
$prenom=$_POST['prenom'];
$nom=$_POST['nom'];
$type=$_POST['type'];
$Pseudo=$_POST['pseudo'];
$Mail=$_POST['mail'];
$Mdp=md5($_POST['pwd']);

$requete='Insert into utilisateur (Pseudo, Mail, Mdp, prenom, nom, type) 
values ("'.$Pseudo.'","'.$Mail.'","'.$Mdp.'","'.$prenom.'","'.$nom.'","'.$type.'")';
  $bdd->query($requete);
header("location:index.php");