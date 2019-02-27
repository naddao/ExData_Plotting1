## Instructions
There are four R scripts to make a visualize of data from Individual household electric power consumption Data Set<a href="https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip">Electric power consumption</a> [20Mb]. All script for make visualization filter data only for 2 days(2007-02-01 and 2007-02-02) and make a plot from various measurement by time(original data was  sampling every 1 minute)

#### To run analysis
1. plot histogram of data from household global minute-averaged active power(kilowatt) and save output as "plot1.png"
`source("plot1.R")`
2. plot data of time vs household global minute-averaged active power(kilowatt) and save output as "plot2.png"
`source("plot2.R")`
3. plot data of time vs (energy sub-metering-1, energy sub-metering-2, energy sub-metering-3) in watt-hour of active energy and save output as "plot3.png". Descriptions of each mesurement available in README.md
`source("plot3.R")`
4. plot data of time vs household global minute-averaged ractive power(kilowatt) and save output as "plot4.png"
`source("plot4.R")`

#### Require library
> datasets, dplyr, data.table

#### Files
* <b>README.txt</b> - Detail of analysis process.
* <b>plot1.R</b> - R script to plot histogram of data from household global minute-averaged active power(kilowatt) and save output as "plot1.png"
* <b>plot1.png</b> - Visualize of plot from script plot1.R.
* <b>plot2.R</b> - R script to plot data of time vs household global minute-averaged active power(kilowatt) and save output as "plot2.png"
* <b>plot2.png</b> - Visualize of plot from script plot2.R.
* <b>plot3.R</b> - R script to plot data of time vs (energy sub-metering-1, energy sub-metering-2, energy sub-metering-3) in watt-hour of active energy and save output as "plot3.png".
* <b>plot3.png</b> - Visualize of plot from script plot3.R.
* <b>plot4.R</b> - R script to plot data of time vs household global minute-averaged ractive power(kilowatt) and save output as "plot4.png"
* <b>plot4.png</b> - Visualize of plot from script plot4.R.
* <b>extract_household_power_data.R</b> - R script which contains common function which have been used for all 4 ploting scripts. Example function such as filtered only specify mesurement and create temporary file, load data from temporary file, convert data string to POSIXct date object


#### Steps of analysis
1. Read data from dataset(9 columns available: Date, Time, Global_active_power, Global_reactive_power, Voltage, Global_intensity, Sub_metering_1, Sub_metering_2, Sub_metering_3)
2. Filter data only 2 days ("01/02/2007 00:00:00" to "03/02/2007 00:00:00")
3. From Filter data from 2, combine string of column Date and Time and make a new column "DateTime"
4. Select specify mesurements using for make a plot which is diffrent in each script(for example plot1.R select mesurement of Date, Time and Global_active_power)
5. Create temporary file for dataset which is result from 4, 5. Then remove unused variables to free up memory usage
6. Load data from temporary file( create from 5)
7. Generate label info use on DateTime axis by using start_time=01/02/2007 00:00:00 and end_time=03/02/2007 00:00:00 which label every 1 day. Results give sequence of weekday name as("Thu", "Fri", "Sat")
8. Make a plot from specify which is different in each R script and save graph output to *.png file



