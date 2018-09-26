######### Estatística Descritiva  #########
###  Tecnologia da Informação em Saúde  ###
###  Prof. Julio Cesar Melo (IMD/UFRN)  ###


#### dados EEG ####
require(readr)
eeg <- read_csv("~/tinasaude/EEG_Data.csv.csv")


#### exercicio 1 ####
# Faça um gráfico contendo os sinais F7 e F3, O1, e O2 ambos plotados no tempo e no mesmo gráfico (verifique as funções plot, lines e par).

# par()              # view current settings
# opar <- par()      # make a copy of current settings
# par(opar)          # restore original settings
# https://www.statmethods.net/advgraphs/parameters.html

par(opar)
# mar = c(bottom , left, top , right) => Aumenta as margens para inserir a legenda
par(mar = c(5, 4, 4, 8))

# ?plot()
plot(F7 ~ TIMESTAMP, data = eeg, xlab = "timestamp", ylab = "regsiter", ylim = c(3900, 4600), main = "EEG", col = '2', type = 'l')
lines(eeg$F3 ~ eeg$TIMESTAMP, col = "3")
lines(eeg$O1 ~ eeg$TIMESTAMP, col = "4")
lines(eeg$O2 ~ eeg$TIMESTAMP, col = "5")

legend("bottomright", legend = c("F7", "F3", "O1", "O2"), col = c(2, 3, 4, 5), lty = 2, lwd = 1, bty = "n")


#### exercicio 2 ####
# Faça gráficos contendo os histogramas dos sinais F7 e F3, O1 e O2 na mesma figura, porém em um gráfico 2x2 (use a função par com o argumento mfrow).

par(opar)

# ?hist()
par(mfrow = c(2, 2))
hist(eeg$F7, xlab = "F7", ylim = c(0, 400), main = "", col = "lightgrey")
hist(eeg$F3, xlab = "F3", ylim = c(0, 400), main = "", col = "lightgrey")
hist(eeg$O1, xlab = "O1", ylim = c(0, 400), main = "", col = "lightgrey")
hist(eeg$O2, xlab = "O2", ylim = c(0, 400), main = "", col = "lightgrey")


#### exercicio 3 ####
# Utilize a função boxplot para plotar fatias de 3 em 3 segundos do AF3 no mesmo gráfico.

# fatiamento usando TIMESTAMP
range(eeg$TIMESTAMP)
eeg0_3 <- eeg[which(eeg$TIMESTAMP <= 3.0), ]
eeg3_6 <- eeg[which(eeg$TIMESTAMP > 3.0 & eeg$TIMESTAMP <= 6.0), ]
eeg6_9 <- eeg[which(eeg$TIMESTAMP > 6.0 & eeg$TIMESTAMP <= 9.0), ]
eeg9_12 <- eeg[which(eeg$TIMESTAMP > 9.0 & eeg$TIMESTAMP <= 12.0), ]
eeg12_15 <- eeg[which(eeg$TIMESTAMP > 12.0 & eeg$TIMESTAMP <= 15.0), ]

# ?boxplot()
boxplot(eeg0_3$AF3, eeg3_6$AF3, eeg6_9$AF3, eeg9_12$AF3, eeg12_15$AF3, main = "Boxplot AF3")


# usando listas e laços for
slices <- list()
for (i in (1 : 5)){
  slices[[i]] <- eeg[which(eeg$TIMESTAMP > (i-1)*3.0 & eeg$TIMESTAMP <= i*3.0), ]
}

boxplot(slices[[1]]$AF3, slices[[2]]$AF3, slices[[3]]$AF3, slices[[4]]$AF3, slices[[5]]$AF3, main = "Boxplot AF3")

