# Project 1 for Data Exploration Course June 2014
# John S. Johnson
# Creates plot 2 
#
#
# Opens file and loads data, reports size
path = "~/R/R Workspace/"
file = "household_power_consumption.txt"
file_address <- paste(path, file, sep ="")
file_info <- file.info(file_address)
EnergyData <- read.csv2(file_address)
View(EnergyData)
#
## remove rows with missing data flagged with "?"
EnergyData <- EnergyData[!(grepl("\\?", EnergyData[,3])) , ]
#
## process dates and times, add as additional column
EnergyData$DateTime <- paste(EnergyData$Date, EnergyData$Time) # concatenate Date, Time
EnergyData$DateTime <- strptime(EnergyData$DateTime, "%d/%m/%Y %T")  #convert to POSIX
#
## only interested in February 2007 observations
EnergyData <- subset(EnergyData, months(EnergyData$DateTime) =="February" 
                        & format(EnergyData$DateTime, "%Y") =="2007" &
                             format(EnergyData$DateTime, "%d") %in% c("01","02"))
#
## convert data types
EnergyData$Voltage <- as.numeric(as.character(EnergyData$Voltage))
EnergyData$Global_active_power <- 
    as.numeric(as.character(EnergyData$Global_active_power))
#                               
## Create Plot :
png(filename = paste(path, "plot2.png", sep =""),
     width = 480, height = 480, units = "px", bg = "white")
plot(EnergyData$DateTime, EnergyData$Global_active_power, 
          ylab = "Global Active Power (kilowatts)", main = "", type = "l")
dev.off()
#
## end of R Script
