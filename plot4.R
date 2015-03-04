Sys.setlocale("LC_TIME", "English")

###WARNINGS##
## The file household_power_consumption.txt must be in the working directory (unzipped)##
if(!file.exists("./household_power_consumption.txt")) { print("'household_power_consumption.txt' is not in the working directory"); break}

# Load the data for 01/02/2007 and 02/02/2007.
DATA <- read.table(text = grep("^[1,2]/2/2007", readLines("household_power_consumption.txt"), value = TRUE),
                   col.names = c("Date", "Time", "Global_active_power", "Global_reactive_power", "Voltage", "Global_intensity",
                                 "Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), sep = ";", header = TRUE)

#Concatenate the time and Date variable, change it to a date format.
DATA$Date <- strptime(paste(DATA$Date,DATA$Time), format='%d/%m/%Y %H:%M:%S')

#Remove TIme variable
DATA$Time <- NULL


# Create the plot in png format
png("plot4.png",width = 480, height = 480)
#set the display parameters        
par (mfrow = c(2,2), mar= c(4,4,2,2))

#I notice that the plot2 and plot3 are to be displayed in this graph, I will  not use the plot2.R and Plot3.R in this script
# because there are slight difference in the dispay ( differents label, no box around legend.)

#Add the up_left plot
with(DATA,plot(Date,Global_active_power, ylab = 'Global Active Power',type='l',xlab=''))

#Add the up_righ plot
with(DATA,plot(Date,Voltage, ylab = 'Voltage',type='l',xlab = 'datetime'))

#Add the down_left plot
with(DATA,plot(Date,Sub_metering_1, ylab = 'Energy sub metering',type='n',xlab=''))
with(DATA,points(Date,Sub_metering_1, col="black", type="l"))
with(DATA,points(Date,Sub_metering_2, col="red", type="l"))
with(DATA,points(Date,Sub_metering_3, col="blue", type="l"))
legend("topright", col = c('black','red','blue'), legend = c('Sub_metering_1','Sub_metering_2','Sub_metering_3'),lty=c(1,1),bty="n" )

#Add the down_right plot
with(DATA,plot(Date,Global_reactive_power,type='l',xlab = 'datetime'))

dev.off()