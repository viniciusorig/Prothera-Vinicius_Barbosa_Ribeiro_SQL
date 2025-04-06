DROP VIEW IF EXISTS alphabetical_order;
DROP VIEW IF EXISTS without_cpf;
DROP VIEW IF EXISTS all_documents;
DROP VIEW IF EXISTS soares_surname;
DROP VIEW IF EXISTS between_twoty_sixty;
DROP TABLE IF EXISTS Documento;
DROP TABLE IF EXISTS Pessoa;

CREATE TABLE Pessoa (
  id SERIAL PRIMARY KEY,
  nome VARCHAR(100),
  idade INT
);

CREATE TABLE Documento (
  id SERIAL PRIMARY KEY,
  tipo VARCHAR(50),
  numero VARCHAR(50),
  descricao VARCHAR(100),
  pessoa_id INT,
  FOREIGN KEY (pessoa_id) REFERENCES Pessoa(id)
);

-- Insert de Todas as Pessoas
INSERT INTO Pessoa (id, nome, idade) VALUES 
(1, 'Luiz Roberto', 33),
(2, 'Raimundo Soares', 51),
(3, 'Ana Tavares', 24),
(4, 'Jurek Nethuns', 42),
(5, 'Pablo da Rosa', 19),
(6, 'Wesley Soares', 29),
(7, 'Tamires Souza', 12);

-- Luiz Roberto (ID = 1)
INSERT INTO Documento (id, tipo, numero, descricao, pessoa_id) VALUES
(1, 'CNH',  '74591035698445', 'Carteira de Motorista', 1),
(2, 'RG',   '5200789',        'Carteira de Identidade', 1),
(3, 'CTPS', '4567698',        'Carteira de Trabalho', 1);

-- Raimundo Soares (ID = 2)
INSERT INTO Documento (id, tipo, numero, descricao, pessoa_id) VALUES
(4, 'CNH',  '45963548565789', 'Carteira de Motorista', 2),
(5, 'RG',   '5200785',        'Carteira de Identidade', 2),
(6, 'CTPS', '7891237',        'Carteira de Trabalho', 2);

-- Ana Tavares (ID = 3)
INSERT INTO Documento (id, tipo, numero, descricao, pessoa_id) VALUES
(7,  'CNH', '6523652662159',  'Carteira de Motorista', 3),
(8,  'CPF', '41254125147',    'Cadastro de Pessoa Física', 3);

-- Jurek Nethuns (ID = 4)
INSERT INTO Documento (id, tipo, numero, descricao, pessoa_id) VALUES
(9,  'CPF', '6523652662',     'Cadastro de Pessoa Física', 4),
(10, 'RG',  '3300785',        'Carteira de Identidade', 4),
(11, 'SUS', '784512',         'Sistema Único de Saúde', 4);

-- Pablo da Rosa (ID = 5)
INSERT INTO Documento (id, tipo, numero, descricao, pessoa_id) VALUES
(12, 'RG',  '5200785',        'Carteira de Identidade', 5),
(13, 'CPF', '456215812541',   'Cadastro de Pessoa Física', 5);

-- Wesley Soares (ID = 6)
INSERT INTO Documento (id, tipo, numero, descricao, pessoa_id) VALUES
(14, 'CNH', '91035698445963', 'Carteira de Motorista', 6),
(15, 'RG',  '7415595',        'Carteira de Identidade', 6),
(16, 'CPF', '5184852136',     'Cadastro de Pessoa Física', 6),
(17, 'SUS', '2200789',        'Sistema Único de Saúde', 6);

-- Tamires Souza (ID = 7)
INSERT INTO Documento (id, tipo, numero, descricao, pessoa_id) VALUES
(18, 'RG',  '7852123',        'Carteira de Identidade', 7);

--view para retornar as pessoas em ordem alfabetica
CREATE OR REPLACE VIEW alphabetical_order AS SELECT pessoa.nome, pessoa.idade, documento.tipo, documento.numero, documento.descricao FROM documento JOIN pessoa ON documento.pessoa_id = pessoa.id ORDER BY pessoa.nome; 
--view para retornar as pessoas entre 20 e 60 anos
CREATE OR REPLACE VIEW between_twoty_sixty AS SELECT pessoa.nome, pessoa.idade, documento.tipo, documento.numero, documento.descricao FROM documento JOIN pessoa ON documento.pessoa_id = pessoa.id WHERE pessoa.idade >= 20 AND pessoa.idade <= 60 ORDER BY pessoa.nome ;
--view para retornar as pessoas sem cpf
CREATE OR REPLACE VIEW without_cpf AS SELECT pessoa.nome, pessoa.idade, documento.tipo, documento.numero, documento.descricao FROM documento JOIN pessoa ON documento.pessoa_id = pessoa.id WHERE pessoa_id NOT IN (SELECT DISTINCT(pessoa_id) FROM documento WHERE documento.tipo = 'CPF');
--view para retornar as pessoas com o sobrenome soares
CREATE OR REPLACE VIEW soares_surname AS SELECT pessoa.nome, pessoa.idade, documento.tipo, documento.numero, documento.descricao FROM documento JOIN pessoa ON documento.pessoa_id = pessoa.id WHERE pessoa.nome ILIKE('%Soares%');
--view para retornar todos os tipos de documentos 
CREATE OR REPLACE VIEW all_documents AS SELECT DISTINCT documento.tipo, documento.descricao FROM documento ;