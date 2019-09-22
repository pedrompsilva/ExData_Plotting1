library(data.table)
library(dplyr)
library(lubridate)
library(ggplot2)


download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", "exdata_data_household_power_consumption.zip")
unzip("exdata_data_household_power_consumption.zip")


ds <- fread("household_power_consumption.txt",
            sep=";",
            header = TRUE,
            dec=".",
            na.strings=c("","?"),
            select= c("Date", "Time", "Global_active_power"),
            data.table=FALSE)

ds <- ds[ds$Date=="1/2/2007"|ds$Date=="2/2/2007",]
ds$Date <- dmy_hms(paste(ds$Date, ds$Time))

ds$Global_active_power <- as.numeric(ds$Global_active_power)

ds <- ds[!is.na(ds$Global_active_power),]
ds <- arrange(ds,ds$Date)

png("plot2.png",width = 640, height = 640, units = "px")
plot(ds$Date,ds$Global_active_power,type = "l", ylab="Global Active Power (kilowatts)", xlab = "")

dev.off()



