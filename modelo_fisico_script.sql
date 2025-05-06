/*CREATE DATABASE db_sistema_faculdade;
use db_sistema_faculdade;*/


CREATE TABLE tbl_cursos (
	id_curso INT AUTO_INCREMENT PRIMARY KEY NOT NULL,
    descricao varchar(100),
    nome_curso VARCHAR(60) NOT NULL,
    duracao_semestres INT NOT NULL
);

CREATE TABLE tbl_materias (
	id_materia INT AUTO_INCREMENT PRIMARY KEY NOT NULL,
    nome_materia VARCHAR(60) NOT NULL,
    carga_horaria INT NOT NULL
);

CREATE TABLE tbl_cursos_materias (
	id_cursos_materias INT AUTO_INCREMENT PRIMARY KEY NOT NULL,
    FK_id_materia INT NOT NULL,
    FK_id_curso INT NOT NULL,
    
    CONSTRAINT FK_curso_cursoMateria
    FOREIGN KEY (FK_id_curso)
    REFERENCES tbl_cursos(id_curso),
    
    CONSTRAINT FK_materia_cursoMateria
    FOREIGN KEY (FK_id_materia)
    REFERENCES tbl_materias(id_materia)
);

CREATE TABLE tbl_professores (
	id_professor INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    nome_professor VARCHAR(60) NOT NULL,
    email_professor VARCHAR(60) NOT NULL, 
    telefone_professor INT NOT NULL,
    especialidade VARCHAR(100) NOT NULL
);

CREATE TABLE tbl_materias_professores (
	id_materia_professor INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    FK_id_materia INT NOT NULL,
    FK_id_professor INT NOT NULL,
    
    CONSTRAINT FK_materia_materiaProfessor
    FOREIGN KEY (FK_id_materia)
    REFERENCES tbl_materias(id_materia),
    
    CONSTRAINT FK_professor_materiaProfessor
    FOREIGN KEY (FK_id_professor)
    REFERENCES tbl_professores(id_professor)
);

CREATE TABLE tbl_horarios (
	id_horario INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    horario VARCHAR(10)
);

CREATE TABLE tbl_turmas (
	id_turma INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    ano INT NOT NULL,
    semestre INT NOT NULL,
    sala VARCHAR(10) NOT NULL,
    FK_id_horario INT NOT NULL,
    
    CONSTRAINT FK_horario_turma
    FOREIGN KEY (FK_id_horario)
    REFERENCES tbl_horarios(id_horario)
);

CREATE TABLE tbl_materias_turmas (
	id_materia_turma INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    FK_id_turma INT NOT NULL,
    FK_id_materia INT NOT NULL,
    
    CONSTRAINT FK_materia_materiaTurma
    FOREIGN KEY (FK_id_materia)
    REFERENCES tbl_materias(id_materia),
    
    CONSTRAINT FK_turma_materiaTurma
    FOREIGN KEY (FK_id_turma)
    REFERENCES tbl_turmas(id_turma)
);

CREATE TABLE tbl_endereco (
	id_endereco INT AUTO_INCREMENT PRIMARY KEY NOT NULL,
    rua VARCHAR(60) NOT NULL,
    bairro VARCHAR(60) NOT NULL, 
    cidade VARCHAR(60) NOT NULL,
    estado VARCHAR(30) NOT NULL
);

CREATE TABLE tbl_alunos (
	id_aluno INT AUTO_INCREMENT PRIMARY KEY NOT NULL,
	nome_aluno VARCHAR(60) NOT NULL,
    data_nascimento DATE NOT NULL,
    data_matricula DATE NOT NULL, 
    cpf CHAR(11) NOT NULL UNIQUE, 
    email_aluno VARCHAR(60) NOT NULL,
    telefone_aluno INT NOT NULL, 
	FK_id_endereco INT NOT NULL,
    
    CONSTRAINT FK_endereco_aluno
    FOREIGN KEY (FK_id_endereco)
    REFERENCES tbl_endereco(id_endereco)
);

CREATE TABLE tbl_alunos_turmas (
	id_aluno_turma INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    FK_id_turma INT NOT NULL,
    FK_id_aluno INT NOT NULL,
    
    CONSTRAINT FK_aluno_alunoTurma
    FOREIGN KEY (FK_id_aluno)
    REFERENCES tbl_alunos(id_aluno),
    
	CONSTRAINT FK_turma_alunoTurma
    FOREIGN KEY (FK_id_turma)
    REFERENCES tbl_turmas(id_turma)
);

CREATE TABLE tbl_faltas (
	id_falta INT AUTO_INCREMENT PRIMARY KEY NOT NULL,
	faltas INT NOT NULL,
    FK_id_aluno INT NOT NULL,
    FK_id_materia INT NOT NULL,
    
    CONSTRAINT FK_aluno_falta
    FOREIGN KEY (FK_id_aluno)
    REFERENCES tbl_alunos(id_aluno),
    
    CONSTRAINT FK_materia_falta
    FOREIGN KEY(FK_id_materia)
    REFERENCES tbl_materias(id_materia)
);

CREATE TABLE tbl_tipos_avaliacoes (
	id_tipo_avaliacao INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    nome_tipo_avaliacao VARCHAR(45) NOT NULL
);

CREATE TABLE tbl_avaliacoes (
	id_avaliacao INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    data_avaliacao DATETIME NOT NULL,
    FK_id_tipo_avaliacao INT NOT NULL,
    FK_id_professor INT NOT NULL,
    FK_id_turma INT NOT NULL,
    FK_id_materia INT NOT NULL,
    
    CONSTRAINT FK_tipoAvaliacao_avaliacao
    FOREIGN KEY (FK_id_tipo_avaliacao)
    REFERENCES tbl_tipos_avaliacoes(id_tipo_avaliacao),
    
    CONSTRAINT FK_professor_avaliacao
    FOREIGN KEY (FK_id_professor)
    REFERENCES tbl_professores(id_professor),
    
    CONSTRAINT FK_turma_avaliacao
    FOREIGN KEY (FK_id_turma)
    REFERENCES tbl_turmas(id_turma),
    
	CONSTRAINT FK_materia_avaliacao
    FOREIGN KEY (FK_id_materia)
    REFERENCES tbl_materias(id_materia)
);

CREATE TABLE tbl_notas (
	id_nota INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    nota DECIMAL(2,1) NOT NULL,
    FK_id_aluno INT NOT NULL,
    FK_id_avaliacao INT NOT NULL,
    
    CONSTRAINT FK_aluno_nota
    FOREIGN KEY (FK_id_aluno)
    REFERENCES tbl_alunos(id_aluno),
    
    CONSTRAINT FK_avalicao_nota
    FOREIGN KEY (FK_id_avaliacao)
    REFERENCES tbl_avaliacoes(id_avaliacao)
);

INSERT INTO tbl_cursos (descricao, nome_curso, duracao_semestres)
VALUES
('Curso de Análise e Desenvolvimento de Sistemas', 'ADS', 6),
('Curso de Engenharia de Software', 'Engenharia Software', 8);


INSERT INTO tbl_materias (nome_materia, carga_horaria)
VALUES
('Banco de Dados', 80),
('Programação Web', 60),
('Estrutura de Dados', 70);

INSERT INTO tbl_cursos_materias (FK_id_materia, FK_id_curso)
VALUES
(1, 1),
(2, 1),
(3, 2);

INSERT INTO tbl_professores (nome_professor, email_professor, telefone_professor, especialidade)
VALUES
('Maria da Silva', 'maria@faculdade.edu', 11999999999, 'Banco de Dados'),
('Carlos Oliveira', 'carlos@faculdade.edu', 11888888888, 'Programação'),
('Fernanda Lima', 'fernanda@faculdade.edu', 11777777777, 'Algoritmos');


INSERT INTO tbl_materias_professores (FK_id_materia, FK_id_professor)
VALUES
(1, 1),
(2, 2),
(3, 3);

INSERT INTO tbl_horarios (horario)
VALUES
('EAD'),
('MATUTINO'),
('NOTURNO');

INSERT INTO tbl_turmas (ano, semestre, sala, FK_id_horario)
VALUES
(2024, 1, '101A', 1),
(2024, 1, '202B', 2);

INSERT INTO tbl_materias_turmas (FK_id_turma, FK_id_materia)
VALUES
(1, 1),
(1, 2),
(2, 3);

INSERT INTO tbl_endereco (rua, bairro, cidade, estado)
VALUES
('Rua A', 'Centro', 'São Paulo', 'SP'),
('Rua B', 'Jardins', 'Campinas', 'SP');

INSERT INTO tbl_alunos (nome_aluno, data_nascimento, data_matricula, cpf, email_aluno, telefone_aluno, FK_id_endereco)
VALUES
('João Pedro', '2000-05-10', '2024-01-15', '12345678900', 'joao@email.com', 11911112222, 1),
('Ana Clara', '2001-08-22', '2024-01-15', '98765432100', 'ana@email.com', 11933334444, 2);

INSERT INTO tbl_alunos_turmas (FK_id_turma, FK_id_aluno)
VALUES
(1, 1),
(1, 2);

INSERT INTO tbl_faltas (faltas, FK_id_aluno, FK_id_materia)
VALUES
(2, 1, 1),
(0, 2, 1);

INSERT INTO tbl_tipos_avaliacoes (nome_tipo_avaliacao)
VALUES
('Prova'),
('Trabalho');

INSERT INTO tbl_avaliacoes (data_avaliacao, FK_id_tipo_avaliacao, FK_id_professor, FK_id_turma, FK_id_materia)
VALUES
('2024-05-10 08:00:00', 1, 1, 1, 1),
('2024-05-15 10:00:00', 2, 2, 1, 2);

INSERT INTO tbl_notas (nota, FK_id_aluno, FK_id_avaliacao)
VALUES
(8.5, 1, 1),
(9.0, 2, 1),
(7.0, 1, 2),
(8.0, 2, 2);


/* Alunos com turma, curso e endereço*/
SELECT 
    a.id_aluno,
    a.nome_aluno,
    t.ano,
    t.semestre,
    c.nome_curso,
    e.rua,
    e.bairro,
    e.cidade,
    e.estado
FROM tbl_alunos a
JOIN tbl_alunos_turmas at ON a.id_aluno = at.FK_id_aluno
JOIN tbl_turmas t ON at.FK_id_turma = t.id_turma
JOIN tbl_materias_turmas mt ON mt.FK_id_turma = t.id_turma
JOIN tbl_materias m ON mt.FK_id_materia = m.id_materia
JOIN tbl_cursos_materias cm ON cm.FK_id_materia = m.id_materia
JOIN tbl_cursos c ON cm.FK_id_curso = c.id_curso
JOIN tbl_endereco e ON a.FK_id_endereco = e.id_endereco
GROUP BY a.id_aluno;

/* Notas dos alunos por matéria e avaliação*/
SELECT 
    a.nome_aluno,
    m.nome_materia,
    av.data_avaliacao,
    ta.nome_tipo_avaliacao,
    n.nota
FROM tbl_notas n
JOIN tbl_alunos a ON n.FK_id_aluno = a.id_aluno
JOIN tbl_avaliacoes av ON n.FK_id_avaliacao = av.id_avaliacao
JOIN tbl_tipos_avaliacoes ta ON av.FK_id_tipo_avaliacao = ta.id_tipo_avaliacao
JOIN tbl_materias m ON av.FK_id_materia = m.id_materia;


/* Faltas por aluno e matéria*/
SELECT 
    a.nome_aluno,
    m.nome_materia,
    f.faltas
FROM tbl_faltas f
JOIN tbl_alunos a ON f.FK_id_aluno = a.id_aluno
JOIN tbl_materias m ON f.FK_id_materia = m.id_materia;

/* Todas as avaliações de uma turma com data, tipo e professo*/
SELECT 
    t.id_turma,
    m.nome_materia,
    av.data_avaliacao,
    ta.nome_tipo_avaliacao,
    p.nome_professor
FROM tbl_avaliacoes av
JOIN tbl_turmas t ON av.FK_id_turma = t.id_turma
JOIN tbl_materias m ON av.FK_id_materia = m.id_materia
JOIN tbl_professores p ON av.FK_id_professor = p.id_professor
JOIN tbl_tipos_avaliacoes ta ON av.FK_id_tipo_avaliacao = ta.id_tipo_avaliacao;









