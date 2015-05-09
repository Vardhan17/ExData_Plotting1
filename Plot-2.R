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

# Making a plot of DateTime v/s Global Active Power
plot.new()
par(mfrow = c(1,1), cex =1)
with(power_consumption, plot(DateTime, Global_active_power, pch = ".", type = "l", xlab = "", ylab = "Global Active Power (kilowatts)"))



# Saving the plot as a .png file in the wd
dev.copy(png, file = "Plot-2.png")
dev.off()

