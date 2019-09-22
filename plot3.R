library(data.table)
library(dplyr)
library(lubridate)

#download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", "exdata_data_household_power_consumption.zip")
#unzip("exdata_data_household_power_consumption.zip")


ds <- fread("household_power_consumption.txt",
            sep=";",
            header = TRUE,
            dec=".",
            na.strings=c("","?"),
            select= c("Date", "Time", "Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
            data.table=FALSE)

ds <- ds[ds$Date=="1/2/2007"|ds$Date=="2/2/2007",]
ds$Date <- dmy_hms(paste(ds$Date, ds$Time))

ds$Sub_metering_1 <- as.numeric(ds$Sub_metering_1)
ds$Sub_metering_2 <- as.numeric(ds$Sub_metering_2)
ds$Sub_metering_3 <- as.numeric(ds$Sub_metering_3)

#ds <- ds[!is.na(ds$Global_active_power),]
ds <- arrange(ds,ds$Date)

png("plot3.png", width = 640, height = 640, units = "px")
  plot(ds$Date,ds$Sub_metering_1,type = "l", xlab="", ylab = "Energy sub metering")
  lines(ds$Date,ds$Sub_metering_2, col="Red")
  lines(ds$Date,ds$Sub_metering_3, col="Blue")
  legend("topright", 
         legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), 
         lty=1:2, cex=0.8, col=c("Black", "Red", "Blue")
  )
dev.off()



