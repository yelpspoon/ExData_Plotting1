#-------------------------------------------------------------------------------------------#
# R Programming: Exploratory Data Analysis
# Project1 
#-------------------------------------------------------------------------------------------#

# Get the data if not gotten
urlURL='https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip'
urlFile='exdata%2Fdata%2Fhousehold_power_consumption.zip'
if (!file.exists(urlFile)){  download.file(urlURL, destfile = urlFile)  }

# Unzip the data
dataFile='household_power_consumption.txt'
if (!file.exists(dataFile)){  unzip(dataFile) }

# Use data.table
if (!is.element('data.table', installed.packages()[,1]))
  install.packages('data.table', dep = TRUE)
require(data.table) 

# Read and subselect data.table
DT<-fread(dataFile, na.strings="?")
DT<- DT[Date=='1/2/2007' | Date=='2/2/2007',]

# Open PNG GR device
png(filename = "plot1.png", width = 480, height = 480)
# Plot
hist(DT$Global_active_power, 
     col='red', 
     main="Global Active Power",  
     xlab="Global Active Power (kilowatts)")
dev.off()