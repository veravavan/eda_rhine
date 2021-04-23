#task 1
rh_catchment_area <- 185000 #in km^2

#task 2
rh_catchment_area <- rh_catchment_area * 1000 ^ 2 #m^2
precip_hour <- 0.5 #mm/h
precip_day <- precip_hour * 24 / 1000 #m/day
catchment_water <- precip_day * rh_catchment_area #m3/day

average_runoff <- catchment_water / (24 * 60 * 60)

#task 4
# a)
# increase in greenhouse gasses will increase global average temperatures
# this will lead to changes in precipitation and therefore discharge
# a decrease in snow precipitation is expected, and an increase in rain

# b)
# assumption about the CO2 emission increase in the future
# number of days with precipitation is unchanged
# climate models include assumptions about temperature changes

#c)
# impacts on winter sports in the alps, flood defense, inland navigation,
# hydropower generation, water availability, floodplain development

#d)
# there are other similar studies, even from 2017, one of them is:
# https://journals.ametsoc.org/view/journals/hydr/15/2/jhm-d-12-098_1.xml

#c)
# decrease
# https://www.nytimes.com/2018/11/04/world/europe/rhine-drought-water-level.html
# increase
# https://www.globaltimes.cn/page/202102/1214806.shtml
