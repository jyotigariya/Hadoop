DROP TABLE IF EXISTS hive_DB.MAX_COST_BY_CITY;

CREATE EXTERNAL TABLE IF NOT EXISTS hive_DB.MAX_COST_BY_CITY (
provider_id INT,
provider_name varchar(255),
provider_cityvarchar(255),
average_covered_charges INT
)
COMMENT 'facility with the maximum average_covered_charges by city'
ROW FORMAT DELIMITED
   FIELDS TERMINATED BY '|'
LOCATION 'max_avg_cols';
