
#Question 5
#How have emissions from motor vehicle sources changed from 1999–2008 in 
#Baltimore City?
#

library(dplyr)
library(ggplot2)

## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")


#Question 1

nei5 <- NEI
scc5 <- SCC


nei5Baltimore <- filter(nei5, fips == "24510")


sccMotor <- grepl("vehicles", scc5$EI.Sector, ignore.case = TRUE)

sccMotorList <- subset(scc5, sccMotor, select = "SCC")

nei5Motor <- nei5[nei5$SCC %in% sccMotorList$SCC, ]


nei5MotorBaltimore <- filter(nei5Motor, fips == "24510")


aggNei5MotorBaltimore <- aggregate(Emissions ~ year, nei5MotorBaltimore, sum)


png(filename = "plot5.png", width = 480, height = 480)


ggplot(aggNei5MotorBaltimore, aes(factor(year), Emissions)) +
    geom_col(fill = "darkorchid3") +
    labs( y = expression("Total Motor PM" [2.5] * " Emissions"), 
          x = "Year", title = expression("Total Baltimore Motor PM" [2.5]
                                         * " Emissions by Year for 1999 to 2008"))

dev.off()


# Answer to Question 5: Baltimore's motor vehcile emissions have decreased at each year
# date point from each previous year data point.
