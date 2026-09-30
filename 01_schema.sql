-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema pet_supply_store
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `pet_supply_store` ;

-- -----------------------------------------------------
-- Schema pet_supply_store
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `pet_supply_store` DEFAULT CHARACTER SET utf8 ;
USE `pet_supply_store` ;

-- -----------------------------------------------------
-- Table `pet_supply_store`.`Customer`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pet_supply_store`.`Customer` (
  `Customer_id` INT NOT NULL AUTO_INCREMENT,
  `Name` VARCHAR(45) NOT NULL,
  `Location` VARCHAR(45) NULL,
  PRIMARY KEY (`Customer_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pet_supply_store`.`Category`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pet_supply_store`.`Category` (
  `Category_id` INT NOT NULL AUTO_INCREMENT,
  `Category_name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`Category_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pet_supply_store`.`Animal_type`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pet_supply_store`.`Animal_type` (
  `Type_id` INT NOT NULL AUTO_INCREMENT,
  `Type_name` VARCHAR(45) NOT NULL,
  `Animal_type_Type_id` INT NULL,
  PRIMARY KEY (`Type_id`),
  INDEX `fk_Animal_type_Animal_type1_idx` (`Animal_type_Type_id` ASC) VISIBLE,
  CONSTRAINT `fk_Animal_type_Animal_type1`
    FOREIGN KEY (`Animal_type_Type_id`)
    REFERENCES `pet_supply_store`.`Animal_type` (`Type_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pet_supply_store`.`Orders`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pet_supply_store`.`Orders` (
  `Order_id` INT NOT NULL AUTO_INCREMENT,
  `Order_date` DATE NOT NULL,
  `Customer_Customer_id` INT NOT NULL,
  PRIMARY KEY (`Order_id`),
  INDEX `fk_Orders_Customer_idx` (`Customer_Customer_id` ASC) VISIBLE,
  CONSTRAINT `fk_Orders_Customer`
    FOREIGN KEY (`Customer_Customer_id`)
    REFERENCES `pet_supply_store`.`Customer` (`Customer_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pet_supply_store`.`Product`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pet_supply_store`.`Product` (
  `Product_id` INT NOT NULL AUTO_INCREMENT,
  `Name` VARCHAR(45) NOT NULL,
  `Price` DECIMAL(6,2) NOT NULL,
  `Category_Category_id` INT NOT NULL,
  PRIMARY KEY (`Product_id`),
  INDEX `fk_Product_Category1_idx` (`Category_Category_id` ASC) VISIBLE,
  CONSTRAINT `fk_Product_Category1`
    FOREIGN KEY (`Category_Category_id`)
    REFERENCES `pet_supply_store`.`Category` (`Category_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pet_supply_store`.`Pet`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pet_supply_store`.`Pet` (
  `Pet_name` VARCHAR(45) NOT NULL,
  `Animal_type_Type_id` INT NOT NULL,
  `Customer_Customer_id` INT NOT NULL,
  PRIMARY KEY (`Pet_name`, `Customer_Customer_id`),
  INDEX `fk_Pet_Animal_type1_idx` (`Animal_type_Type_id` ASC) VISIBLE,
  INDEX `fk_Pet_Customer1_idx` (`Customer_Customer_id` ASC) VISIBLE,
  CONSTRAINT `fk_Pet_Animal_type1`
    FOREIGN KEY (`Animal_type_Type_id`)
    REFERENCES `pet_supply_store`.`Animal_type` (`Type_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Pet_Customer1`
    FOREIGN KEY (`Customer_Customer_id`)
    REFERENCES `pet_supply_store`.`Customer` (`Customer_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pet_supply_store`.`Order_item`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pet_supply_store`.`Order_item` (
  `Orders_Order_id` INT NOT NULL,
  `Product_Product_id` INT NOT NULL,
  `quantity` INT NOT NULL,
  PRIMARY KEY (`Orders_Order_id`, `Product_Product_id`),
  INDEX `fk_Orders_has_Product_Product1_idx` (`Product_Product_id` ASC) VISIBLE,
  INDEX `fk_Orders_has_Product_Orders1_idx` (`Orders_Order_id` ASC) VISIBLE,
  CONSTRAINT `fk_Orders_has_Product_Orders1`
    FOREIGN KEY (`Orders_Order_id`)
    REFERENCES `pet_supply_store`.`Orders` (`Order_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Orders_has_Product_Product1`
    FOREIGN KEY (`Product_Product_id`)
    REFERENCES `pet_supply_store`.`Product` (`Product_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pet_supply_store`.`Product_for`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pet_supply_store`.`Product_for` (
  `Product_Product_id` INT NOT NULL,
  `Animal_type_Type_id` INT NOT NULL,
  PRIMARY KEY (`Product_Product_id`, `Animal_type_Type_id`),
  INDEX `fk_Product_has_Animal_type_Animal_type1_idx` (`Animal_type_Type_id` ASC) VISIBLE,
  INDEX `fk_Product_has_Animal_type_Product1_idx` (`Product_Product_id` ASC) VISIBLE,
  CONSTRAINT `fk_Product_has_Animal_type_Product1`
    FOREIGN KEY (`Product_Product_id`)
    REFERENCES `pet_supply_store`.`Product` (`Product_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Product_has_Animal_type_Animal_type1`
    FOREIGN KEY (`Animal_type_Type_id`)
    REFERENCES `pet_supply_store`.`Animal_type` (`Type_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
