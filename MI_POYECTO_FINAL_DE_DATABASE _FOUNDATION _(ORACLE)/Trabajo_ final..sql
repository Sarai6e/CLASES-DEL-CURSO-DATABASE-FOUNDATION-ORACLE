-- BASE DE DATOS SOBRE VENTAS (PROYECTO FINAL)

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`proveedor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`proveedor` (
  `rut` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  `telefono` VARCHAR(45) NULL,
  `pagina web` VARCHAR(45) NULL,
  PRIMARY KEY (`rut`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`clientes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`cliente` (
  `rut` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`rut`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`categorias`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`categoria` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  `descripcion` VARCHAR(45) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`ventas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`venta` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `fecha` DATE NOT NULL,
  `descuento` DECIMAL(10,2) NULL,
  `clientes_rut` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_ventas_clientes1_idx` (`clientes_rut` ASC) VISIBLE,
  CONSTRAINT `fk_ventas_clientes1`
    FOREIGN KEY (`clientes_rut`)
    REFERENCES `mydb`.`clientes` (`rut`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`productos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`producto` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  `precio` DECIMAL(10,2) NOT NULL,
  `stock` INT NOT NULL,
  `categorias_id` INT NOT NULL,
  `proveedores_rut` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_productos_categorias_idx` (`categorias_id` ASC) VISIBLE,
  INDEX `fk_productos_proveedores1_idx` (`proveedores_rut` ASC) VISIBLE,
  CONSTRAINT `fk_productos_categorias`
    FOREIGN KEY (`categorias_id`)
    REFERENCES `mydb`.`categorias` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_productos_proveedores1`
    FOREIGN KEY (`proveedores_rut`)
    REFERENCES `mydb`.`proveedores` (`rut`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`direccion_proveedor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`direccion_proveedor` (
  `proveedores_rut` INT NOT NULL,
  `calle` VARCHAR(45) NOT NULL,
  `numero` VARCHAR(45) NULL,
  `ciudad` VARCHAR(45) NULL,
  `comuna` VARCHAR(45) NULL,
  PRIMARY KEY (`proveedores_rut`),
  CONSTRAINT `fk_direccion_proveedor_proveedores1`
    FOREIGN KEY (`proveedores_rut`)
    REFERENCES `mydb`.`proveedores` (`rut`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`direccion_cliente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`direccion_cliente` (
  `clientes_rut` INT NOT NULL,
  `calle` VARCHAR(45) NOT NULL,
  `numero` VARCHAR(45) NULL,
  `ciudad` VARCHAR(45) NULL,
  `comuna` VARCHAR(45) NULL,
  PRIMARY KEY (`clientes_rut`),
  CONSTRAINT `fk_direccion_cliente_clientes1`
    FOREIGN KEY (`clientes_rut`)
    REFERENCES `mydb`.`clientes` (`rut`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`telefonos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`telefono` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `numero` VARCHAR(45) NOT NULL,
  `clientes_rut` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_telefonos_clientes1_idx` (`clientes_rut` ASC) VISIBLE,
  CONSTRAINT `fk_telefonos_clientes1`
    FOREIGN KEY (`clientes_rut`)
    REFERENCES `mydb`.`clientes` (`rut`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`detalle_venta`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`detalle_venta` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `precio` DECIMAL(10,2) NOT NULL,
  `cantidad` INT NOT NULL,
  `ventas_id` INT NOT NULL,
  `productos_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_detalle_venta_ventas1_idx` (`ventas_id` ASC) VISIBLE,
  INDEX `fk_detalle_venta_productos1_idx` (`productos_id` ASC) VISIBLE,
  CONSTRAINT `fk_detalle_venta_ventas1`
    FOREIGN KEY (`ventas_id`)
    REFERENCES `mydb`.`ventas` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_detalle_venta_productos1`
    FOREIGN KEY (`productos_id`)
    REFERENCES `mydb`.`productos` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
