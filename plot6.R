#
#Question 6
#Compare emissions from motor vehicle sources in Baltimore City with emissions 
#from motor vehicle sources in Los Angeles County, California 
#(fips == "06037"\color{red}{\verb|fips == "06037"|}fips=="06037"). Which city 
#has seen greater changes over time in motor vehicle emissions?
#


## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#

nei6 <- NEI
scc6 <- SCC


sccMotor <- grepl("vehicles", scc6$EI.Sector, ignore.case = TRUE)

sccMotorList <- subset(scc6, sccMotor, select = "SCC")

nei6Motor <- nei6[nei6$SCC %in% sccMotorList$SCC, ]



nei6MotorBaltimore <- filter(nei6Motor, fips == "24510")


aggBaltimore <- aggregate(Emissions ~ year, nei6MotorBaltimore, sum)


nei6MotorBaltimoreLosAngeles <- filter(nei6Motor, fips == "06037")

aggLosAngeles <- aggregate(Emissions ~ year, nei6MotorBaltimoreLosAngeles, sum)


png(filename = "plot6.png", width = 480, height = 480)

ggplot(bind_rows("Baltimore" = aggBaltimore, "Los Angeles" = aggLosAngeles, 
                 .id = "city"), aes(factor(year), Emissions, fill = city)) +
    geom_col() +
    facet_grid( . ~ city) +
    labs( title = expression("Total PM" [2.5] * " Emissions for Baltimore"
                             * " and Los Angeles for 1999 to 2008"),
          x = "Year", y = expression("Total PM" [2.5] * " Emissions"))


dev.off()

max(aggLosAngeles[, "Emissions"]) - min(aggLosAngeles[,"Emissions"])

# 670.2949

max(aggBaltimore[, "Emissions"]) - min(aggBaltimore[,"Emissions"])

# 258.5445

# Answer to Question 6: Compared to Baltimore, Los Angeles has seen greater
# change in PM2.5 Emissions. Their PM2.5 Emissions from their maximum PM2.5 was
# 4601.415 in 2005 has decreased by 670.2949 to 3931.12 in 2008. Baltimore
# highest to lowest Emissions was a change of 258.5445.
