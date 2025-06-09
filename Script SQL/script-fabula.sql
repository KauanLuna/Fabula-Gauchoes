-- Criação do banco de dados
CREATE DATABASE gauchada;

USE gauchada;

-- Tabela: gaucho
CREATE TABLE gaucho (
  id INT NOT NULL PRIMARY KEY,
  nome VARCHAR(45) NOT NULL,
  data_nasc DATE NOT NULL
);

-- Tabela: vendinha
CREATE TABLE vendinha (
  id INT NOT NULL PRIMARY KEY,
  nome VARCHAR(45) NOT NULL,
  fk_dono INT NOT NULL,
  FOREIGN KEY (fk_dono) REFERENCES gaucho(id)
);

-- Tabela: erva
CREATE TABLE erva (
  id INT NOT NULL PRIMARY KEY,
  fk_vendinha INT NOT NULL,
  nome VARCHAR(45) NOT NULL,
  intensidade VARCHAR(20) NOT NULL,
  FOREIGN KEY (fk_vendinha) REFERENCES vendinha(id),
  preco DOUBLE
);

-- Tabela: pedido
CREATE TABLE pedido (
  id INT,
  fk_gaucho INT NOT NULL,
  fk_item INT NOT NULL,
  data_pedido DATE,
  PRIMARY KEY (fk_gaucho, fk_item, id),
  FOREIGN KEY (fk_gaucho) REFERENCES gaucho(id),
  FOREIGN KEY (fk_item) REFERENCES erva(id)
);

-- Tabela: receita
CREATE TABLE receita (
  id INT NOT NULL PRIMARY KEY,
  desc_receita VARCHAR(45) NOT NULL,
  fk_erva INT NOT NULL,
  FOREIGN KEY (fk_erva) REFERENCES erva(id)
);

-- Tabela: chimarrao
CREATE TABLE chimarrao (
  id INT NOT NULL,
  fk_gaucho INT NOT NULL,
  fk_receita INT NOT NULL,
  PRIMARY KEY (id, fk_gaucho, fk_receita),
  FOREIGN KEY (fk_gaucho) REFERENCES gaucho(id),
  FOREIGN KEY (fk_receita) REFERENCES receita(id)
);

-- Tabela: turma
CREATE TABLE turma (
  fk_gaucho INT NOT NULL,
  id INT NOT NULL,
  PRIMARY KEY (fk_gaucho, id),
  FOREIGN KEY (fk_gaucho) REFERENCES gaucho(id)
);

INSERT INTO gaucho (id, nome, data_nasc) VALUES
(1, 'Anthony', '2003-01-29'),
(2, 'Flavio', '2005-05-04'),
(3, 'Gustavo', '2006-11-04'),
(4, 'Kauan', '2006-03-10'),
(5, 'Sandro', '2003-02-21'),
(6, 'Ademir', '1980-07-15'),
(7, 'Emerson', '1990-12-30'),
(8, 'José', '1995-08-19'),
(9, 'Antônio', '1985-04-25'),
(10, 'Cláudio', '2000-09-11');

INSERT INTO turma (fk_gaucho, id) VALUES
(1, 1),
(2, 1),
(3, 1),
(4, 1),
(5, 1);

INSERT INTO vendinha (id, nome, fk_dono) VALUES
(1, 'Vendinha Novo Mundo',6),
(2, 'Vendinha dos Faceiros', 7),
(3, 'Vendinha do Sul', 8),
(4, 'Vendinha Dos Gurizao', 9),
(5, 'Vendinha Cupinxa', 10);

INSERT INTO erva (id, fk_vendinha, nome, intensidade, preco) VALUES
(1, 1, 'Erva Mate Tradicional', 'Alta', 10),
(2, 2, 'Erva Mate Orgânica', 'Média', 25),
(3, 3, 'Erva Mate Aromática', 'Baixa', 20),
(4, 4, 'Erva Mate Premium', 'Alta', 45),
(5, 5, 'Erva Mate Gourmet', 'Média', 35),
(6, 2, 'Erva Mate Tradicional', 'Alta', 10),
(7, 1, 'Erva Mate Orgânica', 'Média', 25),
(8, 3, 'Erva Mate Aromática', 'Baixa', 20),
(9, 5, 'Erva Mate Premium', 'Alta', 45),
(10, 4, 'Erva Mate Gourmet', 'Média', 35);

INSERT INTO pedido (id, fk_gaucho, fk_item, data_pedido) VALUES
(1, 1, 1, '2024-11-21'),
(2, 2, 2, '2025-03-22'),
(3, 3, 3, '2025-06-03'),
(4, 4, 4, '2024-08-14'),
(5, 5, 5, '2025-12-15');

INSERT INTO receita (id, desc_receita, fk_erva) VALUES
(1, 'Receita Tradicional', 1),
(2, 'Receita Orgânica', 2),
(3, 'Receita Aromática', 3),
(4, 'Receita Premium', 4),
(5, 'Receita Gourmet', 5);

INSERT INTO chimarrao (id, fk_gaucho, fk_receita) VALUES
(1, 1, 1),
(2, 2, 2),
(3, 3, 3),
(4, 4, 1),
(5, 5, 2),
(6, 6, 4),
(7, 7, 4),
(8, 8, 5),
(9, 9, 5),
(10, 10, 3);

-- SELECTS NIVEL FÁCIL

SELECT nome, data_nasc FROM gaucho;

SELECT nome FROM vendinha; 

SELECT nome FROM gaucho WHERE nome LIKE '%o';

SELECT nome FROM gaucho WHERE nome LIKE '%n' AND data_nasc > '2000-01-01';

SELECT nome, data_nasc FROM gaucho ORDER BY data_nasc ASC;

SELECT nome, intensidade FROM erva WHERE intensidade = 'Alta';

SELECT data_pedido FROM pedido WHERE YEAR(data_pedido) = 2025;

SELECT DISTINCT(nome) FROM erva WHERE preco > 30;

SELECT DISTINCT(nome), preco FROM erva ORDER BY preco desc;

SELECT DISTINCT(nome), preco, intensidade FROM erva WHERE intensidade = 'Alta'; 

SELECT DISTINCT(nome), preco FROM erva ORDER BY preco desc limit 3;

SELECT DISTINCT(nome), preco FROM erva ORDER BY preco asc limit 3;

SELECT nome, data_nasc FROM gaucho ORDER BY data_nasc ASC LIMIT 3;

SELECT nome, data_nasc FROM gaucho ORDER BY data_nasc DESC LIMIT 3;

SELECT nome FROM gaucho WHERE nome LIKE '_a%';


-- SELECTS NIVEL MÉDIOS

SELECT v.nome, g.nome FROM vendinha v JOIN gaucho g ON g.id = fk_dono;
            
SELECT v.nome, g.nome FROM vendinha v JOIN gaucho g ON g.id = fk_dono WHERE v.nome LIKE '%o' AND g.nome LIKE '%a%' ORDER BY v.nome desc;

SELECT r.id, e.nome, r.desc_receita FROM erva e JOIN receita r ON e.id = r.fk_erva;

SELECT e.nome, r.desc_receita FROM erva e JOIN receita r ON e.id = r.fk_erva WHERE e.intensidade = 'alta';
                
SELECT max(preco) as MaiorPreco FROM erva;

SELECT min(preco) as MenorPreco FROM erva;

SELECT ROUND(avg(preco), 2) as MédiaPreco FROM erva WHERE intensidade = 'alta';
    
SELECT COUNT(id) as QuantidadeErvas FROM erva WHERE intensidade = 'média';
    
SELECT v.nome, e.nome, e.intensidade, e.preco FROM vendinha v JOIN erva e ON v.id = e.fk_vendinha WHERE e.intensidade = 'média' AND v.nome LIKE '%o%' ORDER BY v.nome desc;

SELECT COUNT(id) as QuantidadeDePedidos FROM pedido;
    
-- SELECTS DIFICEIS

SELECT g.nome, c.id NumeroDoChimarrao, e.preco FROM gaucho g JOIN chimarrao c ON g.id = c.fk_gaucho JOIN receita r ON r.id = c.fk_receita JOIN erva e ON e.id = r.fk_erva WHERE e.preco = (SELECT e.preco FROM erva e ORDER BY e.preco desc limit 1);

SELECT 
  g.nome AS nome_gaucho,
  v.nome AS nome_vendinha,
  e.nome AS nome_erva,
  e.preco,
  r.desc_receita,
  (
    SELECT COUNT(*)
    FROM pedido p
    WHERE p.fk_gaucho = g.id
      AND p.fk_item = e.id
  ) AS qtd_pedidos_erva_gaucho,
  (
    SELECT AVG(preco)
    FROM erva
    WHERE fk_vendinha = v.id
  ) AS media_preco_vendinha
FROM gaucho g
JOIN pedido p ON p.fk_gaucho = g.id
JOIN erva e ON e.id = p.fk_item
JOIN vendinha v ON v.id = e.fk_vendinha
LEFT JOIN receita r ON r.fk_erva = e.id
WHERE e.preco > (
  SELECT AVG(preco) FROM erva
)
ORDER BY qtd_pedidos_erva_gaucho DESC, media_preco_vendinha DESC;

select g.nome as 'Nome do gauchão',
case 
when t.fk_gaucho is not null then 'Gauchão é da turma'
else 'Gauchão não cola com os bacanas'
end as 'Turma',
ifnull(v.nome, 'Não tem vendinha') as 'Nome da vendinha'
from gaucho g left join vendinha v
on g.id = v.fk_DONO
LEFT JOIN turma t
on g.id = t.fk_gaucho;

select g.nome as 'Nome do gauchão',
p.id as 'Número do pedido',
p.data_pedido as 'Data do pedido',
e.nome as 'Nome da erva',
e.intensidade as 'Intensidade da erva'
from
gaucho g join pedido p 
on g.id = p.fk_gaucho
join erva e 
on p.fk_item = e.id
group by g.nome, p.id, p.data_pedido, e.nome, e.intensidade
having p.data_pedido between '2025-01-01' and '2025-12-31'
and e.intensidade = 'Média';

select
count(g.id) as 'Quantidade de gauchos',
count(p.id) as 'Quantidade de pedidos',
sum(e.preco) as 'Soma de todos os preços',
avg(e.preco) as 'Média de preço por erva'
from gaucho g left join pedido p
on g.id = p.fk_gaucho
left join erva e 
on p.fk_item = e.id;


