CREATE DATABASE db.faculdade;

CREATE TABLE departamento (
	id_departamento SERIAL PRIMARY KEY,
	nome_departamento VARCHAR(20)
);


CREATE TABLE professor(
	cod_professor SERIAL PRIMARY KEY,
	nome_professor VARCHAR(20) NOT NULL,
	sobrenome_professor VARCHAR(20) NOT NULL,
	status boolean, 
	cod_departamento INT
);

ALTER TABLE professor ADD CONSTRAINT fk_professor_departamento 
FOREIGN KEY (cod_departamento) REFERENCES departamento (id_departamento);

CREATE TABLE curso(
	id_curso SERIAL PRIMARY KEY,
	nome_curso VARCHAR(20),
	cod_departamento INT
);

ALTER TABLE curso ADD CONSTRAINT fk_curso_departamento 
FOREIGN KEY (cod_departamento) REFERENCES departamento (id_departamento);

CREATE TABLE disciplina (
	cod_disciplina SERIAL PRIMARY KEY,
	cod_disciplina_depende INT NULL,
	nome_disciplina VARCHAR(20),
	cod_departamento INT,
	carga_horaria INT NOT NULL,
	descricao TEXT,
	num_alunos INT
);

ALTER TABLE disciplina ADD CONSTRAINT fk_disciplina_depende
FOREIGN KEY (cod_disciplina_depende) REFERENCES disciplina (cod_disciplina);

ALTER TABLE disciplina ADD CONSTRAINT fk_disciplina_departamento 
FOREIGN KEY (cod_departamento) REFERENCES departamento (id_departamento);

CREATE TABLE prof_disc(
	cod_professor INT NOT NULL,
	cod_disciplina INT NOT NULL,
	PRIMARY KEY (cod_professor, cod_disciplina)
);

ALTER TABLE prof_disc ADD CONSTRAINT fk_professor_prof_disc 
FOREIGN KEY (cod_professor) REFERENCES professor (cod_professor);

ALTER TABLE prof_disc ADD CONSTRAINT fk_disciplina_prof_disc 
FOREIGN KEY (cod_disciplina) REFERENCES disciplina (cod_disciplina);


CREATE TABLE cur_disc(
	cod_curso INT NOT NULL,
	cod_disciplina INT NOT NULL,
	PRIMARY KEY (cod_curso, cod_disciplina)
);

ALTER TABLE cur_disc ADD CONSTRAINT fk_curso_cur_disc 
FOREIGN KEY (cod_curso) REFERENCES curso (id_curso);

ALTER TABLE cur_disc ADD CONSTRAINT fk_disciplina_cur_disc 
FOREIGN KEY (cod_disciplina) REFERENCES disciplina (cod_disciplina);


CREATE TABLE turma(
	cod_turma SERIAL PRIMARY KEY,
	cod_curso INT,
	periodo VARCHAR(8),
	num_alunos INT,
	data_inicio DATE,
	data_fim DATE
);

ALTER TABLE turma ADD CONSTRAINT fk_turma_curso
FOREIGN KEY (cod_curso) REFERENCES curso(id_curso);

CREATE TABLE aluno (
	ra SERIAL PRIMARY KEY,
	nome_aluno VARCHAR(20),
	sobrenome_aluno VARCHAR(50),
	cpf VARCHAR(14) UNIQUE,
	sexo VARCHAR(1),
	status BOOLEAN NOT NULL,
	cod_turma INT,
	cod_curso INT,
	nome_mae VARCHAR(60),
	nome_pai VARCHAR(60),
	email VARCHAR(100),
	whatsapp VARCHAR(15)
);

ALTER TABLE aluno ADD CONSTRAINT fk_aluno_curso
FOREIGN KEY (cod_curso) REFERENCES curso (id_curso);

ALTER TABLE aluno ADD CONSTRAINT fk_aluno_turma
FOREIGN KEY (cod_turma) REFERENCES turma (cod_turma);

CREATE TABLE tipo_telefone(
	cod_tipo_telefone SERIAL PRIMARY KEY,
	tipo_telefone VARCHAR(60)
);

CREATE TABLE telefone_aluno(
	cod_tel_aluno SERIAL PRIMARY KEY,
	ra int,
	cod_tipo_telefone int,
	num_telefone varchar(15)
);

ALTER TABLE telefone_aluno ADD CONSTRAINT fk_telefone_aluno
FOREIGN KEY (ra) REFERENCES aluno (ra);

ALTER TABLE telefone_aluno ADD CONSTRAINT fk_telefone_tipo
FOREIGN KEY (cod_tipo_telefone) REFERENCES tipo_telefone (cod_tipo_telefone);


CREATE TABLE tipo_logradouro(
	cod_tipo_logradouro SERIAL PRIMARY KEY,
	tipo_logradouro VARCHAR(60)
);

CREATE TABLE endereco_aluno(
	cod_endereco SERIAL PRIMARY KEY,
	ra INT,
	cod_tipo_logradouro INT,
	nome_rua VARCHAR(30),
	num_rua VARCHAR(5),
	complemento VARCHAR(20),
	cep VARCHAR(10)
);

ALTER TABLE endereco_aluno ADD CONSTRAINT fk_endereco_aluno
FOREIGN KEY (ra) REFERENCES aluno (ra);

ALTER TABLE endereco_aluno ADD CONSTRAINT fk_endereco_tipo
FOREIGN KEY (cod_tipo_logradouro) REFERENCES tipo_logradouro (cod_tipo_logradouro);

CREATE TABLE aluno_disc(
	ra INT,
	cod_disciplina INT,
	PRIMARY KEY (ra, cod_disciplina)
);

ALTER TABLE aluno_disc ADD CONSTRAINT fk_aluno_disc_ra
FOREIGN KEY (ra) REFERENCES aluno (ra);

ALTER TABLE aluno_disc ADD CONSTRAINT fk_aluno_disc_disciplina
FOREIGN KEY (cod_disciplina) REFERENCES disciplina (cod_disciplina);

CREATE TABLE historico(
	cod_historico SERIAL PRIMARY KEY,
	ra INT,
	data_inicio DATE,
	data_fim DATE
);

ALTER TABLE historico ADD CONSTRAINT fk_historico_aluno
FOREIGN KEY (ra) REFERENCES aluno (ra);

CREATE TABLE hist_disc (
	cod_historico INT,
	cod_disciplina INT,
	frequencia INT,
	nota INT,
	PRIMARY KEY (cod_historico, cod_disciplina)
);

ALTER TABLE hist_disc ADD CONSTRAINT fk_hist_disc_historico
FOREIGN KEY (cod_historico) REFERENCES historico (cod_historico);

ALTER TABLE hist_disc ADD CONSTRAINT fk_hist_disc_disciplina
FOREIGN KEY (cod_disciplina) REFERENCES disciplina (cod_disciplina);


-- INSERCAO NA TABELA -- 


INSERT INTO Departamento (Nome_Departamento)
VALUES
('Ciências Humanas'),
('Matemática'),
('Biológicas'),
('Estágio');


SELECT * FROM departamento


INSERT INTO Professor (Nome_Professor, Sobrenome_Professor, Status, Cod_Departamento)
VALUES
('Fábio', 'dos Reis', false, 2),
('Sophie', 'Allemand', true, 1),
('Monica', 'Barroso', true, 3);

SELECT * FROM professor

INSERT INTO Curso (Nome_Curso, Cod_Departamento)
VALUES
('Matemática', 2),
('Psicologia', 1),
('Análise de Sistemas', 2),
('Biologia', 3),
('História', 1),
('Engenharia', 2);

INSERT INTO Turma (Cod_Curso, Periodo, Num_Alunos, Data_Inicio, Data_Fim)
VALUES
(2, 'Manhã', 20, '2016-05-12', '2017-10-15'),
(1, 'Noite', 10, '2014-05-12', '2020-03-05'),
(3, 'Tarde', 15, '2012-05-12', '2014-05-10');

INSERT INTO Disciplina (Nome_Disciplina, Cod_Departamento, Carga_Horaria, Descricao, Num_Alunos)
VALUES
('Raciocínio Lógico', 2, 1200, 'Desenvolver o raciocínio lógico', 50),
('Psicologia Cognitiva', 1, 1400, 'Entender o funcionamento do aprendizado', 30),
('Programação em C', 2, 1200, 'Aprender uma linguagem de programação', 20),
('Eletrônica Digital', 2, 300, 'Funcionamento de circuitos digitais', 30);

INSERT INTO Aluno (Nome_Aluno, Sobrenome_Aluno, CPF, Status, Cod_Turma, Sexo, Cod_Curso, Nome_Pai, Nome_Mae, Email, Whatsapp)
VALUES
('Marcos', 'Aurelio Martins', 14278914536, true, 2, 'M', 3, 'Marcio Aurelio', 'Maria Aparecida', 'marcosaurelio@gmail.com', 946231249),
('Gabriel', 'Fernando de Almeida', 14470954536, true, 1, 'M', 1, 'Adão Almeida', 'Fernanda Almeida', 'gabrielalmeida@yahoo.com', 941741247),
('Beatriz', 'Sonia Meneguel', 1520984537, true, 3, 'F', 3, 'Samuel Meneguel', 'Gabriella Meneguel', 'batrizmene@hotmail.com', 945781412),
('Jorge', 'Soares', 14223651562, true, 3, 'M', 4, 'João Soares', 'Maria Richter', 'jorgesoares@gmail.com', 925637857),
('Ana Paula', 'Ferretti', 32968914522, true, 3, 'F', 5, 'Marcio Ferretti', 'Ana Hoffbahn', 'anapaulaferretti@hotmail.com', 974267423),
('Mônica', 'Yamaguti', 32988914510, true, 2, 'F', 6, 'Wilson Oliveira', 'Fernanda Yamaguti', 'monyamaguti@outlook.com', 932619560);

SELECT * FROM ALUNO;

INSERT INTO Aluno_Disc (RA, Cod_Disciplina)
VALUES
(3, 1),
(1, 2),
(2, 3),
(4, 3),
(5, 4),
(6, 1);

INSERT INTO Cur_Disc(Cod_Curso, Cod_Disciplina)
VALUES
(1, 1),
(2, 2),
(3, 3),
(6, 4);

INSERT INTO Prof_Disc(Cod_Professor, Cod_Disciplina)
VALUES
(2, 1),
(1, 2),
(3, 3),
(2, 4);

INSERT INTO Historico (RA, Data_Inicio, Data_FiM)
VALUES
(2, '2016-05-12', '2017-10-15'),
(3, '2014-05-12', '2020-03-05'),
(1, '2010-05-12', '2012-05-10');

INSERT INTO Tipo_Logradouro (Tipo_Logradouro)
VALUES
('Rua'),
('Avenida'),
('Alameda'),
('Travessa');

INSERT INTO Endereco_Aluno (RA, Cod_Tipo_Logradouro, Nome_Rua, Num_Rua, Complemento, CEP)
VALUES
(2, 1, 'das Giestas', 255, 'Casa 02', 02854000),
(3, 3, 'Lorena', 10, 'Apto 15', 02945000),
(1, 2, 'do Cursino', 1248, '', 0851040),
(4, 1, 'das Heras', 495, '', 03563142),
(5, 3, 'Santos', 1856, '', 04523963),
(6, 4, 'Matão', 206, '', 04213650);


ALTER TABLE hist_disc
ALTER COLUMN nota TYPE NUMERIC(4,2)

INSERT INTO hist_disc (Cod_Historico, Cod_Disciplina, Nota, Frequencia)
VALUES
(1, 2, 7, 6), 
(2, 3, 8.5, 2), 
(3, 1, 6.8, 8);

INSERT INTO Tipo_Telefone (Tipo_Telefone)
VALUES
('Res'),
('Com'),
('Cel'),
('Rec');

INSERT INTO Telefone_Aluno (RA, Cod_Tipo_Telefone, Num_Telefone)
VALUES
(1, 1, 28467853),
(2, 1, 24653298),
(2, 3, 996324521),
(3, 1, 36549875),
(3, 3, 994532165),
(4, 1, 21956345),
(4, 3, 986321452),
(5, 1, 24569832),
(5, 2, 23854696),
(6, 1, 27698753);
