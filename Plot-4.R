# Reading of fixed rows from the .txt file as per the dates 1/2/2007 & 2/2/2007, which reads 2880 rows of subsetted data
power_consumption <- read.table("./exdata-data-household_power_consumption/household_power_consumption.txt", sep =";", stringsAsFactors = F, skip = 66637, nrows = 2880)

# Naming the column variable as per the original .txt file using nrows = 1
name <- read.table("./exdata-data-household_power_consumption/household_power_consumption.txt", sep =";", stringsAsFactors = F, nrows = 1)
names(power_consumption) <- name


# Merging the Date & Time column from the dataset to form a POSIXct type new variable "DateTime"
library(lubridate)
library(dplyr)
power_consumption[ ,1] <- dmy(power_consumption[ ,1])
power_consumption <- power_consumption %>% 
  mutate(DateTime = as.POSIXct(paste(Date,Time), tz = "UTC"))

# Making a plots 1-4 by declaring png file in the starting such that mfrow are adjusted in the png file
png("plot-4.png")
plot.new()
par(mfrow = c(2,2), cex = 0.8)

# plot 1
plot(power_consumption$DateTime, power_consumption$Global_active_power, type = "l", xlab = "", ylab = "Global Active Power (kilowatts)")

# plot 2
plot(power_consumption$DateTime, power_consumption$Voltage, type = "l", xlab = "datetime", ylab = "Voltage")

# plot 3
with(power_consumption, plot(DateTime, Sub_metering_1, type = "l", xlab = "", ylab = "Energy Sub Metering", col = "black"))
lines(power_consumption$DateTime, power_consumption$Sub_metering_2, type = "l", col = "red")
lines(power_consumption$DateTime, power_consumption$Sub_metering_3, type = "l", col = "blue")
legend("topright", lty = 1, lwd = 2, cex = 0.7, col= c("black", "red", "blue"), legend = c("Sub Metering 1", "Sub Metering 2", "Sub Metering 3"))

# plot 4
plot(power_consumption$DateTime, power_consumption$Global_reactive_power, type = "l", xlab = "datetime", ylab = "Global Reactive Power" )


# Saving the plot as a .png file in the wd
dev.off()