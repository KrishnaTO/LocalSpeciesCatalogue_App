

#Enter Google Maps enabled API key (used Static Maps API)
##To enable, 
## 1) must create Google Cloud Platform account, 
## 2) create a project, then 
## 3) enable the Maps API key via APIs & Services > Credentials > + Create Credentials > API key 
register_google(key = rstudioapi::askForPassword("ENTER GOOGLE API KEY HERE"), 
                account_type = "standard", 
                write = T)  # write = T save the API key to environment so it doesn't have to be declared more than once


#load packages
if(!require("osmdata")) install.packages("osmdata")  
if(!require("sf")) install.packages("sf")
if(!require("ggmap")) devtools::install_github("dkahle/ggmap")

library(dplyr)
library(sf)
library(ggmap)

map <- function(imagedata){
# Note: make_bbox works as expected when ggmap packaged sourced via Github, not via Cran version. Remove package and install git version.
  mapbox <- get_map(location = make_bbox(lon = gps$lon, 
                                         lat = gps$lat),
                                         zoom = 17,
                                         maptype = "satellite", 
                                         source = "google")

  map_plot <- ggmap(mapbox) + 
              geom_point(data = gps, 
               aes(colour = species),
               alpha = 1, 
               shape = 20,
               #color="red", 
               size = 3)

# Add plant image (low version) to coordinates [attempt Ref3, "4. Annotate figure"]
}