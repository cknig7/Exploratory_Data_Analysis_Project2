
## Exploratory Data Analysis
## PM2.5 Emissions


## Download, unzip, and read project files

if(!file.exists("./data")){dir.create("./data")}
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip", destfile = "./data/NEI-Dataset.zip")
unzip("./data/NEI-Dataset.zip",overwrite=T)
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")


## 1.) Have total emissions from PM2.5 decreased in the United States from 1999 to 2008?
## Using the base plotting system, make a plot showing the total PM2.5 emission from all
## sources for each of the years 1999, 2002, 2005, and 2008. Yes


#Calculate the total emissions by year

emYear <- aggregate(Emissions ~ year, NEI, sum)
  
# Base plot 
par(bg="white", mfrow=c(1,1))

# Create plot
plot(emYear$year,emYear$Emissions,
    type= "o",
    xlab= "Year",
    ylab= "Total PM2.5 Emissions",
    main= "Emissions by Year")
  
# Copy plot to .png file
dev.copy(png, file="plot1.png", width = 480, height = 480)

dev.off()
  
  