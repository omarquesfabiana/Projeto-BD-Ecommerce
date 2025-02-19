CREATE TABLE Cliente_PF (
    idCliente_PF INT PRIMARY KEY,
    Nome VARCHAR(100) NOT NULL,
    CPF VARCHAR(11) UNIQUE NOT NULL,
    Endereco VARCHAR(255),
    Forma_de_pagamento VARCHAR(45)
);

CREATE TABLE Cliente_PJ (
    idCliente_PJ INT PRIMARY KEY,
    NomeFantasia VARCHAR(100) NOT NULL,
    CNPJ VARCHAR(14) UNIQUE NOT NULL,
    Endereco VARCHAR(255),
    Forma_de_pagamento VARCHAR(45)
);

CREATE TABLE Produto (
    idProduto INT PRIMARY KEY,
    Categoria VARCHAR(100),
    Descricao TEXT,
    Valor DECIMAL(10,2)
);

CREATE TABLE Pedido (
    idPedido INT PRIMARY KEY,
    Cliente_PF_idCliente_PF INT,
    Cliente_PJ_idCliente_PJ INT,
    StatusPedido ENUM('Pendente', 'Concluído', 'Cancelado') NOT NULL,
    DataPedido TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    Total DECIMAL(10,2),
    FOREIGN KEY (Cliente_PF_idCliente_PF) REFERENCES Cliente_PF(idCliente_PF),
    FOREIGN KEY (Cliente_PJ_idCliente_PJ) REFERENCES Cliente_PJ(idCliente_PJ)
);

CREATE TABLE Pedido_Item (
    Pedido_idPedido INT,
    Produto_idProduto INT,
    Quantidade INT,
    Subtotal DECIMAL(10,2),
    PRIMARY KEY (Pedido_idPedido, Produto_idProduto),
    FOREIGN KEY (Pedido_idPedido) REFERENCES Pedido(idPedido),
    FOREIGN KEY (Produto_idProduto) REFERENCES Produto(idProduto)
);

CREATE TABLE Pagamento (
    idPagamento INT PRIMARY KEY,
    Pedido_idPedido INT,
    MetodoPagamento ENUM('Cartão de Crédito', 'Boleto', 'Transferência', 'Pix') NOT NULL,
    Status ENUM('Aprovado', 'Pendente', 'Recusado') NOT NULL,
    FOREIGN KEY (Pedido_idPedido) REFERENCES Pedido(idPedido)
);

CREATE TABLE Cartao (
    idCartao INT PRIMARY KEY,
    Cliente_PF_idCliente_PF INT,
    Cliente_PJ_idCliente_PJ INT,
    Numero_do_cartao VARCHAR(16) UNIQUE,
    Data_de_validade DATE,
    Nome_no_cartao VARCHAR(100),
    FOREIGN KEY (Cliente_PF_idCliente_PF) REFERENCES Cliente_PF(idCliente_PF),
    FOREIGN KEY (Cliente_PJ_idCliente_PJ) REFERENCES Cliente_PJ(idCliente_PJ)
);

INSERT INTO Cliente_PF (idCliente_PF, Nome, CPF, Endereco, Forma_de_pagamento) VALUES
(1, 'Ana Beatriz', '12345678911', 'Rua dos Contos, 321', 'Cartão de Crédito'),
(2, 'Eduardo Augusto', '92665472133', 'Av. dos Andradas, 478', 'Boleto'),
(3, 'Luisa Sonza', '45678912333', 'Rua dos Aneis, 789', 'Débito');

INSERT INTO Cliente_PJ (idCliente_PJ, NomeFantasia, CNPJ, Endereco, Forma_de_pagamento) VALUES
(1, 'Empresa ABC', '12345678000190', 'Rua das Indústrias, 1', 'Cartão Empresarial'),
(2, 'Empresa XYZ', '23456789000101', 'Av. das Nações, 10', 'Boleto');

INSERT INTO Produto (idProduto, Categoria, Descricao, Valor) VALUES
(1, 'Roupas', 'Camisetas', 150.00),
(2, 'Sapatos', 'Sapatilha', 250.00),
(3, 'Maquiagem', 'Rimel', 70.00);

INSERT INTO Pedido (idPedido, Cliente_PF_idCliente_PF, StatusPedido, Total) VALUES
(1, 1, 'Pendente', 300.00),
(2, 2, 'Concluído', 50.00),
(3, 3, 'Pendente', 20.00);

INSERT INTO Pedido (idPedido, Cliente_PJ_idCliente_PJ, StatusPedido, Total) VALUES
(4, 1, 'Pendente', 500.00),
(5, 2, 'Concluído', 100.00);

INSERT INTO Pedido_Item (Pedido_idPedido, Produto_idProduto, Quantidade, Subtotal) VALUES
(1, 1, 2, 300.00),
(2, 2, 1, 50.00),
(3, 3, 1, 20.00),
(4, 1, 3, 450.00),
(5, 2, 2, 100.00);

SELECT Nome FROM Cliente_PF;

SELECT NomeFantasia FROM Cliente_PJ;

SELECT * FROM Pedido WHERE StatusPedido = 'Pendente';

SELECT Descricao, Valor, Valor * 1.1 AS ValorComImposto FROM Produto;

SELECT Nome FROM Cliente_PF ORDER BY Nome ASC;

SELECT Cliente_PF_idCliente_PF, COUNT(*) AS NumeroDePedidos
FROM Pedido
WHERE Cliente_PF_idCliente_PF IS NOT NULL
GROUP BY Cliente_PF_idCliente_PF;

SELECT Cliente_PJ_idCliente_PJ, COUNT(*) AS NumeroDePedidos
FROM Pedido
WHERE Cliente_PJ_idCliente_PJ IS NOT NULL
GROUP BY Cliente_PJ_idCliente_PJ;

SELECT c.Nome, p.StatusPedido
FROM Cliente_PF c
JOIN Pedido p ON c.idCliente_PF = p.Cliente_PF_idCliente_PF;

SELECT c.NomeFantasia, p.StatusPedido
FROM Cliente_PJ c
JOIN Pedido p ON c.idCliente_PJ = p.Cliente_PJ_idCliente_PJ;