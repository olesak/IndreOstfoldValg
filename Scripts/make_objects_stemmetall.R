library(dplyr)
library(tidyr)

stemmetall_2015 <- read.csv("Data/Stemmetall2015.csv", sep = ";" )
stemmetall_2015 <- stemmetall_2015 %>%
  filter(Kommunenavn %in% c("Spydeberg", "Askim", "HobÃ¸l", "Eidsberg", "TrÃ¸gstad")) %>%
  select(Kommunenavn, Antall.stemmeberettigede, Godkjente.stemmegivninger...Totalt) %>%
  mutate(Year = 2015)

