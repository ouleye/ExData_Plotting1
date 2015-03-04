Sys.setlocale("LC_TIME", "English")

###WARNINGS##
## The file household_power_consumption.txt must be in the working directory (unzipped)##
if(!file.exists("./household_power_consumption.txt")) 
        { print("'household_power_consumption.txt' is not in the working directory"); break}

# Load the data for 01/02/2007 and 02/02/2007.
DATA <- read.table(text = grep("^[1,2]/2/2007", readLines("household_power_consumption.txt"), value = TRUE),
        col.names = c("Date", "Time", "Global_active_power", "Global_reactive_power", "Voltage", "Global_intensity",
        "Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), sep = ";", header = TRUE)

#Concatenate the time and Date variable, change it to a date format.
DATA$Date <- strptime(paste(DATA$Date,DATA$Time), format='%d/%m/%Y %H:%M:%S')

#Remove TIme variable
DATA$Time <- NULL


# Create the plot in png format
png("plot1.png",width = 480, height = 480)
with(DATA,hist(Global_active_power,col="red", xlab = 'Global Active Power (kilowatts)', main='Global Active Power'))
dev.off()


