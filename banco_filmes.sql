-- Criação das tabelas
CREATE TABLE Filmes (
    Id INT PRIMARY KEY AUTO_INCREMENT,
    Nome VARCHAR(255),
    Ano INT,
    Duracao INT
);

CREATE TABLE Generos (
    Id INT PRIMARY KEY AUTO_INCREMENT,
    Genero VARCHAR(255)
);

CREATE TABLE Atores (
    Id INT PRIMARY KEY AUTO_INCREMENT,
    PrimeiroNome VARCHAR(255),
    UltimoNome VARCHAR(255)
);

CREATE TABLE ElencoFilme (
    IdFilme INT,
    IdAtor INT,
    Papel VARCHAR(255),
    FOREIGN KEY (IdFilme) REFERENCES Filmes(Id),
    FOREIGN KEY (IdAtor) REFERENCES Atores(Id)
);

CREATE TABLE FilmeGenero (
    IdFilme INT,
    IdGenero INT,
    FOREIGN KEY (IdFilme) REFERENCES Filmes(Id),
    FOREIGN KEY (IdGenero) REFERENCES Generos(Id)
);

-- Inserts de exemplo
INSERT INTO Filmes (Nome, Ano, Duracao) VALUES 
('De Volta para o Futuro', 1985, 116),
('O Senhor dos Anéis: A Sociedade do Anel', 2001, 178),
('Pulp Fiction', 1994, 154);

INSERT INTO Generos (Genero) VALUES 
('Ficção Científica'),
('Aventura'),
('Drama'),
('Mistério');

INSERT INTO Atores (PrimeiroNome, UltimoNome) VALUES
('Michael', 'Fox'),
('Christopher', 'Lloyd'),
('Elijah', 'Wood'),
('John', 'Travolta');

INSERT INTO ElencoFilme (IdFilme, IdAtor, Papel) VALUES
(1, 1, 'Marty McFly'),
(1, 2, 'Dr. Emmett Brown'),
(2, 3, 'Frodo Baggins'),
(3, 4, 'Vincent Vega');

INSERT INTO FilmeGenero (IdFilme, IdGenero) VALUES
(1, 1),
(1, 4),
(2, 2),
(2, 3),
(3, 3);

-- Consultas
-- 1 - Buscar todos os filmes
SELECT * FROM Filmes;

-- 2 - Buscar apenas o nome e ano dos filmes
SELECT Nome, Ano FROM Filmes;

-- 3 - Buscar os filmes lançados após o ano 2000
SELECT * FROM Filmes WHERE Ano > 2000;

-- 4 - Buscar os filmes com duração maior que 120 minutos
SELECT * FROM Filmes WHERE Duracao > 120;

-- 5 - Buscar os filmes ordenados pelo ano
SELECT * FROM Filmes ORDER BY Ano;

-- 6 - Buscar a quantidade de filmes por ano
SELECT Ano, COUNT(*) AS Quantidade FROM Filmes GROUP BY Ano;

-- 7 - Buscar a quantidade de filmes lançados no ano, agrupando por ano, ordenando pela duração em ordem decrescente
SELECT Ano, COUNT(*) AS Quantidade FROM Filmes GROUP BY Ano ORDER BY MAX(Duracao) DESC;

-- 8 - Buscar o nome do filme e o gênero
SELECT f.Nome AS Filme, g.Genero
FROM Filmes f
JOIN FilmeGenero fg ON f.Id = fg.IdFilme
JOIN Generos g ON fg.IdGenero = g.Id;

-- 9 - Buscar o nome do filme e o gênero do tipo "Mistério"
SELECT f.Nome AS Filme, g.Genero
FROM Filmes f
JOIN FilmeGenero fg ON f.Id = fg.IdFilme
JOIN Generos g ON fg.IdGenero = g.Id
WHERE g.Genero = 'Mistério';

-- 10 - Buscar o filme 'De Volta para o Futuro'
SELECT Nome, Ano, Duracao
FROM Filmes
WHERE Nome = 'De Volta para o Futuro';

-- 11 - Buscar o nome do filme e a quantidade de gêneros
SELECT f.Nome, COUNT(fg.IdGenero) AS QuantidadeGeneros
FROM Filmes f
JOIN FilmeGenero fg ON f.Id = fg.IdFilme
GROUP BY f.Nome;

-- 12 - Buscar o nome do filme e os atores, trazendo o PrimeiroNome, UltimoNome e seu Papel
SELECT f.Nome AS Filme, a.PrimeiroNome, a.UltimoNome, ef.Papel
FROM Filmes f
JOIN ElencoFilme ef ON f.Id = ef.IdFilme
JOIN Atores a ON ef.IdAtor = a.Id;
