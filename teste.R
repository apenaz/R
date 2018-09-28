#install.packages("tidyverse")
require(dplyr)
require(readr)

###Quesstao 1###
#nascimentosRN <- read_csv("~/Documentos/Sem_08/TIS/PJ1/Nascimentos_RN.csv",locale = locale(encoding ="latin1"), na = c("-", "NA"))




#A
nascimentosRN <- read.csv("~/Documentos/Sem_08/TIS/PJ1/Nascimentos_RN2.csv",sep = ";", dec = ",", header = T, encoding = "latin1", na.strings = "-")
queda <-strtoi(nascimentosRN$X2013) - strtoi(nascimentosRN$X2014)
totalRow <- nrow((nascimentosRN)) #encontra a linha do total(ultima)
queda <-queda[-c(totalRow)] #remove o valor da diferença do total
indexQueda <- which.max(queda) #encontra o index do que tem a maior queda
print(nascimentosRN$Município[indexQueda]) #municipio -> Goianinha
print(queda[indexQueda]) #valor 
print(max(queda,na.rm = T))


#B
nascimentosRN <- read.csv("~/Documentos/Sem_08/TIS/PJ1/Nascimentos_RN2.csv",sep = ";", dec = ",", header = T, encoding = "latin1", na.strings = "-")
maior <- 0
maior <- nascimentosRN[[1,3]] - nascimentosRN[[1,2]] #inicia com o valor da 3 coluna menos a 2
iMaior <- 2
for (i in 2:(ncol(nascimentosRN) - 2)){
  crescimento <- nascimentosRN[[1,i+1]] - nascimentosRN[[1,i]]
  if(maior < crescimento){
    maior <- crescimento
    iMaior <- i
  }
}
print(maior) #maior valor
print(nascimentosRN[iMaior]) #ano cm maior valor
#ano de 2002

#C
nascimentosRNDF <- data.frame(nascimentosRN)
print(nascimentosRNDF[,c("X2010", "X2011")])
biggest <- sapply(nascimentosRN, sum(nascimentosRN[[,c("X2010","X2011")]],na.rm=T))

soma <- sapply(nasc[,c("X2010","X2011","X2012","X2013","X2014")],sum)
biggest <- apply(nasc[c("X2010","X2011","X2012","X2013","X2014")],1,sum)

print(max(biggest,na.rm=T))

#soma dos nascimentos entre esses anos p/ cada municipio
bigV <- c(NA)
for (i in 2:nrow(nascimentosRN) - 1){
  bigV[i] <- print(sum(nascimentosRN[i,c("X2010","X2011","X2012","X2013","X2014")],na.rm=T))
}
#maiores valores no vetor de valores
v1 <- max(bigV)
v2 <- max(bigV[bigV!=max(bigV)] )
v3 <- max(bigV[bigV != v1 & bigV != v2])

print(match(c(v1,v2,v3),bigV)) #acha os indices dos maiores valores

#### DAQUI PRA BAIXO SÃO SÓ TESTES, NADA FUNCIONA
plot(nascimentosRN[c(1,2,3),1],nascimentosRN[1,c("X2010","X2011","X2012","X2013","X2014")])
cidades <- nascimentosRN[c(1,2,3),]
print(cidades)
print(nascimentosRN[1,1])
n <- nascimentosRN["1",]
barplot(nascimentosRN[1,c("X2010","X2011","X2012","X2013","X2014")])
print(row.names(nascimentosRN))
print(nascimentosRN[1,c("X2010","X2011","X2012","X2013","X2014")])
print(nascimentosRN[[1]])
row.names(nascimentosRN) <- nascimentosRN[[1]]

nascimentosRN <- as.data.frame(t(nascimentosRN))
nascimentosRN$V1

#D
print(nascimentosRN[c(1,2,3),2:ncol(nascimentosRN)-1])
print(nascimentosRN[c(1,2,3),1])
par(mar = rep(2, 4))
plot(nascimentosRN[c(1,2,3),2:ncol(nascimentosRN)-1],nascimentosRN[c(1,2,3),1])

#grafico
