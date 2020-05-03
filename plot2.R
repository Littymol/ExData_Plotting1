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

##plot2

png(file="plot2.png",width = 480,height = 480,unit="px")
with(data,plot(datetime,Global_active_power,type="l",xlab="",ylab="Global Active Power (kilowatts)"))
dev.off()