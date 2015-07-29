# Author: Matthew Phelps
#Desc: Extracting lat/lon coordinates from the baseline data that is in
#      SPSS file format

# Intro -------------------------------------------------------------------

rm(list = ls())
graphics.off()
mac <- "/Users/Matthew/Google Drive/Copenhagen\\Bangladesh - Cholera\\Map Stuff\\Basemap data\\"
pc <- "C:\\Users\\wrz741\\Google Drev\\Copenhagen\\Bangladesh - Cholera\\Map Stuff\\Basemap data\\"
setwd(pc)
library (xlsx) # reading excel files
library(foreign)
library(plyr) # for renaming

house.gps <- read.spss("main_2ndentry.sav")


houses <- cbind(house.gps$HHID, house.gps$Q1_N, house.gps$Q1_E)
rm(house.gps)
houses <- as.data.frame(houses)
houses2 <- sapply(houses, function(x) as.numeric(as.character(x)))
houses <- as.data.frame(houses2)
houses <- rename(houses, c("V1" = "HHID", "V2" = "lat", "V3" = "lon"))
write.table(houses, file = "House_lat_lon.csv", row.names=F, sep=",")

