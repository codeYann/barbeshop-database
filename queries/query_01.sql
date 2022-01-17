-- Obtendo funcionarios com salarios maiores que 2000 e menor que 5000
SELECT nome_funcionario, funcionario.salario, cargo_funcionario
FROM funcionario
INNER JOIN cargo
  ON id_funcionario = idFuncionario
WHERE 
  (funcionario.salario > 2000 and funcionario.salario < 5000);

-- Obtendo nome dos clientes e o que eles compraram.
SELECT nome_cliente, email, nome, preco
FROM cliente, produto, compras
WHERE id_cliente = idCliente
and id_produto = idProduto;

-- Obtendo nome do fornecedor e cnpj dos produtos que começam com 'C'
SELECT nome_fornecedor, cnpj
FROM fornecedor
WHERE id_fornecedor
IN (
  SELECT id_produto
  FROM produto
  WHERE 
  nome
  LIKE 'C%'
);

-- Obtendo somatorio, média, maximo e minimo de salarios
SELECT 
  SUM(salario) AS "Somatorio dos salários", 
  AVG(salario) AS "Média dos salários", 
  MAX(salario) AS "Maior salário", 
  MIN(salario) AS "Menor salário"
FROM funcionario

-- Obter cargo do funcionario que possui a letra 'a' em seu nome
SELECT cargo_funcionario
FROM cargo
WHERE idFuncionario 
IN (
  SELECT id_funcionario 
  FROM funcionario 
  WHERE 
    nome_funcionario LIKE '%a%' 
  AND 
    TO_CHAR(dt_nascimento, 'YYYY-MM-DD') LIKE '____-08-__'
);

-- Visão  
CREATE VIEW INFORMACOES_MONETARIAS
AS SELECT 
  SUM(salario) AS "Somatorio dos salários", 
  AVG(salario) AS "Média dos salários", 
  MAX(salario) AS "Maior salário", 
  MIN(salario) AS "Menor salário"
FROM funcionario;

SELECT * FROM INFORMACOES_MONETARIAS;
