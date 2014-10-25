##Set local working directory
setwd("C:/R/Course4Project2/")

##Load data sets
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

##Subset for the Baltimore data
Baltimore<-NEI[NEI$fips=="24510",]

##Subset for vehicle-generated emissions in Baltimore
vehicles.EI<-grep("vehicle",SCC$EI.Sector,value=T,ignore.case=T)
vehicles.EI<-unique(vehicles.EI)
SCC.vehicles<-subset(SCC, EI.Sector %in% vehicles.EI)
Baltimore.vehicles<-subset(Baltimore, SCC %in% SCC.vehicles$SCC)
vehicles.emissions<-aggregate(Baltimore.vehicles[c("Emissions")], list(year = Baltimore.vehicles$year), sum)

##Plot
library(ggplot2)
ggplot(vehicles.emissions, aes(x=year, y=Emissions)) + 
  geom_point(alpha=1) + 
  geom_line() + 
  ylab(PM[2.5]~"Emissions (in Tons) by Motor Vehicles: Baltimore") + 
  xlab('Year')

dev.copy(png, file="plot5.png", height=480, width=480)
dev.off()