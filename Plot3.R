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
Baltimore  <- subset(NEI, fips=="24510")
TotalByYearType <- aggregate(Emissions ~ year + type, Baltimore, sum)
png("Plot3.png")
g <- ggplot(TotalByYearType, aes(year, Emissions, color = type))
g <- g + geom_line()+ geom_point() + xlab("Year") + ylab(" Emissions") + ggtitle("Total Emissions in Baltimore City 1999-2008 by Type")
print(g)
dev.off()