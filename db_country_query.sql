USE country;

-- Selezionare tutte le nazioni il cui nome inizia con la P e la cui area è maggiore di 1000 kmq
SELECT *
FROM countries c
WHERE name LIKE 'P%' AND area > 1000;

-- Selezionare le nazioni il cui national day è avvenuto più di 100 anni fa
SELECT *
FROM countries c
WHERE TIMESTAMPDIFF(YEAR, national_day, curdate())>100
-- ordino la tabella per verificare che la data più vicina ai 100 anni sia corretta
ORDER BY national_day DESC;

-- Selezionare il nome delle regioni del continente europeo, in ordine alfabetico
SELECT *
FROM regions r 
ORDER BY name ;

-- Contare quante lingue sono parlate in Italia
SELECT c.name , COUNT(l.language_id) AS lingue_parlate
FROM country_languages cl
INNER JOIN countries c 
ON cl.country_id = c.country_id 
INNER JOIN languages l 
ON cl.language_id = l.language_id 
WHERE cl.country_id = 107;

-- Selezionare quali nazioni non hanno un national day
SELECT *
FROM countries c 
WHERE national_day IS NULL;

-- Per ogni nazione selezionare il nome, la regione e il continente
SELECT c.name AS country , r.name AS region  , c2.name AS continent  
FROM regions r 
INNER JOIN countries c 
ON r.region_id = c.region_id 
INNER JOIN continents c2 
ON r.continent_id = c2.continent_id ;

-- Modificare la nazione Italy, inserendo come national day il 2 giugno 1946
UPDATE countries c
SET c.national_day = '1946-06-2'
WHERE country_id = 107;
-- effettuo il check
SELECT *
FROM countries c 
WHERE c.country_id = 107;

-- Per ogni regione mostrare il valore dell'area totale
SELECT r.name , SUM(c.area ) AS area
FROM countries c 
INNER JOIN regions r 
ON c.region_id = r.region_id 
GROUP BY r.name

-- Selezionare le lingue ufficiali dell'Albania
SELECT c.name , l.`language` AS lingue_ufficiali
FROM country_languages cl 
INNER JOIN countries c 
ON cl.country_id  = c.country_id 
INNER JOIN languages l 
ON cl.language_id = l.language_id
WHERE cl.country_id = 5 AND cl.official  = 1;

-- Selezionare il Gross domestic product (GDP) medio dello United Kingdom tra il 2000 e il 2010
SELECT c.name , AVG(cs.gdp) AS average_GDP
FROM countries c 
INNER JOIN country_stats cs 
ON c.country_id = cs.country_id 
WHERE c.country_id = 77 AND cs.`year` BETWEEN 2000 AND 2010;

-- Selezionare tutte le nazioni in cui si parla hindi, ordinate dalla più estesa alla meno estesa
SELECT c.name , c.area , l.`language` 
FROM country_languages cl 
INNER JOIN countries c 
ON cl.country_id = c.country_id 
INNER JOIN languages l 
ON cl.language_id = l.language_id 
WHERE l.language_id = 26
ORDER BY c.area DESC;

-- Per ogni continente, selezionare il numero di nazioni con area superiore ai 10.000 kmq 
-- ordinando i risultati a partire dal continente che ne ha di più
SELECT c2.name, COUNT(c2.continent_id) AS nazioni_area_maggiore_10000
FROM regions r 
INNER JOIN countries c 
ON r.region_id = c.country_id 
INNER JOIN continents c2 
ON r.continent_id = c2.continent_id 
WHERE c.area > 10000
GROUP BY c2.continent_id
ORDER BY COUNT(c2.continent_id) DESC, c2.name ;