USE master
DROP DATABASE revisao

CREATE DATABASE revisao
GO
USE revisao

CREATE TABLE aluno(
ra		INT				NOT NULL,
nome	VARCHAR(100)	NOT NULL,
idade	INT				NOT NULL	CHECK(idade > 0)
PRIMARY KEY(ra)
)
GO
CREATE TABLE curso(
codigo		INT			NOT NULL,
nome		VARCHAR(50)	NOT NULL,
area		VARCHAR(50)	NOT NULL
PRIMARY KEY(codigo)
)
GO
CREATE TABLE titulacao(
codigo	INT			NOT NULL,
titulo	VARCHAR(40)	NOT NULL
PRIMARY KEY(codigo)
)
GO
CREATE TABLE professor(
registro	INT		NOT NULL,
nome		VARCHAR(100)	NOT NULL,
titulacao	INT		NOT NULL
PRIMARY KEY(registro)
FOREIGN KEY(titulacao) REFERENCES titulacao(codigo)
)
GO
CREATE TABLE disciplina(
codigo			INT			NOT NULL,
nome			VARCHAR(80)	NOT NULL,
carga_horaria	INT			NOT NULL	CHECK(carga_horaria >= 32)
PRIMARY KEY(codigo)
)
GO
CREATE TABLE disciplina_professor(
disciplina_codigo	INT		NOT NULL,
professor_registro	INT		NOT NULL
PRIMARY KEY(disciplina_codigo, professor_registro)
FOREIGN KEY(disciplina_codigo) REFERENCES disciplina(codigo),
FOREIGN KEY(professor_registro)	REFERENCES professor(registro)
)
GO
CREATE TABLE aluno_disciplina(
disciplina_codigo	INT		NOT NULL,
aluno_ra			INT		NOT NULL
PRIMARY KEY(aluno_ra, disciplina_codigo)
FOREIGN KEY(aluno_ra) REFERENCES aluno(ra),
FOREIGN KEY(disciplina_codigo) REFERENCES disciplina(codigo)
)
GO
CREATE TABLE curso_disciplina(
disciplina_codigo	INT		NOT NULL,
curso_codigo		INT		NOT NULL
PRIMARY KEY(curso_codigo, disciplina_codigo)
FOREIGN KEY(curso_codigo) REFERENCES curso(codigo),
FOREIGN KEY(disciplina_codigo) REFERENCES disciplina(codigo)
)

INSERT INTO aluno VALUES
(3416,'DIEGO PIOVESAN DE RAMOS',18),
(3423,'LEONARDO MAGALH�ES DA ROSA',17),
(3434,'LUIZA CRISTINA DE LIMA MARTINELI',20),
(3440,'IVO ANDR� FIGUEIRA DA SILVA',25),
(3443,'BRUNA LUISA SIMIONI',37),
(3448,'THA�S NICOLINI DE MELLO',17),
(3457,'L�CIO DANIEL T�MARA ALVES',29),
(3459,'LEONARDO RODRIGUES',25),
(3465,'�DERSON RAFAEL VIEIRA',19),
(3466,'DAIANA ZANROSSO DE OLIVEIRA',21),
(3467,'DANIELA MAURER',23),
(3470,'ALEX SALVADORI PALUDO',42),
(3471,'VIN�CIUS SCHVARTZ',19),
(3472,'MARIANA CHIES ZAMPIERI',18),
(3482,'EDUARDO CAINAN GAVSKI',19),
(3483,'REDNALDO ORTIZ DONEDA',20),
(3499,'MAYELEN ZAMPIERON',22)

INSERT INTO curso VALUES
(1,'ADS','Ci�ncias da Computa��o'),
(2,'Log�stica','Engenharia Civil')

INSERT INTO titulacao VALUES
(1,'Especialista'),
(2,'Mestre'),
(3,'Doutor')

INSERT INTO professor VALUES
(1111,'Leandro',2),
(1112,'Antonio',2),
(1113,'Alexandre',3),
(1114,'Wellington',2),
(1115,'Luciano',1),
(1116,'Edson',2),
(1117,'Ana',2),
(1118,'Alfredo',1),
(1119,'Celio',2),
(1120,'Dewar',3),
(1121,'Julio',1)

INSERT INTO disciplina VALUES
(1,'Laborat�rio de Banco de Dados',80),
(2,'Laborat�rio de Engenharia de Software',80),
(3,'Programa��o Linear e Aplica��es',80),
(4,'Redes de Computadores',80),
(5,'Seguran�a da informa��o',40),
(6,'Teste de Software',80),
(7,'Custos e Tarifas Log�sticas',80),
(8,'Gest�o de Estoques',40),
(9,'Fundamentos de Marketing',40),
(10,'M�todos Quantitativos de Gest�o',80),
(11,'Gest�o do Tr�fego Urbano',	80),
(12,'Sistemas de Movimenta��o e Transporte',40)

INSERT INTO aluno_disciplina VALUES
(1,3416),
(4,3416),
(1,3423),
(2,3423),
(5,3423),
(6,3423),
(2,3434),
(5,3434),
(6,3434),
(1,3440),
(5,3443),
(6,3443),
(4,3448),
(5,3448),
(6,3448),
(2,3457),
(4,3457),
(5,3457),
(6,3457),
(1,3459),
(6,3459),
(7,3465),
(11,3465),
(8,3466),
(11,3466),
(8,3467),
(12,3467),
(8,3470),
(9,3470),
(11,3470),
(12,3470),
(7,3471),
(7,3472),
(12,3472),
(9,3482),
(11,3482),
(8,3483),
(11,3483),
(12,3483),
(8,3499)

INSERT INTO disciplina_professor VALUES
(1,1111),
(2,1112),
(3,1113),
(4,1114),
(5,1115),
(6,1116),
(7,1117),
(8,1118),
(9,1117),
(10,1119),
(11,1120),
(12,1121)

INSERT INTO curso_disciplina VALUES
(1,1),
(2,1),
(3,1),
(4,1),
(5,1),
(6,1),
(7,2),
(8,2),
(9,2),
(10,2),
(11,2),
(12,2)

--Como fazer as listas de chamadas, com RA e nome por disciplina ?	
SELECT d.nome, a.ra, a.nome
FROM aluno a, disciplina d, aluno_disciplina ad
WHERE a.ra = ad.aluno_ra
	AND d.codigo = ad.disciplina_codigo
ORDER BY d.nome ASC, a.ra ASC

--Fazer uma pesquisa que liste o nome das disciplinas e o nome dos professores que as ministram								
SELECT d.nome, p.nome
FROM disciplina d, professor p, disciplina_professor dp
WHERE d.codigo = dp.disciplina_codigo
	AND p.registro = dp.professor_registro

--Fazer uma pesquisa que , dado o nome de uma disciplina, retorne o nome do curso								
SELECT d.nome, c.nome
FROM disciplina d, curso c, curso_disciplina cp
WHERE d.codigo = cp.disciplina_codigo
	AND c.codigo = cp.curso_codigo

--Fazer uma pesquisa que , dado o nome de uma disciplina, retorne sua �rea								
SELECT d.nome, c.area
FROM disciplina d, curso c, curso_disciplina cp
WHERE d.codigo = cp.disciplina_codigo
	AND c.codigo = cp.curso_codigo

--Fazer uma pesquisa que , dado o nome de uma disciplina, retorne o t�tulo do professor que a ministra								
SELECT d.nome, t.titulo
FROM disciplina d, professor p, disciplina_professor dp, titulacao t
WHERE d.codigo = dp.disciplina_codigo
	AND p.registro = dp.professor_registro
	AND p.titulacao = t.codigo

--Fazer uma pesquisa que retorne o nome da disciplina e quantos alunos est�o matriculados em cada uma delas								
SELECT d.nome, COUNT(a.ra) as qtd_alunos
FROM disciplina d, aluno a, aluno_disciplina ad
WHERE d.codigo = ad.disciplina_codigo
	AND a.ra = ad.aluno_ra
GROUP BY d.nome

--Fazer uma pesquisa que, dado o nome de uma disciplina, retorne o nome do professor.  S� deve retornar de disciplinas que tenham, no m�nimo, 5 alunos matriculados													
SELECT d.nome, p.nome
FROM disciplina d, professor p, disciplina_professor dp, aluno a, aluno_disciplina ad
	WHERE d.codigo = dp.disciplina_codigo
	AND p.registro = dp.professor_registro
	AND d.codigo = ad.disciplina_codigo
	AND a.ra = ad.aluno_ra
GROUP BY d.nome, p.nome
HAVING COUNT(a.ra) >= 5

--Fazer uma pesquisa que retorne o nome do curso e a quatidade de professores cadastrados que ministram aula nele. A coluna deve se chamar quantidade													
SELECT c.nome, COUNT(p.registro) as quantidade
FROM curso c, professor p, disciplina d, curso_disciplina cd, disciplina_professor dp
WHERE c.codigo = cd.curso_codigo
	AND d.codigo = cd.disciplina_codigo
	AND p.registro = dp.professor_registro
	AND d.codigo = dp.disciplina_codigo
GROUP BY c.nome
