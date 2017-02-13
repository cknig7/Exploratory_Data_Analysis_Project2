
## Exploratory Data Analysis
## PM2.5 Emissions


## Download, unzip, and read project files

if(!file.exists("./data")){dir.create("./data")}
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip", destfile = "./data/NEI-Dataset.zip")
unzip("./data/NEI-Dataset.zip",overwrite=T)
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")


## Reference needed libraries

library(ggplot2)


## 3.) Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad) variable, which of these four sources have
## seen decreases in emissions from 1999-2008 for Baltimore City? Which have seen increases in emissions from 1999-2008? Use the ggplot2
## plotting system to make a plot answer this question. All have seen decreases except 'point' which saw a slight increase from '99-'8

# Calculate total emissions by year and type for Baltimore City
emYearBaltTyp <- aggregate(Emissions ~ year + type, data=subset(NEI, fips == "24510"), sum)

# Base plot 
par(bg="white", mfrow=c(1,1))

# Plot
ggplot(data=emYearBaltTyp, aes(x=year, y=Emissions, color= type)) + geom_line() + geom_point() +
  labs(title="Total Baltimore City Emissions by Year", x="Year")

# Copy plot to .png file
dev.copy(png, file="plot3.png", width = 480, height = 480)

dev.off()
