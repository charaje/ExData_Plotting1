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
# Create timestamp and convert variable to numeric
############################################################################

datetimeStamp <- strptime(paste(hpc2007$Date, hpc2007$Time, sep=" "), "%d/%m/%Y %H:%M:%S") 
hpc2007$Sub_metering_1 <- as.numeric(hpc2007$Sub_metering_1)
hpc2007$Sub_metering_2 <- as.numeric(hpc2007$Sub_metering_2)
hpc2007$Sub_metering_3 <- as.numeric(hpc2007$Sub_metering_3)

############################################################################
# Create Chart
############################################################################

png("plot3.png", width=480, height=480)

plot(datetimeStamp, hpc2007$Sub_metering_1, type="l", col="black",xlab = "",
     ylab = "Energy sub metering")
lines(datetimeStamp, hpc2007$Sub_metering_2, col="red"  )
lines(datetimeStamp, hpc2007$Sub_metering_3, col="blue"  )


legend("topright", lty=1, col = c("black","blue", "red"), 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
dev.off()




