-- MySQL Script generated by MySQL Workbench
-- Tue Mar 16 19:25:28 2021
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Table `Status`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Status` ;

CREATE TABLE IF NOT EXISTS `Status` (
  `status` VARCHAR(30) NOT NULL,
  PRIMARY KEY (`status`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Users`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Users` ;

CREATE TABLE IF NOT EXISTS `Users` (
  `userID` INT NOT NULL AUTO_INCREMENT,
  `username` VARCHAR(45) NOT NULL,
  `firstName` VARCHAR(90) NOT NULL,
  `lastName` VARCHAR(90) NOT NULL,
  `address` VARCHAR(90) NOT NULL,
  `zipCode` VARCHAR(10) NOT NULL,
  `city` VARCHAR(45) NOT NULL,
  `phoneNumber` VARCHAR(45) NULL,
  `mobileNumber` VARCHAR(45) NULL,
  `emailAddress` VARCHAR(60) NOT NULL,
  `IMAddress` VARCHAR(45) NULL,
  `dateRegistered` TIMESTAMP NOT NULL,
  `password` VARCHAR(100) NOT NULL,
  `isAdmin` TINYINT NOT NULL DEFAULT 0,
  `isProjectLeader` TINYINT NOT NULL DEFAULT 0,
  `isGroupLeader` TINYINT NOT NULL DEFAULT 0,
  `isTemporary` TINYINT NOT NULL DEFAULT 0,
  `isCustomer` TINYINT NOT NULL DEFAULT 0,
  `isEmailVerified` TINYINT NOT NULL DEFAULT 0,
  `isVerifiedByAdmin` TINYINT NOT NULL DEFAULT 0,
  `status` VARCHAR(30) NOT NULL,
  PRIMARY KEY (`userID`),
  UNIQUE INDEX `UserID_UNIQUE` (`userID` ASC) VISIBLE,
  UNIQUE INDEX `Username_UNIQUE` (`username` ASC) VISIBLE,
  UNIQUE INDEX `Email address_UNIQUE` (`emailAddress` ASC) VISIBLE,
  INDEX `Users Status FK_idx` (`status` ASC) VISIBLE,
  CONSTRAINT `Users Status FK`
    FOREIGN KEY (`status`)
    REFERENCES `Status` (`status`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Projects`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Projects` ;

CREATE TABLE IF NOT EXISTS `Projects` (
  `projectName` VARCHAR(45) NOT NULL,
  `projectLeader` INT NULL,
  `startTime` TIMESTAMP NULL,
  `finishTime` TIMESTAMP NULL,
  `status` INT(1) NOT NULL,
  `customer` INT NULL,
  `isAcceptedByAdmin` TINYINT NOT NULL DEFAULT 0,
  PRIMARY KEY (`projectName`),
  INDEX `Project leader FK_idx` (`projectLeader` ASC) VISIBLE,
  INDEX `Projects Customer FK_idx` (`customer` ASC) VISIBLE,
  CONSTRAINT `Projects Project leader FK`
    FOREIGN KEY (`projectLeader`)
    REFERENCES `Users` (`userID`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE,
  CONSTRAINT `Projects Customer FK`
    FOREIGN KEY (`customer`)
    REFERENCES `Users` (`userID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Groups`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Groups` ;

CREATE TABLE IF NOT EXISTS `Groups` (
  `groupID` INT NOT NULL AUTO_INCREMENT,
  `groupName` VARCHAR(45) NOT NULL,
  `isAdmin` TINYINT NOT NULL DEFAULT 0,
  `groupLeader` INT NULL,
  INDEX `Groups Group leader_idx` (`groupLeader` ASC) VISIBLE,
  PRIMARY KEY (`groupID`),
  CONSTRAINT `Groups Group leader`
    FOREIGN KEY (`groupLeader`)
    REFERENCES `Users` (`userID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `TaskCategories`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `TaskCategories` ;

CREATE TABLE IF NOT EXISTS `TaskCategories` (
  `categoryName` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`categoryName`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `GroupsAndProjects`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `GroupsAndProjects` ;

CREATE TABLE IF NOT EXISTS `GroupsAndProjects` (
  `groupID` INT NOT NULL,
  `projectName` VARCHAR(45) NOT NULL,
  INDEX `GroupsAndProjects Project name FK_idx` (`projectName` ASC) VISIBLE,
  CONSTRAINT `GroupsAndProjects Group ID FK`
    FOREIGN KEY (`groupID`)
    REFERENCES `Groups` (`groupID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `GroupsAndProjects Project name FK`
    FOREIGN KEY (`projectName`)
    REFERENCES `Projects` (`projectName`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Tasks`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Tasks` ;

CREATE TABLE IF NOT EXISTS `Tasks` (
  `taskID` INT NOT NULL AUTO_INCREMENT,
  `category` VARCHAR(45) NULL,
  `parentTask` VARCHAR(45) NULL,
  `taskName` VARCHAR(45) NOT NULL,
  `startTime` TIMESTAMP NULL,
  `finishTime` TIMESTAMP NULL,
  `status` INT(1) NOT NULL DEFAULT 0,
  `projectName` VARCHAR(45) NULL,
  `estimatedTime` INT NULL,
  `timeLeft` INT NULL,
  `hasSubtasks` TINYINT NOT NULL DEFAULT 0,
  PRIMARY KEY (`taskID`),
  INDEX `Tasks TaskCategories FK_idx` (`category` ASC) VISIBLE,
  INDEX `Tasks Project name FK_idx` (`projectName` ASC) VISIBLE,
  CONSTRAINT `Tasks TaskCategories FK`
    FOREIGN KEY (`category`)
    REFERENCES `TaskCategories` (`categoryName`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `Tasks Project name FK`
    FOREIGN KEY (`projectName`)
    REFERENCES `Projects` (`projectName`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `UsersAndTasks`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `UsersAndTasks` ;

CREATE TABLE IF NOT EXISTS `UsersAndTasks` (
  `userID` INT NULL,
  `taskID` INT NULL,
  INDEX `UsersAndTasks UserID FK_idx` (`userID` ASC) VISIBLE,
  INDEX `UsersAndTasks Task ID FK_idx` (`taskID` ASC) VISIBLE,
  CONSTRAINT `UsersAndTasks UserID FK`
    FOREIGN KEY (`userID`)
    REFERENCES `Users` (`userID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `UsersAndTasks Task ID FK`
    FOREIGN KEY (`taskID`)
    REFERENCES `Tasks` (`taskID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `UsersAndGroups`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `UsersAndGroups` ;

CREATE TABLE IF NOT EXISTS `UsersAndGroups` (
  `groupID` INT NULL,
  `userID` INT NULL,
  INDEX `UsersAndGroups UserID_idx` (`userID` ASC) VISIBLE,
  CONSTRAINT `UsersAndGroups Group ID FK`
    FOREIGN KEY (`groupID`)
    REFERENCES `Groups` (`groupID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `UsersAndGroups UserID`
    FOREIGN KEY (`userID`)
    REFERENCES `Users` (`userID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `UsersAndProjects`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `UsersAndProjects` ;

CREATE TABLE IF NOT EXISTS `UsersAndProjects` (
  `userID` INT NULL,
  `projectName` VARCHAR(45) NULL,
  INDEX `UsersAndProjects Project name_idx` (`projectName` ASC) VISIBLE,
  CONSTRAINT `UsersAndProjects User ID`
    FOREIGN KEY (`userID`)
    REFERENCES `Users` (`userID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `UsersAndProjects Project name`
    FOREIGN KEY (`projectName`)
    REFERENCES `Projects` (`projectName`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `TaskDependencies`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `TaskDependencies` ;

CREATE TABLE IF NOT EXISTS `TaskDependencies` (
  `firstTask` INT NULL,
  `secondTask` INT NULL,
  INDEX `First Task FK_idx` (`firstTask` ASC) VISIBLE,
  INDEX `TaskDependencies Second Task FK_idx` (`secondTask` ASC) VISIBLE,
  CONSTRAINT `TaskDependencies First Task FK`
    FOREIGN KEY (`firstTask`)
    REFERENCES `Tasks` (`taskID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `TaskDependencies Second Task FK`
    FOREIGN KEY (`secondTask`)
    REFERENCES `Tasks` (`taskID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Report types`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Report types` ;

CREATE TABLE IF NOT EXISTS `Report types` (
  `reportType` VARCHAR(30) NOT NULL,
  PRIMARY KEY (`reportType`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `TasksAndGroups`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `TasksAndGroups` ;

CREATE TABLE IF NOT EXISTS `TasksAndGroups` (
  `taskID` INT NULL,
  `groupID` INT NULL,
  INDEX `TasksAndGorups Group name FK_idx` (`groupID` ASC) VISIBLE,
  INDEX `TasksAndGroups Task ID_idx` (`taskID` ASC) VISIBLE,
  CONSTRAINT `TasksAndGroups Group ID FK`
    FOREIGN KEY (`groupID`)
    REFERENCES `Groups` (`groupID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `TasksAndGroups Task ID`
    FOREIGN KEY (`taskID`)
    REFERENCES `Tasks` (`taskID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Phases`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Phases` ;

CREATE TABLE IF NOT EXISTS `Phases` (
  `phaseID` INT NOT NULL AUTO_INCREMENT,
  `phaseName` VARCHAR(45) NOT NULL,
  `projectName` VARCHAR(45) NOT NULL,
  `startTime` TIMESTAMP NULL,
  `finishTime` TIMESTAMP NULL,
  `status` INT(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`phaseID`),
  INDEX `Phases Project name FK_idx` (`projectName` ASC) VISIBLE,
  CONSTRAINT `Phases Project name FK`
    FOREIGN KEY (`projectName`)
    REFERENCES `Projects` (`projectName`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
COMMENT = '					';


-- -----------------------------------------------------
-- Table `PhasesAndTasks`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `PhasesAndTasks` ;

CREATE TABLE IF NOT EXISTS `PhasesAndTasks` (
  `phaseID` INT NULL,
  `taskID` INT NULL,
  INDEX `PhasesAndTasks Phase ID_idx` (`phaseID` ASC) VISIBLE,
  INDEX `PhasesAndTasks Task ID_idx` (`taskID` ASC) VISIBLE,
  CONSTRAINT `PhasesAndTasks Phase ID`
    FOREIGN KEY (`phaseID`)
    REFERENCES `Phases` (`phaseID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `PhasesAndTasks Task ID`
    FOREIGN KEY (`taskID`)
    REFERENCES `Tasks` (`taskID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Absence types`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Absence types` ;

CREATE TABLE IF NOT EXISTS `Absence types` (
  `absenceType` VARCHAR(30) NOT NULL,
  PRIMARY KEY (`absenceType`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Location`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Location` ;

CREATE TABLE IF NOT EXISTS `Location` (
  `location` VARCHAR(30) NOT NULL,
  PRIMARY KEY (`location`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Hours`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Hours` ;

CREATE TABLE IF NOT EXISTS `Hours` (
  `hourID` INT NOT NULL AUTO_INCREMENT,
  `taskID` INT NOT NULL,
  `WhoWorked` INT NOT NULL,
  `startTime` TIMESTAMP NULL,
  `endTime` TIMESTAMP NULL,
  `activated` TINYINT NOT NULL DEFAULT 1,
  `location` VARCHAR(30) NULL,
  `phaseID` INT NULL,
  `absenceType` VARCHAR(30) NULL,
  `overtimeType` INT(1) NULL,
  `comment` LONGTEXT NULL,
  `isChanged` TINYINT NOT NULL DEFAULT 0,
  `stampingStatus` TINYINT NOT NULL DEFAULT 0,
  PRIMARY KEY (`hourID`),
  INDEX `Hours Task ID FK_idx` (`taskID` ASC) VISIBLE,
  INDEX `Hours User ID FK_idx` (`WhoWorked` ASC) VISIBLE,
  INDEX `Hours Phase ID FK_idx` (`phaseID` ASC) VISIBLE,
  INDEX `Hours absence type_idx` (`absenceType` ASC) VISIBLE,
  INDEX `Hours Location_idx` (`location` ASC) VISIBLE,
  CONSTRAINT `Hours Task ID FK`
    FOREIGN KEY (`taskID`)
    REFERENCES `Tasks` (`taskID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `Hours User ID FK`
    FOREIGN KEY (`WhoWorked`)
    REFERENCES `Users` (`userID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `Hours Phase ID FK`
    FOREIGN KEY (`phaseID`)
    REFERENCES `Phases` (`phaseID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `Hours Absence type`
    FOREIGN KEY (`absenceType`)
    REFERENCES `Absence types` (`absenceType`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `Hours Location`
    FOREIGN KEY (`location`)
    REFERENCES `Location` (`location`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Reports`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Reports` ;

CREATE TABLE IF NOT EXISTS `Reports` (
  `reportID` INT NOT NULL AUTO_INCREMENT,
  `reportName` VARCHAR(45) NOT NULL,
  `generatedBy` INT NULL,
  `dateUpdated` TIMESTAMP NULL,
  `report` MEDIUMBLOB NOT NULL,
  `reportType` VARCHAR(30) NOT NULL,
  `fileType` VARCHAR(30) NOT NULL,
  `groupID` INT NULL,
  `projectName` VARCHAR(45) NULL,
  `phaseID` INT NULL,
  PRIMARY KEY (`reportID`),
  INDEX `Reports User ID FK_idx` (`generatedBy` ASC) VISIBLE,
  INDEX `Reports Report types FK_idx` (`reportType` ASC) VISIBLE,
  INDEX `Reports Group ID FK_idx` (`groupID` ASC) VISIBLE,
  INDEX `Reports Project name FK_idx` (`projectName` ASC) VISIBLE,
  INDEX `Reports Phase ID FK_idx` (`phaseID` ASC) VISIBLE,
  CONSTRAINT `Reports User ID FK`
    FOREIGN KEY (`generatedBy`)
    REFERENCES `Users` (`userID`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE,
  CONSTRAINT `Reports Report types FK`
    FOREIGN KEY (`reportType`)
    REFERENCES `Report types` (`reportType`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE,
  CONSTRAINT `Reports Group ID FK`
    FOREIGN KEY (`groupID`)
    REFERENCES `Groups` (`groupID`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE,
  CONSTRAINT `Reports Project name FK`
    FOREIGN KEY (`projectName`)
    REFERENCES `Projects` (`projectName`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE,
  CONSTRAINT `Reports Phase ID FK`
    FOREIGN KEY (`phaseID`)
    REFERENCES `Phases` (`phaseID`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

-- -----------------------------------------------------
-- Data for table `Status`
-- -----------------------------------------------------
START TRANSACTION;
INSERT INTO `Status` (`status`) VALUES ('Sick');
INSERT INTO `Status` (`status`) VALUES ('Travel');
INSERT INTO `Status` (`status`) VALUES ('Meeting');
INSERT INTO `Status` (`status`) VALUES ('Various');
INSERT INTO `Status` (`status`) VALUES ('Working');
INSERT INTO `Status` (`status`) VALUES ('Free');
INSERT INTO `Status` (`status`) VALUES ('N/A');

COMMIT;


-- -----------------------------------------------------
-- Data for table `Users`
-- -----------------------------------------------------
START TRANSACTION;
INSERT INTO `Users` (`userID`, `username`, `firstName`, `lastName`, `address`, `zipCode`, `city`, `phoneNumber`, `mobileNumber`, `emailAddress`, `IMAddress`, `dateRegistered`, `password`, `isAdmin`, `isProjectLeader`, `isGroupLeader`, `isTemporary`, `isCustomer`, `isEmailVerified`, `isVerifiedByAdmin`, `status`) VALUES (1, 'abdullah', 'Abdullah', 'Karagøz', 'Some address 45', '4568', 'Oslo', '+478999898', '+478797987', 'aka160@post.uit.no', 'someIMaddress', '2021-03-09 15:54:00', '$2y$10$34L1AX8nlMAeRm4kovfksOVeeohGUXCBnaCgTtvr6XbuY35W5gMlG', 1, 0, 0, 0, 0, 1, 1, 'Working');
INSERT INTO `Users` (`userID`, `username`, `firstName`, `lastName`, `address`, `zipCode`, `city`, `phoneNumber`, `mobileNumber`, `emailAddress`, `IMAddress`, `dateRegistered`, `password`, `isAdmin`, `isProjectLeader`, `isGroupLeader`, `isTemporary`, `isCustomer`, `isEmailVerified`, `isVerifiedByAdmin`, `status`) VALUES (2, 'halil', 'Halil Ibrahim', 'Keser', 'Some address 45', '4568', 'Oslo', '+478999898', '+478797987', 'hke006@post.uit.no', 'someIMaddress', '2021-03-09 15:54:00', '$2y$10$34L1AX8nlMAeRm4kovfksOVeeohGUXCBnaCgTtvr6XbuY35W5gMlG', 1, 0, 0, 0, 0, 1, 1, 'Working');
INSERT INTO `Users` (`userID`, `username`, `firstName`, `lastName`, `address`, `zipCode`, `city`, `phoneNumber`, `mobileNumber`, `emailAddress`, `IMAddress`, `dateRegistered`, `password`, `isAdmin`, `isProjectLeader`, `isGroupLeader`, `isTemporary`, `isCustomer`, `isEmailVerified`, `isVerifiedByAdmin`, `status`) VALUES (3, 'tore', 'Tore', 'Bjerkan', 'Some address 45', '4568', 'Oslo', '+478999898', '+478797987', 'tbj034@post.uit.no', 'someIMaddress', '2021-03-09 15:54:00', '$2y$10$34L1AX8nlMAeRm4kovfksOVeeohGUXCBnaCgTtvr6XbuY35W5gMlG', 1, 0, 0, 0, 0, 1, 1, 'Working');
INSERT INTO `Users` (`userID`, `username`, `firstName`, `lastName`, `address`, `zipCode`, `city`, `phoneNumber`, `mobileNumber`, `emailAddress`, `IMAddress`, `dateRegistered`, `password`, `isAdmin`, `isProjectLeader`, `isGroupLeader`, `isTemporary`, `isCustomer`, `isEmailVerified`, `isVerifiedByAdmin`, `status`) VALUES (4, 'are', 'Are Magnus Lohne|', 'Abrahamsen', 'Some address 45', '4568', 'Oslo', '+478999898', '+478797987', 'aab057@post.uit.no', 'someIMaddress', '2021-03-09 15:54:00', '$2y$10$34L1AX8nlMAeRm4kovfksOVeeohGUXCBnaCgTtvr6XbuY35W5gMlG', 1, 0, 0, 0, 0, 1, 1, 'Working');
INSERT INTO `Users` (`userID`, `username`, `firstName`, `lastName`, `address`, `zipCode`, `city`, `phoneNumber`, `mobileNumber`, `emailAddress`, `IMAddress`, `dateRegistered`, `password`, `isAdmin`, `isProjectLeader`, `isGroupLeader`, `isTemporary`, `isCustomer`, `isEmailVerified`, `isVerifiedByAdmin`, `status`) VALUES (5, 'asbjoern', 'Asbjørn', 'Bjørge', 'Some address 45', '4568', 'Oslo', '+478999898', '+478797987', 'abj075@post.uit.no', 'someIMaddress', '2021-03-09 15:54:00', '$2y$10$34L1AX8nlMAeRm4kovfksOVeeohGUXCBnaCgTtvr6XbuY35W5gMlG', 1, 0, 0, 0, 0, 1, 1, 'Working');
INSERT INTO `Users` (`userID`, `username`, `firstName`, `lastName`, `address`, `zipCode`, `city`, `phoneNumber`, `mobileNumber`, `emailAddress`, `IMAddress`, `dateRegistered`, `password`, `isAdmin`, `isProjectLeader`, `isGroupLeader`, `isTemporary`, `isCustomer`, `isEmailVerified`, `isVerifiedByAdmin`, `status`) VALUES (6, 'nicholai', 'Nicholai Mørch', 'Rindarøy', 'Some address 45', '4568', 'Oslo', '+478999898', '+478797987', 'nri007@post.uit.no', 'someIMaddress', '2021-03-09 15:54:00', '$2y$10$34L1AX8nlMAeRm4kovfksOVeeohGUXCBnaCgTtvr6XbuY35W5gMlG', 1, 0, 0, 0, 0, 1, 1, 'Working');
INSERT INTO `Users` (`userID`, `username`, `firstName`, `lastName`, `address`, `zipCode`, `city`, `phoneNumber`, `mobileNumber`, `emailAddress`, `IMAddress`, `dateRegistered`, `password`, `isAdmin`, `isProjectLeader`, `isGroupLeader`, `isTemporary`, `isCustomer`, `isEmailVerified`, `isVerifiedByAdmin`, `status`) VALUES (7, 'joergen', 'Jørgen', 'Rypdal', 'Some address 45', '4568', 'Oslo', '+478999898', '+478797987', 'jry017@post.uit.no', 'someIMaddress', '2021-03-09 15:54:00', '$2y$10$34L1AX8nlMAeRm4kovfksOVeeohGUXCBnaCgTtvr6XbuY35W5gMlG', 1, 0, 0, 0, 0, 1, 1, 'Working');
INSERT INTO `Users` (`userID`, `username`, `firstName`, `lastName`, `address`, `zipCode`, `city`, `phoneNumber`, `mobileNumber`, `emailAddress`, `IMAddress`, `dateRegistered`, `password`, `isAdmin`, `isProjectLeader`, `isGroupLeader`, `isTemporary`, `isCustomer`, `isEmailVerified`, `isVerifiedByAdmin`, `status`) VALUES (8, 'tine', 'Tine Nathalie', 'Joramo', 'Some address 45', '4568', 'Oslo', '+478999898', '+478797987', 'tjo221@post.uit.no', 'someIMaddress', '2021-03-09 15:54:00', '$2y$10$34L1AX8nlMAeRm4kovfksOVeeohGUXCBnaCgTtvr6XbuY35W5gMlG', 1, 0, 0, 0, 0, 1, 1, 'Working');

COMMIT;


-- -----------------------------------------------------
-- Data for table `TaskCategories`
-- -----------------------------------------------------
START TRANSACTION;
INSERT INTO `TaskCategories` (`categoryName`) VALUES ('Self-study');
INSERT INTO `TaskCategories` (`categoryName`) VALUES ('Course');
INSERT INTO `TaskCategories` (`categoryName`) VALUES ('Meeting');
INSERT INTO `TaskCategories` (`categoryName`) VALUES ('Project Engineering');
INSERT INTO `TaskCategories` (`categoryName`) VALUES ('Nothing ');
INSERT INTO `TaskCategories` (`categoryName`) VALUES ('');

COMMIT;


-- -----------------------------------------------------
-- Data for table `Report types`
-- -----------------------------------------------------
START TRANSACTION;
INSERT INTO `Report types` (`reportType`) VALUES ('Standard reports');
INSERT INTO `Report types` (`reportType`) VALUES ('Progress charts');
INSERT INTO `Report types` (`reportType`) VALUES ('Project report');
INSERT INTO `Report types` (`reportType`) VALUES ('Group report');

COMMIT;


-- -----------------------------------------------------
-- Data for table `Absence types`
-- -----------------------------------------------------
START TRANSACTION;
INSERT INTO `Absence types` (`absenceType`) VALUES ('Sick');
INSERT INTO `Absence types` (`absenceType`) VALUES ('Travel');
INSERT INTO `Absence types` (`absenceType`) VALUES ('Holyday');

COMMIT;


-- -----------------------------------------------------
-- Data for table `Location`
-- -----------------------------------------------------
START TRANSACTION;
INSERT INTO `Location` (`location`) VALUES ('Home');
INSERT INTO `Location` (`location`) VALUES ('Outside of the office');
INSERT INTO `Location` (`location`) VALUES ('Out of country');
INSERT INTO `Location` (`location`) VALUES ('Office');

COMMIT;

