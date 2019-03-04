library(dplyr)
library(tidyr)

fordeling_2015 <- read.csv("Data/Partifordeling2015.csv", sep = ";" )
fordeling_2015 <- fordeling_2015 %>%
  filter(Kommunenavn %in% c("Spydeberg", "Askim", "HobÃ¸l", "Eidsberg", "TrÃ¸gstad")) %>%
  select(Kommunenavn, Partinavn, Antall.stemmeberettigede, Antall.stemmer.totalt) %>%
  mutate(Antall.avgitte.stemmer = sum(Antall.stemmer.totalt)) %>%
  spread(Partinavn, Antall.stemmer.totalt) %>%
  mutate(Year = 2015)

Indre <- c("Indre_Ostfold", sum(fordeling_2015$Antall.stemmeberettigede, na.rm = TRUE), 
           sum(fordeling_2015$Antall.avgitte.stemmer, na.rm = TRUE), sum(fordeling_2015$Arbeiderpartiet, na.rm = TRUE), 
           sum(fordeling_2015$Blanke, na.rm = TRUE),
           sum(fordeling_2015$Fremskrittspartiet, na.rm = TRUE),
           sum(fordeling_2015$`HÃ¸yre`, na.rm = TRUE),
           sum(fordeling_2015$`Kristelig Folkeparti`, na.rm = TRUE),
           sum(fordeling_2015$`MiljÃ¸partiet De GrÃ¸nne`, na.rm = TRUE),
           sum(fordeling_2015$Senterpartiet, na.rm = TRUE),
           sum(fordeling_2015$`Sosialistisk Venstreparti`, na.rm = TRUE),
           sum(fordeling_2015$Venstre, na.rm = TRUE),
           2015)
Indre <- as.data.frame(t(Indre))
colnames(Indre) <- kolonner
fordeling_2015 <- rbind(fordeling_2015, Indre)

  