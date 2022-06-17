-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema pozos_profundos_db
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema pozos_profundos_db
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `pozos_profundos_db` DEFAULT CHARACTER SET utf8 ;
USE `pozos_profundos_db` ;

-- -----------------------------------------------------
-- Table `pozos_profundos_db`.`usuario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pozos_profundos_db`.`usuario` (
  `correo_electronico` VARCHAR(50) NOT NULL,
  `contrasena` VARCHAR(16) NOT NULL,
  `nombre` VARCHAR(25) NOT NULL,
  `apellido` VARCHAR(25) NOT NULL,
  `numero_telefono` INT(11) NOT NULL,
  `direccion` VARCHAR(90) NOT NULL,
  `administrador` TINYINT NULL,
  PRIMARY KEY (`correo_electronico`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pozos_profundos_db`.`proyecto`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pozos_profundos_db`.`proyecto` (
  `id_proyecto` INT NOT NULL AUTO_INCREMENT,
  `nombre_proyecto` VARCHAR(30) NOT NULL,
  `ubicacion` VARCHAR(90) NOT NULL,
  PRIMARY KEY (`id_proyecto`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pozos_profundos_db`.`usuario_proyecto`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pozos_profundos_db`.`usuario_proyecto` (
  `id_usuario_proyecto` INT NOT NULL AUTO_INCREMENT,
  `correo_electronico` VARCHAR(50) NOT NULL,
  `id_proyecto` INT NOT NULL,
  PRIMARY KEY (`id_usuario_proyecto`),
  INDEX `usuario_proyecto_usuario_idx` (`correo_electronico` ASC) VISIBLE,
  INDEX `usuario_proyecto_proyecto_idx` (`id_proyecto` ASC) VISIBLE,
  CONSTRAINT `usuario_proyecto_usuario`
    FOREIGN KEY (`correo_electronico`)
    REFERENCES `pozos_profundos_db`.`usuario` (`correo_electronico`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `usuario_proyecto_proyecto`
    FOREIGN KEY (`id_proyecto`)
    REFERENCES `pozos_profundos_db`.`proyecto` (`id_proyecto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pozos_profundos_db`.`cotizacion`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pozos_profundos_db`.`cotizacion` (
  `id_cotizacion` INT NOT NULL AUTO_INCREMENT,
  `fecha` DATE NOT NULL,
  `precio_por_distancia` INT NULL,
  `precio_total` INT NOT NULL,
  `precio_por_profundidad` INT NOT NULL,
  PRIMARY KEY (`id_cotizacion`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pozos_profundos_db`.`proyecto_cotizacion`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pozos_profundos_db`.`proyecto_cotizacion` (
  `id_proyecto_cotizacion` INT NOT NULL AUTO_INCREMENT,
  `id_proyecto` INT NOT NULL,
  `id_cotizacion` INT NOT NULL,
  PRIMARY KEY (`id_proyecto_cotizacion`),
  INDEX `proyecto_cotizacion_proyecto_idx` (`id_proyecto` ASC) VISIBLE,
  INDEX `proyecto_cotizacion_cotizacion_idx` (`id_cotizacion` ASC) VISIBLE,
  CONSTRAINT `proyecto_cotizacion_proyecto`
    FOREIGN KEY (`id_proyecto`)
    REFERENCES `pozos_profundos_db`.`proyecto` (`id_proyecto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `proyecto_cotizacion_cotizacion`
    FOREIGN KEY (`id_cotizacion`)
    REFERENCES `pozos_profundos_db`.`cotizacion` (`id_cotizacion`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pozos_profundos_db`.`item_cotizado`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pozos_profundos_db`.`item_cotizado` (
  `id_item_cotizado` INT NOT NULL AUTO_INCREMENT,
  `nombre_item` VARCHAR(45) NOT NULL,
  `precio` INT NOT NULL,
  PRIMARY KEY (`id_item_cotizado`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pozos_profundos_db`.`cotizacion_item_cotizado`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pozos_profundos_db`.`cotizacion_item_cotizado` (
  `id_cotizacion_item_cotizado` INT NOT NULL AUTO_INCREMENT,
  `id_cotizacion` INT NOT NULL,
  `id_item_cotizado` INT NOT NULL,
  PRIMARY KEY (`id_cotizacion_item_cotizado`),
  INDEX `cotizacion_item_cotizado_cotizacion_idx` (`id_cotizacion` ASC) VISIBLE,
  INDEX `cotizacion_item_cotizado_item_cotizado_idx` (`id_item_cotizado` ASC) VISIBLE,
  CONSTRAINT `cotizacion_item_cotizado_cotizacion`
    FOREIGN KEY (`id_cotizacion`)
    REFERENCES `pozos_profundos_db`.`cotizacion` (`id_cotizacion`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `cotizacion_item_cotizado_item_cotizado`
    FOREIGN KEY (`id_item_cotizado`)
    REFERENCES `pozos_profundos_db`.`item_cotizado` (`id_item_cotizado`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pozos_profundos_db`.`publicacion_inicio`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pozos_profundos_db`.`publicacion_inicio` (
  `id_publicacion_inicio` INT NOT NULL AUTO_INCREMENT,
  `titulo` VARCHAR(45) NOT NULL,
  `imagen` VARCHAR(45) NULL,
  `descripcion` VARCHAR(200) NOT NULL,
  PRIMARY KEY (`id_publicacion_inicio`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pozos_profundos_db`.`archivo_adjunto`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pozos_profundos_db`.`archivo_adjunto` (
  `id_archivo_adjunto` INT NOT NULL AUTO_INCREMENT,
  `tipo_archivo` VARCHAR(45) NOT NULL,
  `archivo_adjunto` VARCHAR(45) NULL,
  PRIMARY KEY (`id_archivo_adjunto`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pozos_profundos_db`.`proyecto_archivo_adjunto`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pozos_profundos_db`.`proyecto_archivo_adjunto` (
  `id_proyecto_archivo_adjunto` INT NOT NULL AUTO_INCREMENT,
  `id_proyecto` INT NOT NULL,
  `id_archivo_adjunto` INT NOT NULL,
  PRIMARY KEY (`id_proyecto_archivo_adjunto`),
  INDEX `proyecto_proyecto_archivo_adjunto_idx` (`id_proyecto` ASC) VISIBLE,
  INDEX `proyecto_archivo_adjunto_archivo_adjunto_idx` (`id_archivo_adjunto` ASC) VISIBLE,
  CONSTRAINT `proyecto_proyecto_archivo_adjunto`
    FOREIGN KEY (`id_proyecto`)
    REFERENCES `pozos_profundos_db`.`proyecto` (`id_proyecto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `proyecto_archivo_adjunto_archivo_adjunto`
    FOREIGN KEY (`id_archivo_adjunto`)
    REFERENCES `pozos_profundos_db`.`archivo_adjunto` (`id_archivo_adjunto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pozos_profundos_db`.`banners_socios`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pozos_profundos_db`.`banners_socios` (
  `id_banners_socios` INT NOT NULL AUTO_INCREMENT,
  `imagen_banner` VARCHAR(45) NULL,
  `banners_socioscol` VARCHAR(45) NULL,
  PRIMARY KEY (`id_banners_socios`))
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
