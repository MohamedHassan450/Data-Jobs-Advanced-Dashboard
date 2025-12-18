--Average Hourly Salary For Every Country
SELECT search_location As Country , round(avg(salary_hour_avg)) As Hourly_Salary
 From job_postings_fact
 WHERE salary_hour_avg is NOT NULL
 GROUP BY search_location
 ORDER BY Hourly_Salary DESC;

-----------------------------------------------------------------------------------------------------


--Degree Mentioned Vs No Degree Mentioned
SELECT
job_no_degree_mention,
Count(*) 
From job_postings_fact
GROUP BY job_no_degree_mention

-----------------------------------------------------------------------------------------------------


--Most Wanted Data Job For Every Platform
SELECT * FROM
(
    SELECT 
        job_via As Platform,
        job_title_short As Title,
        Count(job_title_short) As Count , 
        RANK() OVER (PARTITION BY job_via ORDER BY COUNT(*) DESC) AS rnk
    From job_postings_fact
    GROUP BY job_via,job_title_short
)As Rank_Table
WHERE rnk = 1
ORDER BY count DESC;

-----------------------------------------------------------------------------------------------------

--Most Wanted Data Job For Every Country
SELECT Country, Title, Count
FROM 
(
    SELECT 
        search_location AS Country,
        job_title_short AS Title,
        COUNT(*) AS Count,
        RANK() OVER (PARTITION BY search_location ORDER BY COUNT(*) DESC) AS rnk
    FROM job_postings_fact
    GROUP BY search_location, job_title_short
) AS ranked_jobs
WHERE rnk = 1
ORDER BY Count DESC;

-----------------------------------------------------------------------------------------------------

--Posts Number For Every Year
SELECT 
extract(YEAR From job_posted_date) as YEAR,
count(extract(YEAR FROM job_posted_date)) As Posts_Number
FROM job_postings_fact
GROUP BY YEAR;

-----------------------------------------------------------------------------------------------------

--Top Hiring Companies in the Every Country
SELECT 
    search_location As Country,
    name As Company ,
    COUNT(name) as Count
FROM job_postings_fact
LEFT JOIN company_dim ON company_dim.company_id = job_postings_fact.company_id
WHERE search_location Like '%United%' AND search_location LIKE '%Emirates%'
GROUP BY search_location,name
ORDER BY count DESC

-----------------------------------------------------------------------------------------------------

--No Degree Mentioned Cound
SELECT
job_no_degree_mention, 
Count(*)
From job_postings_fact
GROUP BY job_no_degree_mention;
-----------------------------------------------------------------------------------------------------
