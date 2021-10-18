library(tidyverse)
library(data.table)
library (ggplot2)
library (scales)
library(dplyr) 

args=c("netflix_titles.csv","/Users/Elina/Desktop")
INPUT = args[1]
mydir=args[2]

setwd(mydir)

file<- read.csv(INPUT, header=T) %>% select(type, country, duration, duration_value) %>%
      filter(type=="Movie") %>% select(-duration_value, -type)

datastats <- file %>% 
  group_by (country) %>% summarize(
    Mean = round(mean (duration, na.rm = TRUE),2),
    StdDev= round(sd (duration, na.rm = TRUE),2),
  ) %>%
  ungroup %>% data.frame

final<-datastats %>% filter(!is.na(StdDev)) %>% filter(!grepl(",", country)) %>% arrange(desc(Mean))

write.table (final, paste0("movies_countries_Netflix_stats.txt"), sep = "\t", row.names = F, quote = F)


