
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


## 5.) How have emissions from motor vehicle sources changed from 1999-2008 in Baltimore City? Decreased drastically

# Keep SCC rows related to Mobile or Vehicle
myvars <- c("SCC", "EI.Sector", "SCC.Level.One", "SCC.Level.Three")
SCC2 <- SCC[myvars]
vehicEmis <- SCC2[grepl("Mobile",SCC2$SCC.Level.One),]  
vehicEmis2 <- vehicEmis[grepl("Vehicle",vehicEmis$SCC.Level.Three),]  

# Merge SCC fields with NEI
mergedData2 <- merge(x=NEI, y=vehicEmis2, by='SCC')

# Calculate total motor vehicle emissions by year for Baltimore City
vehicEmisYr <- aggregate(Emissions ~ year, data=subset(mergedData2, fips == "24510"), sum)

# Base plot 
par(bg="white", mfrow=c(1,1))

# Plot
ggplot(data=vehicEmisYr, aes(x=year, y=Emissions)) + geom_line() + geom_point() +
  labs(title="Total Baltimore City Motor Vehicle Emissions by Year", x="Year")

# Copy plot to .png file
dev.copy(png, file="plot5.png", width = 480, height = 480)

dev.off()
