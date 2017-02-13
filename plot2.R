
## Exploratory Data Analysis
## PM2.5 Emissions


## Download, unzip, and read project files

if(!file.exists("./data")){dir.create("./data")}
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip", destfile = "./data/NEI-Dataset.zip")
unzip("./data/NEI-Dataset.zip",overwrite=T)
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")


## 2.) Have total emissions from PM2.5 decreased in the Baltimore City, Maryland (fips == "24510") from 1999 to 2008?
## Use the base plotting system to make a plot answering this question. Yes

# Calculate total emissions by year for Baltimore City, Maryland
emYearBalt <- aggregate(Emissions ~ year, data=subset(NEI, fips == "24510"), sum)

#Base plot 
par(bg="white", mfrow=c(1,1))

# Plot
plot(Emissions ~ year, data= emYearBalt,
      type= "o",
     xlab= "Year",
     ylab= "Total Emissions",
     main= "Baltimore City Emission by Year")
  
# Copy to .png file
dev.copy(png, file="plot2.png", width = 480, height = 480)

dev.off()
