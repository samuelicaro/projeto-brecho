SET datestyle = 'ISO, DMY';

CREATE TABLE tbVendedor(
  cpf_vendedor varchar(14) NOT NULL,
  nome_vendedor varchar(70) NOT NULL,
  email_vendedor varchar(200) NOT NULL,
  dt_admissao date NOT NULL,
  PRIMARY KEY(cpf_vendedor)
);

CREATE TYPE conservacao AS ENUM('Novo','Usado');

CREATE TYPE genero AS ENUM('M', 'F', 'Unissex');

CREATE TABLE tbCategoria(
  id_categoria serial NOT NULL,
  genero GENERO NOT NULL,
  faixa_etaria int NOT NULL,
  conservacao CONSERVACAO NOT NULL,
  PRIMARY KEY(id_categoria)
);

CREATE TABLE tbEnderecoFornecedor(
  id_endereco serial NOT NULL,
  logradouro varchar(50) NOT NULL,
  cidade varchar(30) NOT NULL,
  bairro varchar(40) NOT NULL,
  cep varchar(9) NOT NULL,
  PRIMARY KEY(id_endereco)
);

CREATE TYPE tipo_fornecedor AS ENUM('Físico', 'Jurídico');

CREATE TABLE tbFornecedor(
  cpf_cnpj_fornecedor varchar(18) NOT NULL,
  tipo TIPO_FORNECEDOR NOT NULL,
  nome_fornecedor varchar(70) NOT NULL,
  nome_empresa varchar(60),
  email_fornecedor varchar(200) NOT NULL,
  id_endereco_fornecedor int NOT NULL,
  PRIMARY KEY(cpf_cnpj_fornecedor),
  FOREIGN KEY(id_endereco_fornecedor) references tbEnderecoFornecedor(id_endereco)
);

CREATE TYPE tipo_telefone AS ENUM('Fixo','Celular');

CREATE TABLE tbTelefoneFornecedor(
  id_telefone serial NOT NULL,
  numero varchar(18) NOT NULL,
  tipo TIPO_TELEFONE NOT NULL,
  cpf_cnpj_fornecedor varchar(18) NOT NULL,
  PRIMARY KEY (id_telefone),
  FOREIGN KEY (cpf_cnpj_fornecedor) references tbFornecedor(cpf_cnpj_fornecedor)
);

CREATE TABLE tbCLiente(
  id_cliente serial NOT NULL,
  nome_cliente varchar(70) NOT NULL,
  telefone_celular varchar(18) NOT NULL,
  cpf_cnpj_fornecedor varchar(18),
  PRIMARY KEY (id_cliente),
  FOREIGN KEY (cpf_cnpj_fornecedor) references tbFornecedor(cpf_cnpj_fornecedor)
);

CREATE TABLE tbVenda(
  id_venda serial NOT NULL,
  dt_venda timestamp NOT NULL,
  valor_total decimal(10, 2) NOT NULL,
  id_cliente int NOT NULL,
  cpf_vendedor varchar(14) NOT NULL,
  PRIMARY KEY (id_venda),
  FOREIGN KEY (id_cliente) references tbCLiente(id_cliente),
  FOREIGN KEY (cpf_vendedor) references tbVendedor(cpf_vendedor)
);

CREATE TABLE tbProduto(
  id_produto serial NOT NULL,
  nome_produto varchar(60) NOT NULL,
  preco decimal(10, 2) NOT NULL,
  descricao varchar(100) NOT NULL, 
  cpf_cnpj_fornecedor varchar(18) NOT NULL,
  id_categoria int NOT NULL,
  id_venda int,
  PRIMARY KEY (id_produto),
  FOREIGN KEY(cpf_cnpj_fornecedor) references tbFornecedor(cpf_cnpj_fornecedor),
  FOREIGN KEY (id_categoria) references tbCategoria(id_categoria),
  FOREIGN KEY (id_venda) references tbVenda(id_venda)
);


INSERT INTO tbVendedor (cpf_vendedor, nome_vendedor, email_vendedor, dt_admissao) VALUES 
  ('503.347.319-09', 'Guilherme Matheus Paulo Rocha', 'guilherme-rocha98@viacorte.com.br', '06/03/2017'),
  ('661.914.307-52', 'Marli Milena Allana Oliveira', 'marli_oliveira@tec3.com.br', '20/01/2016'),
  ('108.826.659-28', 'Sueli Alice Luciana Caldeira', 'sueli_alice_caldeira@live.com.br', '04/05/2019'),
  ('724.476.819-25', 'Marcos Martin Pinto', 'marcos.martin.pinto@valdulion.com.br', '16/01/2014'),
  ('190.711.690-73', 'Sabrina Josefa Lopes', 'sabrina_josefa_lopes@ci.com.br', '09/05/2020'),
  ('575.781.623-65', 'Emily Isabelly Eliane Oliveira', 'emilyisabellyoliveira@uol.com', '24/04/2018');

INSERT INTO tbCategoria(genero, faixa_etaria, conservacao) VALUES
  ('M', 14, 'Novo'),
  ('M', 16, 'Usado'),
  ('F', 18, 'Novo'),
  ('F', 14, 'Usado'),
  ('Unissex', 16, 'Novo'),
  ('Unissex', 18, 'Usado');
  
INSERT INTO tbEnderecoFornecedor(logradouro, cidade, bairro, cep) VALUES
  ('Avenida Francisco Dias, s/n', 'Jordão', 'Centro', '69975-970'),
  ('Travessa Aracajuzinho', 'Aracaju', 'Industrial', '49065-120'),
  ('Passagem Marçal', 'Belém', 'Curió-Utinga', '66610-565'),
  ('Rua Espanha', 'Sinop', 'Jardim Europa', '78555-216'),
  ('Rua Porciúncula', 'Nilópolis', 'Centro', '26525-480'),
  ('Rua dos Gaviões', 'Serra', 'Porto Canoa', '29168-670');

INSERT INTO tbFornecedor(cpf_cnpj_fornecedor, tipo, nome_fornecedor, nome_empresa, email_fornecedor, id_endereco_fornecedor) VALUES
  ('89.078.897/0001-80', 'Jurídico', 'Matheus e Evelyn Mudanças' , 'Matheus e Evelyn Mudanças Ltda', 'pesquisa@matheuseevelynmudancasltda.com.br', 1)
  ('352.144.112-19', 'Físico', 'Pietro Erick Rocha', NULL, 'pietro-rocha75@lojaprincezinha.com.br', 2),
  ('770.532.721-09', 'Físico', 'Maitê Isabella Renata Sales', NULL, 'maite_sales@amoreencantos.com', 3),
  ('09.001.759/0001-63', 'Jurídico', 'Thiago e Luiz Restaurante', 'Tiago e Luiz Restaurante ME', 'financeiro@tiagoeluizrestauranteme.com.br', 3),
  ('987.367.849-23', 'Físico', 'Lorenzo Yuri Baptista', NULL, 'lorenzo_yuri_baptista@isbt.com.br', 4);
  
INSERT INTO tbTelefoneFornecedor(numero, tipo, cpf_cnpj_fornecedor) VALUES
  ('(21) 98762-1259', 'Celular', '89.078.897/0001-80'),
  ('(21) 99437-1925', 'Celular', '352.144.112-19'),
  ('(21) 2979-2705', 'Fixo', '770.532.721-09'),
  ('(11) 99778-5166', 'Celular', '09.001.759/0001-63'),
  ('(11) 3506-7478', 'Celular', '987.367.849-23');
  
INSERT INTO tbCLiente(nome_cliente, telefone_celular, cpf_cnpj_fornecedor) VALUES
  ('Pietro Erick Rocha', '(21) 99437-1925', '352.144.112-19'),
  ('Louise Simone Cavalcanti', '(21) 99437-1925', NULL),
  ('Milena Laís da Mata', '(85) 98401-4537', NULL);

INSERT INTO tbVendedor (cpf_vendedor, nome_vendedor, email_vendedor, dt_admissao) VALUES 
  ('503.347.319-09', 'Guilherme Matheus Paulo Rocha', 'guilherme-rocha98@viacorte.com.br', '06/03/2017'),
  ('661.914.307-52', 'Marli Milena Allana Oliveira', 'marli_oliveira@tec3.com.br', '20/01/2016'),
  ('108.826.659-28', 'Sueli Alice Luciana Caldeira', 'sueli_alice_caldeira@live.com.br', '04/05/2019'),
  ('724.476.819-25', 'Marcos Martin Pinto', 'marcos.martin.pinto@valdulion.com.br', '16/01/2014'),
  ('190.711.690-73', 'Sabrina Josefa Lopes', 'sabrina_josefa_lopes@ci.com.br', '09/05/2020'),
  ('575.781.623-65', 'Emily Isabelly Eliane Oliveira', 'emilyisabellyoliveira@uol.com', '24/04/2018');

INSERT INTO tbCategoria(genero, faixa_etaria, conservacao) VALUES
  ('M', 14, 'Novo'),
  ('M', 16, 'Usado'),
  ('F', 18, 'Novo'),
  ('F', 14, 'Usado'),
  ('Unissex', 16, 'Novo'),
  ('Unissex', 18, 'Usado');
  
INSERT INTO tbEnderecoFornecedor(logradouro, cidade, bairro, cep) VALUES
  ('Avenida Francisco Dias, s/n', 'Jordão', 'Centro', '69975-970'),
  ('Travessa Aracajuzinho', 'Aracaju', 'Industrial', '49065-120'),
  ('Passagem Marçal', 'Belém', 'Curió-Utinga', '66610-565'),
  ('Rua Espanha', 'Sinop', 'Jardim Europa', '78555-216'),
  ('Rua Porciúncula', 'Nilópolis', 'Centro', '26525-480'),
  ('Rua dos Gaviões', 'Serra', 'Porto Canoa', '29168-670');

INSERT INTO tbFornecedor(cpf_cnpj_fornecedor, tipo, nome_fornecedor, nome_empresa, email_fornecedor, id_endereco_fornecedor) VALUES
  ('89.078.897/0001-80', 'Jurídico', 'Matheus e Evelyn Mudanças' , 'Matheus e Evelyn Mudanças Ltda', 'pesquisa@matheuseevelynmudancasltda.com.br', 1),
  ('352.144.112-19', 'Físico', 'Pietro Erick Rocha', NULL, 'pietro-rocha75@lojaprincezinha.com.br', 2),
  ('770.532.721-09', 'Físico', 'Maitê Isabella Renata Sales', NULL, 'maite_sales@amoreencantos.com', 3),
  ('09.001.759/0001-63', 'Jurídico', 'Thiago e Luiz Restaurante', 'Tiago e Luiz Restaurante ME', 'financeiro@tiagoeluizrestauranteme.com.br', 3),
  ('987.367.849-23', 'Físico', 'Lorenzo Yuri Baptista', NULL, 'lorenzo_yuri_baptista@isbt.com.br', 4);
  
INSERT INTO tbTelefoneFornecedor(numero, tipo, cpf_cnpj_fornecedor) VALUES
  ('(21) 98762-1259', 'Celular', '89.078.897/0001-80'),
  ('(21) 99437-1925', 'Celular', '352.144.112-19'),
  ('(21) 2979-2705', 'Fixo', '770.532.721-09'),
  ('(11) 99778-5166', 'Celular', '09.001.759/0001-63'),
  ('(11) 3506-7478', 'Celular', '987.367.849-23');
  
INSERT INTO tbCLiente(nome_cliente, telefone_celular, cpf_cnpj_fornecedor) VALUES
  ('Pietro Erick Rocha', '(21) 99437-1925', '352.144.112-19'),
  ('Louise Simone Cavalcanti', '(21) 99437-1925', NULL),
  ('Milena Laís da Mata', '(85) 98401-4537', NULL),
  ('Thiago e Luiz Restaurante', '(11) 99778-5166', '09.001.759/0001-63'); 
  
INSERT INTO tbVenda(dt_venda, valor_total, id_cliente, cpf_vendedor) VALUES
  ('14/01/2019', 30.00, 4, '190.711.690-73');

INSERT INTO tbProduto(nome_produto, preco, descricao, cpf_cnpj_fornecedor, id_categoria, id_venda) VALUES
  ('Blusa Florida', 30.00, 'Está em ótimo estado, porém, tem 4 meses desde que foi comprada', '770.532.721-09', 2, NULL),
  ('Tênis Vans com listras', 30.00, 'Tênis com solado um pouco ruim, mas utilizável', '987.367.849-23', 1, 1),
  ('Óculos de sol Oakley', 20.00, 'Óculos em bom estado e veio com as lentes de cores diferentes', '89.078.897/0001-80', 6, NULL);
