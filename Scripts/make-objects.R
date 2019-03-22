library(dplyr)
library(tidyr)


fordeling_2015 <- read.csv("Data/Partifordeling2015.csv", sep = ";", stringsAsFactors = FALSE )
fordeling_2015 <- fordeling_2015 %>%
  filter(Kommunenavn %in% c("Spydeberg", "Askim", "HobÃ¸l", "Eidsberg", "TrÃ¸gstad")) %>%
  select(Kommunenavn, Partinavn, Partikode, Oppslutning.prosentvis, Antall.stemmeberettigede, Antall.stemmer.totalt) %>%
  mutate(Year = 2015, Totalt_ant_stemmer_Indre = sum(Antall.stemmer.totalt))

fordeling_2015$Oppslutning.prosentvis <- gsub(",", ".", fordeling_2015$Oppslutning.prosentvis)

fordeling_2015 <- mutate(fordeling_2015, Oppslutning.prosentvis = as.double(Oppslutning.prosentvis))

Indre2015 <- fordeling_2015 %>%
  group_by(Partinavn, Partikode) %>%
  summarize(Oppslutning.prosentvis = (sum(Antall.stemmer.totalt, na.rm = TRUE)/unique(Totalt_ant_stemmer_Indre))*100,
            Antall.stemmer.totalt = sum(Antall.stemmer.totalt, na.rm = TRUE)) %>%
            mutate(Kommunenavn = "Indre", Year = 2015, Antall.stemmeberettigede = 33872)

fordeling_2015 <- merge(fordeling_2015, Indre2015, all = TRUE)
 


fordeling_2011 <- read.csv("Data/Partifordeling2011.csv", sep = ";", stringsAsFactors = FALSE )
fordeling_2011 <- fordeling_2011 %>%
  filter(Kommunenavn %in% c("Spydeberg", "Askim", "HobÃ¸l", "Eidsberg", "TrÃ¸gstad")) %>%
  select(Kommunenavn, Partinavn, Partikode, Oppslutning.prosentvis, Antall.stemmeberettigede, Antall.stemmer.totalt) %>%
  mutate(Year = 2011, Totalt_ant_stemmer_Indre = sum(Antall.stemmer.totalt))

fordeling_2011$Oppslutning.prosentvis <- gsub(",", ".", fordeling_2011$Oppslutning.prosentvis)

fordeling_2011 <- mutate(fordeling_2011, Oppslutning.prosentvis = as.double(Oppslutning.prosentvis))
fordeling_2011$Partinavn <- gsub("Det norske Arbeiderparti", "Arbeiderpartiet", fordeling_2011$Partinavn)

Indre2011 <- fordeling_2011 %>%
  group_by(Partinavn, Partikode) %>%
  summarize(Oppslutning.prosentvis = (sum(Antall.stemmer.totalt, na.rm = TRUE)/unique(Totalt_ant_stemmer_Indre))*100,
            Antall.stemmer.totalt = sum(Antall.stemmer.totalt, na.rm = TRUE)) %>%
  mutate(Kommunenavn = "Indre", Year = 2011, Antall.stemmeberettigede = 31919)

fordeling_2011 <- merge(fordeling_2011, Indre2011, all = TRUE)

kommune_valg_indreOstfold <- merge(fordeling_2011, fordeling_2015, all = TRUE)

rm(fordeling_2011, fordeling_2015, Indre2011, Indre2015)

kommune_valg_indreOstfold$Partinavn <- gsub("HÃ¸yre", "Høyre", kommune_valg_indreOstfold$Partinavn) 
kommune_valg_indreOstfold$Partinavn <- gsub("MiljÃ¸partiet De GrÃ¸nne", "Miljøpartiet De Grønne", kommune_valg_indreOstfold$Partinavn)
kommune_valg_indreOstfold$Kommunenavn <- gsub("TrÃ¸gstad", "Trøgstad", kommune_valg_indreOstfold$Kommunenavn)
kommune_valg_indreOstfold$Kommunenavn <- gsub("HobÃ¸l", "Hobøl", kommune_valg_indreOstfold$Kommunenavn)

kommune_valg_indreOstfold <- kommune_valg_indreOstfold %>%
  select(Kommunenavn, År = Year, everything())

stemmeandel <- kommune_valg_indreOstfold %>%
  group_by(Kommunenavn, År) %>%
  summarize(Andel_som_stemte = (sum(Antall.stemmer.totalt) / sum(unique(Antall.stemmeberettigede)))*100,
            Antall_stemmer = sum(Antall.stemmer.totalt),
            Antall.stemmeberettigede = sum(unique(Antall.stemmeberettigede)))
