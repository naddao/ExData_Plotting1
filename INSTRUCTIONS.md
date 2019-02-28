## Instructions
There are four R scripts to make a visualize of data from Individual household electric power consumption Data Set<a href="https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip">Electric power consumption</a> [20Mb]. All script for make visualization filter data only for 2 days(2007-02-01 and 2007-02-02) and make a plot from various measurement by time(original data was  sampling every 1 minute)

#### To run analysis
1. plot histogram of data from household global minute-averaged active power(kilowatt) and save output as "plot1.png"
`source("plot1.R")`
2. plot data of time vs household global minute-averaged active power(kilowatt) and save output as "plot2.png"
`source("plot2.R")`
3. plot data of time vs (energy sub-metering-1, energy sub-metering-2, energy sub-metering-3) in watt-hour of active energy and save output as "plot3.png". Descriptions of each mesurement available in "README.md"
`source("plot3.R")`
4. plot data of time vs household global minute-averaged reactive power(kilowatt) and save output as "plot4.png"
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
1. Read data from dataset(9 measurements available: <b>"Date"</b>, <b>"Time"</b>, <b>"Global_active_power"</b>, <b>"Global_reactive_power"</b>, <b>"Voltage"</b>, <b>"Global_intensity"</b>, <b>"Sub_metering_1"</b>, <b>"Sub_metering_2"</b>, <b>"Sub_metering_3"</b>)
2. Filter data only 2 days (<b>"01/02/2007 00:00:00"</b> to <b>"03/02/2007 00:00:00"</b>)
3. From Filter data from 2, combine string from column <b>"Date"</b> and <b>"Time"</b> , then make a new column <b>"DateTime"</b>
4. Select specify mesurements using for make a plot which is diffrent in each script(for example plot1.R select mesurements of <b>"Date"</b>, <b>"Time"</b> and <b>"Global_active_power"</b>)
5. Create temporary file for dataset which is result from 4. Then clear unused variables to free up memory usage.
6. Load data from temporary file( create from 5) which will contain only measurements which will be used in each plot.
7. Generate label info use on DateTime (x-axis) by using <b>start_time="01/02/2007 00:00:00"</b> and <b>end_time="03/02/2007 00:00:00"</b> which wiil mark a label every 1 day. Results give sequence of weekday name as <b>("Thu", "Fri", "Sat")</b>
8. Make a plot from specify measurement which will be different in each R script and save graph output to <b>*.png</b> file



