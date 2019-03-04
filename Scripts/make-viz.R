library(ggplot2)
library(plotly)
library(knitr)
library(DT)
library(xtable)

kable(stemmeandel)

partifarger <- c("Arbeiderpartiet" = "#DC143C", "Askimpartiet" = "#ffe6ff", 
                 "Blanke" = "#bfbfbf", "Fremskrittspartiet" = "#663300", "Høyre" = "#0066ff", 
                 "Kristelig Folkeparti" = "#ffff1a", "Miljøpartiet De Grønne" = "#66ff33", 
                 "Senterpartiet" = "#00cc00", "Sosialistisk Venstreparti" = "#e60000", 
                 "Venstre" = "#336600")

ggplot(stemmeandel, aes(Year, Andel_som_stemte, fill = Kommunenavn)) +
  geom_bar(stat = "identity", position =  "dodge") +
  scale_y_continuous(limits = c(0,100)) +
  theme_bw()

kable(kommune_valg_indreOstfold) 

Oppslutning <- ggplot(kommune_valg_indreOstfold, aes(Partinavn, Oppslutning.prosentvis, fill = Partinavn)) +
  geom_bar(stat = "identity", position =  "dodge") +
  facet_grid(Kommunenavn ~ Year) +
  scale_y_continuous(limits =c(0, 80)) +
  theme_bw() +
  ylab("Prosentvis oppslutning") +
  xlab("Parti") +
  scale_fill_manual(values = partifarger)

ggplotly(Oppslutning)