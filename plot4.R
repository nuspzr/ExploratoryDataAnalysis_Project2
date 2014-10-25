##Set local working directory
setwd("C:/R/Course4Project2/")

##Load data sets
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

##Subset for PM2.5 emissions related to coal combustion
coal.EI<-grep("coal",SCC$EI.Sector,value=T,ignore.case=T)
coal.EI<-unique(coal.EI)

SCC.coal<-subset(SCC, EI.Sector %in% coal.EI)
NEI.coal<-subset(NEI, SCC %in% SCC.coal$SCC)
coal.emissions<-aggregate(NEI.coal[c("Emissions")], list(year = NEI.coal$year), sum)

library(ggplot2)
ggplot(coal.emissions, aes(x=year, y=Emissions)) + 
  geom_point(alpha=1) + 
  geom_line() + 
  ylab(PM[2.5]~"Emissions (in Tons) related to Coal Combustion") + 
  xlab('Year')

dev.copy(png, file="plot4.png", height=480, width=480)
dev.off()