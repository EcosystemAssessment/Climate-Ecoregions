# Author: Sparkle L. Malone (sparklelmalone@gmail.com)
# Objectives: Import and format Shapefiles.
# Shapefile Source (http://data.fs.usda.gov/geodata/edw/datasets.php)

rm(list=ls())

library(rgdal)
library(RCurl)
library(raster)
library(rgeos)

setwd( '~/git/Climate-Ecoregions/ShapeFiles')

# Import and plot shapefiles:
region.rpa <-readOGR(".", 'RPA_region2') # RPA Region 2
climate.summary <-readOGR(".", 'S_USA.ClimateSections') # Climate data by province
er.p <-readOGR(".", 'S_USA.EcoMapProvinces') # Ecoregion Provinces
usa <- readOGR(".", 'USA_BOUNDARY') # USA

# Reproject shapefiles:
crs <- '+proj=longlat +datum=WGS84 +ellps=WGS84 +towgs84=0,0,0' # Projection
region.rpa <- spTransform(region.rpa, crs)
climate.summary <- spTransform(climate.summary, crs)
er.p <- spTransform(er.p, crs)
usa <- spTransform(usa, crs)


# Creat Domain and Division Shape files (Two methods of dissolving polygons)
er.dom<- aggregate(er.p, vars= er.p$DOMAIN_NAM, dissolve=T) 
er.div<- aggregate(er.p, vars= er.p$DIVISION_N, dissolve=T) # Not working

library(maptools)
er.dom<- unionSpatialPolygons(er.p, IDs=er.p$DOMAIN_NAM)
er.div<- unionSpatialPolygons(er.p, IDs=er.p$DIVISION_N)

# Figure:
library(RColorBrewer)
pal.2 <- colorRampPalette(c("gold", "green","skyblue", "grey", "blue"))

spplot(er.p, "DIVISION_N", col="white", col.regions=pal.2(12),
       colorkey = T, bty="n", lwd=0.4,
       sp.layout=list("sp.polygons", region.rpa, first=F))

plot(er.dom)
plot(er.p)


writeOGR(er.p, ".","er_provinces",driver="ESRI Shapefile" )
writeOGR(usa, ".","usa",driver="ESRI Shapefile" )
