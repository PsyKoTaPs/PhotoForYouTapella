-- phpMyAdmin SQL Dump
-- version 4.7.9
-- https://www.phpmyadmin.net/
--
-- Hôte : 127.0.0.1:3306
-- Généré le :  ven. 16 nov. 2018 à 10:48
-- Version du serveur :  5.7.21
-- Version de PHP :  5.6.35

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données :  `photoforyou`
--

DELIMITER $$
--
-- Procédures
--
DROP PROCEDURE IF EXISTS `Moyenne_Credit_Photographe`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `Moyenne_Credit_Photographe` ()  BEGIN
DECLARE resultat float;
select avg(credit) into resultat from users where type_utilisateur=1;
insert into statistique values(date(now()),"Moyenne_Credit_Photographe",resultat);
END$$

--
-- Fonctions
--
DROP FUNCTION IF EXISTS `AffichePrenom`$$
CREATE DEFINER=`root`@`localhost` FUNCTION `AffichePrenom` () RETURNS VARCHAR(50) CHARSET utf8 BEGIN
declare prenom varchar(50);
select pseudo into prenom from utilisateur;
RETURN prenom;
END$$

DROP FUNCTION IF EXISTS `client_sans_credit`$$
CREATE DEFINER=`root`@`localhost` FUNCTION `client_sans_credit` (`untype` VARCHAR(50)) RETURNS INT(11) BEGIN
DECLARE nbclientpauvre integer ;
select count(*) into nbclientpauvre from utilisateur where credit=0 and type=untype;
RETURN nbclientpauvre;
END$$

DROP FUNCTION IF EXISTS `credit_avec_plus_de_50`$$
CREATE DEFINER=`root`@`localhost` FUNCTION `credit_avec_plus_de_50` (`untype` CHAR) RETURNS INT(11) BEGIN
DECLARE nbclient50 integer ;
select count(*) into nbclient50 from utilisateur where credit>50 and type_utilisateur=untype;
RETURN nbclient50;
END$$

DROP FUNCTION IF EXISTS `InitCap`$$
CREATE DEFINER=`root`@`localhost` FUNCTION `InitCap` (`chaine` VARCHAR(100)) RETURNS VARCHAR(100) CHARSET latin1 BEGIN
declare FirstLetter char;
set FirstLetter = upper(substr(chaine,1,1));
set chaine=lower(substr(chaine,2,length(chaine)));
set chaine=concat(FirstLetter,chaine);
RETURN chaine;
END$$

DROP FUNCTION IF EXISTS `nbrphoto`$$
CREATE DEFINER=`root`@`localhost` FUNCTION `nbrphoto` (`selfi` VARCHAR(20)) RETURNS INT(11) BEGIN
declare cptphoto integer;
declare type_type varchar(50);
select count(*) into cptphoto from photos where Num_id=selfi;
select type into type_type from utilisateur where Num_id=selfi;
if(type_type ="client") then
return -1;
end if;
if(type_type ="photographe") then
return cptphoto;
end if;

END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Structure de la table `menu`
--

DROP TABLE IF EXISTS `menu`;
CREATE TABLE IF NOT EXISTS `menu` (
  `idMenu` int(11) NOT NULL AUTO_INCREMENT,
  `NomMenu` varchar(70) DEFAULT NULL,
  `Lien` varchar(500) DEFAULT NULL,
  `Connect` tinyint(1) DEFAULT NULL,
  `Deconnect` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`idMenu`)
) ENGINE=MyISAM AUTO_INCREMENT=7 DEFAULT CHARSET=latin1;

--
-- Déchargement des données de la table `menu`
--

INSERT INTO `menu` (`idMenu`, `NomMenu`, `Lien`, `Connect`, `Deconnect`) VALUES
(1, 'Acheter des crédits', 'achatcredits.php', 1, 1),
(2, 'Acheter des images', 'achatimages.php', 1, 1),
(3, 'Nous Contacter', 'contacts.php', 1, 1),
(4, 'Connexion', 'connexion.php', 0, 1),
(5, 'S\'inscrire', 'inscription.php', 0, 1),
(6, 'Deconnexion', 'deconnexion.php', 1, 0);

-- --------------------------------------------------------

--
-- Structure de la table `photos`
--

DROP TABLE IF EXISTS `photos`;
CREATE TABLE IF NOT EXISTS `photos` (
  `id_photos` int(11) NOT NULL AUTO_INCREMENT,
  `nom_photo` varchar(20) NOT NULL,
  `taille_pixels_x` int(11) NOT NULL,
  `taille_pixels_y` int(11) NOT NULL,
  `poids` float NOT NULL,
  `Num_ID` int(11) NOT NULL,
  PRIMARY KEY (`id_photos`),
  KEY `user_id` (`Num_ID`)
) ENGINE=MyISAM AUTO_INCREMENT=9 DEFAULT CHARSET=latin1;

--
-- Déchargement des données de la table `photos`
--

INSERT INTO `photos` (`id_photos`, `nom_photo`, `taille_pixels_x`, `taille_pixels_y`, `poids`, `Num_ID`) VALUES
(1, 'photo_superbe', 2356, 1571, 3700, 1),
(2, 'portrait', 2356, 1571, 3700, 1),
(3, 'photo_reportage', 3421, 2280, 7800, 3),
(4, 'kenya', 3421, 2280, 7800, 5),
(5, 'photo_paysage', 2356, 1571, 3700, 4),
(6, 'portrait_animal', 2356, 1571, 3700, 7),
(7, 'photo_ciel', 3421, 2280, 7800, 2),
(8, 'jena', 3421, 2280, 7800, 9);

-- --------------------------------------------------------

--
-- Structure de la table `statistique`
--

DROP TABLE IF EXISTS `statistique`;
CREATE TABLE IF NOT EXISTS `statistique` (
  `id_stat` int(11) NOT NULL,
  `date` date NOT NULL,
  `champs` varchar(100) NOT NULL,
  `Valeur` float NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Déchargement des données de la table `statistique`
--

INSERT INTO `statistique` (`id_stat`, `date`, `champs`, `Valeur`) VALUES
(0, '2018-11-09', 'Moyenne_Credit_Photographe', 0),
(0, '2018-11-09', 'Moyenne_Credit_Photographe', 0);

-- --------------------------------------------------------

--
-- Structure de la table `utilisateur`
--

DROP TABLE IF EXISTS `utilisateur`;
CREATE TABLE IF NOT EXISTS `utilisateur` (
  `Num_ID` int(11) NOT NULL AUTO_INCREMENT,
  `Pseudo` varchar(25) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `Mail` varchar(75) NOT NULL,
  `Mdp` varchar(50) NOT NULL,
  `prenom` varchar(20) NOT NULL,
  `nom` varchar(20) NOT NULL,
  `type` varchar(20) NOT NULL,
  `credit` int(11) NOT NULL,
  PRIMARY KEY (`Num_ID`),
  UNIQUE KEY `Pseudo` (`Pseudo`),
  UNIQUE KEY `Mail` (`Mail`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;

--
-- Déchargement des données de la table `utilisateur`
--

INSERT INTO `utilisateur` (`Num_ID`, `Pseudo`, `Mail`, `Mdp`, `prenom`, `nom`, `type`, `credit`) VALUES
(1, 'PsyKoTaPs', 'quentin.tapella@outlook.com', 'Azerty21', '', '', 'photographe', 0),
(2, 'azyz', 'azyz@outlook.com', 'jean', '', '', '', 0),
(3, 'bichette', 'bichette@outlook.com', 'bibiche', '', '', '', 0),
(4, 'tabab', 'azdzadaz@live.fr', 'abcd', '', '', '', 0),
(5, 'TAPS', 'tapstaps@taps.taps', 'tapsouioui', '', '', '', 0),
(6, 'Psyko', 'quentindu62@outlook.com', 'ed735d55415bee976b771989be8f7005', '', '', '', 0);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
