# Title     : Social Adversity Study
# Objective : TODO
# Created by: Dib Gill - MSI3
# Created on: 26-Oct-20
options(digits = 9) #This is becasue census tract ID only shows first 6 digits in console and I want to see all of them

library(tidyverse) #Just a library to let me do more
library(ggplot2)


## Problems: So for the PCCF there are some codes that do not match to active postal codes, how do we know which one to pick if there are multiple postal code entries?



#pt<-read.csv("Pt Postal Code ID #.csv", TRUE) # read pt CSV and put it into "pt"
#pt$PostCode <- toupper(pt$PostCode) # Change all postal codes to upper case

#pccf<-read.csv("pccf_with_labels.csv", TRUE) # read pccf and put it into pccf
#pccf<-pccf %>% distinct(Postal.Code, .keep_all= TRUE) # Only keep unique values of postal code and throw away everything else
#write.csv(pccf, "pccf_with_labels_unique_Postals.csv", row.names = TRUE) # Write the pccf with only unique postal code values to computer
#m1<-merge(pt, pccf, by.x = "PostCode", by.y = "Postal.Code", all.x=TRUE) # Merge pt and pccf based on columns PostCode and Postal.Code
#write.csv(m1, "merge.csv", row.names = TRUE) # Write the above merge to computer
#########################################################################################################
# The below adds HRName to the merge.csv and only keeps PostCode, DAuid, CTname, and HRName
# This is also where we lose 4 of the postal codes as they cannot be joined to a CTname

#m1<-read.csv("merge.csv", TRUE)
#m1<- m1 %>%  select("PostCode","DAuid", "CTname")
#HRName<-read.csv("HRNAME.csv", TRUE)
#HRName<- HRName %>%  select("HRNAME", "DAuid")
#m1<- merge(m1, HRName, by.x="DAuid", by.y="DAuid")
#write.csv(m1, "merge_HRName_simple.csv", row.names = TRUE)


#########################################################################################################
# Create a new HRNAME.CSV with only FRASER SOUTH and CTNames attached
#pccf<- read.csv("pccf_with_labels_unique_Postals.csv", TRUE)
#pccf <- pccf[c("DAuid", "CTname")]
#HRname<- read.csv("HRNAME.csv", TRUE)
#HRname<- filter(HRname, HRNAME == "Fraser South                                                ")
#
#HRname<- merge(HRname, pccf, by.x="DAuid", by.y="DAuid")
#HRname <- HRname %>% mutate (CTname = as.character(CTname))
#HRname$CTname<-substring(HRname$CTname, 1, 7)
#HRname$CTname <- paste0("9330", HRname$CTname)
#HRname <- HRname %>% mutate (CTname = as.numeric(CTname))
#write.csv(HRname, "HRNAME_FRASERSOUTH.CSV", row.names = TRUE)



#########################################################################################################

# The below is changing the CT_Population_2001.CSV file to have the CTname convention used in other census files
#pop<- read.csv("CT_Population_2001.CSV", TRUE)
#names(pop)[names(pop) == "Geography"] <- "CTname"
#pop<-pop[-c(1), ]
#pop <- pop %>% mutate (CTname = as.character(CTname))
#pop$CTname<-substring(pop$CTname, 1, 7)
#pop$CTname <- paste0("933", pop$CTname)
#pop <- pop %>% mutate (CTname = as.numeric(CTname))
#head(pop)
#write.csv(pop, "CT_Population_2001_CTnameFixed.CSV", row.names = TRUE)

#########################################################################################################
# The below counts number of cases per Census Tract and adds "9330" as the CMA to the census tract ID
# Also adds entries from HRName that have 0 incidence

#m1<-read.csv("merge_HRName_simple.csv", TRUE)
#pop<- read.csv("CT_Population_2001_CTnameFixed.CSV", TRUE)
#pop<- pop[c("CTname", "Population..2001..100..data.")]
#HRname<- read.csv("HRNAME_FRASERSOUTH.CSV", TRUE)
#
#m1_count<- as.data.frame(table (m1$CTname))
#names(m1_count)[names(m1_count) == "Var1"] <- "CTname"
#
#m1_count <- m1_count %>% mutate (CTname = as.character(CTname))
#m1_count$CTname <- paste0("9330", m1_count$CTname)
#m1_count <- m1_count %>% mutate (CTname = as.numeric(CTname))
#
#HRname<-HRname %>% distinct(CTname, .keep_all = TRUE)
#m1_count<- merge(m1_count, HRname, by.x="CTname", by.y="CTname", all.x = TRUE, all.y = TRUE)
#m1_count[is.na(m1_count)]<-0
#
#m1_count_pop<- merge(m1_count, pop, by.x="CTname", by.y="CTname")
#m1_count_pop$incidence=m1_count_pop$Freq/m1_count_pop$Population..2001..100..data.
#m1_count_pop<-m1_count_pop[c("CTname", "Freq", "HRNAME", "Population..2001..100..data.","incidence")]
#
#
#write.csv(m1_count_pop, "m1_count_pop.csv", row.names = TRUE)


#########################################################################################################
# Adding income by census family households merged to census tract

#income<- read.csv("Income_2001.csv", TRUE)
#m1_count_pop<- read.csv("m1_count_pop.csv", TRUE)
#colnames(income)
#
#income_house<-income %>% select("CTname","Median.family.income..")
#head(income_house)
#m1_income_house<-merge(m1_count_pop, income_house, by.x="CTname", by.y="CTname")
##
#write.csv(m1_income_house, "m1_income_house.csv", row.names = TRUE)



#########################################################################################################
##Calculating VANDIX Scores and Writing to VANDIX.CSV file

## Read all of the raw files that I made using data extracted from census
#NoCert <- read.csv("./Raw CSV/NoCert.csv", TRUE)
#EduPop <- read.csv("./Raw CSV/EduPop.csv", TRUE)
#UniCert <- read.csv("./Raw CSV/UniCert.csv", TRUE)
#Unemployed <- read.csv("./Raw CSV/Unemployed.csv", TRUE)
#LonePar <- read.csv("./Raw CSV/LonePar.csv", TRUE)
#AveInc <- read.csv("./Raw CSV/AveInc.csv", TRUE)
#HomeOwn <- read.csv("./Raw CSV/HomeOwn.csv", TRUE)
#TotDwell <- read.csv("./Raw CSV/TotDwell.csv", TRUE)
#ParticipationRate <- read.csv("./Raw CSV/ParticipationRate.csv", TRUE)
#TotFam<- read.csv("./Raw CSV/TotFam.csv", TRUE)

## Merge all of the above files into a single data frame
#VANDIX<- merge(NoCert, EduPop)
#VANDIX<- merge(VANDIX, UniCert)
#VANDIX<- merge(VANDIX, Unemployed)
#VANDIX<- merge(VANDIX, LonePar)
#VANDIX<- merge(VANDIX, AveInc)
#VANDIX<- merge(VANDIX, HomeOwn)
#VANDIX<- merge(VANDIX, TotDwell)
#VANDIX<- merge(VANDIX, ParticipationRate)
#VANDIX<- merge(VANDIX, TotFam)

## Correct the CTname to follow the same format as the other CSV files
#VANDIX <- VANDIX %>% mutate (CTname = as.character(CTname))
#VANDIX$CTname<-substring(VANDIX$CTname, 1, 7)
#VANDIX$CTname <- paste0("933", VANDIX$CTname)
#VANDIX <- VANDIX %>% mutate (CTname = as.numeric(CTname))

## Calculate the components of the VANDIX score as required by the VANDIX algorithm
#VANDIX$No.High.school.completion<-VANDIX$NoCert/VANDIX$EduPop
#VANDIX$University.completion<- VANDIX$UniCert/VANDIX$EduPop
#VANDIX$Proportion.of.lone.parent.families<-VANDIX$LonePar/VANDIX$TotFam
#VANDIX$Home.ownership<-VANDIX$HomeOwn/VANDIX$TotDwell

## Calculate the Z score for each of the VANDIX components
#VANDIX<- VANDIX %>%  mutate(Z.No.High.school.completion = (No.High.school.completion - mean(No.High.school.completion))/sd(No.High.school.completion))
#VANDIX<- VANDIX %>%  mutate(Z.University.completion = (University.completion - mean(University.completion))/sd(University.completion))
#VANDIX<- VANDIX %>%  mutate(Z.Unemployed = (Unemployed - mean(Unemployed))/sd(Unemployed))
#VANDIX<- VANDIX %>%  mutate(Z.Proportion.of.lone.parent.families = (Proportion.of.lone.parent.families - mean(Proportion.of.lone.parent.families))/sd(Proportion.of.lone.parent.families))
#VANDIX<- VANDIX %>%  mutate(Z.AveInc = (AveInc - mean(AveInc))/sd(AveInc))
#VANDIX<- VANDIX %>%  mutate(Z.Home.ownership = (Home.ownership - mean(Home.ownership))/sd(Home.ownership))
#VANDIX<- VANDIX %>%  mutate(Z.ParticipationRate = (ParticipationRate - mean(ParticipationRate))/sd(ParticipationRate))

## Calculate the total VANDIX score multiplying each component by its required weight
#VANDIX<- VANDIX%>% mutate(VANDIX.Score=(Z.No.High.school.completion*0.25+Z.University.completion*-0.179+Z.Unemployed*0.214+Z.ParticipationRate*-0.036
#  +Z.Proportion.of.lone.parent.families*0.143+Z.Home.ownership*-0.089+Z.AveInc*-0.089))

## Write the file to the computer
#write.csv(VANDIX, "VANDIX.csv", row.names = TRUE)


########################################################################################################################

## Read the necessary files
VANDIX<-read.csv("VANDIX.csv", TRUE)
m1_count_pop<- read.csv("m1_count_pop.csv", TRUE)

## Merge the above two so I have the VANDIX score and incidence together
VANDIX<- merge(VANDIX, m1_count_pop, by.x="CTname", by.y="CTname")
VANDIX<- VANDIX[-c(34),]  # Remove entry #34 which has a very abnormal finding (easily over 6SD)

## Do the linear regression and print out the summary
pred<- lm(VANDIX.Score~incidence, data=VANDIX)
summary(pred)

## Graph the VANDIX with the incidence
p <- ggplot(VANDIX, aes(x = VANDIX.Score, y = incidence, ylab = "Incidence Per Capita", xlab="TVANDIX"))+ geom_point(shape=0, size=1)
p










#########################################################################################################
## Just extra reference code below this point

#graphics.off()

#m1_income_house<- read.csv("m1_income_house.csv", TRUE)
##lm.imp.1<-lm(earnings ~male+over65+white+immig+educ_r+workmos+workhrs.top+any.ssi+anywelfare+any.charity, data=sis, subset=earnings>0)
#names(m1_income_house)[names(m1_income_house) == "Dim..Household.income.statistics..3...Member.ID...2...Median.total.income.of.households...."] <- "income"
#
#pred <- lm(incidence~income, data=m1_income_house)
##png(file="Plot incidence and income.png",width=1920, height=1080)
#p <- ggplot(m1_income_house, aes(x = income, y = incidence, ylab = "Incidence Per Capita", xlab="Total Household Income ($)")) + geom_point()
#p + annotate("text", x = 4, y = 0.0015, label = summary(pred)) +ylim(0, 0.0018)

##abline(pred)
##dev.off()
#text
#summary(pred)



#########################################################################################################
#The Following Bins the income. Not necessary going forward.

#m1_income_house<- read.csv("m1_income_house.csv", TRUE)
#m1_income_house <- mutate(m1_income_house, IncomeBracket = ifelse(Median.family.income..<60000, "Low", ifelse(Median.family.income..>80000, "High","Middle")))
#m1_income_house<- m1_income_house[-c(100,34),]
#
##ToothGrowth$dose <- as.factor(ToothGrowth$dose)
##head(ToothGrowth)
#
#graphics.off()
##png(file="Plot incidence and income.png",width=1920, height=1080)
#p <- ggplot(m1_income_house, aes(x = Median.family.income.., y = incidence, ylab = "Incidence Per Capita", xlab="Total Household Income ($)"))+ geom_point(shape=0, size=1, aes(color = IncomeBracket))
#p

#ByBracket<-m1_income_house %>%  group_by(IncomeBracket) %>%  summarise_at(vars(Population..2001..100..data., Freq), funs(sum))
#names(ByBracket)[names(ByBracket) == "Freq"] <- "Patient Cases"
#head(ByBracket)
#ByBracket$Incidence<- ByBracket$`Patient Cases`/ByBracket$Population..2001..100..data.
#ByBracket
#

