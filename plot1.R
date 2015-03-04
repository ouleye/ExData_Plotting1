Sys.setlocale("LC_TIME", "English")

## if the file is not in the working directory, it is donwloaded and unzipped##
if(!file.exists("./household_power_consumption.txt")) 
        { download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",
                                destfile = "household_power_consumption.zip")
          unzip("./household_power_consumption.zip")
        }

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


