############################################################################
# Input file download, unzip and load
############################################################################

if(!file.exists("./data")){dir.create("./data")}
fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileUrl,destfile="./data/Dataset.zip",method="curl")

unzip(zipfile="./data/Dataset.zip",exdir="./data")

filePath <- file.path("./data")

hpcMaster  <- read.table(file.path(filePath, "household_power_consumption.txt" ),
                         header = TRUE,
                         sep = ";",
                         stringsAsFactors = FALSE,
                         dec=".")

############################################################################
# Subset data base on requirements 2/1/2007 & 2/2/2007
############################################################################

hpc2007 <- hpcMaster[hpcMaster$Date %in% c("1/2/2007","2/2/2007"),]

############################################################################
# Create timestamp and convert variables to numerics
############################################################################

datetimeStamp <- strptime(paste(hpc2007$Date, hpc2007$Time, sep=" "), "%d/%m/%Y %H:%M:%S") 
hpc2007$Global_active_power <- as.numeric(hpc2007$Global_active_power)
hpc2007$Global_reactive_power <- as.numeric(hpc2007$Global_reactive_power)
hpc2007$Voltage <- as.numeric((hpc2007$Voltage))
hpc2007$Sub_metering_1 <- as.numeric(hpc2007$Sub_metering_1)
hpc2007$Sub_metering_2 <- as.numeric(hpc2007$Sub_metering_2)
hpc2007$Sub_metering_3 <- as.numeric(hpc2007$Sub_metering_3)

############################################################################
# Create Chart
############################################################################

png("plot4.png", width=480, height=480)


#par(mfrow = c(2, 2), mar = c(4, 4, 4, 4), oma = c(0, 0, 2, 0)) 
par(mfrow = c(2, 2)) 


#####Chart 1
plot(datetimeStamp, hpc2007$Global_active_power, 
     type="l", xlab="", ylab="Global Active Power (kilowatts)")

#####Chart 2
plot(datetimeStamp, hpc2007$Voltage, 
     type="l", xlab="datetime", ylab="Voltage")

#####Chart 3
plot(datetimeStamp, hpc2007$Sub_metering_1, type="l", col="black",xlab = "",
     ylab = "Energy sub metering")
lines(datetimeStamp, hpc2007$Sub_metering_2, col="red"  )
lines(datetimeStamp, hpc2007$Sub_metering_3, col="blue"  )

legend("topright", lty=1, col = c("black","blue", "red"), bty = "n",
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))


#####Chart 4

plot(datetimeStamp, hpc2007$Global_reactive_power, 
     type="l", xlab="datetime", ylab="Global_reactive_power")

dev.off()
