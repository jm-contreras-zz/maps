# maps.R draws a map of the world with countries color-coded by population rank.
#
# Written by Juan Manuel Contreras (juan.manuel.contreras.87@gmail.com)
# on March 16, 2014.

# Load libraries
library(maps)
library(RColorBrewer)

# Load world data
data(world.cities)

# Calculate world population by country
world.pop = aggregate(x=world.cities$pop, by=list(world.cities$country.etc),
                      FUN=sum)
world.pop = setNames(world.pop, c('Country', 'Population'))

# Count the number of countries
n.countries = nrow(world.pop)

# Create a color palette
palette = colorRampPalette(brewer.pal(n=9, name='Greens'))(n.countries)

# Sort the colors in the same order as the countries' populations
palette = palette[rank(-world.pop$Population)]

# Draw a map of the world, with countries colored by population
map(database='world', fill=T, col=palette)