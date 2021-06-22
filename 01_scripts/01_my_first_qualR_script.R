# library(devtools)
# install_github("quishqa/qualR")

library(qualR)

# Baixar os dados de O3 na estação Pinehiros

o3_code <- 63
pin_code <- 99

start_date <- "18/02/2015"
end_date <- "25/02/2015"

my_user <- Sys.getenv("QUALAR_USER")
my_pass <- Sys.getenv("QUALAR_PASS")

pin_o3 <- CetesbRetrieve(my_user, 
                         my_pass,
                         o3_code,
                         pin_code,
                         start_date,
                         end_date)

selectByDate(pin_o3, hour = seq(6,18))


pin_o3 <- CetesbRetrieve(start_date=start_date,
                         end_date=end_date,
                         aqs_code = 99,
                         pol_code = 63,
                         password = my_pass,
                         username = my_user)


# Usar CetesREtrieve como Humano
# nome do parametros: cetesb_param
# nome das estações: cetesb_latlon

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
attributes(pin_pm_wind$date)$tz <- "America/Sao_Paulo"

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




# Como baixar dados de muitas estações
# Pinheiros -> Urban-traf
# Interlagos -> Sub-Urban traf
# Ibirapuera -> Urban bg
# Pico do Jaraguá -> Sub-urban bg

aqs <- c("Pinheiros",
         "Interlagos",
         "Ibirapuera",
         "Pico do Jaraguá")
# No R evitamos os for -> lapply
aqs_o3 <- lapply(aqs, CetesbRetrieve,
                 username = my_user,
                 password = my_pass,
                 pol_code = o3_code,
                 start_date = start_date,
                 end_date = end_date)

# de lista para df
aqs_o3_df <- do.call(rbind, aqs_o3)

timeVariation(aqs_o3_df, pol="pol", group="aqs",
              name.pol="o3")


# Melhoras nome pm25
# Incluir loop stações
# Incluir string -> as.POSIXct
# Incluir raw data (24 ou 23)???
# Horario do verão!!!!
# Horario da calibração













