
## Exploratory Data Analysis
## PM2.5 Emissions


## Download, unzip, and read project files

if(!file.exists("./data")){dir.create("./data")}
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip", destfile = "./data/NEI-Dataset.zip")
unzip("./data/NEI-Dataset.zip",overwrite=T)
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")


## Reference needed libraries

library(plyr)
library(ggplot2)


## 6.) Compare emissions from motor vehicle sources in Baltimore City with emissions from
## motor vehicle sources in Los Angeles County, California (fips == "06037").
## Which city has seen greater changes over time in motor vehicle emissions?  Baltimore City

# Keep SCC rows related to Mobile or Vehicle
myvars <- c("SCC", "EI.Sector", "SCC.Level.One", "SCC.Level.Three")
SCC2 <- SCC[myvars]
vehicEmis <- SCC2[grepl("Mobile",SCC2$SCC.Level.One),]  
vehicEmis2 <- vehicEmis[grepl("Vehicle",vehicEmis$SCC.Level.Three),]  

# Merge SCC fields with NEI
mergedData2 <- merge(x=NEI, y=vehicEmis2, by='SCC')

# Calculate total motor vehicle emissions by year by cities of interest
vehicEmisYr2<- aggregate(Emissions ~ year + fips, data=subset(mergedData2, fips == "24510" | fips == "06037"), sum)

# Base plot 
par(bg="white", mfrow=c(1,1))

# Plot emissions by city and year  
ggplot(data=vehicEmisYr2, aes(x=year, y=Emissions, color=fips)) + geom_line() + geom_point() +
  labs(title="Total Emissions by Year For Baltimore City and Los Angeles County", x="Year")

# Copy plot to .png file
dev.copy(png, file="plot6.png", width = 480, height = 480)

dev.off()

