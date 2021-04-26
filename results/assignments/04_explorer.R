#task 1
# It represents the same thing 

#task 2
# Because the data is not normally distributed, it is skewed to one side

#task 3
# lobi is at a higher altitude than rees, even though it is closer to the sea
# It is probably the altitude of the station, not the runoff

#task 4
library(data.table) 
library(ggplot2) 

#months
runoff_month <- readRDS('./data/runoff_month.rds')

runoff_month[, min := min(value), by = 'sname']
runoff_month[, max := max(value), by = 'sname']

runoff_month_max <- runoff_month[runoff_month$value == runoff_month$max] 
runoff_month_min <- runoff_month[runoff_month$value == runoff_month$min] 

ggplot(runoff_month_max, aes(x = sname, y = max, label = month)) +
  geom_point() +
  geom_text(vjust = -0.5) 

ggplot(runoff_month_min, aes(x = sname, y = min, label = month)) +
  geom_point() +
  geom_text(vjust = -0.5) 

#seasons
runoff_summer <- readRDS('./data/runoff_summer.rds')
runoff_winter <- readRDS('./data/runoff_winter.rds')

runoff_summer[, min := min(value), by = 'sname']
runoff_summer[, max := max(value), by = 'sname']

runoff_summer_max <- runoff_summer[runoff_summer$value == runoff_summer$max] 
runoff_summer_min <- runoff_summer[runoff_summer$value == runoff_summer$min] 

ggplot(runoff_summer_max, aes(x = sname, y = max, label = year)) +
  geom_point() +
  geom_text(vjust = -0.5)

ggplot(runoff_summer_min, aes(x = sname, y = min, label = year)) +
  geom_point() +
  geom_text(vjust = -0.5) 

runoff_winter[, min := min(value), by = 'sname']
runoff_winter[, max := max(value), by = 'sname']

runoff_winter_max <- runoff_winter[runoff_winter$value == runoff_winter$max] 
runoff_winter_min <- runoff_winter[runoff_winter$value == runoff_winter$min] 

ggplot(runoff_winter_max, aes(x = sname, y = max, label = year)) +
  geom_point() +
  geom_text(vjust = -0.5)

ggplot(runoff_winter_min, aes(x = sname, y = min, label = year)) +
  geom_point() +
  geom_text(vjust = -0.5) 

#years
runoff_year <- readRDS('./data/runoff_year.rds')

runoff_year[, min := min(value), by = 'sname']
runoff_year[, max := max(value), by = 'sname']

runoff_year_max <- runoff_year[runoff_year$value == runoff_year$max] 
runoff_year_min <- runoff_year[runoff_year$value == runoff_year$min] 

ggplot(runoff_year_max, aes(x = sname, y = max, label = year)) +
  geom_point() +
  geom_text(vjust = -0.5) 

ggplot(runoff_year_min, aes(x = sname, y = min, label = year)) +
  geom_point() +
  geom_text(vjust = -0.5) 
