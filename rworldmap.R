# rworldmap.R draws a map of the world with countries color-coded by
# population rank.
#
# Written by Juan Manuel Contreras (juan.manuel.contreras.87@gmail.com)
# on March 30, 2014.

# Load libraries
library(rworldmap)
library(RColorBrewer)

# Load data
data(countryExData)

# Insert Taiwan's 2005 population, which is missing
countryExData$Population2005[which(countryExData$Country=='Taiwan')] = 22894.3

# Add a population rank column
countryExData$PopulationRank2005 = rank(-countryExData$Population2005)

# Join data to map
world.population = joinCountryData2Map(dF=countryExData, joinCode='ISO3',
                                       nameJoinColumn='ISO3V10')
n.countries = 149

# Ensure the map will fill the available space on the page
par(mai=c(0, 0, 0.2, 0), xaxs='i', yaxs='i')

palette = rev(colorRampPalette(brewer.pal(n=9, name='YlOrRd'))(n.countries))

# Draw a map of the world
map = mapCountryData(mapToPlot=world.population, missingCountryCol='white',
                     nameColumnToPlot='PopulationRank2005', numCats=n.countries,
                     colourPalette=palette, addLegend=F, oceanCol='lightblue',
                     mapTitle='Countries by Population Rank')

# Add a small legend
do.call(addMapLegend, c(map, legendWidth=0.5, legendMar=2))
