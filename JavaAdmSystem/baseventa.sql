-- MySQL Script generated by MySQL Workbench
-- Sun Feb 24 17:48:11 2019
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema baseventas
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema baseventas
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `baseventas` DEFAULT CHARACTER SET utf8 ;
USE `baseventas` ;

-- -----------------------------------------------------
-- Table `baseventas`.`articulo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `baseventas`.`articulo` (
  `id_articulo` VARCHAR(50) NOT NULL,
  `nombre` VARCHAR(50) NOT NULL,
  `descripcion` VARCHAR(256) NOT NULL,
  PRIMARY KEY (`id_articulo`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `baseventas`.`proveedor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `baseventas`.`proveedor` (
  `id_proveedor` INT NOT NULL AUTO_INCREMENT,
  `cedula` VARCHAR(50) NOT NULL,
  `nombre` VARCHAR(50) NOT NULL,
  `direccion` VARCHAR(256) NOT NULL,
  `rif` VARCHAR(60) NOT NULL,
  `empresa` VARCHAR(128) NOT NULL,
  `telefono` VARCHAR(20) NULL,
  `correo` VARCHAR(60) NULL,
  PRIMARY KEY (`id_proveedor`),
  UNIQUE INDEX `cedula_UNIQUE` (`cedula` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `baseventas`.`trabajador`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `baseventas`.`trabajador` (
  `id_trabajador` VARCHAR(50) NOT NULL,
  `nombre` VARCHAR(45) NOT NULL,
  `direccion` VARCHAR(256) NOT NULL,
  `sexo` VARCHAR(10) NOT NULL,
  `acceso` VARCHAR(20) NOT NULL,
  `contraseña` VARCHAR(60) NOT NULL,
  `telefono` VARCHAR(20) NULL,
  `correo` VARCHAR(60) NULL,
  `pregunta` VARCHAR(60) NOT NULL,
  `respuesta` VARCHAR(60) NOT NULL,
  PRIMARY KEY (`id_trabajador`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `baseventas`.`ingreso`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `baseventas`.`ingreso` (
  `id_ingreso` INT NOT NULL AUTO_INCREMENT,
  `id_trabajador` VARCHAR(50) NOT NULL,
  `id_proveedor` INT NOT NULL,
  `fecha` DATE NOT NULL,
  `estado` VARCHAR(45) NOT NULL,
  `precio_total` DOUBLE NOT NULL,
  PRIMARY KEY (`id_ingreso`),
  INDEX `fk_ingreso_proveedor_idx` (`id_proveedor` ASC),
  INDEX `fk_ingreso_trabajador_idx` (`id_trabajador` ASC),
  CONSTRAINT `fk_ingreso_proveedor`
    FOREIGN KEY (`id_proveedor`)
    REFERENCES `baseventas`.`proveedor` (`id_proveedor`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_ingreso_trabajador`
    FOREIGN KEY (`id_trabajador`)
    REFERENCES `baseventas`.`trabajador` (`id_trabajador`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `baseventas`.`detalle_ingreso`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `baseventas`.`detalle_ingreso` (
  `id_detalle_ingreso` INT NOT NULL AUTO_INCREMENT,
  `id_ingreso` INT NOT NULL,
  `id_articulo` VARCHAR(50) NOT NULL,
  `precio_compra` DOUBLE NOT NULL,
  `precio_venta` DOUBLE NOT NULL,
  `stock_inicial` INT NOT NULL,
  `stock_actual` INT NOT NULL,
  PRIMARY KEY (`id_detalle_ingreso`),
  INDEX `fk_detalleingreso_articulo_idx` (`id_articulo` ASC),
  INDEX `fk_detalleingreso_ingreso_idx` (`id_ingreso` ASC),
  CONSTRAINT `fk_detalleingreso_articulo`
    FOREIGN KEY (`id_articulo`)
    REFERENCES `baseventas`.`articulo` (`id_articulo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_detalleingreso_ingreso`
    FOREIGN KEY (`id_ingreso`)
    REFERENCES `baseventas`.`ingreso` (`id_ingreso`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `baseventas`.`cliente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `baseventas`.`cliente` (
  `id_cliente` VARCHAR(50) NOT NULL,
  `nombre` VARCHAR(50) NOT NULL,
  `direccion` VARCHAR(256) NOT NULL,
  `telefono` VARCHAR(20) NULL,
  `correo` VARCHAR(60) NULL,
  `sexo` VARCHAR(10) NOT NULL,
  PRIMARY KEY (`id_cliente`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `baseventas`.`venta`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `baseventas`.`venta` (
  `id_venta` INT NOT NULL AUTO_INCREMENT,
  `id_cliente` VARCHAR(50) NOT NULL,
  `id_trabajador` VARCHAR(50) NOT NULL,
  `fecha` DATE NOT NULL,
  `subtotal` DOUBLE NOT NULL,
  `impuesto` DOUBLE NOT NULL,
  `total` DOUBLE NOT NULL,
  `estado` VARCHAR(45) NULL,
  PRIMARY KEY (`id_venta`),
  INDEX `fk_venta_trabajador_idx` (`id_trabajador` ASC),
  INDEX `fk_venta_cliente_idx` (`id_cliente` ASC),
  CONSTRAINT `fk_venta_trabajador`
    FOREIGN KEY (`id_trabajador`)
    REFERENCES `baseventas`.`trabajador` (`id_trabajador`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_venta_cliente`
    FOREIGN KEY (`id_cliente`)
    REFERENCES `baseventas`.`cliente` (`id_cliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `baseventas`.`detalle_venta`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `baseventas`.`detalle_venta` (
  `id_detalle_venta` INT NOT NULL AUTO_INCREMENT,
  `id_venta` INT NOT NULL,
  `id_detalle_ingreso` INT NOT NULL,
  `cantidad` INT NOT NULL,
  `precio` DOUBLE NOT NULL,
  PRIMARY KEY (`id_detalle_venta`),
  INDEX `fk_detalleventa_venta_idx` (`id_venta` ASC),
  INDEX `fk_detalleventa_detalleingreso_idx` (`id_detalle_ingreso` ASC),
  CONSTRAINT `fk_detalleventa_venta`
    FOREIGN KEY (`id_venta`)
    REFERENCES `baseventas`.`venta` (`id_venta`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_detalleventa_detalleingreso`
    FOREIGN KEY (`id_detalle_ingreso`)
    REFERENCES `baseventas`.`detalle_ingreso` (`id_detalle_ingreso`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
