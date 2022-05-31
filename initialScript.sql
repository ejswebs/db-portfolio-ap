-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema portfolio-AP
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema portfolio-AP
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `portfolio-AP` DEFAULT CHARACTER SET utf8 ;
USE `portfolio-AP` ;

-- -----------------------------------------------------
-- Table `portfolio-AP`.`persona`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `portfolio-AP`.`persona` (
  `dni` INT NOT NULL,
  `nombre` VARCHAR(45) NOT NULL,
  `apellido` VARCHAR(45) NOT NULL,
  `email` VARCHAR(45) NOT NULL,
  `telefono` INT NULL,
  `fecha_nac` DATE NULL,
  PRIMARY KEY (`dni`),
  UNIQUE INDEX `email_UNIQUE` (`email` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `portfolio-AP`.`institucion`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `portfolio-AP`.`institucion` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  `url_logo` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
COMMENT = '				';


-- -----------------------------------------------------
-- Table `portfolio-AP`.`estudio`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `portfolio-AP`.`estudio` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `titulo` VARCHAR(45) NOT NULL,
  `tipo` VARCHAR(45) NULL,
  `promedio` DECIMAL(2) NULL,
  `fecha_inicio` DATE NOT NULL,
  `fecha_fin` DATE NULL,
  `url_logo` VARCHAR(100) NOT NULL,
  `url_certificado` VARCHAR(100) NULL,
  `persona_dni` INT NOT NULL,
  `institucion_id_institucion` INT NOT NULL,
  PRIMARY KEY (`id`, `persona_dni`, `institucion_id_institucion`),
  INDEX `fk_estudio_persona_idx` (`persona_dni` ASC) VISIBLE,
  INDEX `fk_estudio_institucion1_idx` (`institucion_id_institucion` ASC) VISIBLE,
  CONSTRAINT `fk_estudio_persona`
    FOREIGN KEY (`persona_dni`)
    REFERENCES `portfolio-AP`.`persona` (`dni`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_estudio_institucion1`
    FOREIGN KEY (`institucion_id_institucion`)
    REFERENCES `portfolio-AP`.`institucion` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `portfolio-AP`.`proyecto`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `portfolio-AP`.`proyecto` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `titulo` VARCHAR(45) NOT NULL,
  `descripcion` VARCHAR(200) NULL,
  `url_git` VARCHAR(100) NULL,
  `url_preview` VARCHAR(100) NULL,
  `url_img` VARCHAR(100) NOT NULL,
  `persona_dni` INT NOT NULL,
  PRIMARY KEY (`id`, `persona_dni`),
  INDEX `fk_proyecto_persona1_idx` (`persona_dni` ASC) VISIBLE,
  CONSTRAINT `fk_proyecto_persona1`
    FOREIGN KEY (`persona_dni`)
    REFERENCES `portfolio-AP`.`persona` (`dni`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `portfolio-AP`.`tecnologia`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `portfolio-AP`.`tecnologia` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  `url_logo` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
COMMENT = '				';


-- -----------------------------------------------------
-- Table `portfolio-AP`.`experiencia`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `portfolio-AP`.`experiencia` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `puesto` VARCHAR(45) NOT NULL,
  `resumen` VARCHAR(200) NOT NULL,
  `descripcion` VARCHAR(400) NULL,
  `fecha_inicio` DATE NOT NULL,
  `fecha_fin` DATE NULL,
  `persona_dni` INT NOT NULL,
  `id_institucion` INT NOT NULL,
  PRIMARY KEY (`id`, `persona_dni`, `id_institucion`),
  INDEX `fk_experiencia_persona1_idx` (`persona_dni` ASC) VISIBLE,
  INDEX `fk_experiencia_institucion1_idx` (`id_institucion` ASC) VISIBLE,
  CONSTRAINT `fk_experiencia_persona1`
    FOREIGN KEY (`persona_dni`)
    REFERENCES `portfolio-AP`.`persona` (`dni`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_experiencia_institucion1`
    FOREIGN KEY (`id_institucion`)
    REFERENCES `portfolio-AP`.`institucion` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
COMMENT = '	';


-- -----------------------------------------------------
-- Table `portfolio-AP`.`habilidad`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `portfolio-AP`.`habilidad` (
  `nombre_habilidad` VARCHAR(45) NOT NULL,
  `porcentaje` DECIMAL(2) NOT NULL,
  `descripcion` VARCHAR(100) NULL,
  `persona_dni` INT NOT NULL,
  PRIMARY KEY (`nombre_habilidad`, `persona_dni`),
  INDEX `fk_habilidad_persona1_idx` (`persona_dni` ASC) VISIBLE,
  CONSTRAINT `fk_habilidad_persona1`
    FOREIGN KEY (`persona_dni`)
    REFERENCES `portfolio-AP`.`persona` (`dni`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
COMMENT = '				';


-- -----------------------------------------------------
-- Table `portfolio-AP`.`localidad`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `portfolio-AP`.`localidad` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `ciudad` VARCHAR(45) NOT NULL,
  `provincia` VARCHAR(45) NOT NULL,
  `pais` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
COMMENT = '				';


-- -----------------------------------------------------
-- Table `portfolio-AP`.`domicilio`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `portfolio-AP`.`domicilio` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `direccion` VARCHAR(100) NOT NULL,
  `persona_dni` INT NOT NULL,
  `id_localidad` INT NOT NULL,
  PRIMARY KEY (`id`, `persona_dni`, `id_localidad`),
  INDEX `fk_domicilio_persona1_idx` (`persona_dni` ASC) VISIBLE,
  INDEX `fk_domicilio_domicilio_copy11_idx` (`id_localidad` ASC) VISIBLE,
  CONSTRAINT `fk_domicilio_persona1`
    FOREIGN KEY (`persona_dni`)
    REFERENCES `portfolio-AP`.`persona` (`dni`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_domicilio_domicilio_copy11`
    FOREIGN KEY (`id_localidad`)
    REFERENCES `portfolio-AP`.`localidad` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
COMMENT = '				';


-- -----------------------------------------------------
-- Table `portfolio-AP`.`usuario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `portfolio-AP`.`usuario` (
  `user` VARCHAR(15) NOT NULL,
  `password` VARCHAR(15) NOT NULL,
  `persona_dni` INT NOT NULL,
  PRIMARY KEY (`user`, `persona_dni`),
  UNIQUE INDEX `user_UNIQUE` (`user` ASC) VISIBLE,
  INDEX `fk_usuario_persona1_idx` (`persona_dni` ASC) VISIBLE,
  CONSTRAINT `fk_usuario_persona1`
    FOREIGN KEY (`persona_dni`)
    REFERENCES `portfolio-AP`.`persona` (`dni`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
COMMENT = '				';


-- -----------------------------------------------------
-- Table `portfolio-AP`.`experiencia_tecnologia`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `portfolio-AP`.`experiencia_tecnologia` (
  `id_experiencia` INT NOT NULL,
  `id_tecnologia` INT NOT NULL,
  PRIMARY KEY (`id_experiencia`, `id_tecnologia`),
  INDEX `fk_experiencia_has_tecnologia_tecnologia1_idx` (`id_tecnologia` ASC) VISIBLE,
  INDEX `fk_experiencia_has_tecnologia_experiencia1_idx` (`id_experiencia` ASC) VISIBLE,
  CONSTRAINT `fk_experiencia_has_tecnologia_experiencia1`
    FOREIGN KEY (`id_experiencia`)
    REFERENCES `portfolio-AP`.`experiencia` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_experiencia_has_tecnologia_tecnologia1`
    FOREIGN KEY (`id_tecnologia`)
    REFERENCES `portfolio-AP`.`tecnologia` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `portfolio-AP`.`proyecto_tecnologia`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `portfolio-AP`.`proyecto_tecnologia` (
  `id_proyecto` INT NOT NULL,
  `id_tecnologia` INT NOT NULL,
  PRIMARY KEY (`id_proyecto`, `id_tecnologia`),
  INDEX `fk_proyecto_has_tecnologia_tecnologia1_idx` (`id_tecnologia` ASC) VISIBLE,
  INDEX `fk_proyecto_has_tecnologia_proyecto1_idx` (`id_proyecto` ASC) VISIBLE,
  CONSTRAINT `fk_proyecto_has_tecnologia_proyecto1`
    FOREIGN KEY (`id_proyecto`)
    REFERENCES `portfolio-AP`.`proyecto` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_proyecto_has_tecnologia_tecnologia1`
    FOREIGN KEY (`id_tecnologia`)
    REFERENCES `portfolio-AP`.`tecnologia` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
