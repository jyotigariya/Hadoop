#####
CREATE DATABASE IF NOT EXISTS  hive_DB;

DROP TABLE IF EXISTS hive_DB.DISCHARGE_BY_YEAR;

CREATE EXTERNAL TABLE IF NOT EXISTS hive_DB.DISCHARGE_BY_YEAR (
Year INT,
OSHPD_Facility_Number INT,
TOTAL_DISCHARGES INT
)
COMMENT 'Find number of discharge by each hospital by year'
ROW FORMAT DELIMITED
   FIELDS TERMINATED BY '|'
LOCATION 'discharge_by_year_facility';

###


DROP TABLE IF EXISTS hive_DB.ADMISSIONS_PERCENT;

CREATE EXTERNAL TABLE IF NOT EXISTS hive_DB.ADMISSIONS_PERCENT (
Year INT,
OSHPD_Facility_Number INT,
max_count INT,
total_discharges INT,
Race_Group varchar(255)
)
COMMENT 'Find number of discharges by year, race, facility'
ROW FORMAT DELIMITED
   FIELDS TERMINATED BY '|'
LOCATION 'max_discharge_race';
