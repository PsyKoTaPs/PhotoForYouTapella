
<div id="nav">
    	<ul>
        	<?php 

    if(isset($_SESSION['login']))
    {
        $resultat=$bdd->query('Select * from menu where Connect="1"');
    }
    else
    {
        $resultat=$bdd->query('Select * from menu where Deconnect="1"');
    }
    while ($menu=$resultat->fetch(PDO::FETCH_ASSOC))
{
    echo "    <li><a href='".$menu["Lien"]."'>".$menu["NomMenu"]."</a></li>          ";
}
?>
        </ul>
    </div>
    
    