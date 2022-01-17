-- Primeira etapa: Criar as tabelas.
CREATE TABLE funcionario (
  id_funcionario    INT NOT NULL,
  nome_funcionario  VARCHAR(60),
  dt_nascimento     DATE,
  salario           FLOAT DEFAULT 1222.0 CHECK (salario > 0 AND salario < 50000),
  rua               VARCHAR(60),
  bairro            VARCHAR(60),
  cidade            VARCHAR(60),
  cep               VARCHAR(60),
  estado            VARCHAR(60),
  numero            INT CHECK (numero >= 0),
  PRIMARY KEY (id_funcionario)
);

CREATE TABLE cliente (
  id_cliente        INT NOT NULL,
  nome_cliente      VARCHAR(80) NOT NULL,
  senha             VARCHAR(255) NOT NULL,
  dt_nascimento     DATE NOT NULL,
  email             VARCHAR(255) NOT NULL,
  PRIMARY KEY (id_cliente)
);

CREATE TABLE telefone (
  numero            VARCHAR(80) NOT NULL,
  ddd               INT NOT NULL,
  operadora         VARCHAR(15),
  idCliente         INT,
  PRIMARY KEY (numero),
  FOREIGN KEY (idCliente) REFERENCES cliente (id_cliente)
  ON UPDATE CASCADE
  ON DELETE SET DEFAULT
);

CREATE TABLE servico (
  id_servico        INT NOT NULL,
  preco             FLOAT DEFAULT 0 CHECK(preco >= 0),
  data              DATE,
  nome_servico      VARCHAR(50),
  PRIMARY KEY (id_servico)
);

CREATE TABLE agendamento (
  id_agendamento    INT NOT NULL,
  idCliente         INT,
  idServico         INT,
  PRIMARY KEY (id_agendamento),

  FOREIGN KEY (idCliente) REFERENCES cliente (id_cliente)
  ON UPDATE CASCADE
  ON DELETE SET DEFAULT,

  FOREIGN KEY (idServico) REFERENCES servico (id_servico)
  ON UPDATE CASCADE
  ON DELETE SET DEFAULT
);

CREATE TABLE fornecedor (
  id_fornecedor     INT NOT NULL,
  cnpj              VARCHAR(80) NOT NULL,
  nome_fornecedor   VARCHAR(50) NOT NULL,
  PRIMARY KEY(id_fornecedor)
);

CREATE TABLE produto (
  id_produto        INT NOT NULL,
  preco             FLOAT DEFAULT 0 CHECK(preco >= 0),
  quantidade        INT DEFAULT 0 CHECK(preco >= 0),
  nome              VARCHAR(60),
  idFornecedor      INT,
  PRIMARY KEY (id_produto),
  FOREIGN KEY (idFornecedor) REFERENCES fornecedor (id_fornecedor)
  ON UPDATE CASCADE
  ON DELETE SET DEFAULT
);

CREATE TABLE compras (
  nota_fiscal       VARCHAR(80) NOT NULL,
  idCliente         INT,
  idProduto         INT,
  PRIMARY KEY (nota_fiscal),

  FOREIGN KEY (idProduto) REFERENCES produto (id_produto)
  ON UPDATE CASCADE
  ON DELETE SET DEFAULT,

  FOREIGN KEY (idCliente) REFERENCES cliente (id_cliente)
  ON UPDATE CASCADE
  ON DELETE SET DEFAULT
);

CREATE TABLE prestar_servico (
  id_ps             INT NOT NULL,
  idServico         INT, 
  idFuncionario     INT,
  PRIMARY KEY (id_ps),

  FOREIGN KEY (idServico) REFERENCES servico (id_servico)
  ON UPDATE CASCADE
  ON DELETE SET DEFAULT,

  FOREIGN KEY (idFuncionario) REFERENCES funcionario (id_funcionario)
  ON UPDATE CASCADE
  ON DELETE SET DEFAULT
);

CREATE TABLE cargo (
  id_cargo_func     INT NOT NULL,
  cargo_funcionario VARCHAR(60) NOT NULL,
  salario           FLOAT DEFAULT 1222.0 CHECK (salario > 0 AND salario < 50000),
  idFuncionario     INT,
  PRIMARY KEY (id_cargo_func),
  FOREIGN KEY (idFuncionario) REFERENCES funcionario (id_funcionario)
  ON UPDATE CASCADE
  ON DELETE SET DEFAULT
);
