library(data.table)
library(ggplot2)

#task 1
runoff_stations_raw <- fread('data/raw/runoff_stations.csv')
runoff_stations_raw[, sname := factor(abbreviate(station))]
runoff_stations_raw[, altitude := round(altitude, 0)]

runoff_st_area_alt <- runoff_stations_raw[, .(sname, area, altitude)]

#task 2
ggplot(runoff_st_area_alt) +
  geom_point(aes(x = area, y = altitude))

#task 3
runoff_stations <- readRDS('data/runoff_stations.rds')
ggplot(data = runoff_stations, aes(x = area, y = altitude, col = size)) +
  geom_point() +
  geom_text(label = runoff_stations$sname) +
  theme_bw()

ggplot(data = runoff_stations, aes(x = lon, y = lat, col = altitude)) +
  geom_point() +
  geom_text(label = runoff_stations$sname) +
  scale_color_gradient(low = 'dark green', high = 'brown') +
  theme_bw()

#task 4
runoff_st_years <- runoff_stations[, .(sname, start, end)]

ggplot(data = runoff_st_years, aes(x = start, y = sname)) +
  geom_segment(aes(xend = end, yend = sname))  
