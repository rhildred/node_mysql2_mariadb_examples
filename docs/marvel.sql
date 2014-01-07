SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

CREATE SCHEMA IF NOT EXISTS `Marvel` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci ;
USE `Marvel` ;

-- -----------------------------------------------------
-- Table `Marvel`.`Department`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Marvel`.`Department` (
  `code` CHAR(3) NOT NULL,
  `Name` VARCHAR(45) NULL,
  PRIMARY KEY (`code`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Marvel`.`Major`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Marvel`.`Major` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NULL,
  `Department_code` CHAR(3) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_Major_Department1_idx` (`Department_code` ASC),
  CONSTRAINT `fk_Major_Department1`
    FOREIGN KEY (`Department_code`)
    REFERENCES `Marvel`.`Department` (`code`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Marvel`.`Student`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Marvel`.`Student` (
  `StudentNumber` CHAR(10) NOT NULL,
  `FirstName` VARCHAR(45) NULL,
  `LastName` VARCHAR(45) NULL,
  `Address1` VARCHAR(256) NULL,
  `Address2` VARCHAR(256) NULL,
  `City` VARCHAR(45) NULL,
  `Province` VARCHAR(45) NULL,
  `PostCode` VARCHAR(45) NULL,
  `Country` VARCHAR(45) NULL,
  `Address1Local` VARCHAR(256) NULL,
  `Address2Local` VARCHAR(256) NULL,
  `CityLocal` VARCHAR(45) NULL,
  `ProvinceLocal` VARCHAR(45) NULL,
  `PostCodeLocal` VARCHAR(45) NULL,
  `CountryLocal` VARCHAR(45) NULL,
  PRIMARY KEY (`StudentNumber`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Marvel`.`Faculty`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Marvel`.`Faculty` (
  `StudentNumber` CHAR(10) NOT NULL,
  `FirstName` VARCHAR(45) NULL,
  `LastName` VARCHAR(45) NULL,
  `Address1` VARCHAR(256) NULL,
  `Address2` VARCHAR(256) NULL,
  `City` VARCHAR(45) NULL,
  `Province` VARCHAR(45) NULL,
  `PostCode` VARCHAR(45) NULL,
  `Country` VARCHAR(45) NULL,
  `OfficeLocation` VARCHAR(45) NULL,
  `PhoneNumber` VARCHAR(45) NULL,
  `CurrentRank` VARCHAR(45) NULL,
  `StartDate` DATE NULL,
  `Department_code` CHAR(3) NOT NULL,
  PRIMARY KEY (`StudentNumber`),
  INDEX `fk_Faculty_Department1_idx` (`Department_code` ASC),
  CONSTRAINT `fk_Faculty_Department1`
    FOREIGN KEY (`Department_code`)
    REFERENCES `Marvel`.`Department` (`code`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Marvel`.`student_major`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Marvel`.`student_major` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `Student_StudentNumber` CHAR(10) NOT NULL,
  `Major_id` INT NOT NULL,
  `Faculty_StudentNumber` CHAR(10) NOT NULL,
  PRIMARY KEY (`id`, `Major_id`),
  INDEX `fk_student_major_Student_idx` (`Student_StudentNumber` ASC),
  INDEX `fk_student_major_Major1_idx` (`Major_id` ASC),
  INDEX `fk_student_major_Faculty1_idx` (`Faculty_StudentNumber` ASC),
  CONSTRAINT `fk_student_major_Student`
    FOREIGN KEY (`Student_StudentNumber`)
    REFERENCES `Marvel`.`Student` (`StudentNumber`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_student_major_Major1`
    FOREIGN KEY (`Major_id`)
    REFERENCES `Marvel`.`Major` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_student_major_Faculty1`
    FOREIGN KEY (`Faculty_StudentNumber`)
    REFERENCES `Marvel`.`Faculty` (`StudentNumber`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Marvel`.`Course`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Marvel`.`Course` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `Department_code` CHAR(3) NOT NULL,
  `CourseNumber` INT NULL,
  `CourseDescription` VARCHAR(45) NULL,
  `Credits` DECIMAL(3,1) NULL,
  PRIMARY KEY (`id`, `Department_code`),
  INDEX `fk_Course_Department1_idx` (`Department_code` ASC),
  CONSTRAINT `fk_Course_Department1`
    FOREIGN KEY (`Department_code`)
    REFERENCES `Marvel`.`Department` (`code`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Marvel`.`Semester`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Marvel`.`Semester` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `Term` VARCHAR(45) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Marvel`.`Section`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Marvel`.`Section` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `Course_id` INT NOT NULL,
  `Semester_id` INT NOT NULL,
  `Section` VARCHAR(45) NULL,
  `ScheduleCode` INT NULL,
  `ScheduleTime` VARCHAR(45) NULL,
  `Place` VARCHAR(45) NULL COMMENT 'this is also called the room number on the Time Schedule',
  `Faculty_StudentNumber` CHAR(10) NOT NULL,
  `EnrollmentMax` INT NULL,
  PRIMARY KEY (`id`, `Course_id`, `Semester_id`),
  INDEX `fk_Section_Course1_idx` (`Course_id` ASC),
  INDEX `fk_Section_Semester1_idx` (`Semester_id` ASC),
  INDEX `fk_Section_Faculty1_idx` (`Faculty_StudentNumber` ASC),
  CONSTRAINT `fk_Section_Course1`
    FOREIGN KEY (`Course_id`)
    REFERENCES `Marvel`.`Course` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Section_Semester1`
    FOREIGN KEY (`Semester_id`)
    REFERENCES `Marvel`.`Semester` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Section_Faculty1`
    FOREIGN KEY (`Faculty_StudentNumber`)
    REFERENCES `Marvel`.`Faculty` (`StudentNumber`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Marvel`.`student_section`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Marvel`.`student_section` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `Student_StudentNumber` CHAR(10) NOT NULL,
  `Section_id` INT NOT NULL,
  `Section_Course_id` INT NOT NULL,
  `grade` INT NULL,
  PRIMARY KEY (`id`, `Section_id`, `Section_Course_id`),
  INDEX `fk_student_section_Student1_idx` (`Student_StudentNumber` ASC),
  INDEX `fk_student_section_Section1_idx` (`Section_id` ASC, `Section_Course_id` ASC),
  CONSTRAINT `fk_student_section_Student1`
    FOREIGN KEY (`Student_StudentNumber`)
    REFERENCES `Marvel`.`Student` (`StudentNumber`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_student_section_Section1`
    FOREIGN KEY (`Section_id` , `Section_Course_id`)
    REFERENCES `Marvel`.`Section` (`id` , `Course_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Marvel`.`Prerequisite`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Marvel`.`Prerequisite` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `Course_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_Prerequisite_Course1_idx` (`Course_id` ASC),
  CONSTRAINT `fk_Prerequisite_Course1`
    FOREIGN KEY (`Course_id`)
    REFERENCES `Marvel`.`Course` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Marvel`.`student_grade`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Marvel`.`student_grade` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `Grade` VARCHAR(45) NULL,
  `Student_StudentNumber` CHAR(10) NOT NULL,
  `Course_id` INT NOT NULL,
  `Course_Department_code` CHAR(3) NOT NULL,
  PRIMARY KEY (`id`, `Student_StudentNumber`, `Course_id`, `Course_Department_code`),
  INDEX `fk_student_grade_Student1_idx` (`Student_StudentNumber` ASC),
  INDEX `fk_student_grade_Course1_idx` (`Course_id` ASC, `Course_Department_code` ASC),
  CONSTRAINT `fk_student_grade_Student1`
    FOREIGN KEY (`Student_StudentNumber`)
    REFERENCES `Marvel`.`Student` (`StudentNumber`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_student_grade_Course1`
    FOREIGN KEY (`Course_id` , `Course_Department_code`)
    REFERENCES `Marvel`.`Course` (`id` , `Department_code`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
