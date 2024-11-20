CREATE DATABASE oficina;

USE oficina;

CREATE TABLE cliente (
    id_cliente INT AUTO_INCREMENT,
    nome VARCHAR(50) NOT NULL,
    cpf VARCHAR(20) NOT NULL UNIQUE,
    data_nascimento DATE NOT NULL,
    PRIMARY KEY(id_cliente)
);

CREATE TABLE veiculos (
    id_veiculo INT AUTO_INCREMENT,
    placa VARCHAR(10) NOT NULL UNIQUE,
    modelo VARCHAR(20) NOT NULL,
    ano_veiculo YEAR CHECK (ano_veiculo > 1950 AND ano_veiculo < 2025),
    fk_id_cliente INT,
    PRIMARY KEY(id_veiculo),
    FOREIGN KEY (fk_id_cliente) REFERENCES cliente(id_cliente)
);

CREATE INDEX idx_placa ON veiculos(placa);

CREATE TABLE mecanico (
    id_mecanico INT,
    nome VARCHAR(40) NOT NULL,
    endereco VARCHAR(50),
    especialidade VARCHAR(50) NOT NULL,
    PRIMARY KEY(id_mecanico)
);

CREATE TABLE mecanico_veiculo (
    fk_id_mecanico INT,
    fk_id_veiculo INT,
    FOREIGN KEY (fk_id_mecanico) REFERENCES mecanico(id_mecanico),
    FOREIGN KEY (fk_id_veiculo) REFERENCES veiculos(id_veiculo)
);

CREATE TABLE ordem_servico (
    id_servico INT AUTO_INCREMENT,
    data_emissao DATE NOT NULL,
    data_entrega DATE NOT NULL,
    status_autorizacao ENUM('autorizado', 'aguardando', 'nao autorizado'),
    descricao TEXT NOT NULL,
    valor_total FLOAT NOT NULL,
    PRIMARY KEY(id_servico)
);

CREATE TABLE servico_mecanico (
    fk_id_mecanico INT,
    fk_id_servico INT,
    FOREIGN KEY (fk_id_mecanico) REFERENCES mecanico(id_mecanico),
    FOREIGN KEY (fk_id_servico) REFERENCES ordem_servico(id_servico)
);

CREATE TABLE tipos_servico (
    id_tipo_servico INT,
    nome VARCHAR(50) NOT NULL,
    valor FLOAT NOT NULL,
    PRIMARY KEY(id_tipo_servico)
);

CREATE TABLE servico_ordem (
    fk_id_tipo_servico INT,
    fk_id_servico INT,
    FOREIGN KEY (fk_id_tipo_servico) REFERENCES tipos_servico(id_tipo_servico),
    FOREIGN KEY (fk_id_servico) REFERENCES ordem_servico(id_servico)
);
