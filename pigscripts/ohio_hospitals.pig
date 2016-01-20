%declare ohio_hospitals_schema 'provider_id: chararray, provider_name: chararray, provider_street_address: chararray, provider_city: chararray, provider_state: chararray, provider_zip_code: chararray, hrr: chararray, total_discharges: chararray, count_drgs: chararray, average_covered_charges: chararray, average_total_payments: chararray, latitude: chararray, longitude: chararray'


ohio_hospitals_in = LOAD '/home/ohio_hospitals_info.csv' USING PigStorage(',') AS ($ohio_hospitals_schema);


-- Find number of hospitals by city;
ohio_hospitals_cols1 =  FOREACH ohio_hospitals_in GENERATE provider_id, provider_name, provider_city, total_discharges;

grp_city = GROUP ohio_hospitals_cols1 BY provider_city;
provider_counts_by_city = FOREACH grp_city GENERATE FLATTEN (group) AS city_name, COUNT(ohio_hospitals_cols1) as provider_count;

--- Find number of discharge's by City
discharge_by_city = FOREACH grp_city GENERATE FLATTEN (group) AS city_name, SUM(ohio_hospitals_cols1.total_discharges) as total_discharges;



--Find the facility with the maximum average_covered_charges by city

ohio_hospitals_cols2 =  FOREACH ohio_hospitals_in GENERATE provider_id, provider_name, provider_city, average_covered_charges;

grp_by_city = GROUP ohio_hospitals_cols2 BY (provider_city);

max_avg_charges_gen = FOREACH grp_by_city GENERATE  FLATTEN(ohio_hospitals_cols2), MAX(ohio_hospitals_cols2.average_covered_charges) as max_chg;

max_avg_charges = FILTER max_avg_charges_gen BY (ohio_hospitals_cols2::max_avg_charges == max_chg);

max_avg_cols = FOREACH max_avg_charges GENERATE 
				ohio_hospitals_cols2::provider_id
				ohio_hospitals_cols2::provider_name
				ohio_hospitals_cols2::provider_city
				ohio_hospitals_cols2::average_covered_charges;
				
STORE max_avg_cols into 'max_avg_cols' USING PigStorage('|');
				
	



