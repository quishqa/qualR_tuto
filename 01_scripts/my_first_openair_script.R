au <- read.table("03_output/au_df_example.csv",
                       sep = ",", dec = ".", head = T)

au[au < 0] <- NA
# DICA: ANtes de usar openair limpar os seus dados

au$date <- as.POSIXct(strptime(au$date, format = "%Y-%m-%dT%H:%M:%S+10:00",
                               tz = "Etc/GMT+10"))

# Opeain vai precisar que a coluna do data seja chamada date

library(openair)

summaryPlot(au)
summaryPlot(au, period="months")

au$o3 <- au$o3 * 1000
timePlot(au, pollutant = "pm25")
timePlot(au, pollutant = c("pm10", "pm25", "o3"))
timePlot(au, pollutant = c("pm10", "pm25", "o3"), avg.time="day")

# Vamos trabalhar com os dados de Sao Paulo
ibi <- readRDS("~/Downloads/ibi_30_year_df.RDS")

summaryPlot(ibi)
timePlot(ibi, pollutant = "o3")
timePlot(ibi, pollutant = "o3", avg.time = "month")
timePlot(ibi, pol = c("pm10", "pm25"), avg.time = "day")

#timeVariation
timeVariation(ibi, pol = "o3")

# Dados Pinheiros 2020 com vento
pin <- readRDS("~/Downloads/pin_pol_with_wind.Rds")

windRose(pin, ws="ws", wd="wd")
windRose(pin, ws="ws", wd="wd", type="month", layout=c(6, 2))
windRose(pin, ws="ws", wd="wd", type="season", layout=c(2, 2),
         hemisphere="southern")

pp <- polarPlot(pin, pol = "mp2.5")
pr <- percentileRose(pin, pol = "mp2.5", percentile = 75,
                     method = "cpf", col="red", smooth = T)
pa <- polarAnnulus(pin, pol = "mp2.5", period="hour",
                   exclude.missing = F, cols = "viridis")

# FAZER "rosquinha" por dia (TAREFA PARA CASA)

library(gridExtra)
grid.arrange(pp$plot, pr$plot, pa$plot, nrow=1, ncol=3)

# Funções para facilitar a vida
# selectBydata

ibi19 <- selectByDate(ibi, year = 2019)
timePlot(ibi19, pol = "co")
ibi_covid <- selectByDate(ibi, start = "15/3/2020", end = "28/3/2020")
timePlot(ibi_covid, pol = "o3")
ibi_week <- selectByDate(ibi19, day="weekday")
ibi_weekend <- selectByDate(ibi19, day="weekend")
mean(ibi_week$o3, na.rm = T)
mean(ibi_weekend$o3, na.rm = T)

# timeAverage
ibi19_day <- timeAverage(ibi19, avg.time = "day")
ibi19_day_sd <- timeAverage(ibi19, avg.time = "day", 
                            statistic="sd")
ibi19_day_max <- timeAverage(ibi19, avg.time = "day",
                             statistic="max")

ibi19_month <- timeAverage(ibi19, avg.time = "month")

ibi19_season <- timeAverage(ibi19, avg.time = "season",
                            hemisphere="southern")

# splitByDate
ibi_split <- splitByDate(ibi, dates="1/3/2020",
                         labels = c("Before COVID", "After COVID"),
                         name = "situation")
timeVariation(ibi_split, pol="o3", group = "situation")


# 
library(qualR)

# Para trocar a lingua para o inglés
Sys.setlocale("LC_ALL", "en_US.UTF-8")

pin <- CetesbRetrieveParam(Sys.getenv("QUALAR_USER"),
                           Sys.getenv("QUALAR_PASS"),
                           c("MP2.5", "VV", "DV"),
                           "Pinheiros",
                           "01/06/2021",
                           "30/06/2021")

polarAnnulus(pin, pollutant = "mp2.5")
timeVariation(pin, pollutant = "mp2.5")
