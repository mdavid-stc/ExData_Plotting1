# Date format is backward, so setup to reverse.
setClass("myDate")
setAs("character","myDate", function(from) as.Date(from, format="%d/%m/%Y") )

# Load a subset of the data (just 01-02 Feb 2007)
pwrData <- read.table("household_power_consumption.txt", header=TRUE, sep=";",
                      colClasses=c("myDate",NA,"numeric","numeric","numeric","numeric","numeric","numeric","numeric"),
                      na.strings="?", nrows=69517)
pwrData <- pwrData[pwrData$Date >= "2007/02/01" & pwrData$Date <= "2007/02/02",]

# Convert to proper Date and Time classes
pwrData$DateTime <- strptime(paste(pwrData$Date, pwrData$Time),"%Y-%m-%d %H:%M:%S")

### Now create plot ###

plot(pwrData$DateTime, pwrData$Sub_metering_1, ylab="Energy sub metering",
     xlab="", type="n")
points(pwrData$DateTime, pwrData$Sub_metering_1, type="l")
points(pwrData$DateTime, pwrData$Sub_metering_2, type="l", col="red")
points(pwrData$DateTime, pwrData$Sub_metering_3, type="l", col="blue")
legend("topright", legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
       col=c("black","red","blue"), lwd=1)
# Copy plot to a PNG file
dev.copy(png, file="plot3.png")
# Note that the default dimensions are 480x480.
dev.off()  # close the PNG device
