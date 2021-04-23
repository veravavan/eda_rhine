#task 3
library(data.table) #not used

temperature_values <- c(3, 6, 10, 14) #in C
weight_values <- c(1, 0.8, 1.2, 1) #in kg

find_product <- function(x, y) {
  x * y
}

temp_wght_product <- find_product(temperature_values, weight_values)

#task 4
library(data.table)

runoff_ts <- data.table(time = as.Date(1:90, origin = '2020/12/31'),
                        value = sample(c(130, 135, 140), 
                                       size = 90, replace = T))
runoff_dt <- data.table(runoff_ts)

runoff_dt[, mon := month(time)]
runoff_dt[, mon_mean := mean(value), by = mon]
runoff_month <- unique(runoff_dt[, .(mon, mon_mean)])
runoff_month

runoff_month[, percent_change := 
               ((mon_mean - shift(mon_mean)) / shift(mon_mean)) * 100]
runoff_month_change <- runoff_month[, .(mon, percent_change)]
runoff_month_change
