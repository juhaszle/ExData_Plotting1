# downloading and unzipping the data file "household_power_consumption.txt"
fileUrl<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileUrl, destfile="powerconsumption.zip")
unzip("powerconsumption.zip")
#reading dataframe
data0=read.table(file="household_power_consumption.txt", header=T, na.strings="?", sep=";")
# constructing a new POSIXlt time variable from Date and Time
library(stringr)
data0$datetime=paste(data0$Date, data0$Time)
data0$datetime=strptime(x=data0$datetime, format="%d/%m/%Y %H:%M:%S")
# discarding missing tatetime cases
data0=data0[!is.na(data0$datetime),]
#subsetting cases with date 2007-02-01 and 2007-02-02
date1=strptime("2007-02-01 00:00:00", format="%Y-%m-%d %H:%M:%S")
date2=strptime("2007-02-03 00:00:00", format="%Y-%m-%d %H:%M:%S")
dt=data0[data0$datetime<date2 & data0$datetime>date1,]

# saving default settings
opar <- par(no.readonly=TRUE)
#turn off local specific timing, setting standard locale
Sys.setlocale("LC_TIME", "C")

png( "plot4.png")

# setting 2x2 array layout
par(mfrow=c(2, 2))
par(cex=0.8)
#building plot4.1
with(dt, plot(datetime,Global_active_power, type="l", xlab="", ylab="Global Active Power"))

#building plot4.2

with(dt, plot(datetime,Voltage, type="l"))

#building plot4.3
with(dt, plot(datetime, Sub_metering_1, type='l', xlab="", ylab="Energy sub metering"))
lines(dt$datetime, dt$Sub_metering_2, col="red")
lines(dt$datetime, dt$Sub_metering_3, col="blue")
legend("topright", lty=1, col=c("black", "red", "blue"), 
       legend=c("Sub_metering_1","Sub_metering_2", "Sub_metering_3"), 
       bty="n")


#building plot4.4
with(dt, plot(datetime,Global_reactive_power, type="l"))

#copying plot
dev.off()

# resetting default parameters
par(opar)