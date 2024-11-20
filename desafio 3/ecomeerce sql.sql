create database ecomerce;
use ecomerce ;

-- tabela cleintes

create table cliente (
idcliente int auto_increment,
pnome varchar(15)  not null ,
nome_meio varchar(10),
sobrenome varchar(15) ,
cpf varchar(15) not null,
endereco varchar(45) not null ,
data_nascimento date not null ,
unique(cpf) ,
primary key (idcliente) );

alter table cliente 
change nome_meio nome_meio varchar(10) default " ";


-- tabela produtos
create table produto(
idproduto int auto_increment,
pname varchar (20) not null ,
classificacao int not null,
avaliacao float default 0,
categoria enum('eletronico' , 'roupas' , 'brinquedos ' , 'moveis' ) not null,
primary key(idproduto) );


-- tabela pedidos
create table pedido (
 idpedido int auto_increment,
 status_pedido enum('entregue' , 'aguardando') not null,
 descricao varchar(40) not null,
 frete float not null default 5 ,
 fk_idcliente int ,
 primary key(idpedido) ,
 foreign key (fk_idcliente) references cliente(idcliente) );


-- relação entre pedidos e produtos
create table produto_pedido (
fk_idproduto int ,
fk_idpedido int ,
quantidade int not null ,
foreign key (fk_idproduto) references produto(idproduto),
foreign key(fk_idpedido) references pedido(idpedido) );

-- tabela estoque 
create table estoque (
idestoque int auto_increment,
quantidade int not null,
local varchar(50) not null,
primary key(idestoque)
);

-- relacao estoque produto 

create table estoque_produto (
fk_idproduto int ,
fk_idestoque int ,
quantidade int not null,
foreign key (fk_idproduto) references produto(idproduto),
foreign key(fk_idestoque) references estoque(idestoque) );

-- tabela fornecdor
create table fornecedor (
idfornecedor int ,
cnpj varchar(20) not null unique ,
nome_fantasia varchar(45) not null ,
contato varchar(30) not null ,
local varchar(50) not null,
primary key(idfornecedor) );

-- relacao entre fornecedor e produto

create table fornecedor_produto (
fk_idfornecedor int  ,
fk_idproduto int ,
foreign key (fk_idproduto) references produto(idproduto),
foreign key(fk_idfornecedor) references fornecedor(idfornecedor) );


-- tabela vendedores externos
create table terceiro_vendedor (
idterceiro int auto_increment,
local varchar(50) not null,
nome_fantasia varchar(50) not null,
cnpj varchar(30) not null unique ,
primary key(idterceiro) );

-- relacao terceiros e produto 

create table terceiros_produto (
fk_idproduto int ,
fk_idterceiro int ,
quantidade int not null ,	
foreign key (fk_idproduto) references produto(idproduto),
foreign key (fk_idterceiro) references terceiro_vendedor(idterceiro) );

alter table produto_pedido 
add primary key (fk_idproduto, fk_idpedido);

alter table fornecedor_produto 
add primary key (fk_idfornecedor, fk_idproduto);

alter table terceiros_produto 
add primary key (fk_idproduto, fk_idterceiro);

alter table estoque_produto 
add primary key (fk_idproduto, fk_idestoque);




-- dados clientes
INSERT INTO cliente (pnome, nome_meio, sobrenome, cpf, endereco, data_nascimento)
VALUES 
('João', 'da Silva', 'Souza', '12345678901', 'Rua A, 123', '1990-05-15'),
('Maria', NULL, 'Oliveira', '98765432100', 'Avenida B, 456', '1985-10-20'),
('Carlos', 'Almeida', 'Santos', '45678912302', 'Rua C, 789', '1992-07-12');


update nome_meio
set deafult 
where idcliente = 2 ;


-- dados produto
INSERT INTO produto (pname, classificacao, avaliacao, categoria)
VALUES 
('Smartphone', 5, 4.5, 'eletronico'),
('Camiseta', 3, 3.8, 'roupas'),
('Boneca', 4, 4.2, 'brinquedos'),
('Mesa', 2, 4.0, 'moveis');

-- dados pedido

INSERT INTO pedido (status_pedido, descricao, frete, fk_idcliente)
VALUES 
('aguardando', 'Pedido de eletrônicos', 10.5, 1),
('entregue', 'Pedido de roupas', 5.0, 2),
('aguardando', 'Pedido de móveis', 15.0, 3);

-- dados relação produto - pedido

INSERT INTO produto_pedido (fk_idproduto, fk_idpedido, quantidade)
VALUES 
(1, 1, 2), -- Smartphone no pedido 1
(2, 2, 5), -- Camiseta no pedido 2
(4, 3, 1); -- Mesa no pedido 3


-- dados estoque

INSERT INTO estoque (quantidade, local)
VALUES 
(50, 'Armazém A'),
(100, 'Armazém B'),
(30, 'Armazém C');


-- dados estoque-produto
INSERT INTO estoque_produto (fk_idproduto, fk_idestoque, quantidade)
VALUES 
(1, 1, 20), -- 20 Smartphones no Armazém A
(2, 2, 50), -- 50 Camisetas no Armazém B
(4, 3, 10); -- 10 Mesas no Armazém C


INSERT INTO fornecedor (idfornecedor, cnpj, nome_fantasia, contato, local)
VALUES 
(1, '12345678000101', 'Fornecedor Eletrônicos', 'contato@eletronicos.com', 'Cidade X'),
(2, '98765432000102', 'Fornecedor Roupas', 'contato@roupas.com', 'Cidade Y'),
(3, '11223344000103', 'Fornecedor Móveis', 'contato@moveis.com', 'Cidade Z');


INSERT INTO fornecedor_produto (fk_idfornecedor, fk_idproduto)
VALUES 
(1, 1), -- Fornecedor 1 fornece Smartphone
(2, 2), -- Fornecedor 2 fornece Camiseta
(3, 4); -- Fornecedor 3 fornece Mesa


INSERT INTO terceiro_vendedor (local, nome_fantasia, cnpj)
VALUES 
('Shopping A', 'Loja Eletrônicos X', '12345000111'),
('Shopping B', 'Loja Roupas Y', '67890000222'),
('Shopping C', 'Loja Móveis Z', '98765000333');

INSERT INTO terceiros_produto (fk_idproduto, fk_idterceiro, quantidade)
VALUES 
(1, 1, 10), -- 10 Smartphones vendidos pelo terceiro 1
(2, 2, 20), -- 20 Camisetas vendidas pelo terceiro 2
(4, 3, 5);  -- 5 Mesas vendidas pelo terceiro 3


-- exercicios 

-- recuperacão simples com select statement
-- primeiro nome e cpf 
select pnome , cpf 
from cliente ;

-- primeiro nome e cpf com where
select pnome , cpf 
from cliente 
where idcliente = 1 ;

-- atributos derivados
-- nome inteiro cliente
select  concat(pnome,' ',nome_meio,' ',sobrenome)
as nome_completo
from cliente 
where idcliente = 1;


-- Defina ordenações dos dados com ORDER BY
-- ordenacao por idade crescente
select *
from cliente
order by  data_nascimento asc ;


-- Condições de filtros aos grupos – HAVING Statement
-- produtos com availicao maior que 4
select pname , avaliacao
from produto 
group by pname 
having avaliacao >= 4 ;
-- Crie junções entre tabelas para fornecer uma perspectiva mais complexa dos dados

-- Qual pedido cada cliente fez

SELECT c.pnome AS Nome_Cliente, pr.pname AS Produto_Comprado
FROM cliente AS c
INNER JOIN pedido AS pe ON c.idcliente = pe.fk_idcliente
INNER JOIN produto_pedido AS pp ON pe.idpedido = pp.fk_idpedido
INNER JOIN produto AS pr ON pp.fk_idproduto = pr.idproduto;


-- Relação de produtos fornecedores e estoques;

SELECT pr.pname AS Nome_Produto, f.nome_fantasia AS Nome_Fornecedor, e.local AS Local_Estoque, ep.quantidade AS Quantidade_Estoque
FROM produto AS pr
INNER JOIN fornecedor_produto AS fp ON pr.idproduto = fp.fk_idproduto
INNER JOIN fornecedor AS f ON fp.fk_idfornecedor = f.idfornecedor
INNER JOIN estoque_produto AS ep ON pr.idproduto = ep.fk_idproduto
INNER JOIN estoque AS e ON ep.fk_idestoque = e.idestoque;

-- Relação de nomes dos fornecedores e nomes dos produtos

SELECT f.nome_fantasia AS Nome_Fornecedor, p.pname AS Nome_Produto
FROM fornecedor AS f
INNER JOIN fornecedor_produto AS fp ON f.idfornecedor = fp.fk_idfornecedor
INNER JOIN produto AS p ON fp.fk_idproduto = p.idproduto;



