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

#only one graph will be display
par(mfrow=c(1,1))

#create graph
with(data,plot(Date,as.numeric(as.character(Global_active_power)),type="l",ylab="Global Active Power (kilowatts)",xlab=""),)

#save it to a png file with 480 by 480 pixel
dev.copy(png, file = "plot2.png", width = 480, height = 480) 
dev.off()