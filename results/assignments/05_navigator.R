library(data.table)
library(ggplot2)

runoff_year_key <- readRDS('data/runoff_year_key.rds')
runoff_month_key <- readRDS('data/runoff_month_key.rds')
runoff_day <- readRDS('data/runoff_day.rds')
runoff_summer <- readRDS('data/runoff_summer.rds')
runoff_winter <- readRDS('data/runoff_winter.rds')
runoff_summary <- readRDS('data/runoff_summary.rds')
colset_4 <-  c("#D35C37", "#BF9A77", "#D6C6B9", "#97B8C2")
key_stations <- c('DOMA', 'BASR', 'KOEL')

#task 1
#years
runoff_year_key[year <= 2000, age_range := factor('before_2000')]
runoff_year_key[year > 2000, age_range := factor('after_2000')]

ggplot(runoff_year_key, aes(age_range, value, fill = age_range)) +
  geom_boxplot() +
  facet_wrap(~sname, scales = 'free_y') +
  scale_fill_manual(values = colset_4[c(4, 1)]) +
  xlab(label = "Age Range") +
  ylab(label = "Runoff (m3/s)") +
  theme_bw()
#big changes in range can be noticed

#months
runoff_month_key[year <= 2000, age_range := factor('before_2000')]
runoff_month_key[year > 2000, age_range := factor('after_2000')]

ggplot(runoff_month_key, aes(factor(month), value, fill = age_range)) +
  geom_boxplot() +
  facet_wrap(~sname, scales = 'free_y') +
  scale_fill_manual(values = colset_4[c(4, 1)]) +
  xlab(label = "Month") +
  ylab(label = "Runoff (m3/s)") +
  theme_bw()
#maybe more significant changes during winter months?

#task 2
runoff_day_key <- runoff_day[sname %in% key_stations]
year_thres <- 2016 - 30
runoff_day_key[year <= year_thres, age_range := factor('before_1986')]
runoff_day_key[year > year_thres, age_range := factor('after_1986')]
runoff_day_key[, qu_01 := quantile(value, 0.1), by = .(sname, month)]
runoff_day_key[, qu_09 := quantile(value, 0.9), by = .(sname, month)]

runoff_day_key[, runoff_class := factor('medium')]
runoff_day_key[value <= qu_01, runoff_class := factor('low')]
runoff_day_key[value >= qu_09, runoff_class := factor('high')]
runoff_day_key[, days := .N, .(sname, year, runoff_class, season)]

runoff_day_key_class <- unique(
  runoff_day_key[, .(sname, days, year, age_range, season, runoff_class)])

ggplot(runoff_day_key_class[season == 'winter' | season == 'summer'], 
       aes(season, days, fill = age_range)) +
  geom_boxplot() +
  facet_wrap(runoff_class~sname, scales = 'free_y') +
  scale_fill_manual(values = colset_4[c(4, 1)]) +
  xlab(label = "Season") +
  ylab(label = "Days") +
  theme_bw()

#task 3
#loess
runoff_winter[, value_norm := scale(value), sname]
runoff_summer[, value_norm := scale(value), sname]
n_stations <- nrow(runoff_summary)

ggplot(runoff_winter[year > 1950 & year <= 2010], aes(x = year, y = value_norm, col = sname)) +
  geom_smooth(method = 'loess', formula = y~x, se = 0) + 
  scale_color_manual(values = colorRampPalette(colset_4)(n_stations)) +
  ggtitle('Winter runoff') +
  xlab(label = "Year") +
  ylab(label = "Runoff (z-score)") +
  theme_bw()
#this plot makes it seem like there is a big recent decrease in runoff
#but we can see that the runoff stabilizes after 2010 and starts increasing again

ggplot(runoff_summer[year > 1950 & year <= 2010], aes(x = year, y = value_norm, col = sname)) +
  geom_smooth(method = 'loess', formula = y~x, se = 0) + 
  scale_color_manual(values = colorRampPalette(colset_4)(n_stations)) +
  ggtitle('Summer runoff') +
  xlab(label = "Year") +
  ylab(label = "Runoff (z-score)") +
  theme_bw()
#this plot does not show the recent increase in runoff, just a drop

#linear r
ggplot(runoff_winter[year > 1950 & year <= 2010], aes(x = year, y = value_norm, col = sname)) +
  geom_smooth(method = 'lm', formula = y~x, se = 0) + 
  scale_color_manual(values = colorRampPalette(colset_4)(n_stations)) +
  ggtitle('Winter runoff') +
  xlab(label = "Year") +
  ylab(label = "Runoff (z-score)") +
  theme_bw()
#there is no recent increase as with loess, shows a steady increase

ggplot(runoff_summer[year > 1950 & year <= 2010], aes(x = year, y = value_norm, col = sname)) +
  geom_smooth(method = 'lm', formula = y~x, se = 0) + 
  scale_color_manual(values = colorRampPalette(colset_4)(n_stations)) +
  ggtitle('Summer runoff') +
  xlab(label = "Year") +
  ylab(label = "Runoff (z-score)") +
  theme_bw()
#again shows steady decrease, but some information is lost
