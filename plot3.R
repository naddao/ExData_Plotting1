##########################################################
## R script to extract data from dataset of electric power consumption in one household which was recored every one-minute ("household_power_consumption.txt").
## Process in script is to filter data only 2 days(2007-02-01 and 2007-02-02) from datasets, 
## then making a line graphs to visualize data and save plot result as a picture(png format)
##
## line graph : DateTime vs (Sub_metering_1(black line), Sub_metering_1(red line), Sub_metering_1(blue line) )
###########################################################

library(data.table)
library(dplyr)
library(datasets)
source("extract_household_power_data.R")

source_file <- "household_power_consumption.txt"
selected_columns <- c("Date", "Time", "Sub_metering_1", "Sub_metering_2", "Sub_metering_3")
process_columns <- c("DateTime", "Sub_metering_1", "Sub_metering_2", "Sub_metering_3")

# extract only data using for plot 
plot3_data <- extract_plotting_data(source_file, selected_columns, process_columns)

# filter data only 2 specify days
print("----- Filter data only for 2 specify days ------")
start_time <- convert_to_date("01/02/2007 00:00:00")
end_time   <- convert_to_date("03/02/2007 00:00:00")
filtered_data <- subset(plot3_data, (DateTime>=start_time & DateTime<=end_time)) 

# generate name of weekdays using for label on x-axis(DateTime)
print("----- Generate label of name of weekdays using for label on DateTime axis ------")
weekday_seq <- seq(start_time, end_time, by="1 day")

# remove unused variable to free up memory
rm(plot3_data, start_time, end_time)

# plot data as line graph
print("----- plot data ------")
png("plot3.png", width=480, height=480, bg=NA)
par(mfrow=c(1, 1))
with(
    filtered_data, {
        
        # plot data between time and Sub metering
        plot(x=DateTime, y=Sub_metering_1, col="black", xaxt="n", xlab = "", ylab="Energy sub metering", main = "", type="l")
        lines(x=DateTime, y=Sub_metering_2, col="red")
        lines(x=DateTime, y=Sub_metering_3, col="blue")
        axis(side=1, at=weekday_seq, labels = get_weekday(weekday_seq))
        legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
               lty = 1, xjust = 1, yjust = 1, col = c("black", "red", "blue")
        )
    }
)
dev.off()

# remove unused variable to free up memory
rm(filtered_data, weekday_seq)