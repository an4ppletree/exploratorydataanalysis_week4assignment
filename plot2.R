
#Question 2
#Have total emissions from PM2.5 decreased in the Baltimore City, Maryland 
#(fips == "24510"\color{red}{\verb|fips == "24510"|}fips=="24510") from 1999 to 
#2008? Use the base plotting system to make a plot answering this question.

library(dplyr)

## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")


#Question 2

nei2 <- NEI

nei2Baltimore <- filter(nei2, fips == "24510")

totalBaltimore <- tapply(nei2Baltimore$Emissions, nei2Baltimore$year, sum)

png(filename = "plot2.png", width = 480, height = 480)

barplot(totalBaltimore, xlab = expression("Total PM" [2.5] * " Emissions"), 
        ylab = "Year", main = expression("Total USA PM" [2.5] * " Emissions by"
                                         * " Yea for 1999 - 2008r"), col = "darkorchid3")

dev.off()

# Answer to Question 2: Total Emissions from 1999 went down in 2002; then it 
# increased in 2005; then it decreased in 2008. So, overall total emissions
# has gone down since 1999 to 2008, but not before rising in 2005 from 2002.
