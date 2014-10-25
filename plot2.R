##Set local working directory
setwd("C:/R/Course4Project2/")

##Load data sets
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

##Subset for the Baltimore data
Baltimore<-NEI[NEI$fips=="24510",]

##Plot the line of total emissions
total.emission.baltimore<-tapply(Baltimore$Emissions,Baltimore$year,sum)
year<-names(total.emission.baltimore)

plot(y=total.emission.baltimore,x=year,type="o",
     xlab="Year",ylab="Total Emissions (in Tons): Baltimore",
     pch=19,lty=1)

dev.copy(png, file="plot2.png", height=480, width=480)
dev.off()