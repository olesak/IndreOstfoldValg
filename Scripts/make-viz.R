library(ggplot2)
library(plotly)
library(knitr)
library(DT)
library(xtable)

kable(stemmeandel)

partifarger <- c("A" = "#DC143C", "ASKIMP" = "#ffe6ff", 
                 "BLANKEe" = "#bfbfbf", "FRP" = "#663300", "H" = "#0066ff", 
                 "KRF" = "#ffff1a", "MDG" = "#66ff33", 
                 "SP" = "#00cc00", "SV" = "#e60000", 
                 "V" = "#336600")

andel_stemte <- ggplot(stemmeandel, aes(Kommunenavn, Andel_som_stemte, fill = Kommunenavn)) +
  geom_bar(stat = "identity", position =  "dodge") +
  scale_y_continuous(limits = c(0,80)) +
  facet_grid(~År)
  theme_bw()

ggplotly(andel_stemte)

kable(kommune_valg_indreOstfold)

OppslutningAlle <- kommune_valg_indreOstfold %>%
  filter(Kommunenavn != "Indre") %>%
  arrange(År)

kable(OppslutningAlle)

OppslutningAlleViz <- ggplot(OppslutningAlle, aes(Partikode, Oppslutning.prosentvis, fill = Partikode)) +
  geom_bar(stat = "identity", position =  "dodge") +
  facet_grid(Kommunenavn ~ År) +
  scale_y_continuous(limits =c(0, 80)) +
  theme_bw() +
  ylab("Prosentvis oppslutning") +
  xlab("Parti") +
  scale_fill_manual(values = partifarger)

ggplotly(OppslutningAlleViz)

OppslutningIndre <- kommune_valg_indreOstfold %>%
  filter(Kommunenavn == "Indre") %>%
  arrange(År)

kable(OppslutningIndre)

OppslutningIndreViz <- ggplot(OppslutningIndre, aes(Partikode, Oppslutning.prosentvis, fill = Partikode)) +
  geom_bar(stat = "identity", position =  "dodge") +
  facet_grid(Kommunenavn ~ År) +
  scale_y_continuous(limits =c(0, 80)) +
  theme_bw() +
  ylab("Prosentvis oppslutning") +
  xlab("Parti") +
  scale_fill_manual(values = partifarger)

ggplotly(OppslutningIndreViz)

MandaterIndreviz <- ggplot(MandaterIndre, aes(Partikode, Mandater, fill = Partikode)) +
  geom_bar(stat = "identity", position = "dodge") +
  scale_y_continuous(limits =c(0, 50)) +
  theme_bw() +
  ylab("Antall representanter i kommunestyret") +
  xlab("Parti") +
  scale_fill_manual(values = partifarger)

ggplotly(MandaterIndreviz)

