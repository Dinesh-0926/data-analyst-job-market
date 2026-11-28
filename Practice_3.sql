SELECT * FROM regions LIMIT 3;
SELECT * FROM postings 

SELECT r.region, COUNT(*) AS n_postings
FROM postings p
INNER JOIN regions r ON p.city = r.city
GROUP BY r.region
ORDER BY n_postings  DESC;

CREATE TABLE seniority_labels (Seniority TEXT, Level_No INTEGER) ;
INSERT INTO seniority_labels VALUES ('Junior/Entry', 1), ('Mid/Unspecified',2), ('Senior/Lead' ,3) ;

SELECT * FROM seniority_labels


SELECT s.Level_No, ROUND(AVG(p.Sal_Mid_K), 1) AS avg_pay
FROM postings p
INNER JOIN seniority_labels s ON p.Seniority = s.Seniority
GROUP BY s.Level_No
ORDER BY s.Level_No;