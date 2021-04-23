eur_runoff <- c(1977, 1995, 1946, 1859, 1863, 1864, 1922, 1949, 1921, 1858, 1954, 2003, 2015)
sorted_eur_runoff <- sort(eur_runoff)
ordered_eur_runoff <- eur_runoff[order(eur_runoff)]
all_droughts <- list(
  
  precipitation = c(2015, 1863, 1976, 1945, 2003, 1954, 1904, 1921, 1858, 1949, 1953, 1790),
  
  runoff = c(1977, 1995, 1859, 1946, 2003, 2015, 1863, 1922, 1864, 1949, 1921, 1858, 1954),
  
  soil_moisture = c(2001, 1963, 2003, 1857, 1922, 1858, 2015, 1954, 1953, 1921)
  
)
(mean(diff(all_droughts$precipitation)))
(mean(diff(all_droughts$runoff)))
(mean(diff(all_droughts$soil_moisture)))
prcp_droughts_ceu <- data.frame('year' = c(1998, 1863, 1976, 1954, 1921, 1858, 1918, 2003, 2015),
                                'region' = 'CEU',
                                'severity' = c(3, 3.5, 3.4, 3.6, 4.2, 4, 3, 2.3, 1.9),
                                'area' = c(5, 58, 59, 78, 80, 98, 61, 58, 52))
prcp_droughts_ceu
str(prcp_droughts_ceu)
after_19 <- prcp_droughts_ceu$year[prcp_droughts_ceu$year > 1900]
after_19

plot(x = prcp_droughts_ceu$severity, y = prcp_droughts_ceu$area)
