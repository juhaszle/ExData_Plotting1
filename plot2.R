# downloading and unzipping the data file "household_power_consumption.txt"
fileUrl<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileUrl, destfile="powerconsumption.zip")
unzip("powerconsumption.zip")
#reading dataframe
data0=read.table(file="household_power_consumption.txt", header=T, na.strings="?", sep=";")
# constructing a new POSIXlt time variable from Date and Time
library(stringr)
data0$DateTime=paste(data0$Date, data0$Time)
data0$DateTime=strptime(x=data0$DateTime, format="%d/%m/%Y %H:%M:%S")
# discarding missing DateTime cases
data0=data0[!is.na(data0$DateTime),]
#subsetting cases with date 2007-02-01 and 2007-02-02
date1=strptime("2007-02-01 00:00:00", format="%Y-%m-%d %H:%M:%S")
date2=strptime("2007-02-03 00:00:00", format="%Y-%m-%d %H:%M:%S")
dt=data0[data0$DateTime<date2 & data0$DateTime>date1,]

png( "plot2.png")

# saving default settings
opar <- par(no.readonly=TRUE)

#turn off local specific timing, setting standard locale
Sys.setlocale("LC_TIME", "C")

#building plot2
with(dt, plot(DateTime,Global_active_power, type="l", xlab="", ylab="Global Active Power (kilowatts)"))

#coping plot
dev.off()
# resetting default par
par(opar)