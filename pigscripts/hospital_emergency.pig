%declare hosp_emergency_schema 'OSHPD_ID: chararray, YEAR: chararray, COUNTY: chararray, FACILITY_NAME: chararray, TYPE_CNTRL: chararray, ED_LEVEL: chararray, EMSA_TRAUMA_LEVEL: chararray, ACUITY: chararray, ED_VISITS_NOT_ADMITTED: int, ADMISSIONS_FROM_ED: int'


hosp_emergengy_inp = LOAD '/home/hosp_emergency.csv' USING PigStorage(',') AS ($hosp_emergency_schema);

all_facility_nm = FOREACH hosp_emergengy_inp GENERATE FACILITY_NAME;

-- Find all facility names
dist_facility_nm = DISTINCT all_facility_nm;

--Find by year&facility number of ED visits and percentage of ADMISSIONS
Facility_Cols = FOREACH hosp_emergengy_inp GENERATE YEAR, FACILITY_NAME, ED_VISITS_NOT_ADMITTED, ADMISSIONS_FROM_ED;


year_facility_grp = GROUP Facility_Cols BY (YEAR, FACILITY_NAME);

facility_sum = FOREACH year_facility_grp GENERATE FLATTEN(group), SUM(Facility_Cols.ED_VISITS_NOT_ADMITTED) as not_admitted, SUM(Facility_Cols.ADMISSIONS_FROM_ED) AS admissions;

admit_percent = FOREACH facility_sum GENERATE group.YEAR, group.FACILITY_NAME, not_admitted, admissions, ((admissions/not_admitted) *  100) admit_percent; 


rmf dist_facility_nm
rmf admit_percent

STORE dist_facility_nm into 'distinct_facility_nm' USING PigStorage('|');
STORE admit_percent into 'admit_percent' USING PigStorage('|');
