Peer-graded Assignment: Getting and Cleaning Data Course Project
======

This repository is my answer to Week 4 assignment from Roger D. Peng's Coursera course "Exploratory Data Analysis," which is part of Coursera's "Data Science Specialization" with R language offered by John Hopkins University.

### **Dataset:**
The Dataset used is ["Data for Peer Assessment" on the assignment's page](https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip)

The following are descriptions of the variables in <span style="color:darkred">summarySCC_PM25.rds</span> in that zip file

* fips: A five-digit number (represented as a string) indicating the U.S. county
* SCC: The name of the source as indicated by a digit string (see source code classification table)
* Pollutant: A string indicating the pollutant
* Emissions: Amount of PM2.5 emitted, in tons
* type: The type of source (point, non-point, on-road, or non-road)
* year: The year of emissions recorded

### **Loading the data:**
```R
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
````

### **Question 1:** ([plot1.R](https://github.com/an4ppletree/exploratorydataanalysis_week4assignment/blob/master/plot1.R))
Have total emissions from PM2.5 decreased in the United States from 1999 to 2008? Using the base plotting system, make a plot showing the total PM2.5 emission from all sources for each of the years 1999, 2002, 2005, and 2008.

```R
nei1 <- NEI

totalNEI1 <- tapply(nei1$Emissions, nei1$year, sum)

png(filename = "plot1.png", width = 480, height = 480)

barplot(totalNEI1, ylab = expression("Total USA PM" [2.5] * " Emissions"), 
        xlab = "Year", main = expression("Total USA PM" [2.5] * " Emissions by"
            * " Year for 1999 - 2008"), col = "darkred")

dev.off()
```

<img src="https://github.com/an4ppletree/exploratorydataanalysis_week4assignment/blob/master/plot1.png">

Answer to Question 1: Total PM2.5 Emissions in the USA has decreased at each
year given in the data file.

### **Question 2:** ([plot2.R](https://github.com/an4ppletree/exploratorydataanalysis_week4assignment/blob/master/plot2.R))
Have total emissions from PM2.5 decreased in the Baltimore City, Maryland (fips == "24510"\color{red}{\verb|fips == "24510"|}fips=="24510") from 1999 to 2008? Use the base plotting system to make a plot answering this question.

```R
nei2 <- NEI

nei2Baltimore <- filter(nei2, fips == "24510")

totalBaltimore <- tapply(nei2Baltimore$Emissions, nei2Baltimore$year, sum)

png(filename = "plot2.png", width = 480, height = 480)

barplot(totalBaltimore, xlab = expression("Total PM" [2.5] * " Emissions"), 
        ylab = "Year", main = expression("Total USA PM" [2.5] * " Emissions by"
                            * " Yea for 1999 - 2008r"), col = "darkorchid3")

dev.off()
```
<img src="https://github.com/an4ppletree/exploratorydataanalysis_week4assignment/blob/master/plot2.png">

Answer to Question 2: Total Emissions from 1999 went down in 2002; then it 
increased in 2005; then it decreased in 2008. So, overall total emissions
has gone down since 1999 to 2008, but not before rising in 2005 from 2002.

### **Question 3:**([plot3.R](https://github.com/an4ppletree/exploratorydataanalysis_week4assignment/blob/master/plot3.R))
Of the four types of sources indicated by the type\color{red}{\verb|type|}type (point, nonpoint, onroad, nonroad) variable, which of these four sources have seen decreases in emissions from 1999-2008 for Baltimore City? Which have seen increases in emissions from 1999-2008? Use the ggplot2 plotting system to make a plot answer this question.

```R
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
```
<img src="https://github.com/an4ppletree/exploratorydataanalysis_week4assignment/blob/master/plot3.png">

Answer to Question 3: Non-road, Nonpoint, and On-road have seen decreases from
1999 to 2008. Point has seen an increase from 1999 to 2005; then, it decreased
from 2005 to 2008.

### **Question 4:** ([plot4.R](https://github.com/an4ppletree/exploratorydataanalysis_week4assignment/blob/master/plot4.R))
Across the United States, how have emissions from coal combustion-related sources changed from 1999-2008?

```R
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
```
<img src="https://github.com/an4ppletree/exploratorydataanalysis_week4assignment/blob/master/plot4.png">
	
Answer to Question 4: Coal Emissions droped from 1999 to 2002; then, it rose
from 2002 to 2005 before dropping again from 2005 to 2008.

### **Question 5:** ([plot5.R](https://github.com/an4ppletree/exploratorydataanalysis_week4assignment/blob/master/plot5.R))
How have emissions from motor vehicle sources changed from 1999-2008 in Baltimore City?

```R
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

```
<img src="https://github.com/an4ppletree/exploratorydataanalysis_week4assignment/blob/master/plot5.png">

Answer to Question 5: Baltimore's motor vehcile emissions have decreased at each year
date point from each previous year data point.

### **Question 6:** ([plot6.R](https://github.com/an4ppletree/exploratorydataanalysis_week4assignment/blob/master/plot6.R))
Compare emissions from motor vehicle sources in Baltimore City with emissions from motor vehicle sources in Los Angeles County, California (fips == "06037"\color{red}{\verb|fips == "06037"|}fips=="06037"). Which city has seen greater changes over time in motor vehicle emissions?


```R
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
```
<img src="https://github.com/an4ppletree/exploratorydataanalysis_week4assignment/blob/master/plot6.png">

Answer to Question 6: Compared to Baltimore, Los Angeles has seen greater
change in PM2.5 Emissions. Their PM2.5 Emissions from their maximum PM2.5 was
4601.415 in 2005 has decreased by 670.2949 to 3931.12 in 2008. Baltimore
highest to lowest Emissions was a change of 258.5445.