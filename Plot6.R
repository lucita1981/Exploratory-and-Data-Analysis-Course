## Downloading & Unzip
if(!file.exists("./data")){dir.create("./data")}
fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
download.file(fileUrl, destfile="./data/Data.zip")
unzip(zipfile="./data/Data.zip",exdir="./data")

## Reading Files
if(!exists("NEI")){
  NEI <- readRDS("./data/summarySCC_PM25.rds")
}
if(!exists("SCC")){
  SCC <- readRDS("./data/Source_Classification_Code.rds")
}

#Plot function & Using PNG Device
library(ggplot2)
mixOnRoad <- NEI[(NEI$fips=="24510"|NEI$fips=="06037") & NEI$type=="ON-ROAD",  ]
TotalByYearFips <- aggregate(Emissions ~ year + fips, mixOnRoad, sum)
TotalByYearFips$fips[TotalByYearFips$fips=="24510"] <- "Baltimore"
TotalByYearFips$fips[TotalByYearFips$fips=="06037"] <- "Los Angeles"
png("Plot6.png")
g <- ggplot(TotalByYearFips, aes(factor(year), Emissions))
g <- g + geom_bar(stat="identity", aes(colour= fips, fill=fips)) + facet_grid(.~fips) + xlab("Year") + ylab(" Emissions") + ggtitle("Motor Vehicle Emission Variation in Baltimore Versus Los Angeles")
print(g)
dev.off()