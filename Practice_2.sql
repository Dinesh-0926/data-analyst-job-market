-- Q1: How many postings mention Tableau?
SELECT COUNT(*) FROM postings WHERE sk_Tableau = 1;

-- Q2: Top 5 cities for postings that mention Python
SELECT City, COUNT(*) AS python_postings
FROM postings
WHERE sk_Python = 1
GROUP BY City
ORDER BY python_postings DESC
LIMIT 5;

-- Q3: Percentage of postings that mention both SQL and Excel
SELECT ROUND(100.0 * SUM(sk_SQL AND sk_Excel) / COUNT(*), 1) AS both_pct
FROM postings;

-- Q4: Average pay by seniority, levels with more than 30 postings
SELECT Seniority, COUNT(*) AS n_postings, ROUND(AVG(Sal_Mid_K), 1) AS avg_pay
FROM postings
GROUP BY Seniority
HAVING COUNT(*) > 30
ORDER BY avg_pay DESC;

-- Q5: SQL postings per sector, sectors with more than 50 postings
SELECT Sector, COUNT(*) AS n_postings, SUM(sk_SQL) AS sql_postings
FROM postings
WHERE Sector IS NOT NULL
GROUP BY Sector
HAVING COUNT(*) > 50
ORDER BY sql_postings DESC;

-- Subquery 1: postings below average pay that mention both SQL and Python
SELECT COUNT(*) FROM postings
WHERE sk_SQL = 1 AND sk_Python = 1
  AND Sal_Mid_K < (SELECT AVG(Sal_Mid_K) FROM postings);

-- Subquery 2: postings above average pay in New York
SELECT COUNT(*) FROM postings
WHERE City = 'New York'
  AND Sal_Mid_K > (SELECT AVG(Sal_Mid_K) FROM postings);

-- Subquery 3: different sectors with a Chicago posting paying below average
SELECT COUNT(DISTINCT Sector) FROM postings
WHERE City = 'Chicago'
  AND Sal_Mid_K < (SELECT AVG(Sal_Mid_K) FROM postings);

-- CASE WHEN: pay bands (High 80+, Medium 60-79, Low below 60)
SELECT
  CASE
    WHEN Sal_Mid_K IS NULL THEN 'No salary'
    WHEN Sal_Mid_K >= 80 THEN 'High'
    WHEN Sal_Mid_K >= 60 THEN 'Medium'
    ELSE 'Low'
  END AS pay_band,
  COUNT(*) AS n_postings
FROM postings
GROUP BY pay_band
ORDER BY n_postings DESC;