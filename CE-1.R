# Author: Sparkle L. Malone (sparklelmalone@gmail.com)
# Objectives: Import and format Shapefiles.
# Shapefile Source (http://data.fs.usda.gov/geodata/edw/datasets.php)

# Climate patterns for ecoregions
rm(list=ls())

library(rgdal)
library(RCurl)
library(raster)

setwd( '~/git/Climate-Ecoregions/ShapeFiles') # Adjust to your directory!

# Import and plot shapefiles:

region.rpa <-readOGR(".", 'RPA_region2') # RPA Region 2
climate.summary <-readOGR(".", 'S_USA.ClimateSections') # Climate data by province
er.p <-readOGR(".", 'S_USA.EcoMapProvinces') # Ecoregion Provinces
usa <- readOGR(".", 'USA_BOUNDARY') # USA

# Vizualize of shapefile layers
plot(climate.summary, border="lightgrey")
plot(er.p, border="dimgrey", add=T)
plot(usa, border="black", add=T)
plot(region.rpa, border="blue", add=T)

# Reproject shapefiles:
crs <- '+proj=longlat +datum=WGS84 +ellps=WGS84 +towgs84=0,0,0' # Projection
region.rpa <- spTransform(region.rpa, crs)
climate.summary <- spTransform(climate.summary, crs)
er.p <- spTransform(er.p, crs)
usa <- spTransform(usa, crs)

