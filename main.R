# Title     : Social Adversity Study
# Objective : TODO
# Created by: Dib Gill - MSI3
# Created on: 26-Oct-20
options(digits = 9) #This is becasue census tract ID only shows first 6 digits in console and I want to see all of them

library(tidyverse) #Just a library to let me do more

## Problems: So for the PCCF there are some codes that do not match to active postal codes, how do we know which one to pick if there are multiple postal code entries?



#pt<-read.csv("Pt Postal Code ID #.csv", TRUE) # read pt CSV and put it into "pt"
#pt$PostCode <- toupper(pt$PostCode) # Change all postal codes to upper case

#pccf<-read.csv("pccf_with_labels.csv", TRUE) # read pccf and put it into pccf
#pccf<-pccf %>% distinct(Postal.Code, .keep_all= TRUE) # Only keep unique values of postal code and throw away everything else
#write.csv(pccf, "pccf_with_labels_unique_Postals.csv", row.names = TRUE) # Write the pccf with only unique postal code values to computer
#m1<-merge(pt, pccf, by.x = "PostCode", by.y = "Postal.Code", all.x=TRUE) # Merge pt and pccf based on columns PostCode and Postal.Code
#write.csv(m1, "merge.csv", row.names = TRUE) # Write the above merge to computer


#########################################################################################################
# The below counts number of cases per Census Tract and adds "9330" as the CMA to the census tract ID

#m1<-read.csv("merge.csv", TRUE)
#pop<- read.csv("CT_Population.CSV", TRUE)
#
#m1_count<- as.data.frame(table (m1$CTname))
#names(m1_count)[names(m1_count) == "Var1"] <- "CTname"
#
#m1_count <- m1_count %>% mutate (CTname = as.character(CTname))
#m1_count$CTname <- paste0("9330", m1_count$CTname)
#m1_count <- m1_count %>% mutate (CTname = as.numeric(CTname))
#
#m1_count_pop<- merge(m1_count, pop, by.x="CTname", by.y="Geographic.code")
#m1_count_pop$incidence=m1_count_pop$Freq/m1_count_pop$Population..2016
#head(m1_count_pop)
#write.csv(m1_count_pop, "m1_count_pop.csv", row.names = TRUE)

#########################################################################################################
# The below I am not done yet but I am adding in the income by census family households merged to census tract

income<- read.csv("Vancouver-Household_data_stats.csv", TRUE)
m1_count_pop<- read.csv("m1_count_pop.csv", TRUE)
colnames(income)

income_house<-income %>% filter(a == 2)
m1_income_house<-merge(m1_count_pop, income_house, by.x="CTname", by.y="GEO_CODE..POR.")

write.csv(m1_income_house, "m1_income_house.csv", row.names = TRUE)



#CT_population<-read.csv("CT_Population.CSV", TRUE)
#colnames(CT_population)



#income<- read.csv("Vancouver-Household_data_stats.csv", TRUE)
#income<-income %>% filter(a == 2)
#
#m1_house_income_count<-merge(m1_count, income, by.x="CTname", by.y="GEO_NAME")
#write.csv(m1_house_income_count, "temp.csv", row.names = TRUE)

