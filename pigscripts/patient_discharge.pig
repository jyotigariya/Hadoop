%declare patient_disc_schema 'Year: chararray, OSHPD_Facility_Number: chararray, Facility_Name: chararray, Type_Of_Control: chararray, County_Name: chararray, Race_Group: chararray, Count: int'

patient_disc_inp = LOAD '/home/patient_discharge.txt' USING PigStorage(',') AS ($patient_disc_schema);

--Find number of discharge by each hospital by year
year_facility_grp = GROUP patient_disc_inp BY (Year, OSHPD_Facility_Number);
discharge_by_year_facility =  FOREACH year_facility_grp GENERATE FLATTEN(group), SUM(patient_disc_inp.Count) as total_discharges;

rmf discharge_by_year_facility
STORE discharge_by_year_facility into 'discharge_by_year_facility' USING PigStorage('|');


-- Find number of discharge's by year, race, facility and find the race with the maximum discharge's
year_facility_race_grp = GROUP patient_disc_inp BY (Year, OSHPD_Facility_Number, Race_Group);

FOREACH year_facility_race_grp GENERATE FLATTEN(group), 
