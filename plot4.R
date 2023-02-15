library(dplyr)
library(lubridate)

#Download the file
#First check if it exists
filename <- "power consumption.zip"
if (!file.exists(filename)){
  fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
  download.file(fileURL, filename, method = "curl")
}

#unzip the folder and download, if it doesn't exist
if(!file.exists("power consumption")){
  unzip(filename)
}

#read in the data and set the date to a real date
table <- read.table("household_power_consumption.txt", header = TRUE, sep = ";")
table$Date <- as.Date(table$Date, "%d/%m/%Y")

#Extract only two dates
table2 <- subset(table, Date == "2007-02-01" | Date == "2007-02-02")
table2$date_time <- with(table2, ymd(Date) + hms(Time)) # create a date + time column

png(file= "plot4.png") # Open png file

#create 2x2 for plots
par(mfrow = c(2,2))

##PLOT 1
with(table2, plot(date_time, as.double(Global_active_power), type = "l", xlab = "", ylab = "Global Active Power (kilowatts)"))

##PLOT 2
with(table2, plot(date_time, as.double(Voltage), type = "l", xlab = "datetime", ylab = "Voltage"))

##PLOT 3
#Create the empty plot
with(table2, plot(date_time, as.double(Sub_metering_1), type = "n", xlab = "", ylab = "Energy sub metering"))
#Create the legend
legend("topright", lwd = 1, bty = "n", col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
#add the lines
with(table2, lines(date_time, as.double(Sub_metering_1)))
with(table2, lines(date_time, as.double(Sub_metering_2), col = "red"))
with(table2, lines(date_time, as.double(Sub_metering_3), col = "blue"))

##Plot 4
with(table2, plot(date_time, as.double(Global_reactive_power), type = "l", xlab = "datetime", ylab = "Global_reactive_power"))

dev.off() # Close PNG file