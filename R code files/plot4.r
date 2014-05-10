#download the file
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", destfile="pwr.zip")

#unzip it and put data in a table
data <- read.table(unz("pwr.zip", "household_power_consumption.txt"),header=T, sep=";")

#close connection
close(unz("pwr.zip", "household_power_consumption.txt"))

#format date column
data$Date<-as.Date(data$Date, format="%d/%m/%Y")
# only data from the dates 2007-02-01 and 2007-02-02.
data <- data[data$Date%in%  as.Date(c('2007-02-01','2007-02-02')), ]

# Format date with date and time
data$Date<-paste(data$Date, data$Time)
data$Date<-strptime(data$Date, "%Y-%m-%d %H:%M:%S")

#set local 
Sys.setlocale(locale = "C")

#load library
library(datasets)

#four plot will be display

png(file = "plot4.png", width = 480, height = 480) 

par(mfrow = c(2, 2))

#create graph and save it
#first graph
with(data,plot(Date,as.numeric(as.character(Global_active_power)),type="l",ylab="Global Active Power (kilowatts)",xlab=""),)

#second graph
with(data,plot(Date,as.numeric(as.character(Voltage)),type="l",ylab="Voltage",xlab="datetime"),)

#third graph
with(data,plot(Date,as.numeric(as.character(Sub_metering_1)),type="l",ylab="Energy sub metering",xlab=""))
with(data,points(Date,as.numeric(as.character(Sub_metering_2)),type="l",col="red"))
with(data,points(Date,as.numeric(as.character(Sub_metering_3)),type="l",col="blue"))
legend("topright", cex=0.7, lty = 1, col = c("black", "red", "blue"), legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

#last one
with(data,plot(Date,as.numeric(as.character(Global_reactive_power)),type="l",ylab="Global_reactive_powe",xlab="datetime"),)

dev.off()


