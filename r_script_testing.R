

#Load packages -> BAD CODE (delete once renv snapshot)
library(Sleuth3)
library(janitor)
library(here)
library(tidyverse)
library(dplyr)
library(ggplot2)

#renv::snapshot() - run when all the packages are loaded 
```

attach(case0201)   
str(case0201)

# To write data to csv
write.csv(case1402, here("data", "agri_pollution_raw.csv"))

# Load data 
agri_pollution_raw <- read.csv(here("data","agri_pollution_raw.csv"))

mean(Depth[Year==1978]) - mean(Depth[Year==1976])  

yearFactor <- factor(Year) # Convert the numerical variable Year into a factor
# with 2 levels. 1976 is "group 1" (it comes first alphanumerically)
t.test(Depth ~ yearFactor, var.equal=TRUE) # 2-sample t-test; 2-sided by default 
t.test(Depth ~ yearFactor, var.equal=TRUE, 
       alternative = "less") # 1-sided; alternative: group 1 mean is less 

boxplot(Depth ~ Year,  
        ylab= "Beak Depth (mm)",   
        names=c("89 Finches in 1976","89 Finches in 1978"), 
        main= "Beak Depths of Darwin Finches in 1976 and 1978")  

## BOXPLOTS FOR PRESENTATION
boxplot(Depth ~ Year,             
        ylab="Beak Depth (mm)", names=c("89 Finches in 1976","89 Finches in 1978"),  
        main="Beak Depths of Darwin Finches in 1976 and 1978", col="green", 
        boxlwd=2, medlwd=2, whisklty=1, whisklwd=2, staplewex=.2, staplelwd=2,  
        outlwd=2, outpch=21, outbg="green", outcex=1.5)       

detach(case0201)  