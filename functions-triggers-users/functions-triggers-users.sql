-- (a) Criar um procedimento armazenado (Stored Procedure)

/* Dado o nome de determinado fornecedor, determinar a quantidade de produtos
que aquele fornecedor fornece.
*/

CREATE FUNCTION qtd_produtos_que_determinado_fornecedor_fornece(nome_forn VARCHAR(45))
RETURNS INTEGER AS $$
BEGIN

return COUNT(*)
FROM FORNECEDOR, PRODUTO
WHERE nome_fornecedor = nome_forn AND idFornecedor = id_fornecedor;

END;

$$ LANGUAGE 'plpgsql';

SELECT qtd_produtos_que_determinado_fornecedor_fornece('bruno');
SELECT qtd_produtos_que_determinado_fornecedor_fornece('felipe');
-- (b) Criar um gatilho (Trigger) NAO relacionado ao procedimento do item item (a)

/*

*/

-- Tabela para registrar os log's em relacao a alteracao nos produtos
CREATE TABLE IF NOT EXISTS log_produto (
	data_log DATE,
	msg VARCHAR(70),
	usuario VARCHAR(45)
);

DROP TABLE IF EXISTS log_produto;

-- Funcao responsavel: se determinado produto for atualizado com preco abaixo de R$ 20
-- o gatilho (Trigger) é acionado
CREATE FUNCTION funcao_log_produto() RETURNS trigger AS $$
BEGIN
	IF (NEW.preco < 20) THEN
		INSERT INTO log_produto VALUES
		(now(), 'Tentativa de registro de Produto abaixo do valor permitido', USER);
		RETURN NEW;
	END IF;
	
	RETURN NEW;
END;

$$ LANGUAGE 'plpgsql';

DROP FUNCTION funcao_log_produto() CASCADE;

-- Criacao do gatilho (Trigger)
CREATE TRIGGER verificar_valor_de_produtos
AFTER UPDATE ON PRODUTO
FOR EACH ROW EXECUTE PROCEDURE funcao_log_produto();

-- Realizando Update do produto 5 com valor abaixo do permitido (Triiger sera acionada)
UPDATE PRODUTO
SET preco = 7
WHERE id_produto = 5;

-- Realizando Update do produto com valor permitido (Trigger nao sera acionada)
UPDATE PRODUTO
SET preco = 56
WHERE id_produto = 8;

select * from log_produto;

-- (c) Criar 2 usuários
-- 1 Deve ter acesso administrativo somente para o banco de dados criado
-- 2 Deve ter acesso somente a leitura para o banco de dados criado

CREATE USER adm_db LOGIN SUPERUSER ENCRYPTED PASSWORD 'barbearia';
GRANT ALL PRIVILEGES ON agendamento, cargo, cliente, compras, fornecedor,
funcionario, log_produto, prestar_servico, produto, servico, telefone TO adm_db;

CREATE USER usuario_comum NOSUPERUSER LOGIN ENCRYPTED PASSWORD '123';
GRANT SELECT ON agendamento, cargo, cliente, compras, fornecedor,
funcionario, log_produto, prestar_servico, produto, servico, telefone TO usuario_comum;