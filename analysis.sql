-- Data Analyst Job Market (US, 2020) | SQLite / PostgreSQL-friendly
-- Load DataAnalyst_clean.csv into a table named postings first.
-- Skill columns (sk_*) are 1/True when the job description mentions the skill.

-- 1. Dataset size and salary summary
SELECT COUNT(*) AS postings,
       ROUND(AVG(Sal_Mid_K),1) AS avg_mid_k,
       MIN(Sal_Mid_K) AS min_mid_k, MAX(Sal_Mid_K) AS max_mid_k
FROM postings;

-- 2. Share of postings mentioning each skill
SELECT 'SQL' AS skill, SUM(sk_SQL) AS postings, ROUND(100.0*SUM(sk_SQL)/COUNT(*),1) AS pct FROM postings
UNION ALL SELECT 'Excel', SUM(sk_Excel), ROUND(100.0*SUM(sk_Excel)/COUNT(*),1) FROM postings
UNION ALL SELECT 'Python', SUM(sk_Python), ROUND(100.0*SUM(sk_Python)/COUNT(*),1) FROM postings
UNION ALL SELECT 'Tableau', SUM(sk_Tableau), ROUND(100.0*SUM(sk_Tableau)/COUNT(*),1) FROM postings
UNION ALL SELECT 'Power BI', SUM("sk_Power BI"), ROUND(100.0*SUM("sk_Power BI")/COUNT(*),1) FROM postings
UNION ALL SELECT 'SAP', SUM(sk_SAP), ROUND(100.0*SUM(sk_SAP)/COUNT(*),1) FROM postings
ORDER BY postings DESC;

-- 3. Average salary midpoint with and without SQL
SELECT sk_SQL AS mentions_sql, COUNT(*) AS postings, ROUND(AVG(Sal_Mid_K),1) AS avg_mid_k
FROM postings GROUP BY sk_SQL;

-- 4. Top 10 cities by postings, with average pay
SELECT City, COUNT(*) AS postings, ROUND(AVG(Sal_Mid_K),1) AS avg_mid_k
FROM postings GROUP BY City ORDER BY postings DESC LIMIT 10;

-- 5. Highest-paying cities with at least 20 postings
SELECT City, COUNT(*) AS postings, ROUND(AVG(Sal_Mid_K),1) AS avg_mid_k
FROM postings GROUP BY City HAVING COUNT(*) >= 20
ORDER BY avg_mid_k DESC LIMIT 10;

-- 6. Pay by seniority
SELECT Seniority, COUNT(*) AS postings, ROUND(AVG(Sal_Mid_K),1) AS avg_mid_k
FROM postings GROUP BY Seniority ORDER BY avg_mid_k DESC;

-- 7. Sectors hiring the most
SELECT Sector, COUNT(*) AS postings, ROUND(AVG(Sal_Mid_K),1) AS avg_mid_k
FROM postings WHERE Sector IS NOT NULL
GROUP BY Sector ORDER BY postings DESC LIMIT 10;

-- 8. Skills that appear together: Python or Tableau postings that also ask for SQL
SELECT ROUND(100.0*SUM(CASE WHEN sk_SQL=1 THEN 1 ELSE 0 END)/COUNT(*),1) AS pct_also_sql
FROM postings WHERE sk_Python=1;
SELECT ROUND(100.0*SUM(CASE WHEN sk_SQL=1 THEN 1 ELSE 0 END)/COUNT(*),1) AS pct_also_sql
FROM postings WHERE sk_Tableau=1;

-- 9. Supply chain and logistics postings: skills they ask for
SELECT COUNT(*) AS postings,
       ROUND(100.0*SUM(sk_SQL)/COUNT(*),1) AS pct_sql,
       ROUND(100.0*SUM(sk_Excel)/COUNT(*),1) AS pct_excel,
       ROUND(100.0*SUM("sk_Power BI")/COUNT(*),1) AS pct_power_bi,
       ROUND(100.0*SUM(sk_SAP)/COUNT(*),1) AS pct_sap,
       ROUND(AVG(Sal_Mid_K),1) AS avg_mid_k
FROM postings WHERE "sk_Supply Chain"=1;

-- 10. Companies posting the most roles
SELECT Company, COUNT(*) AS postings FROM postings
GROUP BY Company ORDER BY postings DESC LIMIT 10;
