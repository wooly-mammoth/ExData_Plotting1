# Plots
# --------------------------------------------------------------------
setwd("Z:/SWISSCOM_AG/COURSES/eTraining_Courses/Coursera/Data_Science_Specialization/04_Exploratory_Data_Analysis/R_wd")

library(plyr)
# rough estimate of memory of the dataset: The dataset has 2,075,259 rows and 9 columns: 2,075,259*9*8 bytes/numeric =
# = 149418648 bytes = (149418648 bytes)/(2^20 bytes/MB) MB=  142.49 MB 

# Note that in this dataset missing values are coded as ?

# Load data -- 1st way
# CIdatain <- read.table("household_power_consumption.txt", sep = ";", header = TRUE, na.strings = "?") 

# part1 <- subset(UCIdatain, Date == "1/2/2007")
# part2 <- subset(UCIdatain, Date == "2/2/2007")
# all <- rbind(part1, part2)

# Load data -- 2nd way
# read data (only the part of the data needed for the analysis)
# dat1 <- read.table("household_power_consumption.txt", sep = ";", header = TRUE, na.strings = "?", skip = grep("1/2/2007", readLines("household_power_consumption.txt"))-2, nrow = 1440) 
# dat2 <- read.table("household_power_consumption.txt", sep = ";", header = TRUE, na.strings = "?", skip = grep("2/2/2007", readLines("household_power_consumption.txt"))-2, nrow = 1440) 
# or
dat <- read.table("household_power_consumption.txt", sep = ";", header = TRUE, na.strings = "?", skip = grep("1/2/2007", readLines("household_power_consumption.txt"))-2, nrow = 2880) 
colnames(dat) <- c("Date", "Time", "Global_active_power", "Global_reactive_power", "Voltage", "Global_intensity", "Sub_metering_1", "Sub_metering_2", "Sub_metering_3")
# You may find it useful to convert the Date and Time variables to Date/Time classes in R
# using the strptime()  and as.Date() functions.
# # 

# for both Time/Date
Sys.setenv(LANG = "en")
date <- as.Date(as.character(dat$Date), "%d/%m/%Y")
time <- as.character(dat$Time)
datetime <- strptime(paste(date, time), "%Y-%m-%d %H:%M:%S")

# replace Date and Time columns with datetime

data <- cbind(datetime, dat[, 3:9])

# to check:
sapply(data, class)
Sys.setenv(LANG = "en")
# create plots and save as png file


# plot 3: 
par(mfrow = c(1,1))
dev.set(2)

with(data, plot(datetime, Sub_metering_1, type = "l", ylab = "Energy sub metering", xlab = ""))
with(data, lines(datetime, Sub_metering_2, ylab = "", xlab = "", col = "red"))
with(data, lines(datetime, Sub_metering_3, ylab = "", xlab = "", col = "blue"))

legend("topright",  lty = c(1,1,1), col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

dev.cur()
dev.set(2)
dev.copy(png, file = "plot3.png")
dev.off()

