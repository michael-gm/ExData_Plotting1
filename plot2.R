#Getting data
data = read.table("household_power_consumption.txt", sep=";" , header = TRUE)
head(data)
df = as.data.frame(data)
#rm(data)
head(df)
tbl = tbl_df(df)
#rm(df)

#Convert Date
tbl$Date = strptime(tbl$Date, format = "%d/%m/%Y")
tbl$Date
tbl$Date = as.Date(tbl$Date)

#filter Data
tbl_filtered = filter(tbl, Date >= "2007-02-01")
head(tbl_filtered)
tbl_filtered
tbl_filtered = filter(tbl_filtered, Date <= "2007-02-02")
head(tbl_filtered)
tbl_filtered

#Convert Date again
tbl_filtered$DateTime = strptime(paste(tbl_filtered$Date, tbl_filtered$Time), "%Y-%m-%d %H:%M:%S")

#Filter Column to plot
tbl_plot_data = select(tbl_filtered, DateTime, Global_active_power)
head(tbl_plot_data)

#plot
tbl_plot_data$DateTime = as.POSIXct(tbl_plot_data$DateTime)
png(filename="C:/Users/Master/Documents/Coursera/Data_Science/4Exploratory_Data_Analysis/Assignments/Week1/ExData_Plotting1/plot2.png", height = 480, width = 480)
plot(as.numeric(tbl_plot_data$Global_active_power)/1000 ~ tbl_plot_data$DateTime, type = "l", ylab = "Global Active Power (kilowatts)", xlab = "")
dev.off()
