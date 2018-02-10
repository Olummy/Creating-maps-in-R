# My new script for learning R
# Sat Feb 10 16:25:29 2018 ------------------------------
# read in the shapefile

library(rgdal)
library(sp)
lnd <- readOGR(dsn = "data",layer = "london_sport")
sel <- lnd$Partic_Per > 20 & lnd$Partic_Per < 25
plot(lnd[sel, ])
head(sel)
plot(lnd, col = "lightgrey")
sel2 <- lnd$Partic_Per > 25
plot(lnd[sel2, ], col = "turquoise", add = TRUE) ## Simple plot of London with areas of high sports participation highlighted in blue

# create an outline of the London area by merging all of the polygons in the lnd object
library(rgeos)
london <- gUnaryUnion(lnd,lnd$dummy)
london <- SpatialPolygonsDataFrame(london, data.frame(dummy = c("london")), match.ID = FALSE)

# Find the centre of the london area
centerlondon = gCentroid(london, byid = TRUE)
