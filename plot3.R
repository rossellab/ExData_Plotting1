# Download and unzip files in current working directory
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",destfile="household_power_consumption.zip",method="curl")
unzip("household_power_consumption.zip")


# Read data, convert dates and times and select only data from february 1st and 2nd, 2007
data<-read.table("household_power_consumption.txt",sep=";",header=TRUE,stringsAsFactors=FALSE,na.strings="?")
library("dplyr")
time<-paste(data$Date,data$Time)
data$Time<-strptime(time,"%d/%m/%Y %H:%M:%S")
data<-mutate(data,Date=as.Date(Date,format="%d/%m/%Y"))
data<-mutate(data,Time=as.POSIXct(Time)) # filter command in next line does not accept POSIXlt values
data<-filter(data,Date=="2007-02-01"|Date=="2007-02-02")

# Make plot and save it to file
png(file="plot3.png",width=500,height=500)
plot(data$Time,data$Sub_metering_1,xlab="",ylab="Energy sub metering",type="l",col="black")
points(data$Time,data$Sub_metering_2,col="red",type="l")
points(data$Time,data$Sub_metering_3,col="blue",type="l")
legend("topright", col = c("black", "red","blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),lwd=1)
dev.off()