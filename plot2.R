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

#Create the PNG file
png("plot2.png")
plot(ts,data$Global_active_power,type = "l",xlab= "",ylab = "Global Active Power (kilowatts)")
axis(1,at=c(0,1440,2880),label=c("Thu","Fri","Sat"))
dev.off()


