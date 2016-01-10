#Read data from file in current Working Directory
data <- read.table("household_power_consumption.txt",header=TRUE,sep=";")

#Load data.table library and convert data
library("data.table")
data <- data.table(data)

#Convert Dates and filter data.table
data[,Date := as.Date(Date,"%d/%m/%Y")]
data <- data[Date < "2007-02-03"]
data <- data[Date > "2007-01-31"]

#convert Global Active Power to a Numeric
data[,Global_active_power := as.numeric(as.character(Global_active_power))]

#Create PNG Histogram
png("plot1.png")
hist(data$Global_active_power,col = "red",xlab = "Global Active Power (kilowatts)",main = "Global Active Power")
dev.off()