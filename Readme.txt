This is a repository for the R code used in the Social Adversity Study with Dib Gill and Robert Nathan

Files:
Raw data
Pt Postal Code ID#.csv: Just Pt postal codes
pccf_with_labels.csv: Is the Postal Code Conversion File used here to convert postal code to census tracts
CT_Population.csv: Census population information for Vancouver area
Vancouver-Household_data_stats.csv: Census income information for Vancouver Area

Edited File
pccf_with_labels_unique_Postals: PCCF but all non-unique postal codes removed. May lose data quality.
merge.csv: Pt Postal Code ID# and pccf_with_labels_unique_Postals.csv merged together on postal code
m1_count_pop.csv: tabulation of # of pt's per census tract from merge.csv. Also merged w/ CT_Population.csv to calculate incidence of pt's per census tract
m1_income_house.csv: m1_count_pop.csv merged w/ Vancouver-Household_data_stats.csv



temp.csv: Just temporary. Delete later
main.R: Has all of the code with comments and only the most recent part of code is uncommented. Old code used to create project is still there.