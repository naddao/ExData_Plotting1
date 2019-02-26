##########################################################
## R script to extract data from dataset of electric power consumption in one household which was recored every one-minute ("household_power_consumption.txt").
## Process in script is to filter data only 2 days(2007-02-01 and 2007-02-02) from datasets, 
## then making a line graph to visualize data and save plot result as a picture(png format)
##
## line graph : DateTime vs Global active power
###########################################################

library(data.table)
library(dplyr)
library(datasets)
source("extract_household_power_data.R")

source_file <- "household_power_consumption.txt"
selected_columns <- c("Date", "Time", "Global_active_power")
process_columns <- c("DateTime", "Global_active_power")

# extract only data using for plot 
plot2_data <- extract_plotting_data(source_file, selected_columns, process_columns)

# filter data only 2 specify days
print("----- Filter data only for 2 specify days ------")
start_time <- convert_to_date("01/02/2007 00:00:00")
end_time   <- convert_to_date("03/02/2007 00:00:00")
filtered_data <- subset(plot2_data, (DateTime>=start_time & DateTime<=end_time)) 

# generate name of weekdays using for label on x-axis(DateTime)
print("----- Generate label of name of weekdays using for label on DateTime axis ------")
weekday_seq <- seq(start_time, end_time, by="1 day")

# remove unused variable to free up memory
rm(plot2_data, start_time, end_time)

# plot data as line graph
print("----- plot data ------")
png("plot2.png", width=480, height=480, bg=NA)
par(mfrow=c(1, 1))
with(filtered_data, {
    
    # plot data between time and global active power
    plot(x=DateTime, y=Global_active_power, xaxt="n", xlab = "", ylab="Global Active Power (kilowatts)", main = "", type="l")
    axis(side=1, at=weekday_seq, labels = get_weekday(weekday_seq)) 
})
dev.off()

rm(filtered_data, weekday_seq)