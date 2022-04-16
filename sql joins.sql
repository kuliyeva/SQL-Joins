CREATE DATABASE IMDb

USE IMDb

CREATE TABLE Directors(
	Id INT PRIMARY KEY IDENTITY,
	Fullname NVARCHAR(100) NOT NULL
)

CREATE TABLE Movies(
	Id INT PRIMARY KEY IDENTITY,
	Name NVARCHAR(120) NOT NULL UNIQUE,
	RealeseDate DATETIME2 DEFAULT GETDATE(),
	Duration INT NOT NULL,
	Description NVARCHAR(500) NOT NULL,
	ImdbPoint FLOAT NOT NULL CHECK(ImdbPoint >= 0),
	DirectorId INT FOREIGN KEY REFERENCES Directors(Id)
)

CREATE TABLE Genres(
	Id INT PRIMARY KEY IDENTITY,
	Name NVARCHAR(100) NOT NULL UNIQUE
)

CREATE TABLE MovieGenres(
	Id INT PRIMARY KEY IDENTITY,
	MovieId INT FOREIGN KEY REFERENCES Movies(Id),
	GenreId INT FOREIGN KEY REFERENCES Genres(Id)
)

CREATE TABLE Actors(
	Id INT PRIMARY KEY IDENTITY,
	Fullname NVARCHAR(150) NOT NULL
)

CREATE TABLE MovieActors(
	Id INT PRIMARY KEY IDENTITY,
	MovieId INT FOREIGN KEY REFERENCES Movies(Id),
	ActorId INT FOREIGN KEY REFERENCES Actors(Id)
)


CREATE VIEW  V_ALLNAME
AS
SELECT M.Name 'Movies',
M.ImdbPoint 'Imdbpoint',
G.Name 'Genres',
D.Fullname 'Directors',
A.Fullname 'Actors'
FROM Movies M
JOIN MovieGenres MG
ON MG.MovieId=M.Id
JOIN Genres G
ON MG.GenreId=G.Id
JOIN Directors D
ON M.DirectorId=D.Id
JOIN MovieActors MA
ON MA.MovieId=M.Id
JOIN Actors A
ON MA.ActorId=A.Id

WHERE ImdbPoint>6
SELECT * FROM V_ALLNAME

CREATE VIEW  V_Genres
AS
SELECT M.Name 'Movies',
M.ImdbPoint 'Imdbpoint',
G.Name 'Genres'
FROM Movies M
JOIN MovieGenres MG
ON MG.MovieId=M.Id
JOIN Genres G
ON MG.GenreId=G.Id
--
SELECT * FROM V_Genres
WHERE G.Name LIKE 'a%'

--
CREATE VIEW  V_ALLMOVIE
AS
SELECT M.Name 'Movies',
M.ImdbPoint 'Imdbpoint',
M.Duration 'Duration',
G.Name 'Genres'
FROM Movies AS M
JOIN MovieGenres AS MG
ON MG.MovieId=M.Id
JOIN Genres  AS G
ON MG.GenreId=G.Id

SELECT Movies  FROM V_ALLMOVIE
WHERE M.Name LIKE 'a_________%'	







