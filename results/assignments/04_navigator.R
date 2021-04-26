library(data.table)
library(ggplot2)
library(moments)

#task 1
runoff_stats <- readRDS('data/runoff_stats.rds')
runoff_day <- readRDS('data/runoff_day.rds')

med_runoff <- runoff_day[, .(median = median(value)), sname]
runoff_stats_cl <- med_runoff[runoff_stats, on = 'sname']
runoff_stats_cl <- runoff_stats_cl[, -4]

runoff_stats_plot <- melt(runoff_stats_cl, id.vars = 'sname')

ggplot(runoff_stats_plot, aes(x = sname, y = value)) + 
  geom_point(aes(col = variable, shape = variable))

#task 2
#a
runoff_skew_var <- runoff_day[, .(skewness = skewness(value)), by = sname]
runoff_stats[, var_day := sd_day / mean_day]
runoff_stats <- runoff_skew_var[runoff_stats, on = 'sname']

#b
runoff_skew_var[, variation_coef := runoff_stats$var_day]

#task 3
runoff_month <- readRDS('data/runoff_month.rds')
runoff_summary <- readRDS('data/runoff_summary.rds')

runoff_classes <- runoff_summary[, .(sname, runoff_class)]
runoff_monthly_class <- runoff_month[runoff_classes, on = 'sname']

ggplot(runoff_monthly_class, aes(x = factor(month), y = value, fill = runoff_class)) +
  geom_boxplot() +
  facet_wrap(~sname, scales = 'free')

#task 4
ggplot(runoff_day, aes(x = sname, y = value)) +
  geom_boxplot()

# Boxplots are not the optimal presentation of this data due to the distribution
# There are too many outliers, and they increase with the size of runoff

#task 5
runoff_summary[, area_class := factor('small')]
runoff_summary[area >= 20000 & area < 120000, area_class := factor('medium')]
runoff_summary[area >= 120000, area_class := factor('large')]

runoff_summary[, alt_class := factor('low')]
runoff_summary[altitude >= 60 & altitude < 350, alt_class := factor('medium')]
runoff_summary[altitude >= 350, alt_class := factor('high')]
runoff_summary

dt <- runoff_summary[, .(sname, area, alt_class)]
to_plot <- runoff_stats[dt, on = 'sname']
colset_4 <-  c("#D35C37", "#BF9A77", "#D6C6B9", "#97B8C2")

ggplot(to_plot, aes(x = mean_day, y = area, col = sname, cex = alt_class)) +
  geom_point() +
  scale_color_manual(values = colorRampPalette(colset_4)(20)) +
  theme_bw()
