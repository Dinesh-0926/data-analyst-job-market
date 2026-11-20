# Data Analyst Job Market Analysis (US, 2020)

I analysed 2,253 Glassdoor "Data Analyst" job postings with SQL and Excel to see which skills, cities, sectors and seniority levels show up most, and how pay compares.

## Tools
- **SQL** (SQLite, DB Browser): all the analysis queries
- **Excel**: cross-checks with COUNTIF, AVERAGEIF and pivot tables
- The raw data was cleaned with a Python script that was prepared with AI assistance (Claude). I used the cleaned file for my own analysis.

## Folder structure
- `data/raw/DataAnalyst.csv` is the original dataset, unchanged.
- `data/clean/DataAnalyst_clean.csv` is the cleaned version.
- `data/postings.db` is the cleaned data as a SQLite database (table `postings`, plus a small `regions` lookup table I added).
- `sql/practice.sql` and `sql/joins.sql` hold my queries.
- `sql/analysis.sql` holds the 10 project queries.
- `clean_and_extract.py` is the cleaning script.

## How the data was cleaned
- Replaced `-1` placeholders with blanks.
- Split the company name from the rating attached to it.
- Turned salary text (for example "$37K-$66K") into min, max and midpoint columns.
- Split location into city and state.
- Derived seniority from job titles.
- Flagged 23 skills and topics with keyword matches on the job descriptions (1 = mentioned, 0 = not mentioned).

## SQL concepts used
SELECT, WHERE, ORDER BY, LIMIT, COUNT, SUM, AVG, ROUND, GROUP BY, HAVING, percentage calculations, INNER JOIN and LEFT JOIN (with COALESCE).

## What I found
- SQL appears in about 61% of postings, Excel in 40% and Python in 28%.
- About 88% of Python postings also mention SQL.
- Average pay is almost the same with or without SQL in the posting ($71.7K versus $72.8K), so skills don't explain much of the pay in this data.
- Pay varies far more by city than by skill. San Jose, Santa Clara and San Francisco are the highest.
- Senior/Lead titles average about $75K against about $66K for Junior/Entry.
- About 19% of postings mention supply chain or logistics work.

## Limits
- Postings are from 2020 and cover the US only.
- Salaries are Glassdoor estimates, not posted pay, and they fall into a small number of fixed ranges.
- Skills are keyword matches, so a mention does not mean the skill is required.
