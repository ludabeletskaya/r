library (dplyr)
# assume that correct working directory already set (ex. "C:/Users/ludab/Documents")
# use getwd() to verify and setwd() or UI to set it up
refine_1 <- read.table("GitHub/r/refine_original.csv", header=TRUE, sep=",")

library(stringr)
refine_1 <- refine_1 %>% mutate_each(funs(tolower)) %>% mutate_each(funs(str_trim))

codes <- c ( "philips", "akzo", "van houten", "unilever" )
D <- adist (refine_1$company, codes)
i <- apply (D, 1, which.min )

data.frame(rawtext =refine_1$company, coded = codes[i])
coded <- codes [i]
refine_1$company <- coded
View(refine_1)

refine_1 <- separate(refine_1, Product.code...number, c("product_code","product_number" ))

refine_codes <- read.table("GitHub/r/product_codes.csv", header=TRUE, sep=",")
refine_1 <- inner_join(refine_1, refine_codes)
refine_1 <- unite(refine_1, full_address, address, city, country, sep = ",", remove = FALSE)

library(dummies)

refine_3 <- dummy(refine_1$company, sep= "_")

refine_5 <- dummy(refine_1$product_category, sep= "_")

refine_clean <- cbind(refine_3, refine_1, refine_5)
View (refine_clean)

write.csv(refine_clean, "GitHub/r/refine_clean.csv")