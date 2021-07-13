# Australia Southport dataset 
# Downloaded from openaq.org

au <- read.table("02_data/au_southport_05_07_2021.csv", 
                 header = T, sep = ",", dec = ".")

au_o3 <- subset(au, subset = parameter == "o3")
au_pm25 <- subset(au, subset = parameter == "pm25")
au_pm10 <- subset(au, subset = parameter == "pm10")


au_df <- data.frame(
  date = au$local,
  id = au$location,
  o3 = au_o3$value,
  pm10 = au_pm10$value,
  pm25 = au_pm25$value
)

write.table(au_df, file = "03_output/au_df_example.csv",
            sep = ",", quote = FALSE, row.names = FALSE)

load("02_data/ibi_30years.Rda")


ibi_data <- data.frame(
  date = ibi_co_30$date,
  co = ibi_co_30$pol,
  nox = ibi_nox_30$pol,
  o3 = ibi_o3_30$pol,
  pm10 = ibi_pm10_30$pol,
  pm25 = ibi_pm25_30$pol
)

saveRDS(ibi_data, file="02_data/ibi_30_year_df.RDS")
