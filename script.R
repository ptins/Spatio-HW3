rm(list=ls())

# install.packages('ggmap')
library(ggmap)

zoo_addr = '500 S Greenlawn Ave, South Bend, IN 46615'
ohare_addr = '10000 W O\'Hare Ave, Chicago, IL 60666'

zoo_map <- get_map(zoo_addr, zoom=15)
ggmap(zoo_map)

from <- zoo_addr
to <- ohare_addr

driving = mapdist(from, to, mode='driving')
driving$method = 'driving'
biking = mapdist(from, to, mode='bicycling')
biking$method = 'biking'
walking = mapdist(from, to, mode='walking')
walking$method = 'walking'

distances = data.frame()
distances = rbind(distances, driving)
distances = rbind(distances, biking)
distances = rbind(distances, walking)
distances

