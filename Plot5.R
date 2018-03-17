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
BaltimoreOnRoad <- NEI[NEI$fips=="24510" & NEI$type=="ON-ROAD",  ]
TotalByYear <- aggregate(Emissions ~ year, BaltimoreOnRoad, sum)
png("Plot5.png")
g <- ggplot(TotalByYear, aes(factor(year), Emissions))
g <- g + geom_bar(stat="identity", aes(colour= year, fill=year)) + xlab("Year") + ylab(" Emissions") + ggtitle("Emissions from motor vehicle sources in Baltimore")
print(g)
dev.off()