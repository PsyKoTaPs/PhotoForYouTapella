 <?php
   
        try
{
        $bdd = new PDO('mysql:host=localhost;dbname=photoforyou;charset=utf8', 'adminfoto', 'azerty11');
}
catch (Exception $e)
{
        die('Erreur : ' . $e->getMessage());
}
