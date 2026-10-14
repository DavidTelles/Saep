-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `estoque_db` ;

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `estoque_db` DEFAULT CHARACTER SET utf8 ;
USE `estoque_db` ;

-- -----------------------------------------------------
-- Table `mydb`.`produtos`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `estoque_db`.`produtos` ;

CREATE TABLE IF NOT EXISTS `estoque_db`.`produtos` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(100) NOT NULL,
  `valor` DECIMAL(10,2) NOT NULL,
  `quantidade` INT NOT NULL,
  `categoria` VARCHAR(50) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`movimentacoes`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `estoque_db`.`movimentacoes` ;

CREATE TABLE IF NOT EXISTS `estoque_db`.`movimentacoes` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `data` DATETIME NOT NULL,
  `tipo` VARCHAR(45) NOT NULL,
  `quantidade` INT NULL,
  `produtos_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_movimentacoes_produtos_idx` (`produtos_id` ASC) VISIBLE)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;



SELECT * FROM produtos;

INSERT INTO produtos (nome, valor, quantidade, categoria)
VALUES
('Processador Ryzen', 800.00, 20, 'Peças'),
('Mouse', 80.00, 80, 'Periférico'),
('Body Splash', 47.90, 45, 'Perfume');

INSERT INTO movimentacoes (id, data, tipo, quantidade, produtos_id)
VALUES
(1, now(), 'entrada', 10, 1),
(2, now(), 'saida', 5, 2),
(3, now(), 'entrada', 8, 3);

SELECT * FROM movimentacoes;

CREATE VIEW vw_estoque AS
SELECT
	id,
	nome,
	quantidade,
	valor,
	(quantidade * valor) AS valor_total
FROM produtos;

SELECT*FROM vw_estoque;