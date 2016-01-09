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
DT$Date<- as.Date(DT$Date, "%e/%m/%Y")
DT$Date<- as.POSIXct(paste(DT$Date, DT$Time), format="%Y-%m-%d %H:%M:%S")

require(ggplot2)
# Open PNG GR device
png(filename = "plot2.png", width = 480, height = 480)

# Plot
ggplot(DT, aes(Date, Global_active_power)) + 
  geom_line() + xlab("") +  
  ylab("Global Active Power (kilowatts)") + 
  scale_x_datetime(date_breaks = '1 day', date_labels="%a") +
  theme(panel.background = element_rect(fill = "white"),
        panel.border = element_rect(color = "black", fill=NA)) 

dev.off()


