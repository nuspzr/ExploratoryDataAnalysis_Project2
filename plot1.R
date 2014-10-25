##Set local working directory
setwd("C:/R/Course4Project2/")

##Load data sets
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

##Calculate total emissions for the four years
total.emission<-tapply(NEI$Emissions,NEI$year,sum)
year<-names(total.emission)


plot(y=total.emission,x=year,type="o",
     xlab="Year",ylab="Total Emissions (in Tons)",ylim=c(3e+06,8e+06),
     pch=19,lty=1)

dev.copy(png, file="plot1.png", height=480, width=480)
dev.off()
