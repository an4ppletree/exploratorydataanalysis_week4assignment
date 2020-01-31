
#Question 4
#Across the United States, how have emissions from coal combustion-related 
#sources changed from 1999–2008?   
#


## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")



#Question 4

nei4 <- NEI
scc4 <- SCC

sccCoal <- grepl("coal", scc4$EI.Sector, ignore.case = TRUE)

sccCoalList <- subset(scc4, sccCoal, select = "SCC")

nei4Coal <- nei4[nei4$SCC %in% sccCoalList$SCC, ]

nei4CoalTotal <- aggregate( Emissions ~ year, nei4Coal, sum)

png(filename = "plot4.png", width = 480, height = 480)


ggplot(nei4Coal, aes(factor(year), Emissions, col = type)) + 
    geom_col(show.legend = FALSE) +
    labs(x = "Year", y = expression("Total PM" [2.5] * " Emission"), 
         title = expression("Total US PM" [2.5] * " Coal Emission by Year"
                            * " for 1999 to 2008"))


dev.off()

# Answer to Question 4: Coal Emissions droped from 1999 to 2002; then, it rose
# from 2002 to 2005 before dropping again from 2005 to 2008.