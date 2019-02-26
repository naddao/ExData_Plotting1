library(data.table)
library(dplyr)

# define variable for using in extracting data
date_format <- "%d/%m/%Y %H:%M:%S"
timezone <- "GMT"
days <- c("Mon", "Tue", "Wed","Thu", "Fri", "Sat", "Sun")
temporary_file <- "plot_data.csv"

# function to get number of which day of the week
get_weekday = function(x){
    week_day_no <- as.numeric(strftime(x, "%w"))
    days[week_day_no]
}

# function to find index of column from specify column name
get_column_index = function(column_name, columns){
    which(columns==column_name)
}

# function to extract only specify column using for plot data and create new temporary file (for memory saving purpose)
create_plot_data_file = function(source_file, selected_columns, process_columns){
    
    # read data from original source file and combine string from column Date and Time
    print("----- read original data and select only data used for plot and save as a temporary csv file -----")
    data <- read.table(source_file, header=T, sep=";", na.strings = "?", colClasses = c("character", "character", "numeric",  "numeric",  "numeric" , "numeric" , "numeric" , "numeric"))
    data <- subset(data, (Date=="1/2/2007" | Date=="2/2/2007" |  Date=="3/2/2007") )
    d <- data$Date
    t <- data$Time
    dt <- mapply(FUN=function(d, t){ paste(d, t, sep=" ") }, d, t)
    
    # get column index to be selected
    selected_column_idx <- c()
    idx = 1
    for (column_name in selected_columns){
        if(idx > 2){
            column_idx <- get_column_index(column_name, colnames(data))
            selected_column_idx <- append(selected_column_idx, column_idx)
        }
        idx <- idx+1
    }

    # create data for plotting and save to temporary file
    plot_data <- cbind(dt, data[, selected_column_idx])
    colnames(plot_data) <- process_columns
    write.table(file=temporary_file, x=plot_data, sep = ",", row.names = F)
    
    # free up unused variable to save memory
    rm(data, d, t, dt, plot_data)
}

# read data using for plot by specify selected column
extract_plotting_data = function( source_file, selected_columns, process_columns){
    
    # extract only columns using for plot and create temporary file (to save memory usage)
    print("-------  Extract only columns using in plot and save to temporary file  -------")
    create_plot_data_file(source_file, selected_columns, process_columns)
    
    # read plot data from temporary file
    plot_data <- read.table(temporary_file, sep=",", header = TRUE)
    
    # convert date string as POSIXct
    plot_data$DateTime <- lapply(plot_data$DateTime, FUN=function(x){  as.POSIXct(strptime( x , date_format, tz=timezone)) } )

    # delete temporary file
    unlink(temporary_file)
    
    plot_data
}

# convert date string to POSIXct date
convert_to_date = function(str_date){
    as.POSIXct(strptime(str_date, date_format, tz=timezone))
}