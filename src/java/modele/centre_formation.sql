-- Change le délimiteur pour pouvoir écrire des ; dans la
-- procédure stockée
DELIMITER §

DROP SCHEMA IF EXISTS centre_formation §
CREATE SCHEMA IF NOT EXISTS centre_formation DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci §
USE centre_formation §

CREATE TABLE IF NOT EXISTS promotion (
  id_promotion INT NOT NULL AUTO_INCREMENT,
  nom VARCHAR(45) NOT NULL,
  PRIMARY KEY (id_promotion),
  UNIQUE INDEX nom_UNIQUE (nom ASC))
ENGINE = InnoDB§


CREATE TABLE IF NOT EXISTS personne (
  id_personne INT NOT NULL AUTO_INCREMENT,
  nom VARCHAR(45) NOT NULL,
  prenom VARCHAR(45) NOT NULL,
  email VARCHAR(45) NOT NULL,
  PRIMARY KEY (id_personne),
  UNIQUE INDEX email_UNIQUE (email ASC))
ENGINE = InnoDB§


CREATE TABLE IF NOT EXISTS membre_promotion (
  id_promotion INT NOT NULL,
  id_personne INT NOT NULL,
  PRIMARY KEY (id_promotion, id_personne),
  CONSTRAINT fk_membre_promotion_promotion
    FOREIGN KEY (id_promotion)
    REFERENCES promotion (id_promotion)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT fk_membre_promotion_personne
    FOREIGN KEY (id_personne)
    REFERENCES personne (id_personne)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB§


CREATE TABLE IF NOT EXISTS projet (
  id_projet INT NOT NULL AUTO_INCREMENT,
  id_promotion INT NOT NULL,
  id_createur INT NOT NULL,
  sujet TEXT NOT NULL,
  titre VARCHAR(100) NOT NULL,
  date_creation DATETIME NOT NULL,
  date_limite DATETIME NOT NULL,
  PRIMARY KEY (id_projet),
  CONSTRAINT fk_projet_promotion
    FOREIGN KEY (id_promotion)
    REFERENCES promotion (id_promotion)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT fk_projet_personne
    FOREIGN KEY (id_createur)
    REFERENCES personne (id_personne)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB§


CREATE TABLE IF NOT EXISTS equipe (
  id_equipe INT NOT NULL AUTO_INCREMENT,
  id_projet INT NOT NULL,
  id_createur INT NOT NULL,
  date_creation DATETIME NOT NULL,
  resume VARCHAR(255) NULL,
  PRIMARY KEY (id_equipe),
  CONSTRAINT fk_equipe_projet
    FOREIGN KEY (id_projet)
    REFERENCES projet (id_projet)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT fk_equipe_personne
    FOREIGN KEY (id_createur)
    REFERENCES personne (id_personne)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB§


CREATE TABLE IF NOT EXISTS membre_equipe (
  id_equipe INT NOT NULL,
  id_personne INT NOT NULL,
  PRIMARY KEY (id_equipe, id_personne),
  CONSTRAINT fk_membre_equipe_equipe
    FOREIGN KEY (id_equipe)
    REFERENCES equipe (id_equipe)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT fk_membre_equipe_personne
    FOREIGN KEY (id_personne)
    REFERENCES personne (id_personne)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB§


DROP PROCEDURE IF EXISTS centre_formation_refresh§
CREATE DEFINER=root@localhost PROCEDURE centre_formation_refresh()
BEGIN
    -- Lever temporairement les contraintes d'intégrité
    SET FOREIGN_KEY_CHECKS=0;
    -- Vider les tables
    TRUNCATE equipe;
    TRUNCATE membre_equipe;
    TRUNCATE membre_promotion;
    TRUNCATE personne;
    TRUNCATE projet;
    TRUNCATE promotion;
    -- Remettre les contraintes d'integrite
    SET FOREIGN_KEY_CHECKS=1;

    BEGIN
        -- Traitement si exception (catch)
        DECLARE EXIT HANDLER FOR SQLSTATE '23000'
        BEGIN
            ROLLBACK;
            SELECT 'Opération annulée';
        END;
        -- Les insertions
        START TRANSACTION;

        INSERT INTO personne (id_personne, nom, prenom, email) VALUES
        (1, 'Haddock', 'Archibald', 'haddock@moulinsart.be'),
          (2, 'Castafiore','Bianca', 'bianca.castafiore@scala.it'),
          (3, 'Tournesol', 'Tryphon', 'tournesol@moulinsart.be'),
          (4, 'Lampion', 'Séraphin', 'lampion@mondass.fr'),
        (5, 'Krad' , 'Imen', 'krad_imen@yahoo.fr'),
        (6, 'Siby' , 'Abdoulaye', 'absiby@yahoo.fr'),
        (7, 'Twahirwa' , 'Jean vladimir' , 'tvradmir@yahoo.fr'),
        (8, 'Lutula' , 'Okito' , 'okito82@hotmail.fr'),
        (9, 'Feyte' ,'Florien' , 'f.feyete@gmail.com'),
        (10, 'Plase' , 'Michelle' , 'm.place@gmail.com');

        INSERT INTO promotion (id_promotion, nom) VALUES
          (1, 'java'),
        (2, 'moa');

        INSERT INTO membre_promotion (id_promotion,  id_personne) VALUES
        (1,1 ),
        (1,2 ),
        (1,3 ),
        (1,4 ),
        (1,5 ),
        (1,6 ),
        (2,7 ),  
        (2,8 );
        INSERT INTO projet (id_projet, id_promotion, id_createur, sujet, titre, date_creation, date_limite) VALUES
        (1, 1, 10, 'creation application web', 'projet bicec','2016-05-10 00:00:00', '2016-07-15 00:00:00'),
        (2, 1, 10, 'creation interface contentieux judiciares', 'projetweb', '2016-03-05 00:00:00', '2016-06-15 00:00:00'),
        (3, 1, 10, 'connexion base de donnee et sql', 'miniprojet', '2016-07-01 00:00:00', '2016-07-10 00:00:00');

        INSERT INTO equipe (id_equipe, id_projet, id_createur, date_creation, resume) VALUES
        (1,1,1,'2016-05-11 00:00:00', NULL),
        (2,1,3, '2016-05-11 00:00:00', 'excellente equipe' ),
        (3,1,5, '2016-05-11 00:00:00','equipe inactive' ),
        (4,2,7, '2016-03-06 00:00:00', 'equipe moyenne' );

        INSERT INTO membre_equipe (id_equipe, id_personne) VALUES
        (1,1),
        (1,2),
        (2,3),
        (2,4),
        (3,5),
        (3,6),
        (4,7),
        (4,8);

        COMMIT;
    END;
END§


DROP FUNCTION IF EXISTS initcap§
CREATE FUNCTION initcap(chaine text) RETURNS text CHARSET utf8 deterministic
BEGIN
    DECLARE gauche, droite text;
    SET gauche='';
    SET droite ='';
    WHILE chaine LIKE '% %' DO -- si elle contient un espace
        SELECT SUBSTRING_INDEX(chaine, ' ', 1) INTO gauche;
        SELECT SUBSTRING(chaine, LOCATE(' ', chaine) + 1) INTO chaine; SELECT CONCAT(droite, ' ',
        CONCAT(UPPER(SUBSTRING(gauche, 1, 1)),
        LOWER(SUBSTRING(gauche, 2)))) INTO droite
    END WHILE;
    RETURN LTRIM(CONCAT(droite, ' ', CONCAT(UPPER(SUBSTRING(chaine,1,1)), LOWER(SUBSTRING(chaine, 2)))));
END§


DROP TRIGGER IF EXISTS personne_before_insert_trigger§ 
CREATE TRIGGER personne_before_insert_trigger
BEFORE INSERT ON personne
FOR EACH ROW
BEGIN
  SET NEW.prenom = trim(initcap(NEW.prenom)); 
  SET NEW.nom = trim(upper(NEW.nom));
  SET NEW.email = trim(NEW.email);
END§

DROP TRIGGER IF EXISTS personne_before_update_trigger§ 
CREATE TRIGGER personne_before_update_trigger
BEFORE UPDATE ON personne
FOR EACH ROW
BEGIN
  SET NEW.prenom = trim(initcap(NEW.prenom));
  SET NEW.nom = trim(upper(NEW.nom));
  SET NEW.email = trim(NEW.email);
END§


CALL centre_formation_refresh() §


