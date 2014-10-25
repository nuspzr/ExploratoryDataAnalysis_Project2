##Set local working directory
setwd("C:/R/Course4Project2/")

##Load data sets
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

##Subset for the Baltimore data
Baltimore<-NEI[NEI$fips=="24510",]
LA<-NEI[NEI$fips=="06037",]

##Subset for vehicle-generated emissions in Baltimore
vehicles.EI<-grep("vehicle",SCC$EI.Sector,value=T,ignore.case=T)
vehicles.EI<-unique(vehicles.EI)
SCC.vehicles<-subset(SCC, EI.Sector %in% vehicles.EI)

Baltimore.vehicles<-subset(Baltimore, SCC %in% SCC.vehicles$SCC)
vehicles.Baltimore<-aggregate(Baltimore.vehicles[c("Emissions")], list(year = Baltimore.vehicles$year), sum)

##Subset for vehicle-generated emissions in Los Angeles
LA.vehicles<-subset(LA, SCC %in% SCC.vehicles$SCC)
vehicles.LA<-aggregate(LA.vehicles[c("Emissions")], list(year = LA.vehicles$year), sum)

##CNormalize the data, and combine two data frames into one
vehicles.Baltimore<-cbind(city="Baltimore City",vehicles.Baltimore)
normalized.emissions.Baltimore<-vehicles.Baltimore$Emissions/vehicles.Baltimore$Emissions[1]
normalized.Baltimore<-vehicles.Baltimore
normalized.Baltimore$Emissions<-normalized.emissions.Baltimore

vehicles.LA<-cbind(city="LA County",vehicles.LA)
normalized.emissions.LA<-vehicles.LA$Emissions/vehicles.LA$Emissions[1]
normalized.LA<-vehicles.LA
normalized.LA$Emissions<-normalized.emissions.LA

Baltimore.LA<-rbind(vehicles.Baltimore,vehicles.LA)
normalized.Baltimore.LA<-rbind(normalized.Baltimore,normalized.LA)


##Plot
library(ggplot2)
p6.a<-qplot(year, Emissions, data=Baltimore.LA, color=city, geom="line") +
  geom_point(alpha=1)+
  ggtitle(PM[2.5]~"Emissions from Motor Vehocles in Absolute Terms: Baltimore City vs. LA County")+
  xlab("Year") +
  ylab(expression(PM[2.5] ~ "Emissions (in Tons) from Motor Vehicles"))
  
p6.b<-qplot(year, Emissions, data=normalized.Baltimore.LA, color=city, geom="line") +
  geom_point(alpha=1)+
  ggtitle(PM[2.5]~"Emissions from Motor Vehicles in Normalized Terms: Baltimore City vs. LA County")+
  xlab("Year") +
  ylab(expression("Normalized"~PM[2.5] ~ "Emissions from Motor Vehicles"))

library(grid)
library(gridExtra)

grid.arrange(p6.a,p6.b)

dev.copy(png, file="plot6.png", height=720, width=540)
dev.off()