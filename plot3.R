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
tbl_plot_data = select(tbl_filtered, DateTime, Sub_metering_1, Sub_metering_2, Sub_metering_3)
head(tbl_plot_data)

#plot
tbl_plot_data$DateTime = as.POSIXct(tbl_plot_data$DateTime)
png(filename="C:/Users/Master/Documents/Coursera/Data_Science/4Exploratory_Data_Analysis/Assignments/Week1/ExData_Plotting1/plot3.png", height = 480, width = 480)
plot(as.numeric(tbl_plot_data$Sub_metering_1) ~ tbl_plot_data$DateTime, type = "l", ylab = "Energy sub metering", xlab = "")
lines(as.numeric(tbl_plot_data$Sub_metering_2) ~ tbl_plot_data$DateTime, col = "Red")
lines(as.numeric(tbl_plot_data$Sub_metering_3) ~ tbl_plot_data$DateTime, col = "Blue")
legend ("topright", lty = 1, col = c("black", "red", "blue"), legend = c("Submetering_1", "Submetering_2", "Submetering_3"))
dev.off()
