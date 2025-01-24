SELECT population, county,
	CASE
		WHEN population >= 500000 THEN 'high population'
		WHEN population > 100000 AND population < 500000 THEN 'medium population'
		WHEN population <= 100000 THEN 'low population'
		ELSE 'missing'
	END AS pop_category
FROM population
WHERE year = 2017;