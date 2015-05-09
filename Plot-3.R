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

# Making a plot of DateTime v/s Sub metering 1,2,3 in the same graph
plot.new()
par(mfrow = c(1,1), cex = 1.0)
png(filename = "Plot-3.png")

with(power_consumption, plot(DateTime, Sub_metering_1, type = "l", xlab = "", ylab = "Energy Sub Metering", col = "black"))
lines(power_consumption$DateTime, power_consumption$Sub_metering_2, type = "l", col = "red")
lines(power_consumption$DateTime, power_consumption$Sub_metering_3, type = "l", col = "blue")
legend("topright", lty = 1, lwd = 2, col= c("black", "red", "blue"), legend = c("Sub_Meter_1", "Sub_Meter_2", "Sub_Meter_3"), )

# Saving the plot as a .png file in the wd and switching off the device to go back to windows()
dev.off()
