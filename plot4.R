##########################################################
## R script to extract data from dataset of electric power consumption in one household which was recored every one-minute ("household_power_consumption.txt").
## Process in script is to filter data only 2 days(2007-02-01 and 2007-02-02) from datasets, 
## then making 4 line graphs to visualize data and save plot result as a picture(png format)
##
## line graph 1 : DateTime vs Global active power
## line graph 2 : DateTime vs Voltage
## line graph 3 : DateTime vs Sub metering(1, 2, 3) 
## line graph 4 : DateTime vs Global reactive power
###########################################################

library(data.table)
library(dplyr)
library(datasets)
source("extract_household_power_data.R")

source_file <- "household_power_consumption.txt"
selected_columns <- c("Date", "Time", "Global_active_power", "Global_reactive_power", "Voltage", "Sub_metering_1", "Sub_metering_2", "Sub_metering_3")
process_columns <- c("DateTime", "Global_active_power", "Global_reactive_power", "Voltage", "Sub_metering_1", "Sub_metering_2", "Sub_metering_3")

# extract only data using for plot 
plot4_data <- extract_plotting_data(source_file, selected_columns, process_columns)

# filter data only 2 specify days
print("----- Filter data only for 2 specify days ------")
start_time <- convert_to_date("01/02/2007 00:00:00")
end_time   <- convert_to_date("03/02/2007 00:00:00")
filtered_data <- subset(plot4_data, (DateTime>=start_time & DateTime<=end_time)) 

# generate name of weekdays using for label on x-axis(DateTime)
print("----- Generate label of name of weekdays using for label on DateTime axis ------")
weekday_seq <- seq(start_time, end_time, by="1 day")

# remove unused variable to free up memory
rm(plot4_data, start_time, end_time)

# plot data 
print("----- Plotting data ------")
png("plot4.png", width=480, height=480, bg=NA)
par(mfrow=c(2, 2))
with(filtered_data,
     {
         # plot data between time and global active power
         plot(x=DateTime, y=Global_active_power, xaxt="n", xlab = "", ylab="Global Active Power (kilowatts)", main = "", type="l")
         axis(side=1, at=weekday_seq, labels = get_weekday(weekday_seq)) #, line=2, tick=FALSE)
         
         # plot data between time and voltage
         plot(x=DateTime, y=Voltage, xaxt="n", xlab = "dateime", ylab="Voltage", main = "", type="l")
         axis(side=1, at=weekday_seq, labels = get_weekday(weekday_seq)) #, line=2, tick=FALSE)
         
         # plot data between time and Sub metering
         plot(x=DateTime, y=Sub_metering_1, col="black", xaxt="n", xlab = "", ylab="Energy sub metering", main = "", type="l")
         lines(x=DateTime, y=Sub_metering_2, col="red")
         lines(x=DateTime, y=Sub_metering_3, col="blue")
         axis(side=1, at=weekday_seq, labels = get_weekday(weekday_seq)) #, line=2, tick=FALSE)
         legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
                lty = 1, xjust = 1, yjust = 1, col = c("black", "red", "blue"), bty = "n"
         )
         
         # plot data between time and Global reactive power
         plot(x=DateTime, y=Global_reactive_power, xaxt="n", xlab = "datetime", ylab="Global_reactive_power", main = "", type="l")
         axis(side=1, at=weekday_seq, labels = get_weekday(weekday_seq)) #, line=2, tick=FALSE)
})
dev.off()

rm(filtered_data, weekday_seq)