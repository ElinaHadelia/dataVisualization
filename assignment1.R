library(tidyverse)
library(data.table)
library (ggplot2)
library (scales)
library(dplyr) 

args=c("share-of-individuals-using-the-internet.txt","toFilter.txt","/Users/Elina/hw1")
INPUT = args[1]
TO_FILTER = args[2]
mydir=args[3]

setwd(mydir)

file <- read.table(INPUT, sep ="\t",  header = T) %>% filter(Year == "2016")

#toFilterSamples <- read.table(TO_FILTER, sep ="\t",  header = F) 
#selsamp <- file %>% select(Entity) %>% filter (Entity %in% toFilterSamples$V1)

selsamp <- file %>% filter(Entity =="Arab World" | Entity =="Caribbean small states" | Entity=="Central Europe and the Baltics"
                            | Entity=="East Asia & Pacific" | Entity=="Europe & Central Asia" | Entity=="Latin America & Caribbean" 
                            | Entity=="Middle East & North Africa" | Entity=="Pacific island small states" | Entity=="South Asia"
                            | Entity=="Sub-Saharan Africa") %>%
  arrange(desc(IndividualsUsingTheInternet_PercOfPopulation))
                  
#barplot. #reorder puts the values of Entity in desc order
g<- ggplot(selsamp, aes(x=reorder(Entity, -IndividualsUsingTheInternet_PercOfPopulation), y=IndividualsUsingTheInternet_PercOfPopulation)) + 
  geom_bar(stat = "identity", aes(fill = Entity))  + theme_bw() +
  labs(title = paste0("Percent of Population Using the Internet in 2016"), x = "Region", y = "Percent of Population") +
  theme(axis.text.x = element_blank(), axis.ticks.x = element_blank())

png("question1_phones.png", width = 3000, height = 2400, res = 300, pointsize = 12)
print(g)
dev.off()

#option1
#pieChart
p<- ggplot(selsamp, aes(x="", y=IndividualsUsingTheInternet_PercOfPopulation, fill=Entity)) +
  geom_bar(stat="identity", width=1, color="white", size=0.8) +
  coord_polar("y", start=0) +theme_minimal() +
  labs(title = paste0("Percent of Population Using the Internet in 2016"),y =element_blank(), x=element_blank()) +
  geom_text(aes(label = paste0(round(IndividualsUsingTheInternet_PercOfPopulation), "%")), 
            position = position_stack(vjust = 0.5), size = 3)  +
  theme(panel.grid  = element_blank(), axis.text = element_blank()) 

png("question2_internet.png", width = 3000, height = 2400, res = 300, pointsize = 12)
print(p)
dev.off()
 
  
#option2
#barchart
file2 <- read.table(INPUT, sep ="\t",  header = T) %>% filter(Year == "2005" | Year =="2010" | Year=="2015")
selsamp2 <- file2 %>% filter(Entity =="Arab World" | Entity =="Caribbean small states" | Entity=="Central Europe and the Baltics"
                           | Entity=="East Asia & Pacific" | Entity=="Europe & Central Asia" | Entity=="Latin America & Caribbean" 
                           | Entity=="Middle East & North Africa" | Entity=="Pacific island small states" | Entity=="South Asia"
                           | Entity=="Sub-Saharan Africa") 

g2<- ggplot(selsamp2, aes(x=reorder(Entity, -IndividualsUsingTheInternet_PercOfPopulation), y=IndividualsUsingTheInternet_PercOfPopulation, fill = Year)) + 
  geom_col() + theme_bw() +
  labs(title = paste0("Percent of Population Using the Internet in 2005, 2010 and 2015"), x = element_blank(), y = "Percent of Population") + 
  theme(axis.text.x = element_text(angle=45, hjust=1)) 

png("question2_internet_medium.png", width = 3000, height = 2400, res = 300, pointsize = 12)
print(g2)
dev.off()


