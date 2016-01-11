#Read data from file in current Working Directory
data <- read.table("household_power_consumption.txt",header=TRUE,sep=";")

#Load data.table library and convert data
library("data.table")
data <- data.table(data)

#Convert Dates and filter data.table
data[,Date := as.Date(Date,"%d/%m/%Y")]
data <- data[Date < "2007-02-03"]
data <- data[Date > "2007-01-31"]
data[,weekday := weekdays(Date)]
data[,Time := strftime(strptime(Time,"%H:%M:%S"),"%H:%M:%S")]
data[,Timestamp := format(as.POSIXct(paste(Date, Time)), "%Y/%m/%d %H:%M:%S")]
ts <- as.POSIXlt(data$Timestamp,format="%Y/%m/%d %H:%M:%S")

#convert Global Active Power to a Numeric
data[,Global_active_power := as.numeric(as.character(Global_active_power))]
data[,Global_reactive_power := as.numeric(as.character(Global_reactive_power))]
data[,Sub_metering_1 := as.numeric(as.character(Sub_metering_1))]
data[,Sub_metering_2 := as.numeric(as.character(Sub_metering_2))]
data[,Voltage := as.numeric(as.character(Voltage))]

#Create the PNG file
png("plot4.png")
par(mfrow=c(2,2))

plot(ts,data$Global_active_power,type = "l",xlab= "",ylab = "Global Active Power (kilowatts)")

plot(ts,data$Voltage,type="l",xlab="",ylab="Voltage")

plot(ts,data$Sub_metering_1,type = "l",ylab="Energy sub metering",xlab="")
lines(ts,data$Sub_metering_1)
lines(ts,data$Sub_metering_2, col = "red")
lines(ts,data$Sub_metering_3, col = "blue")
legend("topright",c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),lty = c(1,1,1),lwd=c(2.5,2.5,2.5),col=c("black","red","blue"))

plot(ts,data$Global_reactive_power,type="l",xlab="Global reactive power")

dev.off()


