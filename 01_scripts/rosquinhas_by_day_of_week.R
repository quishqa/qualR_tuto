library(openair)

pin_20 <- readRDS("02_data/pin_pol_with_wind.Rds")

# Assing day of week to date
pin_20$day <- weekdays(pin_20$date)

# polarAnnulus all data
polarAnnulus(pin_20, pollutant = "mp2.5", period="hour",
             exclude.missing = F)

# polarAnnulus by day, using type argument
polarAnnulus(pin_20, pollutant = "mp2.5", period="hour",
             exclude.missing = F, type = "day")


