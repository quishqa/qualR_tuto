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