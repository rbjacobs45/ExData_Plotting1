rm(list=ls()) # Cleanup
library(dplyr)
setwd("C:/Users/Ryan/Documents/Coursera/Exploratory Data Analysis/Course Project 1/ExData_Plotting1/submission")

# Specify column names for data frame
names <- c("Date", "Time", "Global_active_power", "Global_reactive_power", 
           "Voltage", "Global_intensity", "Sub_metering_1", "Sub_metering_2", 
           "Sub_metering_3")

# Load electrical power consumption data from dates 2007-02-01 and 2007-02-02
data <- read.table("../../household_power_consumption.txt", header = FALSE, 
                   sep = ";", col.names = names, skip = 66637, nrows = 2880)

# Create a new variable datetime with POSIXct format, add it to the data frame,
# and drop the Date and Time variables
data <- mutate(data, datetime = as.POSIXct(paste(Date, Time), tz = "", 
                                           format = "%d/%m/%Y %H:%M:%S")) %>% 
        select(datetime, Global_active_power:Sub_metering_3)

# Open png device, generate line plot, and close the device
png("plot3.png", width = 480, height = 480, units = "px")
plot(data$datetime, data$Sub_metering_1, type = "l", xlab = "",
     ylab = "Energy sub metering")
lines(data$datetime, data$Sub_metering_2, col = "red")
lines(data$datetime, data$Sub_metering_3, col = "blue")
legend("topright", legend = names[7:9], col = c("black", "red", "blue"), 
       lty = 1)
dev.off()