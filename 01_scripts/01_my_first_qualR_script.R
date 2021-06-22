# library(devtools)
# install_github("quishqa/qualR")

library(qualR)

# Baixar os dados de O3 na estação Pinehiros

o3_code <- 63
pin_code <- 99

start_date <- "22/03/2020"
end_date <- "28/03/2020"

my_user <- Sys.getenv("QUALAR_USER")
my_pass <- Sys.getenv("QUALAR_PASS")

pin_o3 <- CetesbRetrieve(my_user, 
                         my_pass,
                         o3_code,
                         pin_code,
                         start_date,
                         end_date)

# Usar CetesREtrieve como Humano
pin_pm25 <- CetesbRetrieve(my_user,
                           my_pass,
                           "MP2.5",
                           "Pinheiros",
                           start_date,
                           end_date)
pj_o3 <- CetesbRetrieve(my_user,
                        my_pass,
                        "O3",
                        "Pico do Jaraguá",
                        start_date,
                        end_date,
                        to_csv = T)

# CetesbRetrieveParam > CetesbRetrieve
# O3, NO, NO2
pin_photo <- CetesbRetrieveParam(my_user,
                                 my_pass,
                                 c("O3", "NO", "NO2"),
                                 "Pinheiros",
                                 start_date,
                                 end_date)
library(openair)
timePlot(pin_photo, pol = c("no", "no2", "o3"),
         group = T)

# Boa Pratica
# Suggestão que aceite WD, WS
to_download <- c("MP2.5", "VV", "DV")
pin_pm_wind <- CetesbRetrieveParam(my_user,
                                   my_pass,
                                   to_download,
                                   "Pinheiros",
                                   start_date,
                                   end_date)
# CETESB usa 777 para ventos calmos
# 888 para missing values
pin_pm_wind[pin_pm_wind == 777] <- NA
pin_pm_wind[pin_pm_wind == 888] <- NA

timePlot(pin_pm_wind[48:96, ],
         pol="mp2.5", 
         windflow = list(
           scale=0.01,
           lwd=1.5,
           col="gray"),
         lwd=2)
windRose(pin_pm_wind)

















