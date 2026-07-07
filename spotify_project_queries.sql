--EASY LEVEL QUESTIONS

/*Question 1: What are the top 10 most popular tracks in the dataset?*/
SELECT track_name, artists, popularity 
FROM spotify_project.spotify_tracks 
ORDER BY popularity DESC 
LIMIT 10;

/*Question 2: What are the top 10 most popular tracks that do not contain explicit content?*/
SELECT track_name, artists, popularity, explicit
FROM spotify_project.spotify_tracks 
WHERE explicit = 'False'
ORDER BY popularity DESC 
LIMIT 10;

/*Question 3: How many total tracks are there for each unique danceability score?*/
SELECT danceability, COUNT(*) AS total_tracks
FROM spotify_project.spotify_tracks
GROUP BY danceability
ORDER BY danceability DESC
LIMIT 5;

/*Question 4: What are the top 5 longest tracks in the dataset?*/
SELECT track_name, artists, duration_ms 
FROM spotify_project.spotify_tracks 
ORDER BY duration_ms DESC 
LIMIT 5;

/*Question 5: Which songs by The Weeknd belong specifically to the 'pop' genre?*/
SELECT DISTINCT track_name, artists, track_genre
FROM spotify_project.spotify_tracks 
WHERE track_genre = 'pop' AND artists = 'The Weeknd';

/*Question 6: Which tracks are strictly instrumental (tracks containing no vocals at all?*/
SELECT DISTINCT track_name, artists, instrumentalness
FROM spotify_project.spotify_tracks
WHERE instrumentalness > 0.5;

/*Question 7: Which songs begin with the word "Love”?*/
SELECT DISTINCT track_name, artists
FROM spotify_project.spotify_tracks
WHERE track_name LIKE 'Love%';

/*Question 8: Which unique tracks belong to either the 'rock' or 'indie' genres?*/
SELECT DISTINCT track_name, artists, track_genre
FROM spotify_project.spotify_tracks
WHERE track_genre IN ('rock', 'indie');

--MEDIUM LEVEL QUESTIONS

/*Question 1: What are the top 5 most popular music genres based on average popularity?*/
SELECT track_genre, AVG(popularity) AS average_popularity 
FROM spotify_project.spotify_tracks
GROUP BY track_genre 
ORDER BY average_popularity DESC LIMIT 5;

/*Question 2: What is the popularity range for active tracks (popularity greater than 0) across different music genres?*/
SELECT track_genre, MAX(popularity) AS max_pop, MIN(popularity) AS min_pop,
       ROUND(MAX(popularity) - MIN(popularity), 2) AS popularity_range
FROM spotify_project.spotify_tracks
WHERE popularity > 0
GROUP BY track_genre
LIMIT 10;

/*Question 3: What are the top 5 music genres with the longest average track duration in minutes?*/
SELECT track_genre, 
       ROUND(AVG(duration_ms) / 60000, 2) AS avg_duration_minutes
FROM spotify_project.spotify_tracks
GROUP BY track_genre
ORDER BY avg_duration_minutes DESC LIMIT 5;

/*Question 4: Which top 8 artists have the highest count of high-energy, danceable tracks?*/
SELECT artists, COUNT(*) AS high_energy_dance_tracks
FROM spotify_project.spotify_tracks
WHERE danceability > 0.8 AND energy > 0.8
GROUP BY artists
ORDER BY high_energy_dance_tracks DESC
LIMIT 8;

/*Question 5: Explicit or non-explicit tracks, which have a higher average popularity score?*/
SELECT explicit, 
       ROUND(AVG(popularity), 2) AS avg_popularity
FROM spotify_project.spotify_tracks
GROUP BY explicit;

/*Question 6: Which top 8 artists have tracks spanning across the highest number of unique genres?*/
SELECT artists, COUNT(DISTINCT track_genre) AS unique_genre_count
FROM spotify_project.spotify_tracks
GROUP BY artists
ORDER BY unique_genre_count DESC
LIMIT 8;

--HARD LEVEL QUESTIONS

/*Question 1: Which tracks have a popularity score higher than the average popularity of all tracks in the entire dataset?*/
SELECT track_name, artists, popularity
FROM spotify_project.spotify_tracks
WHERE popularity > (
    SELECT AVG(popularity) 
    FROM spotify_project.spotify_tracks)
ORDER BY popularity DESC LIMIT 5;

/*Question 2: How many high-danceability tracks versus low-danceability tracks does each artist have?*/
SELECT artists, COUNT(*) AS total_tracks,
       SUM(CASE WHEN danceability > 0.7 THEN 1 ELSE 0 END) AS high_danceability_count,
       SUM(CASE WHEN danceability <= 0.7 THEN 1 ELSE 0 END) AS low_danceability_count
FROM spotify_project.spotify_tracks
GROUP BY artists
ORDER BY high_danceability_count DESC;

/*Question 3: For each genre, what is the difference between the highest popularity score and the average popularity score?*/
SELECT track_genre,
       MAX(popularity) AS max_popularity,
       ROUND(AVG(popularity), 2) AS avg_popularity,
       ROUND(MAX(popularity) - AVG(popularity), 2) AS popularity_difference
FROM spotify_project.spotify_tracks
GROUP BY track_genre
ORDER BY popularity_difference DESC
LIMIT 10;

/*Question 4: Which artists have an average danceability higher than the overall average danceability of all tracks?*/
SELECT artists, 
       ROUND(AVG(danceability), 2) AS artist_avg_danceability
FROM spotify_project.spotify_tracks
GROUP BY artists
HAVING AVG(danceability) > (
    SELECT AVG(danceability) 
    FROM spotify_project.spotify_tracks)
ORDER BY artist_avg_danceability DESC
LIMIT 10;
