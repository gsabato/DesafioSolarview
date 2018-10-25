# Tarefa 2
# Realizar uma análise exploratória dos dados utilizando vizualizações de dados, 
# análise estátistica e análise de séries temporais. Lembre-se aqui vai contar muito como 
# você ira contar a história desses dados. 

# Configurando diretório de trabalho
setwd("E:/Dev/Source/DesafioSolarview/02-analise_exploratoria")
getwd()

# Sources
#source("Tools.R")
#install.packages("zoo")
library(zoo)
library(ggplot2)

# Pré-processamento
## Carregando o arquivo csv resultante da task01
my.df <- read.csv("../output/df_final_v1.csv", header = TRUE, sep = ",")
str(my.dfts)
#View(my.df)
## Converte para o tipo POSIXct
my.df$Datetime <- as.POSIXct(my.df$Datetime, tz="", format = "%Y-%m-%d %H:%M:%S")
class(my.df$Datetime)
## Elimina datas NA resultantes da conversão
any(is.na(my.df['Datetime']))
my.df <- my.df[which(is.na(my.df['Datetime']) == FALSE) , ]
any(is.na(my.df['Datetime']))
## Converte o Dataframe para o tipo zoo (Z's Ordered Observations)
my.dfts <- read.zoo(my.df)
class(my.dfts)
dim(my.dfts)
str(my.dfts)
#View(my.dfts)


# Análise exploratória
head(my.dfts)
tail(my.dfts)

## Estatística Descritiva
summary(coredata(my.dfts))
frequency(my.dfts)

## Visualizações
autoplot(my.dfts)
boxplot.matrix(coredata(my.dfts))
### Analisar comportamento ao longo do período analisado
plot(my.dfts, main = "Consumo de Energia Megawatts/hora", xlab = "Data/hora")
### Distribuição dos dados
for (colName in colnames(my.dfts)) {
  title <- c("Histograma ", colName)
  plot <- hist(my.dfts[,colName], breaks = 30, main = paste(title), xlab = colName)
}

## Série Temporal
start(my.dfts)
end(my.dfts)
frequency(my.dfts)