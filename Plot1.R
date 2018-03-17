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
TotalByYear <- aggregate(Emissions ~ year, NEI, sum)
png("Plot1.png")
barplot(height=TotalByYear$Emissions, names.arg = TotalByYear$year, col=c("Magenta", "Cyan", "Green", "Orange"), main="Total PM2.5 emission by year",xlab="Years", ylab = "Emission")
dev.off()
