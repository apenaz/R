############# EDA - zika ###############
# Tecnologia da Informação em Saúde
# Profs. Julio Ceasar & Beatriz Sransky
# Contribuição: MSc Iara Souza
  

#### pacotes tidyverse ####
# https://www.tidyverse.org/
# https://www.rstudio.com/resources/cheatsheets/
require(readr)
require(tidyr)
require(dplyr)


#### dados cdc_zika ####
# setwd("~/endereço da pasta onde esta o arquivo que sera lido")
zika <- read_csv("~/Dropbox/TI Saude/TIS R_exercicios/cdc_zika.csv")

class(zika)
dim(zika)
colnames(zika)
structure(zika)
summary(zika)
# unique(zika$...)


#### pre-processamento ####
zika <- zika %>%
  separate(col = "report_date", into = c("year", "month"), sep = "-") %>%
  separate(col = "location", into = c("country", "state"), sep = "-") 

# zika$report_date <- as.Date(zika$report_date, format = "%Y-%m-%d") OU
zika$month_name <- ""
zika$month_name[which(zika$month == "01")] <- "jan"
zika$month_name[which(zika$month == "02")] <- "fev"
zika$month_name[which(zika$month == "03")] <- "mar"
zika$month_name[which(zika$month == "04")] <- "abr"
zika$month_name[which(zika$month == "05")] <- "mai"
zika$month_name[which(zika$month == "06")] <- "jun"
zika$month_name[which(zika$month == "07")] <- "jul"
zika$month_name[which(zika$month == "11")] <- "nov"
zika$month_name[which(zika$month == "12")] <- "dez"
View(zika)


#### exerc.1 #####
# Mostre, através de grafico de barras, os países com mais reports na base de dados.

countries <- zika %>%
  group_by(country) %>% 
  drop_na(country) %>%
  summarise(total = sum(value, na.rm = T)) %>% 
  mutate(percent = total / sum(total)) %>%
  arrange(desc(total))

countries <- countries[c(-3, -5, -7, -9, -12), ]
barplot(height = countries$total, log = "y", names.arg = countries$country, las = 2, cex.names = 0.8, main = "Zika cases (cumulative) in 2015-2016")


#### exerc.2 #####
# Construa 3 graficos de barras que mostre, por mes, as incidencias de Zika nos países onde houve maior # incidencia de Zika no ano de 2016. 

co_2016 <- zika %>%
  select(year, month, country, value, month_name) %>%
  filter(country == "Colombia") %>%
  group_by(month, month_name) %>% 
  summarise(total = sum(value, na.rm = T))
# mutate(percent = total / sum(total))
# arrange(month)
barplot(co_2016$total, names.arg = co_2016$month_name, ylab = "cases", main = "Zika cases in Colombia - 2016")

br_2016 <- zika %>%
    select(year, month, country, value, month_name) %>%
    filter(country == "Brazil") %>%
    group_by(month, month_name) %>% 
    summarise(total = sum(value, na.rm = T)) 
#   mutate(percent = total / sum(total))
#   arrange(month)
barplot(br_2016$total, names.arg = br_2016$month_name, log = "y", ylab = "cases", main = "Zika cases in Brazil - 2016")

es_2016 <- zika %>%
    select(year, month, country, value, month_name) %>%
    filter(country == "El_Salvador") %>%
    group_by(year, month) %>% 
    summarise(total = sum(value, na.rm = T)) %>% 
    arrange(month)
barplot(es_2016$total, names.arg = es_2016$month, log = "y", xlab = "month", ylab = "cases", main = "Zika cases in El Salvador - 2015/2016")


#### exerc.3 #####
# Mostre, através de Box Plot, os nuneros de casos por região no Brasil. 
# Use os estados como sendo as amostras, para cada boxplot.

sul <- zika %>%
    select(year, month, state, value) %>%
    filter(state == c("Parana", "Santa_Catarina", "Rio_Grande_do_Sul")) %>%
    group_by(state, month) %>% 
    summarise(total = sum(value, na.rm = T))

boxplot(sul$total[1:5], sul$total[6:11], sul$total[12:13], names.arg = sul$state, ylab = "cases", main = "Zika cases in BR (south region) - 2016")
# xlab = c("PR", "SC", "RS") ??

sul_freq <- spread(data = sul, key = "state", value = "total")
boxplot(sul_freq$Parana, sul_freq$Santa_Catarina, sul_freq$Rio_Grande_do_Sul, ylab = "cases", main = "Zika cases in BR (south region) - 2016")


#### exerc.4 #####
# Crie um grafico de barras que mostre a incidencia total de casos no brasil por estado e por mes. 
# Construa a funçao de densidade de probabilidade que mostra a distribuição de casos de zika por estado e por mes.

br_uf <- zika %>%
    select(year, month, country, state, value) %>%
    filter(country == "Brazil") %>%
    group_by(state) %>% 
    drop_na(state) %>%
    summarise(total = sum(value, na.rm = T)) %>%
    mutate(percent = total / sum(total)) %>%
    arrange(desc(total))

barplot(br_uf$total, names.arg = br_uf$state, log = "y", ylab = "cases", las = 2, cex.names = 0.8, main = "Zika cases in BR - 2016") 

plot(density(br_uf$total))


#### exerc.5 #####
# Calcule a média do aparecimento de Zika no brasil no ano de 2016, em cada estado brasileiro reportado # na base de dados do Zika Virus. Calcule, através desses valores, a média de casos por 100 mil habitantes em cada estado.

mean_uf <- zika %>%
    select(year, month, country, state, value) %>%
    filter(country == "Brazil") %>%
    group_by(state) %>% 
    drop_na(state) %>%
    summarise(avg_state = round(mean(value, na.rm = T), digits = 0)) %>%
    mutate(avg_pop = avg_state / 100000)


#### exerc.6 #####
# Verifique, através de teste estatístico se os valores calculados condizem com a média real proposta 
# pelo ministério da saúde1 para cada região do brasil: Centro Oeste 113,4 casos/100 mil habitantes,
# seguida do Nordeste (53,5); Sudeste (41,4); Norte (36,0); Sul (6,1).
# http://www.brasil.gov.br/editoria/saude/2016/04/saude-divulga-pimeiro-balanco-com-casos-de-zika-no-pais

br_region <- zika %>%
  select(year, month, country, location_type, value) %>%
  filter(location_type == "region") %>%
  group_by(country, month) %>%
  arrange(country)

br_region2 <- zika %>%
    select(year, month, country, location_type, value) %>%
    filter(location_type == "region") %>%
    group_by(country, month) %>%
    arrange(country) %>% 
    summarise(avg_region = mean(value, na.rm = T),
              avg_pop = avg_region / 100000)

valores <- as.vector(br_region$avg_region)
names(valores) <- as.vector(br_region$country)

t.test(x = br_region$value[br_region$country == "Centro"], mu = 53 )
