library(tidyverse)
library(data.table)
library (ggplot2)
library (scales)
library(dplyr) 

args=c("vanGoghExtracted.txt","/Users/Elina/Desktop")
INPUT = args[1]
mydir=args[2]

setwd(mydir)

file <- read.table(INPUT, sep ="\t",  header = T) 

datastats <- file %>% 
  group_by (Label_Place, Genre.UPDATED) %>% summarize(
    Mean = round(mean (image_proportion, na.rm = TRUE),2),
    StdDev= round(sd (image_proportion, na.rm = TRUE),2),
  ) %>%
  ungroup %>% data.frame

write.table (datastats, paste0("stats.txt"), sep = "\t", row.names = F, quote = F)
