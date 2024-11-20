INSERT INTO cliente (nome, cpf, data_nascimento) VALUES
('João Silva', '123.456.789-00', '1985-05-20'),
('Maria Oliveira', '987.654.321-00', '1990-08-15'),
('Pedro Souza', '456.123.789-00', '1975-03-30');

INSERT INTO veiculos (placa, modelo, ano_veiculo, fk_id_cliente) VALUES
('ABC-1234', 'Fiat Uno', 2010, 1),
('XYZ-5678', 'Toyota Corolla', 2018, 2),
('DEF-9012', 'Honda Civic', 2015, 3);

INSERT INTO mecanico (id_mecanico, nome, endereco, especialidade) VALUES
(1, 'Carlos Mendes', 'Rua A, 123', 'Motor'),
(2, 'Ana Paula', 'Rua B, 456', 'Pintura'),
(3, 'Rafael Santos', 'Rua C, 789', 'Suspensão');

INSERT INTO mecanico_veiculo (fk_id_mecanico, fk_id_veiculo) VALUES
(1, 1),
(2, 2),
(3, 3);

INSERT INTO ordem_servico (data_emissao, data_entrega, status_autorizacao, descricao, valor_total) VALUES
('2024-01-10', '2024-01-15', 'autorizado', 'Troca de óleo e filtro', 150.00),
('2024-02-05', '2024-02-10', 'aguardando', 'Reparo na suspensão', 500.00),
('2024-03-15', '2024-03-20', 'nao autorizado', 'Pintura completa', 2000.00);

INSERT INTO servico_mecanico (fk_id_mecanico, fk_id_servico) VALUES
(1, 1),
(2, 2),
(3, 3);


INSERT INTO tipos_servico (id_tipo_servico, nome, valor) VALUES
(1, 'Troca de óleo', 100.00),
(2, 'Reparo na suspensão', 500.00),
(3, 'Pintura completa', 2000.00);

INSERT INTO servico_ordem (fk_id_tipo_servico, fk_id_servico) VALUES
(1, 1),
(2, 2),
(3, 3);

SELECT * FROM cliente;

SELECT * FROM cliente
WHERE data_nascimento > '1980-01-01';

SELECT nome, cpf, YEAR(CURDATE()) - YEAR(data_nascimento) AS idade
FROM cliente;
 
 
SELECT * FROM cliente
ORDER BY nome;

SELECT modelo, COUNT(*) AS total_veiculos
FROM veiculos
GROUP BY modelo
HAVING YEAR(CURDATE()) - ano_veiculo > 10;

SELECT c.nome AS Nome_Cliente, v.modelo AS Modelo_Veiculo, v.placa AS Placa
FROM cliente AS c
INNER JOIN veiculos AS v ON c.id_cliente = v.fk_id_cliente;


