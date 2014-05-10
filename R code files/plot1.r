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

library(datasets)
x<-as.numeric(as.character(data$Global_active_power))
#only one hist will be display
par(mfrow=c(1,1))

#create histogramme
hist(x,col ="red", breaks = 13,main = "Global Active Power",xlab='Global Active Power (kilowatts)')

#save it to a png file with 480 by 480 pixel
dev.copy(png, file = "plot1.png", width = 480, height = 480) 
dev.off()