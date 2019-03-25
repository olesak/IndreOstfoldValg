library(purrr)

MandaterIndre <- kommune_valg_indreOstfold %>%
  filter(Kommunenavn == "Askim", År == 2015, Partinavn != "Blanke") %>%
  select(Partikode, Antall.stemmer.totalt) %>%
  mutate(Mandater = 0)

print(MandaterIndre)

# j = c()
# ind <- 0
# for(i in 1:8) {
#   k <- MandaterIndre[i,2]
#   j <- append(j, k/1.4 )
# }
# ind <- j[] == max(j)
# MandaterIndre[ind,3] <- MandaterIndre[ind,3] +1
# print(ind)
# print(j)

m <- 0
while( m <= 34){
  j = c()
  ind <- 0
  
  for(i in 1:8) {
    k <- MandaterIndre[i,2]
    l <- 2*MandaterIndre[i,3] + 1
    j <- append(j, k/l )
    
  }
  ind <- j[] == max(j)
  
  MandaterIndre[ind,3] <- MandaterIndre[ind,3] +1
  m <- m + 1
  print(j)
}

MandaterIndre <- MandaterIndre %>% arrange(desc(Mandater))

kable(MandaterIndre)
