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

## Create the plot on the screen device
with(dataSub, plot(DateTime, as.numeric(Global_active_power), 
                   ylab="Global Active Power (kilowatts)", xlab="", type="n"))
lines(dataSub$DateTime, dataSub$Global_active_power)

## Save the plot as a PNG file in the working directory
dev.copy(png, file="plot2.png", width=480, height=480, units="px", bg="white")
dev.off()