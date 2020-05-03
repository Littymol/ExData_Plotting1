# If the dataset is not present in the current working directory then download it
fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
if (!file.exists("exdata_data_household_power_consumption.zip")) {
  if (!file.exists("my_data")) {
    dir.create("my_data")
  }
  download.file(fileUrl, destfile="my_data/raw.zip")
  unzip("my_data/raw.zip", exdir=".")
}

## Read data into R

con="household_power_consumption.txt"
date1<-grep("^1/2/2007",readLines(con),perl = TRUE)
date2<-grep("^2/2/2007",readLines(con),perl = TRUE)
names<-c("Date", "Time", "Global_active_power", "Global_reactive_power", "Voltage", "Global_intensity", "Sub_metering_1", "Sub_metering_2", "Sub_metering_3")
data<-read.table("household_power_consumption.txt",  sep = ";", skip = 66637, nrows = 2880, col.names = names)


## Create merged DateTime column
datetime<-strptime(paste(data$Date,data$Time), "%d/%m/%Y %H:%M:%S")

##plot4

png(file="plot4.png",width = 480,height = 480,unit="px")  
par(mfcol=c(2,2))
with(data,plot(datetime,Global_active_power,type="l",xlab="",ylab="Global Active Power")) 
with(data,plot(datetime,Sub_metering_1,type="n",xlab="",ylab="Energy sub metering"))
with(subset(data,Sub_metering_1 >=0), points(datetime,Sub_metering_1,col="black",type="l"))
with(subset(data,Sub_metering_2 >=0), points(datetime,Sub_metering_2,col="red",type="l"))
with(subset(data,Sub_metering_3 >=0), points(datetime,Sub_metering_3,col="blue",type="l"))
legend("topright",lwd=1,col=c("black","red","blue"),legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))
with(data,plot(datetime,Voltage,type="l",xlab="datetime",ylab="Voltage"))
with(data,plot(datetime,Global_reactive_power,type="l",xlab="datetime",ylab="Global_reactive_power"))
dev.off()