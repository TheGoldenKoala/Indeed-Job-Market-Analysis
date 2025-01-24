-- How many rows are in the data_analyst_jobs table?
SELECT COUNT(title)
FROM data_analyst_jobs;
-- 1793

-- Write a query to look at just the first 10 rows. 
-- What company is associated with the job posting 
-- on the 10th row?

SELECT company
FROM data_analyst_jobs
LIMIT 10;
-- ExxonMobil

-- How many postings are in Tennessee? 
-- How many are there in either Tennessee or Kentucky?
SELECT
	COUNT(CASE WHEN location = 'TN' THEN 'Tennessee' END) AS tn_job_count,
	COUNT(CASE WHEN location = 'KY' THEN 'Kentucky' END) AS ky_job_count
FROM data_analyst_jobs;

-- How many postings in Tennessee have a star rating above 4?
SELECT
	COUNT(CASE WHEN location = 'TN' AND star_rating > 4 THEN 'YAY' END) AS tn_4_star_abv
FROM data_analyst_jobs;

-- How many postings in the dataset have a review count between 500 and 1000?
SELECT
	COUNT(CASE WHEN review_count > 500 AND review_count < 1000 THEN 'review_count_btwn' END) AS rvw_cnt_btwn_500_1000
FROM data_analyst_jobs;

-- Show the average star rating for companies in each state. 
-- The output should show the state as state and the average rating 
-- for the state as avg_rating. Which state shows the highest average rating?
SELECT location, AVG(star_rating) AS avg_rating
FROM data_analyst_jobs
GROUP BY location
ORDER BY AVG(star_rating);

-- Select unique job titles from the data_analyst_jobs table. How many are there?
SELECT title, COUNT(title)
FROM data_analyst_jobs
GROUP By title;
-- 881

-- How many unique job titles are there for California companies?
SELECT COUNT(DISTINCT(title)), location
FROM data_analyst_jobs
GROUP BY location
ORDER BY COUNT(title);
--230

-- Find the name of each company and its average star rating for all companies 
-- that have more than 5000 reviews across all locations. How many companies 
-- are there with more that 5000 reviews across all locations?
SELECT company, AVG(star_rating)
FROM data_analyst_jobs
WHERE CASE
		WHEN review_count > 5000 AND company IS NOT NULL THEN 'Keep'
		ELSE 'Discard'
	END = 'Keep'
GROUP BY company
Order BY AVG(star_rating);

-- 40

SELECT DISTINCT(company),
       AVG(star_rating),
	   review_count,
	   location
FROM data_analyst_jobs
WHERE review_count > 5000
GROUP BY company, review_count, location




-- Add the code to order the query in #9 from highest to lowest average
-- star rating. Which company with more than 5000 reviews across all 
-- locations in the dataset has the highest star rating? What is that rating?
SELECT company, AVG(star_rating)
FROM data_analyst_jobs
WHERE CASE
		WHEN review_count > 5000 AND company IS NOT NULL THEN 'Keep'
		ELSE 'Discard'
	END = 'Keep'
GROUP BY company
Order BY AVG(star_rating);
-- General Motors; 4.2 star rating

-- Find all the job titles that contain the word ‘Analyst’. 
-- How many different job titles are there?
SELECT
	CASE
		WHEN title ILIKE '%Analyst%' THEN title END
FROM data_analyst_jobs;
--1000

SELECT title
FROM data_analyst_jobs
WHERE CASE
		WHEN title ILIKE '%Analyst%' THEN 'Keep'
		ELSE 'Discard'
	END='Keep';
--1000

SELECT title
       FROM data_analyst_jobs
       GROUP BY title
       HAVING title ILIKE '%Analyst%';

-- How many different job titles do not contain either the word ‘Analyst’ 
-- or the word ‘Analytics’? What word do these positions have in common?
SELECT title
FROM data_analyst_jobs
WHERE CASE
		WHEN title ILIKE '%Analyst%' THEN 'Discard'
		WHEN title ILIKE '%Analytics%' THEN 'Discard'
		ELSE 'Keep'
	END='Keep'

-- BONUS: You want to understand which jobs requiring SQL are hard to fill. 
-- Find the number of jobs by industry (domain) that require SQL and have 
-- been posted longer than 3 weeks.

-- Disregard any postings where the domain is NULL.
-- Order your results so that the domain with the greatest number of hard 
-- to fill jobs is at the top.
-- Which three industries are in the top 4 on this list? How many jobs have 
-- been listed for more than 3 weeks for each of the top 4?
SELECT title
FROM data_analyst_jobs
WHERE CASE
		WHEN domain IS NOT NULL 
		AND days_since_posting > 21
		AND skill = 'SQL'THEN 'Keep'
		ELSE 'Discard'
	END = 'Keep'
GROUP BY title, domain;

SELECT
	domain,
	COUNT (*) AS jobs_hard_to_fill
FROM data_analyst_jobs
WHERE skill ILIKE '%SQL%'	
	AND days_since_posting > 21
	AND domain IS NOT NULL
GROUP BY domain
ORDER BY jobs_hard_to_fill DESC