# AULA - INTRODUCAO AO R --------------------------------------------------
# Desenvolvido por: Prof. Dr. Rodrigo Dalmolin

# Existem algumas formas gratuitas de aprender a programar em R. Destaco o curso "introducao ao
# R" do Coursera: https://www.coursera.org/learn/r-programming, que faz parte de um programa de 
# especializacao em ciencia de dados, tambem todo voltado ao ambiente do R.

# Duvidas e sugestoes: iaradsouza1@gmail.com

#### Operacoes simples ####

# Aritmetica basica
2+5         #adicao
5-2         #subtracao
2*5         #multiplicacao
8/2         #divisao
2^5         #exponenciacao

# Avaliacao logica
3==5	      #igual
3!=5	      #diferente
3>5	        #maior que
3<5	        #menor que
3>=5	      #maior ou igual
3<=5	      #menor ou igual

#### Variaveis ####

x <- 1        # A seta "<-" representa o simbolo de atribuicao
x           # Ao escrever o nome do objeto, seu valor sera impresso
x <- 5        # sobrescreve o conteudo anterior da variavel x
x

y <- "gol do gremio!"
y
x <- c(c(1 ,2, 3),c(4, 5, 6),c( 7, 8, 9))

x
t(x)
##### Diretorio de trabalho ####

getwd()           # verifica o diretorio de trabalho
setwd("~/Área de Trabalho/Aula/")           # define o diretorio de trabalho
list.files()      # lista os arquivos presentes no diretorio de trabalho

#### Chamada de Funcoes ####

# Chamadas pelo nome
sum(1,3,5)

# Podem receber argumentos
a <- rep("Aluno",times=3)
a

####################################################################################################

#### Vetores ####
# Todos os objetos em R sao vetores. Os mais simples deles, os unidimensionais, sao chamados de 
# vetores atomicos e pode ser das seguintes classes:
# Caracter
# Numerico
# Inteiro
# Logico
# Complexo

# Funcao c() : concatenate
number <- c(1, 2, 3, 4, 5)
letter <- c("x", "y", "z", "w", "j")
logico <- c(TRUE, FALSE, FALSE, TRUE, FALSE)
seq <- 1:10
seq <- c(1L, 2L, 3L, 4L, 5L)
complexo <- 4i

# A classe da cada objeto pode ser acessada pela funcao class()

# Funcao vector(): cria vetores
a <- vector(mode = "integer", length = 10)
b <- vector("logical", 10)
c <- numeric(10)
d <- character(10)
e <- complex(10)                # os vetores sao criados com valores padrao de cada classe

x <- 1                          # numeros sao salvos como numeric
x <- 1L                         # para explicitar integer, usa-se L

# Hierarquia de classes
x <- c(1, 2, 3)                 # numeric
y <- c("1", "2", "3")           # character


x <- c(TRUE, FALSE, FALSE)      # logical
y <- c("TRUE", "FALSE", "FALSE") # character

# Ex.2: verifique a classe de cada objeto
a <- c(1, "a", TRUE)
b <- c(1, "a")
c <- c(1, T)
d <- c("a", T)

# Ordem de hierarquia:
# Character > numeric > integer > logical

sum(logico)           #Podemos somar vetores logicos

# OBS. vetores comportam somente uma classe de elementos

# Coercao de objetos usando funcoes do tipo as.algumacoisa()
x <- 0:10
x
class(x)

a <- as.numeric(x)
a
class(a)

b <- as.character(x)
b
class(b)

c <- as.logical(x)
c
class(c)

#Ex.3: verifique se "x" e "a" sao iguais
identical(a, x)

#Ex.4: tente converter o vetor b em numeric
b <- as.numeric(b)

# Vetores de NA
x <- c(1, 2, 3, NA)
y <- c("a", "b", "c", NA)

is.na(x)
is.numeric(a)
is.logical(c)

a <- c(1, 3, NA, 7, 9)
sum(a)
sum(a, na.rm=TRUE)

# Objetos possuem atributos: classe, tamanho, dimensoes, nomes, etc
x <- 1:5
x
length(x)
dim(x)
attributes(x)
names(x) <- c("a", "b", "c", "d", "e")
x
attributes(x)

#### Factors ####

# Fatores sao vetores categoricos, possuem o atributo level

x <- factor(c("s", "n", "n", "s", "s"))
x
z <- factor(c("alto", "baixo", "medio"))
z

# Trabalhando com vetores ####
##  Operacoes vetorizadas
x <- 1:5
y <- 6:10
x+y               #ocorre a soma dos valores de ambos os vetores

x*2               #podemos multiplicar um vetor por um numero
x^2

z <- c(x,y)
z+x
w <- 1:3
w+x

l <- c(T, T, F, T, F, F)
l/2

## para acessar vetores, usamos [ ]
letter<-c("x", "y", "z", "w", "j")
letter[2]               #acessa o segundo elemento do vetor
letter[2:4]             #podemos usar sequencia de valores
letter[c(1, 4)]         #usamos a funcao c() para valores nao contiguos
letter[-2]              #usamos numeros negativos para excluir um ou mais valores
letter[c(-2, -5)]

idx<-c(1, 4)            #podemos criar indices numericos
letter[idx]

x <- 1:10
x[x>7]                  #podemos usar "<", "==", ">=", etc.

letter[letter>"k"]      #tambem eh possivel para caracteres
letter[letter<"k"]
letter=="z"

# Funcoes para identificar valores extremos
set.seed(1)
s <- sample(-1000:1000, 200)

which.max(s)            #procura a posicao do maior valor
max(s)                  #imprime o maior valor
min(s)
which.min(s)
range(s)

s>0                     #cria um vetor logico
which(s>0)              #cria um vetor com as posicoes que satisfazem o comando

#Ex.1: quantos valores de s sao maiores que 0?

# Funcoes de ordenamento
x <- c(3, 8, 2, 1, 5, 9, 7, 7, 3)
x
sort(x)                 #ordena um vetor
sort(x, decreasing = T)
order(x)                #pega a ordem de cada elemento para torna-lo crescente
sample(x)               #randomiza
unique(x)               #elimina as replicatas
duplicated(x)           #logico

#### Matrizes ####

# Matrizes sao vetores com o atributo dimensao
x <- 1:20
x
attributes(x)

m <- matrix(x, 4, 5)
m
attributes(m)

dim(x) <- c(4,5)
x
identical(x, m)

# OBS.: como sao vetores, matrizes comportam somente uma classe de elementos
a <- 1:5
b <- -1:-5
c <- c(3, 6, 4, 9, 1)

m <- cbind(a, b, c)       #funcao cbind() concatena colunas
m
m1 <- rbind(a, b, c)      #funcao rbind() concatena linhas
m1

# Acesso a matrizes
m[1,3]                  #endereco das duas dimencoes [linha,coluna]
m[1, ]
m[2:3, ]
m[1,] <- NA
m

#### Listas ####

# Listas sao tipos especiais de vetores, que comportam elementos de diferentes classes
a <- c(1, 3, NA, 7, 9)
b <- matrix(1:200, 20, 10)
c <- "Gol do Gremio"
z <- factor(c("alto", "baixo", "medio"))

ls <- list(a, b, c, z)
ls                      #cada elemento da lista aparece com [[]]

ls1 <- vector("list", 5)   #funcao vector pode criar listas vazias
ls1

#### Trabalhando com listas ####
ls[1]              #[] extrai uma lista
ls[[1]]            #[[]]extrai o objeto interno

class(ls[1])
class(ls[[1]])

ls[[c(1,2)]]      # posicao na lista e posicao no elemento
ls[[2]][2,]
names(ls) <- c("Arilson", "Roger", "Paulo Nunes", "Jardel")
ls$Roger
ls$Arilson

#### Data.frame ####

# Formado por vetores de mesmo tamanho, organizados como colunas

number <- c(1, 2, 3, 4, 5)
letter <- c("x", "y", "z", "w", "j")
logical <- c(TRUE, FALSE, FALSE, TRUE, FALSE)
seq <- 1:10

dt <- data.frame(number, letter, logical)
class(dt)
dt$letter                     #usamos $ para acessar as colunas de um data.frame
class(dt$letter)              #vetores de caracter sao interpretados como fatores

dt <- data.frame(number, letter, logical, stringsAsFactors = F) #stringsAsFactors = F
dt$letter
class(dt$letter)

attributes(dt)                #data.frames possuem colnames e rownames
colnames(dt)
row.names(dt)

dt[5,2]                       #acessamos data.frames da mesma forma que matrizes

#### Trabalhando com data.frames ####

# Para acessar data.frames usamos [], [[]] ou $

dt <- data.frame(number=c(1, 2, 3, 4, 5),
               letter = c("x", "y", "z", "w", "j"),
               logical = c(TRUE, FALSE, FALSE, TRUE, FALSE))

dt[[1]]              # [[ ]] acessa cada coluna por posicao
dt[,1]               # [ ] acessa as coordenadas [linha, coluna]
dt$number            # $ acessa cada coluna por nome

cars <- mtcars        #carrega o data.frame mtcars
head(cars)          #mostra as 6 primeiras linhas
tail(cars)          #mostra as 6 ultimas linhas

# Data.frames possuem colnames e rownames
colnames(dt)
row.names(dt)

# Podemos alterar colnames e rownames
row.names(dt) <- c("a", "b", "c", "d", "e")
colnames(dt)[2] <- "letras"     #alteramos unicamente a posicao 2

# Podemos alterar valores especificos de um data.frame
dt[3,1] <- "10"
dt$logical <- as.numeric(dt$logical)
dt$letras <- NA
dt
# Podemos verificar as ocorrencias de um data.frame em outro

biometria <- data.frame(nomes=c("Carlos", "Roberto", "Olivio", "Joel"),
                      altura=c(180, 187, 155, 168),
                      peso=c(80, 90, 98, 64))
esportes <- data.frame(nomes=c("Carlos", "Roberto", "Olivio", "Jomar"),
                     esportes=c("futebol", "remo", "sumo", "maratona"))

biometria$nomes %in% esportes$nomes         #constroi um logico
idx <- biometria$nomes %in% esportes$nomes    #pode ser usado como indice
x <- biometria[idx,]

# Unindo data.frames com a funcao merge()
unido <- merge(biometria, esportes, by="nomes")   #OBS.:Independe da ordem dos data.frames!
# A busca eh feita pelo nome, nao pela ordem!
# O resultado sempre vira em ordem alfabetica!

unido <- merge(biometria, esportes, by="nomes", all.x=T) #com todos presentes no primeiro
unido <- merge(biometria, esportes, by="nomes", all.y=T) #com todos presentes no segundo
unido <- merge(biometria, esportes, by="nomes", all=T) #com todos presentes

#### Importando e salvando dados ####

# Rodando codigos de scripts
source(file = "Exemplo.R")   # source() roda um script do diretorio indicado

# Carregando objetos do R
load("COGs.RData")  # load() carrega arquivos R

# lendo arquivos tabulares de texto (.txt)
cluster11 <- read.table("Data/cluster11.txt") # read.table() le arquivos .txt e converte em data.frame 

args(read.table) # args() imprime os argumentos de uma funcao   
help(read.table)

# Lendo arquivos .csv
GPL570 <- read.csv("Data/GPL570.csv") # read.csv() eh especifico para comma separeted value

# Salvando objetos em arquivos do R
save(unido, biometria, esportes, file="unido.RData") # save() salva os arquivos em binario  

# Salvando txt
write.table(unido, file="unido.txt", sep="\t", row.names=FALSE) # write.table() salva arquivos .txt
list.files()

#### Plots ####

# Funcao plot
plot(x = mtcars$mpg, y = mtcars$hp, xlab = "MPG", ylab = "HP", pch = 16, col = "red")

# Argumentos da funcao plot: parametros graficos
?par

# Barplot 
barplot(mtcars$wt, las = 2, names.arg = rownames(mtcars), cex.names = 0.6, col = "lightgreen")

# Boxplot
boxplot(mtcars$mpg ~ mtcars$cyl)

# Histograma
hist(mtcars$mpg, breaks = 10)



