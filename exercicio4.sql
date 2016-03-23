--Correção do exercício de banco


-- 1 - Qual é pessoa que mais participou nas copas seja como tecnico ou como jogador.
--questao 01 -  fazer uma uniao da tabela jogador e da tabela equipe

SELECT resultado.nome, SUM(cont) FROM

(SELECT  pessoa.nome, jogador.pessoa_cod, count(*)cont FROM jogador, pessoa
WHERE
jogador.pessoa_cod = pessoa.cod
GROUP BY 
pessoa.nome, jogador.pessoa_cod
--ORDER BY 	
--count(*) DESC

UNION ALL

SELECT pessoa.nome, equipe.tecnico as pessoa_cod, count(*) cont
FROM
equipe, pessoa
WHERE
equipe.tecnico = pessoa.cod
GROUP BY pessoa.nome, equipe.tecnico) resultado
GROUP BY resultado.nome
ORDER BY SUM(cont) DESC



--2 - Quais são os dois países que mais copas ganharam no banco de dados COPA.


SELECT pais.sigla, COUNT(pais.sigla) FROM equipe, pais,
(
	SELECT j.copa_ano, j.data, j.equipe1 AS equipe
	FROM jogo j
	WHERE 
	data = (SELECT MAX(data) FROM jogo WHERE copa_ano = j.copa_ano) AND
	j.ngols1 > j.ngols2
	GROUP BY 
	j.copa_ano, j.data, j.equipe1 

	UNION

	SELECT j.copa_ano, j.data, j.equipe2 AS equipe
	FROM jogo j
	WHERE 
	data = (SELECT MAX(data) FROM jogo WHERE copa_ano = j.copa_ano) AND
	j.ngols1 < j.ngols2
	GROUP BY 
	j.copa_ano, j.data, j.equipe2

) resultado
	
WHERE
equipe.cod = resultado.equipe AND
equipe.pais_cod = pais.cod
GROUP BY 
pais.sigla
ORDER BY 
COUNT(pais.sigla)
LIMIT 2

