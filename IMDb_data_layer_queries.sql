-- obtains basic movie details from a database, including the title, year, duration, and genres
SELECT original_title,title_type,is_adult, start_year,runtime_minutes, genres
FROM `bigquery-public-data.imdb.title_basics`
WHERE original_title = "The Matrix" AND title_type = "movie";

-- retrieves details about the characters and the corresponding actors that play them in the movie
SELECT tb.original_title, tp.characters, nb.primary_name as actor_name
FROM `bigquery-public-data.imdb.title_principals` as tp
JOIN `bigquery-public-data.imdb.name_basics` as nb
ON tp.nconst = nb.nconst
JOIN `bigquery-public-data.imdb.title_basics` as tb
ON tb.tconst = tp.tconst
WHERE tb.original_title = "The Matrix" AND tp.category IN ('actor', 'actress');

-- classifies and retrieves films that belong to certain genres such as action, comedy, or drama
SELECT tconst,original_title,start_year,end_year,genres AS Genres
FROM`bigquery-public-data.imdb.title_basics`
WHERE genres LIKE '%Action%' OR genres LIKE '%Comedy%' OR genres LIKE '%Drama%';

-- retrieves the titles and years for every entry related to a certain actor in a variety of productions
SELECT tb.primary_title, tb.start_year
FROM `bigquery-public-data.imdb.title_principals` tp
JOIN `bigquery-public-data.imdb.title_basics` tb ON tp.tconst = tb.tconst
JOIN `bigquery-public-data.imdb.name_basics` nb ON tp.nconst = nb.nconst
WHERE nb.primary_name = 'Tom Cruise';

--retrieve content that was published in a given year or range of years
SELECT tconst, primary_title, start_year
FROM `bigquery-public-data.imdb.title_basics`
WHERE start_year = 2023
OR start_year BETWEEN 2023 AND 2024;

-- retrieve movie details with their ratings
SELECT tb.primary_title, tb.start_year, tr.average_rating, tr.num_votes
FROM `bigquery-public-data.imdb.title_basics` tb
JOIN `bigquery-public-data.imdb.title_ratings` tr ON tb.tconst = tr.tconst
WHERE tb.primary_title = 'The Matrix' AND tb.start_year = 1999;

-- retrieve the director's name for a given film title
SELECT tb.primary_title, nb.primary_name AS Director
FROM `bigquery-public-data.imdb.title_basics` tb
JOIN `bigquery-public-data.imdb.title_crew` tc
ON tb.tconst = tc.tconst
JOIN `bigquery-public-data.imdb.name_basics` nb
ON tc.directors = nb.nconst
WHERE tb.primary_title = "Jurassic Park" AND tb.start_year = 1993;

--provide a list of every unique episode from a given TV season
SELECT DISTINCT tb.primary_title, re.episode_number, re.season_number
FROM `bigquery-public-data.imdb.title_basics` tb
JOIN `bigquery-public-data.imdb.title_episode` re ON tb.tconst = re.tconst
WHERE tb.primary_title = "The Office" AND re.season_number = 1;

--retrieve an extensive collection of reviews in addition to the average rating for a particular film
SELECT r.title, r.review,tr.average_rating
FROM  `bigquery-public-data.imdb.reviews` r
JOIN `bigquery-public-data.imdb.title_ratings` tr
ON  r.movie_id = tr.tconst
WHERE r.title = 'The Devil Wears Prada';

-- retrieve the names of the writers behind a certain film 
SELECT tb.primary_title,nb.primary_name AS writer_name
FROM  `bigquery-public-data.imdb.title_crew` tc
JOIN  `bigquery-public-data.imdb.title_basics` tb ON tb.tconst = tc.tconst
JOIN  `bigquery-public-data.imdb.name_basics` nb ON nb.nconst = tc.writers
WHERE tb.primary_title = 'The Devil Wears Prada';

-- retrieve a list of films in decreasing order of total votes.
SELECT tb.primary_title, tr.num_votes
FROM `bigquery-public-data.imdb.title_basics` AS tb
JOIN `bigquery-public-data.imdb.title_ratings` AS tr
ON tb.tconst = tr.tconst
ORDER BY tr.num_votes DESC
LIMIT 10;

-- retrieve a list of the most well-liked action films that were released in a specific year, arranged according to average rating
SELECT tb.primary_title, tb.start_year as Release_Year,tb.genres, tb.title_type,tr.average_rating
FROM `bigquery-public-data.imdb.title_basics` tb
JOIN `bigquery-public-data.imdb.title_ratings` tr ON tb.tconst = tr.tconst
WHERE tb.start_year = 2018 AND tb.title_type = "movie" AND tb.genres LIKE '%Action%'
ORDER BY tr.average_rating DESC
LIMIT 10;

-- retrieve movies that are directed by a certain director.
SELECT tb.primary_title, tb.start_year as Release_date, tb.genres, nb.primary_name AS director_name
FROM `bigquery-public-data.imdb.title_basics` tb
JOIN `bigquery-public-data.imdb.title_crew` tc ON tb.tconst = tc.tconst
JOIN `bigquery-public-data.imdb.name_basics` nb ON tc.directors = nb.nconst
WHERE nb.primary_name = 'Christopher Nolan'
LIMIT 5;


