# Author: Matthew Phelps
#Desc: Prepare Waterpump data for display on map-page

# Intro -------------------------------------------------------------------

rm(list = ls())
graphics.off()
mac <- "/Users/Matthew/Google Drive/Copenhagen\\Bangladesh - Cholera\\Map Stuff"
pc <- "C:\\Users\\wrz741\\Google Drive\\Copenhagen\\Bangladesh - Cholera\\Map Stuff"
setwd(pc)
library (xlsx) # reading excel files
library(foreign)
library(dplyr) # for renaming
library(rgdal) # write to GeoJSON
library(rgeos) # write to GeoJSON
library(geojsonio) # write to GeoJSON



# read in excel data and convert what needs to be numeric to numeric------------------------------------------------------

water_source <- read.xlsx2(file = "C:/Users/wrz741/Dropbox/C5 Water Sample data/Main Source/W1 - Main source database 25Feb15.xlsx",
                          sheetIndex = 1)
water_source <- water_source[,c(1:5)]
water_source2 <- sapply(water_source, function(x) as.numeric(as.character(x)))
water_source2 <- water_source2[,c(1,3,4)]
water_source3 <- merge(water_source[,-c(3,4)], water_source2, by = 'Pump.ID')


# rename variabels to remove periods so javascript doesn't have pr --------
water_source3 <- rename(water_source3, Pump_ID = Pump.ID, Source_Type = Source.Type)



# Write GeoJSON and CSV ---------------------------------------------------

geojson_write(water_source3, lat = 'Lat', lon = 'Lon', file= "data_for_maps/water_geo.geojson") # NOTE lon goes before LAT
 

