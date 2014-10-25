##Set local working directory
setwd("C:/R/Course4Project2/")

##Load data sets
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

##Subset for the Baltimore data
Baltimore<-NEI[NEI$fips=="24510",]
type.year<-aggregate(Baltimore[c("Emissions")], list(type = Baltimore$type, year = Baltimore$year), sum)

library(ggplot2)
qplot(year, Emissions, data=type.year, color=type, geom="line") +
  geom_point(alpha=1)+
  xlab("Year") +
  ylab(expression(PM[2.5] ~ "Emissions (in Tons) by Source Type and Year: Baltimore City"))

dev.copy(png, file="plot3.png", height=480, width=540)
dev.off()