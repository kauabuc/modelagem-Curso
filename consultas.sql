--1. RAs, Nomes e Sobrenomes dos Alunos, Nomes dos Cursos e Períodos das Turmas, ordenados pelo primeiro nome de aluno:
SELECT 
	a.ra,
	a.nome_aluno,
	a.sobrenome_aluno,
	t.periodo,
	c.nome_curso
FROM aluno a 
INNER JOIN curso c 
ON c.id_curso = a.cod_curso
INNER JOIN turma t
ON t.cod_turma = a.cod_turma
ORDER BY a.nome_aluno;



-- 2.Buscar a aluna BEATRIZ
SELECT 
	a.nome_aluno,
	a.sobrenome_aluno,
	d.nome_disciplina,
	hd.nota
FROM aluno a 
INNER JOIN aluno_disc ad
ON ad.ra = a.ra
INNER JOIN disciplina d
ON d.cod_disciplina = ad.cod_disciplina
INNER JOIN historico h
ON h.ra = a.ra
INNER JOIN hist_disc hd
ON h.cod_historico = hd.cod_historico
WHERE a.ra = 3;


--3. Nomes e sobrenomes dos professores, e disciplinas que ministram com suas cargas horárias:
SELECT
	CONCAT(p.nome_professor, ' ', p.sobrenome_professor) as Docente,
	d.nome_disciplina,
	d.carga_horaria
FROM professor p
INNER JOIN prof_disc pd
ON pd.cod_professor = p.cod_professor
INNER JOIN disciplina d 
ON d.cod_disciplina = pd.cod_disciplina;



-- 4.Gerar "relatório" com nomes, sobrenomes, CPF dos alunos, tipos e números de telefones e endereços completos.
SELECT 
	CONCAT(a.nome_aluno, ' ', a.sobrenome_aluno),
	a.cpf,
	ta.num_telefone,
	CONCAT(tl.tipo_logradouro, ' ', ea.nome_rua, ', ', ea.num_rua),
	ea.complemento,
	ea.cep
FROM aluno a
INNER JOIN telefone_aluno ta
ON ta.ra = a.ra
INNER JOIN endereco_aluno ea
ON ea.ra = a.ra
INNER JOIN tipo_logradouro tl
ON tl.cod_tipo_logradouro = ea.cod_tipo_logradouro;




--5. Listar as disciplinas, indicando seus departamentos, cursos e professores
SELECT
	c.nome_curso,
	di.nome_disciplina,
	CONCAT(p.nome_professor, ' ', p.sobrenome_professor) as Docente,
	de.nome_departamento
from disciplina di
INNER JOIN departamento de
ON de.id_departamento = di.cod_departamento
INNER JOIN prof_disc pd
ON pd.cod_disciplina = di.cod_disciplina
INNER JOIN professor p
ON p.cod_professor = pd.cod_professor
INNER JOIN cur_disc cd
ON cd.cod_disciplina = di.cod_disciplina
INNER JOIN curso c
ON c.id_curso = cd.cod_curso;


 

