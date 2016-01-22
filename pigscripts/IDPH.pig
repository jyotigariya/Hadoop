A = LOAD '/user/data/IDPH__STDs_Nationally_Ranked_By_State.csv' USING PigStorage(',') AS (Sort:int,Year:int,State:chararray,Chlamydia_Count:int,Chlamydia_Rate:chararray,Chlamydia_RankByCount:int,Chlamydia_RankByRate:chararray,Gonorrhea_Count:int,Gonorrhea_Rate:chararray,Gonorrhea_RankByCount:int,Gonorrhea_RankByRate:chararray,Primary_Secondary_Syphilis_Count:int,Primary_Secondary_Syphilis_Rate:chararray,Primary_Secondary_Syphilis_RankByCount:int,Primary_Secondary_Syphilis_RankByRate:chararray);
B = Filter A by State == 'Alabama';
Dump B;
C = Group B by State;
Describe C;
D = Foreach C Generate group, MAX(B.Chlamydia_Count);
Dump D;

