##########################################################
## R script to extract data from dataset of electric power consumption in one household which was recored every one-minute ("household_power_consumption.txt").
## Process in script is to filter data only 2 days(2007-02-01 and 2007-02-02) from datasets, 
## then making a histogram to visualize data and save plot result as a picture(png format)
##
## histogram : frequency of Global active power
###########################################################

source("extract_household_power_data.R")

# download datasets and extract data
dataset_url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
prefix_path <- download_datasets(dataset_url)

# specify dataset file path and specify measurements to be selected
dataset_file <- paste(prefix_path, "household_power_consumption.txt", sep="")
selected_columns <- c("Date", "Time", "Global_active_power")
process_columns <- c("DateTime", "Global_active_power")

# extract only data using for plot 
plot2_data <- extract_plotting_data(dataset_file, selected_columns, process_columns)

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

print("----- Plot data ------")
png("plot1.png", width=480, height=480, bg=NA)
par(mfrow=c(1, 1))
with(filtered_data, {
    # plot histogram of global active power
    hist(Global_active_power, col = "red", xlab="Global Active Power (kilowatts)",main = "Global Active Power")  
})
dev.off()

# remove unused variable to free up memory
rm(filtered_data, weekday_seq)
