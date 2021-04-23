library(data.table)
library(ggplot2)
#task 1
#area is in km^2 and runoff is in m^3/s

#task 2
runoff_stations <- readRDS('data/runoff_stations.rds')
runoff_stations[, mean(area)]

runoff_day <- readRDS('data/runoff_day.rds')
runoff_day[, mean(value)]

#task 3
runoff_avg <- runoff_day[, mean(value), by = sname]
runoff_avg

ggplot(data = runoff_avg, aes(x = sname, y = V1)) +
  geom_bar(stat = 'identity') +
  ylab('mean runoff')

#task 4
#River width is usually smaller in higher altitudes and mountain areas
#but higher in lower altitudes, meaning that the catchment area is also larger