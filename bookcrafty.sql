-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema bookcrafty
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema bookcrafty
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `bookcrafty`;
CREATE SCHEMA IF NOT EXISTS `bookcrafty` DEFAULT CHARACTER SET latin1 ;
USE `bookcrafty` ;

-- -----------------------------------------------------
-- Table `bookcrafty`.`categoria`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bookcrafty`.`categoria` (
  `id_categoria` INT(11) NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`id_categoria`))
ENGINE = InnoDB
AUTO_INCREMENT = 7
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `bookcrafty`.`editora`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bookcrafty`.`editora` (
  `id_editora` INT(11) NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(145) NULL DEFAULT NULL,
  PRIMARY KEY (`id_editora`))
ENGINE = InnoDB
AUTO_INCREMENT = 6
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `bookcrafty`.`usuario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bookcrafty`.`usuario` (
  `id_usuario` INT(11) NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(145) NULL DEFAULT NULL,
  `email` VARCHAR(145) NULL DEFAULT NULL,
  `senha` VARCHAR(200) NULL DEFAULT NULL,
  PRIMARY KEY (`id_usuario`))
ENGINE = InnoDB
AUTO_INCREMENT = 30
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `bookcrafty`.`endereco`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bookcrafty`.`endereco` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `endereco` VARCHAR(199) NULL DEFAULT NULL,
  `numero` INT(11) NULL DEFAULT NULL,
  `complemento` VARCHAR(255) NULL DEFAULT NULL,
  `cep` INT(8) NULL DEFAULT NULL,
  `uf` VARCHAR(2) NULL DEFAULT NULL,
  `fk_usuario` INT(11) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_usuario` (`fk_usuario` ASC),
  CONSTRAINT `fk_endereco_1`
    FOREIGN KEY (`fk_usuario`)
    REFERENCES `bookcrafty`.`usuario` (`id_usuario`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `bookcrafty`.`pedido`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bookcrafty`.`pedido` (
  `id_pedido` INT(11) NOT NULL AUTO_INCREMENT,
  `status` VARCHAR(45) NULL DEFAULT NULL,
  `fk_usuario` INT(11) NOT NULL,
  PRIMARY KEY (`id_pedido`),
  INDEX `fk_usuario` (`fk_usuario` ASC),
  CONSTRAINT `fk_pedido_1`
    FOREIGN KEY (`fk_usuario`)
    REFERENCES `bookcrafty`.`usuario` (`id_usuario`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
AUTO_INCREMENT = 11
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `bookcrafty`.`produto`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bookcrafty`.`produto` (
  `id_produto` INT(11) NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(150) NOT NULL,
  `descricao` VARCHAR(300) NULL DEFAULT NULL,
  `preco` FLOAT NULL DEFAULT NULL,
  `fk_categoria` INT(11) NOT NULL,
  `imagem` VARCHAR(500) NULL DEFAULT NULL,
  `fk_editora` INT(11) NOT NULL,
  PRIMARY KEY (`id_produto`),
  INDEX `fk_produto_categoria` (`fk_categoria` ASC),
  INDEX `fk_produto_editora1` (`fk_editora` ASC),
  CONSTRAINT `fk_produto_1`
    FOREIGN KEY (`fk_categoria`)
    REFERENCES `bookcrafty`.`categoria` (`id_categoria`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_produto_2`
    FOREIGN KEY (`fk_editora`)
    REFERENCES `bookcrafty`.`editora` (`id_editora`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 24
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `bookcrafty`.`item_pedido`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bookcrafty`.`item_pedido` (
  `id_item_pedido` INT(11) NOT NULL AUTO_INCREMENT,
  `fk_pedido` INT(11) NOT NULL,
  `fk_produto` INT(11) NOT NULL,
  PRIMARY KEY (`id_item_pedido`),
  INDEX `fk_pedido` (`fk_pedido` ASC),
  INDEX `fk_produto` (`fk_produto` ASC),
  CONSTRAINT `fk_item_pedido_1`
    FOREIGN KEY (`fk_pedido`)
    REFERENCES `bookcrafty`.`pedido` (`id_pedido`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_item_pedido_2`
    FOREIGN KEY (`fk_produto`)
    REFERENCES `bookcrafty`.`produto` (`id_produto`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
AUTO_INCREMENT = 18
DEFAULT CHARACTER SET = latin1;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;


USE bookcrafty;

--
-- Extraindo dados da tabela `categoria`
--

INSERT INTO `categoria` (`id_categoria`, `nome`) VALUES
(1, 'Ficção'),
(2, 'Tecnico'),
(3, 'Romance'),
(4, 'Mangá'),
(5, 'Programação'),
(6, 'Terror');

--
-- Extraindo dados da tabela `editora`
--

INSERT INTO `editora` (`id_editora`, `nome`) VALUES
(1, 'Saraiva'),
(2, 'Cultura'),
(3, 'Draco'),
(4, 'Abril'),
(5, 'Veronesi');

-- --------------------------------------------------------
--
-- Extraindo dados da tabela `produto`
--

INSERT INTO `produto` (`id_produto`, `nome`, `descricao`, `preco`, `fk_categoria`, `imagem`, `fk_editora`) VALUES
(1, 'Harry Potter', 'Lorem Ipsum is simply dummy text of the printing and typesetting industry', 30.5, 2, '/Images/potter.jpg', 1),
(2, 'Deserto dos Tartaros', 'Lorem Ipsum is simply dummy text of the printing and typesetting industry', 22, 3, '/Images/dino.jpg', 2),
(3, 'Brave New World', 'Lorem Ipsum is simply dummy text of the printing and typesetting industry', 45, 1, '/Images/huxley.jpg', 3),
(4, 'Percy Jackson', 'Lorem Ipsum is simply dummy text of the printing and typesetting industry', 40, 1, '/Images/percy.jpg', 4),
(5, 'A lenda do cavaleiro sem cabeça', 'Lorem Ipsum is simply dummy text of the printing and typesetting industry', 10, 2, '/Images/cavaleiro.jpg', 2),
(6, 'Mysql', 'Lorem Ipsum is simply dummy text of the printing and typesetting industry', 20, 5, '/Images/mysql.jpg', 3),
(7, 'Laravel Ninja', 'Lorem Ipsum is simply dummy text of the printing and typesetting industry', 15, 5, '/Images/ninjas.jpg', 2),
(8, 'Guiness Book 2019', 'Lorem Ipsum is simply dummy text of the printing and typesetting industry', 10, 2, '/Images/guiness.jpg', 4),
(9, 'Php para iniciantes', 'Lorem Ipsum is simply dummy text of the printing and typesetting industry', 30, 5, '/Images/php.jpg', 2),
(10, 'The Murder Book', 'Esse é o melhor livro', 9, 2, '/Images/murder.jpg', 1),
(11, 'Dungeons & Dragons', 'Lorem Ipsum is simply dummy text of the printing and typesetting industry', 8, 2, '/Images/dd.jpg', 3),
(12, 'O Hobbit', 'Lorem Ipsum is simply dummy text of the printing and typesetting industry', 10, 2, '/Images/hebit.jpg', 2),
(13, 'O guia do mochileiro das galáxias', 'Lorem Ipsum is simply dummy text of the printing and typesetting industry', 25, 2, '/Images/galaxia.jpg', 3),
(14, 'Boku No hero', 'Lorem Ipsum is simply dummy text of the printing and typesetting industry', 25, 4, '/Images/cdz.jpg', 4),
(15, 'O trono destruido', 'Lorem Ipsum is simply dummy text of the printing and typesetting industry', 14, 2, '/Images/trono.jpg', 4),
(16, 'One Punch Man', 'Lorem Ipsum is simply dummy text of the printing and typesetting industry', 40, 4, '/Images/saitama.jpg', 4),
(17, 'Naruto', 'Lorem Ipsum is simply dummy text of the printing and typesetting industry', 30, 4, '/Images/naruto.jpg', 4),
(18, 'Dragon Ball', 'Lorem Ipsum is simply dummy text of the printing and typesetting industry', 50, 4, '/Images/dragon.jpg', 4),
(19, 'Kahoot: O mal que nos espera', 'Lorem Ipsum is simply dummy text of the printing and typesetting industry', 25, 2, '/Images/kahot.jpg', 3),
(20, 'Aviões', 'Lorem Ipsum is simply dummy text of the printing and typesetting industry', 10, 1, '/Images/aviao.jpg', 1),
(21, 'O Processo', 'livro treta do kafka, não aguento', 45, 3, NULL, 2),
(22, 'A insustentável leveza do ser', 'livro treta, favor evitar, mas é otimo', 45, 3, '/storage/uploads/treta.jpg', 1);



--
-- Extraindo dados da tabela `usuario`
--

INSERT INTO `usuario` (`id_usuario`, `nome`, `email`, `senha`) VALUES
(1, 'anne', 'anne@mail.com', 'senha123'),
(2, 'hendy teste update agora vai', 'hendy@mail.com', 'hendy teste update'),
(3, 'vero', 'vero@mail.com', '123123'),
(4, 'Evangeline', 'est.Mauris.eu@Etiam.org', '8'),
(7, 'Cain', 'accumsan.interdum.libero@tempordiamdictum.net', '3'),
(8, 'Cyrus', 'sagittis.felis.Donec@uterosnon.com', '2'),
(9, 'Kirestin', 'Nunc.sed.orci@euenimEtiam.com', '4'),
(10, 'Samuel', 'metus.Aliquam.erat@CuraeDonectincidunt.org', '1'),
(11, 'Raymond', 'nulla.In@odio.edu', '5'),
(12, 'Timon', 'egestas.Duis@Pellentesquetincidunttempus.ca', '2'),
(13, 'Yetta', 'egestas@nibhvulputatemauris.ca', '7'),
(14, 'Hall', 'risus.Donec@nuncnulla.ca', '8'),
(15, 'Renee', 'cursus@duiSuspendisse.net', '2'),
(16, 'Lester', 'massa.rutrum@fringilla.co.uk', '9'),
(17, 'Bree', 'Praesent.eu.dui@conubianostraper.co.uk', '10'),
(18, 'Stephen', 'velit.Cras@ridiculus.ca', '7'),
(19, 'Harper', 'ante.dictum@dolordapibus.net', '10'),
(20, 'Edan', 'mi.lorem.vehicula@Vivamuseuismodurna.net', '8'),
(21, 'Ora', 'Integer.vulputate@liberoettristique.co.uk', '10'),
(22, 'Gay', 'dapibus.quam.quis@placeratvelitQuisque.co.uk', '9'),
(23, 'Bevis', 'accumsan.interdum.libero@odiovelest.org', '9'),
(24, 'vinicius teste', 'vinicius@email.com', '123456'),
(25, 'joão', 'joao@email.com', '123456'),
(26, 'Teste 1', 'teste1@email.com', '123456'),
(27, 'Teste 2', 'teste2@email.com', '223456'),
(28, 'Teste 3', 'teste3@email.com', '223456'),
(29, 'Teste 4', 'teste4@email.com', '123456');



-- Extraindo dados da tabela `pedido`
--

INSERT INTO `pedido` (`id_pedido`, `status`, `fk_usuario`) VALUES
(1, 'Aprovado', 1),
(2, 'Aprovado', 1),
(3, 'Criado', 1),
(4, 'Criado', 1),
(5, 'Criado', 1),
(6, 'Criado', 1),
(7, 'Criado', 1),
(8, 'Criado', 1),
(9, 'Criado', 1),
(10, 'Criado', 1);


--
-- Extraindo dados da tabela `item_pedido`
--

INSERT INTO `item_pedido` (`id_item_pedido`, `fk_pedido`, `fk_produto`) VALUES
(1, 1, 1),
(2, 1, 2),
(3, 2, 1),
(10, 1, 7),
(11, 2, 7),
(12, 8, 1),
(13, 8, 2),
(14, 9, 1),
(15, 9, 2),
(16, 10, 1),
(17, 10, 2);

-- --------------------------------------------------------

