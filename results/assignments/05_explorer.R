#task 1
#I would say that DOMA is not representative, but only due to the changes around 
#1950sdue to the dam construction, otherwise it would be fine, since it's 
#important to see the changes in runoff in such small upstream areas.

#task 2
library(data.table)
library(ggplot2)

precip_day <- readRDS('data/raw/precip_day.rds')
colset_4 <-  c("#D35C37", "#BF9A77", "#D6C6B9", "#97B8C2")

precip_day[, month := month(date)]
precip_day[month == 12 | month == 1 | month == 2, season := 'winter']
precip_day[month == 3 | month == 4 | month == 5, season := 'spring']
precip_day[month == 6 | month == 7 | month == 8, season := 'summer']
precip_day[month == 9 | month == 10 | month == 11, season := 'autumn']
precip_day[, season := factor(season, levels = c('winter', 'spring', 'summer', 'autumn'))]

precip_day[, year := year(date)]
precip_winter <- precip_day[season == 'winter', 
                            .(value = sum(value)), by = year]
precip_summer <- precip_day[season == 'summer', 
                            .(value = sum(value)), by = year]

year_thres <- 1987
to_plot <- rbind(cbind(precip_winter, season = factor('winter')), 
                 cbind(precip_summer, season = factor('summer'))) 

to_plot[year < year_thres, period := factor('pre_1987')]
to_plot[year >= year_thres, period := factor('aft_1987')]
to_plot[year < year_thres, period := factor('pre_1987')]
to_plot[year >= year_thres, period := factor('aft_1987')]

ggplot(to_plot[year >= 1957], aes(season, value, fill = period)) +
  geom_boxplot() +
  scale_fill_manual(values = colset_4[c(4, 1)]) +
  xlab(label = "Season") +
  ylab(label = "Precitation") +
  theme_bw()

ggplot(to_plot[season == 'summer' & year >= 1957], aes(x = year, y = value)) +
  geom_line(col = colset_4[3])+
  geom_point(col = colset_4[3])+
  geom_smooth(method = 'lm', formula = y~x, se = 0, col = colset_4[1]) +
  geom_smooth(method = 'loess', formula = y~x, se = 0, col = colset_4[4]) +
  scale_color_manual(values = colset_4[c(1, 2, 4)]) +
  xlab(label = "Year") +
  ylab(label = "Precipitation Summer") +
  theme_bw()

ggplot(to_plot[season == 'winter' & year >= 1957], aes(x = year, y = value)) +
  geom_line(col = colset_4[3])+
  geom_point(col = colset_4[3])+
  geom_smooth(method = 'lm', formula = y~x, se = 0, col = colset_4[1]) +
  geom_smooth(method = 'loess', formula = y~x, se = 0, col = colset_4[4]) +
  scale_color_manual(values = colset_4[c(1, 2, 4)]) +
  xlab(label = "Year") +
  ylab(label = "Precipitation Winter") +
  theme_bw()

#task 3
#we can definitely see that there are changes in the runoff and precipitation,
#however it's hard to prove that they are a result of climate change
#especially when there are outside influences, such as dams
#perhaps more data from the following years would show a more clear trend

#task 4
#perhaps exploring more of the precipitation amounts would lead to more info
#about the runoff, as well as some other effects of climate change such as
#river pollution or water availability in the area
