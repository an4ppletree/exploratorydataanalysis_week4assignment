#Questions

#You must address the following questions and tasks in your exploratory analysis.
#For each question/task you will need to make a single plot. Unless specified, 
#you can use any plotting system in R to make your plot.

#Question 1
#Have total emissions from PM2.5 decreased in the United States from 1999 to 
#2008? Using the base plotting system, make a plot showing the total PM2.5 
#emission from all sources for each of the years 1999, 2002, 2005, and 2008.
#

library(dplyr)

## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#Question 1

nei1 <- NEI

totalNEI1 <- tapply(nei1$Emissions, nei1$year, sum)

png(filename = "plot1.png", width = 480, height = 480)

barplot(totalNEI1, ylab = expression("Total USA PM" [2.5] * " Emissions"), 
        xlab = "Year", main = expression("Total USA PM" [2.5] * " Emissions by"
                                         * " Year for 1999 - 2008"), col = "darkred")

dev.off()

# Answer to Question 1: Total PM2.5 Emissions in the USA has decreased at each
# year given in the data file.
