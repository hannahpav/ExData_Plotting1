library(dplyr)

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

png(file= "plot1.png") # Open png file

#Create the histogram
hist(as.double(table2$Global_active_power), xlab = "Global Active Power (kilowatts)", ylab = "Frequency", main = "Global Active Power", col = "red")

dev.off() # Close PNG file