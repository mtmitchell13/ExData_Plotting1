## Read the data
dataFull <- read.table("household_power_consumption.txt", header=TRUE, sep=";",
                       na.strings="?", colClasses="character")

## Concatenate Date and Time into new DateTime column and convert from
## character to date time format
dataFull$DateTime <- paste(dataFull$Date, dataFull$Time, sep = " ")
dataFull$DateTime <- strptime(dataFull$DateTime, format="%d/%m/%Y %H:%M:%S")

## Subset dataFull for the two days requested by the assignment,
## 2007-02-01 and 2007-02-02
d1 <- as.Date("2007/02/01", format="%Y/%m/%d")
d2 <- as.Date("2007/02/02", format="%Y/%m/%d")
dataSub <- subset(dataFull, as.Date(dataFull$DateTime, format="%Y/%m/%d") 
                  == d1 | as.Date(dataFull$DateTime, format="%Y/%m/%d") 
                  == d2)

## Set the plot rows and columns
par(mfrow = c(2, 2))

## Create the first plot on the screen device
with(dataSub, plot(DateTime, as.numeric(Global_active_power), 
                   ylab="Global Active Power", xlab="", type="n"))
lines(dataSub$DateTime, dataSub$Global_active_power)

## Create the second plot on the screen device
with(dataSub, plot(DateTime, as.numeric(Voltage), xlab="datetime", ylab="Voltage", 
                   type="n"))
lines(dataSub$DateTime, dataSub$Voltage)

## Create the third plot on the screen device
with(dataSub, plot(DateTime, as.numeric(Sub_metering_1), xlab="", 
                   ylab="Energy sub metering", type="n"))
lines(dataSub$DateTime, dataSub$Sub_metering_1, col="black")
lines(dataSub$DateTime, dataSub$Sub_metering_2, col="red")
lines(dataSub$DateTime, dataSub$Sub_metering_3, col="blue")
legend("topright", legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       lty=c(1, 1, 1), col=c("black", "red", "blue"), bty="n", adj=c(0.09, 0.5), cex=0.7)

## Create the fourth plot on the screen device
with(dataSub, plot(DateTime, as.numeric(Global_reactive_power), xlab="datetime", 
                   ylab="Global_reactive_power", type="n"))
lines(dataSub$DateTime, dataSub$Global_reactive_power)

## Save the plot as a PNG file in the working directory
dev.copy(png, file="plot4.png", width=480, height=480, units="px", bg="white")
dev.off()