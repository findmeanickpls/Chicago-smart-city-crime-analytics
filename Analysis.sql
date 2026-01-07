SHOW GLOBAL VARIABLES LIKE 'local_infile';
SET GLOBAL local_infile = 1;

Create Database smartcity_crime;
USE smartcity_crime;
drop table crime_data;

Create Table crime_data(
id int Primary Key, 
case_number varchar(100),
date Datetime,
block VARCHAR(100),
iucr VARCHAR(10),
primary_type VARCHAR(100),
description VARCHAR(255),
location_description VARCHAR(150),
arrest BOOLEAN,
domestic BOOLEAN,
beat VARCHAR(10),
district VARCHAR(10),
ward INT,
community_area VARCHAR(10),
fbi_code VARCHAR(10),
year YEAR,
latitude DECIMAL(9,6),
longitude DECIMAL(9,6)

);

SET SQL_SAFE_UPDATES = 0;

UPDATE crime_data
SET year = YEAR(date)
WHERE year IS NULL
LIMIT 50000;

-- Total Rows
SELECT count(* )FROM crime_data Limit 10;

-- Columns in dataset
SHOW COLUMNS FROM crime_data;

-- Data View
SELECT * FROM crime_data LIMIT 10;

-- creating indexes for analysis
CREATE INDEX idx_year ON crime_data(year);
CREATE INDEX idx_district ON crime_data(district);
CREATE INDEX idx_primary_type ON crime_data(primary_type);

-- Crimes per Year
SELECT year, COUNT(*) AS total_crimes
FROM crime_data
GROUP BY year
ORDER BY year;

-- Top 10 Crime Types 
SELECT primary_type, COUNT(*) AS total
FROM crime_data
GROUP BY primary_type
ORDER BY total DESC
LIMIT 10;

-- District with the Highest Arrest
select district,
 SUM(arrest) as Total_Arrest
from crime_data
group by district
order by Total_Arrest Desc
limit 6;

-- Year with the most Arrest
select year,
SUM(arrest) as Total_Arrest
FROM crime_data
group by year
order by Total_Arrest Desc;

-- Top 6 crimes with the most arrest
select primary_type,
SUM(arrest) as Total_Arrest
from crime_data
group by primary_type
order by Total_Arrest Desc 
Limit 6;

-- Month with the highest crime count
SELECT 
    MONTHNAME(date) AS month,
    COUNT(*) AS total_crimes
FROM crime_data
GROUP BY month
ORDER BY total_crimes DESC;

-- Month per year with the highest crime count
select year,
MONTHNAME(date) as month,
count(*) as total_crimes
from crime_data 
group by year, month
order by year, total_crimes Desc;























