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
merge <- merge(NEI, SCC, by="SCC")
coal <- grepl("coal", merge$Short.Name, ignore.case=TRUE)
subcoal <- subset( merge, coalMatches)
TotalByYear <- aggregate(Emissions ~ year, subcoal, sum)
png("Plot4.png", width=640, height=480)
g <- ggplot(TotalByYear, aes(factor(year), Emissions))
g <- g + geom_bar(stat="identity") + xlab("year") + ylab(" Emissions") + ggtitle("Total emissions from coal sources 1999-2008")
print(g)
dev.off()