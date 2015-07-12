data<-data.frame()
# read data, assign classes to variables
data<-read.table("household_power_consumption.txt", sep=";", dec=".", header=TRUE, na="?", colClasses=(c("character", "character", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric")))
smalldata<-data.frame()
#subset data to two dates in question
smalldata<-subset(data, data$Date=="1/2/2007" | data$Date=="2/2/2007")
#paste together separate date and time columns
smalldata<-transform(smalldata, DateTime=paste(Date, Time, sep=" "))
newsmalldata<-data.frame()
#remove old date and time character columns
newsmalldata<-smalldata[,!(names(smalldata) %in% c("Date", "Time"))]
#convert datetime pasted column into date and time format
newsmalldata$DateTime<-strptime(newsmalldata$DateTime, "%d/%m/%Y %H:%M:%S")
#set up for 2X2 graphs for chart
par(mfcol=c(2,2))
# first plot
plot(newsmalldata$DateTime, newsmalldata$Global_active_power, type="l", xlab="", ylab="Global Active Power" )
#second plot with additional lines and legend
plot(newsmalldata$DateTime, newsmalldata$Sub_metering_1, type="l", xlab="", ylab="Energy sub metering")
lines(newsmalldata$DateTime, newsmalldata$Sub_metering_2, type="l", col="red")
lines(newsmalldata$DateTime, newsmalldata$Sub_metering_3, type="l", col="blue")
legend("topright", legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col=c("black", "red", "blue"), lwd=1, cex=0.3)
#3rd plot
plot(newsmalldata$DateTime, newsmalldata$Voltage, type="l", xlab="datetime", ylab="Voltage")
#4th plot
plot(newsmalldata$DateTime, newsmalldata$Global_reactive_power, type="l", lwd=0.1, xlab="datetime", ylab="Global_reactive_power")
#copy chart to png file, turn off dev
dev.copy(png, file="plot4.png", width=480, height=480)
dev.off()
