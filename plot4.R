
## Exploratory Data Analysis
## PM2.5 Emissions


## Download, unzip, and read project files

getwd()

if(!file.exists("./data")){dir.create("./data")}
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip", destfile = "./data/NEI-Dataset.zip")
unzip("./data/NEI-Dataset.zip",overwrite=T)
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")


## Reference needed libraries

library(plyr)
library(ggplot2)


## 4.) Across the United States, how have emissions from coal combustion-related sources changed from 1999-2008?

# Keep interesting SCC fields; Keep rows that reference Coal
myvars <- c("SCC", "EI.Sector", "SCC.Level.One", "SCC.Level.Three")
SCC2 <- SCC[myvars]
coalComb <- SCC2[grepl("Coal",SCC2$EI.Sector),]

# Merge the SCC fields with the NEI fields
coalCombSCC <- merge(x=NEI, y=coalComb, by='SCC')

# Calculate total emissions by year
aggcoalCombSCC <- aggregate(Emissions ~ year, coalCombSCC, sum)

# Base plot 
par(bg="white", mfrow=c(1,1))

# Plot emissions change
ggplot(data=aggcoalCombSCC, aes(x=year, y=Emissions)) + geom_line() + geom_point() +
  labs(title="Total Coal Combustion Emissions by Year", x="Year")

# Copy plot to .png file
dev.copy(png, file="plot4.png", width = 480, height = 480)

dev.off()

  