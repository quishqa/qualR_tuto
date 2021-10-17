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

# Sorting data
pin_20$day <- factor(pin_20$day, 
                     levels = c("Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"))
pin_20_sorted <- pin_20[order(pin_20$day), ]
polarAnnulus(pin_20_sorted, pollutant = "mp2.5", period="hour",
             exclude.missing = F, type = "day")

# Better 
polarAnnulus(pin_20_sorted, pollutant = "mp2.5", period="hour",
             exclude.missing = F, type = "day",
             key.footer = "PM2.5")
