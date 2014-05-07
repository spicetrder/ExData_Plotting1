# Project 1 for Data Exploration Course June 2014
# Creates plot 1 
#
# Opens file and loads data
path = "~/R/R Workspace/"
file = "household_power_consumption.txt"
file_address <- paste(path, file, sep ="")
file_info <- file.info(file_address)
file_size = file_info$size / 1024 / 1024 #converts to megabytes)
paste(as.character(file_size) & "Megabytes")
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
                                             
## Create Plot :
hist(EnergyData$Global_active_power, col ="red1", 
     xlab = "Global Active Power (kilowatts)", main = "Global Active Power")
