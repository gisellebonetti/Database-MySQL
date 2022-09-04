CREATE DATABASE agenda04_ti

USE agenda04_ti

CREATE TABLE Condominio (
	cod_condominio INT PRIMARY KEY AUTO_INCREMENT, 
	nome VARCHAR(30),
	endereco VARCHAR(30),
	matricula_sind INT,
	FOREIGN KEY(matricula_sind) REFERENCES sindico(matricula_sind)
)

CREATE TABLE Apartamento (
	numero_ap INT PRIMARY KEY not null,
	tipo_apart SET('PADRAO', 'COBERTURA'),
	cod_condominio INT,
	numero_garag INT,
	rg_propr VARCHAR(14)
)

ALTER TABLE Apartamento ADD CONSTRAINT fk_cod_condominio 
FOREIGN KEY(cod_condominio) REFERENCES Condominio(cod_condominio)

ALTER TABLE Apartamento ADD CONSTRAINT fk_numero_garag 
FOREIGN KEY(numero_garag) REFERENCES Garagem(numero_garag)

ALTER TABLE Apartamento ADD CONSTRAINT fk_rg_propr
FOREIGN KEY(rg_propr) REFERENCES Proprietario(rg_propr)

CREATE TABLE Proprietario (
	rg_propr VARCHAR (14) PRIMARY KEY,
	nome_propr VARCHAR(30),
	telefone_propr VARCHAR(20),
	email_propr VARCHAR(20)
)


CREATE TABLE Garagem(
	numero_garag INT,
	tipo_garag SET('PADRAO','COBERTA'),
	numero_ap INT
)

ALTER TABLE Garagem ADD CONSTRAINT pk_numero_garag
PRIMARY KEY(numero_garag)

ALTER TABLE Garagem ADD CONSTRAINT numero_ap 
FOREIGN KEY(numero_ap) REFERENCES Apartamento(numero_ap)

CREATE TABLE Sindico (
	matricula_sind INT PRIMARY KEY AUTO_INCREMENT,
	nome_sind VARCHAR (30),
	endereco_sind VARCHAR (20),
	telefone_sind VARCHAR (20)
)


SELECT * FROM Apartamento
SELECT * FROM Garagem
SELECT * FROM Sindico
SELECT * FROM Proprietario
SELECT * FROM Condominio

SELECT Apartamento.numero_ap, tipo_apart, tipo_garag, nome_propr, nome, endereco FROM Apartamento, Proprietario, Condominio, Garagem
WHERE Apartamento.numero_ap = '105' AND Apartamento.cod_condominio = Condominio.cod_condominio AND Apartamento.rg_propr = Proprietario.rg_propr AND Garagem.numero_garag = Apartamento.numero_garag

SELECT tipo_apart, tipo_garag FROM Apartamento, Garagem
WHERE Garagem.numero_garag = Apartamento.numero_garag

SELECT Proprietario.rg_propr, Apartamento.numero_ap FROM Proprietario, Apartamento
WHERE Proprietario.rg_propr = '5241789' AND Apartamento.rg_propr = Proprietario.rg_propr

ALTER TABLE Garagem
DROP FOREIGN KEY numero_ap


INSERT INTO Garagem VALUES (10, 'COBERTA', '100'), ('11', 'COBERTA', '101'),
('12', 'PADRAO', '102'), ('13', 'PADRAO', '103'), ('14', 'COBERTA', '104'),
('15', 'COBERTA', '105'), ('16', 'PADRAO', '106'), ('17', 'PADRAO', '107'),
('18', 'PADRAO', '108'), ('19', 'COBERTA', '109')
INSERT INTO Garagem VALUES ('20', 'COBERTA', '110')


INSERT INTO Apartamento VALUES 
('100', 'COBERTURA', '1', '10', '741852963'),
('101', 'COBERTURA', '2', '11', '123456789'),
('102', 'PADRAO', '1', '12', '46123586'),
('103', 'PADRAO', '1', '13', '456852963'),
('104', 'COBERTURA', '2', '14', '456123789'), 
('106', 'PADRAO', '1', '16', '77788522'),
('107', 'PADRAO', '2', '17', '85296315'),
('108', 'PADRAO', '2', '18', '857412X'),
('109', 'COBERTURA', '1', '19', '5241789'), -- PROPRIETARIO COM MAIS DE UM APARTAMENTO
('105', 'COBERTURA', '2', '15','46123586')
INSERT INTO Apartamento VALUES ('110', 'COBERTURA', '1', '20', '5241789') -- PROPRIETARIO COM MAIS DE UM APARTAMENTO

INSERT INTO Sindico VALUES (null, 'João Mendes da Silva', 'Av. Brasil, 25 - SP', '11987456123')
INSERT INTO Sindico VALUES (null, 'Ana Laura de Moraes', 'Rua Vinte, 100 - SP', '11985274196')

INSERT INTO Proprietario VALUES ('859674123', 'Maria Joana', '11968415278', 'maria@joana'),
('741852963', 'Jonas da Silva', '11985741263', 'jonas@silva')
INSERT INTO Proprietario VALUES ('123456789', 'Maria Helena', '11912549632', 'maria@helena'), 
('857412X', 'Ana Aparecida Melo', '11974851236', 'ana@melo'), 
('77788522', 'Leticia Alves', '11985120358', 'leticia@alves'),
('85296315', 'Marcos Ribeiro', '11978451263', 'marcos@ribeiro'), 
('5241789', 'Mariana Silva', '13984125398', 'mariana@silva'),
('46123586', 'Mario Siqueira', '13974859625', 'mario@siqueira'), 
('456852963', 'Paloma Oliveira', '1145789632', 'paloma@oliveira'),
('456123789', 'Tarcisio Lima', '11978945612', 'tarcisio@lima')

INSERT INTO Condominio VALUES (null, 'Belas Artes', 'Rua Vinte, 100 - SP', '1'), (null, 'Belas Artes', 'Av. Brasil, 25 - SP', '2')

UPDATE Apartamento SET rg_propr = '77788522' WHERE numero_ap = 100 -- VENDA DO APARTAMENTO PARA OUTRO PROPRIETARIO

SELECT rg_propr, nome_propr FROM Proprietario
	WHERE Proprietario.rg_propr NOT IN (SELECT rg_propr FROM Apartamento) -- PROPRIETARIOS QUE ESTÃO SEM APARTAMENTO

DELETE FROM Proprietario 
	WHERE Proprietario.rg_propr = '741852963'
    
DELETE FROM Proprietario 
	WHERE Proprietario.rg_propr = '859674123'




