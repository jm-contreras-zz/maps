# maps.R attempts to draw a map of the world with countries color-coded by
# population rank. Unfortunately, the maps package does not provide a world map
# and a world dataset with the same country names. This prevents the map
# function from matching countries with their appropriate colors. Without a
# simple programmatic way of solving this problem, this script can merely give
# some sense of how the maps package can be use to create a color-coded map.
#
# Written by Juan Manuel Contreras (juan.manuel.contreras.87@gmail.com)
# on March 16, 2014.

# Load libraries
library(maps)
library(RColorBrewer)
library(SDMTools)

# Load data
data(world.cities)

# Calculate world population by country
world = aggregate(world.cities$pop, list(world.cities$country.etc), sum)
world = setNames(world, c('Country', 'Population'))

# Change some country names to match the dated map names
world$Country[match('Russia', world$Country)] = 'USSR'
world$Country[match('Congo Democratic Republic', world$Country)] = 'Zaire'

# Rank and sort countries by population
world$PopulationRank = rank(-world$Population)
world = world[with(world, order(PopulationRank)), ]

# Create a color palette
palette = rev(colorRampPalette(brewer.pal(n=9, name='YlOrRd'))(nrow(world)))

# Draw a map of the world
map(regions=world$Country, fill=T, col=palette, bg='#ADD8E6')

# Add a title
title('Countries by Population Rank')

# Place latitute and longitude axes
map.axes()

# Insert a color legend
pnts = cbind(x=c(-20, -15, -15, -20) - 150, y=c(0, 60, 60, 0) - 30)
legend.gradient(pnts=pnts, cols=rev(palette), title='', limits=c('Low', 'High'))
