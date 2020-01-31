#Question 3
#Of the four types of sources indicated by the type\color{red}{\verb|type|}type 
#(point, nonpoint, onroad, nonroad) variable, which of these four sources have 
#seen decreases in emissions from 1999–2008 for Baltimore City? Which have seen 
#increases in emissions from 1999–2008? Use the ggplot2 plotting system to make 
#a plot answer this question.
#

library(dplyr)
library(ggplot2)

## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")


#Question 3

nei3 <- NEI

nei3Baltimore <- filter(nei3, fips == "24510")

png(filename = "plot3.png", width = 480, height = 480)

ggplot(nei3Baltimore, aes(factor(year), Emissions)) + 
    geom_col(aes(fill = type), show.legend = FALSE) + 
    facet_grid(. ~ type) + 
    labs( x = "Year", y = expression("Total PM"[2.5]*"Emissions"), 
          title = expression("Total Baltimore PM" [2.5]* " Emissions by"
                             * " Year and Type for 1999 to 2008"))

dev.off()

# Answer to Question 3: Non-road, Nonpoint, and On-road have seen decreases from
# 1999 to 2008. Point has seen an increase from 1999 to 2005; then, it decreased
# from 2005 to 2008.
