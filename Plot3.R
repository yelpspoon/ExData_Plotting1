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
png(filename = "plot3.png", width = 480, height = 480)

# Plot
ggplot(DT, aes(Date)) + 
  geom_line(aes(y=Sub_metering_1, color="Sub_metering_1")) + 
  geom_line(aes(y=Sub_metering_2, color="Sub_metering_2")) + 
  geom_line(aes(y=Sub_metering_3, color="Sub_metering_3")) + 
  xlab("") +   ylab("Energy sub metering") + 
  scale_x_datetime(date_breaks = '1 day', date_labels="%a") +
  scale_color_manual(values=c("black", "red", "blue")) +
  theme(panel.background = element_rect(fill = "white"),
        panel.border = element_rect(color = "black", fill=NA),
        legend.key = element_rect(fill = "white"),
        legend.background = element_rect(color = "black",  linetype = "solid"),
        legend.title = element_blank(),
        legend.position = c(.885,.927) ) 
dev.off()