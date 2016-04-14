

# 0: Load the data in RStudio
titanic_1 <- read.csv ("GitHub/r/ex2_titanic/titanic_original.csv", header=TRUE, sep=",", na="")
titanic_1 = titanic_1 [-1310, ]

#1: Port of embarkation

summary(titanic_1$embarked)
titanic_1$embarked [which(is.na(titanic_1$embarked))]<-"S"

#2: Age
summary(titanic_1$age)
x <- median(titanic_1$age,na.rm = TRUE)
titanic_1$age[which(is.na(titanic_1$age))] <- x

# a better way to substitute NA in Ages would be to analyze the column Names. The titles of the 
#persons in the column Names allow to distinguish between the younger persons (Master, Miss)
#and older ones (Mr, Mrs). Populating the Age column with the Means of the title subsets would be
#more appropriate.
# 

#3: Lifeboat
# NA values inserted here 
# titanic_1 <- read.csv ("GitHub/r/ex2_titanic/titanic_original.csv", header=TRUE, sep=",", na="")


#4: Cabin

titanic_1 <- titanic_1 %>%
  mutate(has_cabin_number = ifelse(is.na(cabin), 0, 1))

#Does it make sense to fill missing cabin numbers with a value?

# It doesn't make sence to fill 1014 missing values out of 1309.  

# What does a missing value here mean?

# Most of the time missing value in Cabin coinsides with death of the passanger.

# write csv file
write.csv(titanic_1, "GitHub/r/ex2_titanic/titanic_clean.csv")


