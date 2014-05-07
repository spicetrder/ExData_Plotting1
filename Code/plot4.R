# Project 1 for Data Exploration Course June 2014
# John S. Johnson
# Creates plot 4 
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
EnergyData$Global_reactive_power <-
    as.numeric(as.character(EnergyData$Global_reactive_power))
#                               
## Create Plots:
png(filename = paste(path, "plot4.png", sep =""),
     width = 480, height = 480, units = "px", bg = "white")
#specify 2 x 2 array of plots
par(mfrow = c(2,2))
#create upper left plot
plot(EnergyData$DateTime, EnergyData$Global_active_power, 
          ylab = "Global Active Power", main = "",
     type = "l", xlab = "")
#create upper right plot
plot(EnergyData$DateTime, EnergyData$Voltage, ylab = "Voltage",
     xlab = "datetime", main = "", type = "l")
#create lower left plot
plot(EnergyData$DateTime, EnergyData$Sub_metering_1, 
     ylab = "Energy sub metering", xlab = "", main = "", type = "l",
     ylim = c(0, 38))
lines(EnergyData$DateTime, EnergyData$Sub_metering_2, col = "red")
lines(EnergyData$DateTime, EnergyData$Sub_metering_3, col = "blue")
legend("topright", c("Sub_metering_1", "Sub_metering_2", 
    "Sub_metering_3"), col = c("black", "red", "blue"),
     bty = "n", lwd=1, cex = 0.9)
#create lower right plot
plot(EnergyData$DateTime, EnergyData$Global_reactive_power, 
     ylab = "Global_reactive_power", main = "", type = "l",
     xlab = "datetime")
# done creating plots
dev.off()
#
## end of R Script
