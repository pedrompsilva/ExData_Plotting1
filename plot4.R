library(data.table)
library(dplyr)
library(lubridate)



setwd("E:\\GIT\\DataScienceCoursera\\exploratory_data_analysis\\course proj 1")

download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", "exdata_data_household_power_consumption.zip")
unzip("exdata_data_household_power_consumption.zip")


ds <- fread("household_power_consumption.txt",
            sep=";",
            header = TRUE,
            dec=".",
            na.strings=c("","?"),
            select= c("Date", "Time", "Global_active_power", "Global_reactive_power","Voltage","Sub_metering_1", "Sub_metering_2", "Sub_metering_3" ),
            data.table=FALSE)

ds <- ds[ds$Date=="1/2/2007"|ds$Date=="2/2/2007",]
ds$Date <- dmy_hms(paste(ds$Date, ds$Time))

ds$Global_active_power <- as.numeric(ds$Global_active_power)
ds$Voltage <- as.numeric(ds$Voltage)
ds$Sub_metering_1 <- as.numeric(ds$Sub_metering_1)
ds$Sub_metering_2 <- as.numeric(ds$Sub_metering_2)
ds$Sub_metering_3 <- as.numeric(ds$Sub_metering_3)


png("plot4.png",width = 640, height = 640, units = "px")
par(mfrow=c(2, 2))

#plot 1,1

  ds1 <- ds[!is.na(ds$Global_active_power),c("Date", "Global_active_power")]
  plot(ds1$Date,ds1$Global_active_power,type = "l", ylab="Global Active Power (kilowatts)", xlab = "")

#plot 2,1
  ds2 <- ds[!is.na(ds$Voltage),c("Date", "Voltage")]
  plot(ds2$Date,ds2$Voltage,type = "l", ylab="Voltage", xlab = "datetime")
  
#plot 1,2
ds3 <- ds[,c("Date", "Sub_metering_1","Sub_metering_2","Sub_metering_3")]
  plot(ds3$Date,ds3$Sub_metering_1,type = "l", xlab="", ylab = "Energy sub metering")
  lines(ds3$Date,ds3$Sub_metering_2, col="Red")
  lines(ds3$Date,ds3$Sub_metering_3, col="Blue")
  legend("topright", 
         legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), 
         lty=1:2, cex=0.8, col=c("Black", "Red", "Blue"))

#plot 2,2
  ds4 <- ds[!is.na(ds$Global_reactive_power),c("Date", "Global_reactive_power")]
  plot(ds4$Date,ds4$Global_reactive_power,type = "l", ylab="Global_reactive_Power", xlab = "datetime")

dev.off()



