# Import helper function to download file
source("get_file.R")

file <- get_file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", "./data", "data.zip", unzip = TRUE)

# Extract the file
unzip(file)

data_file_path <- file.path("./household_power_consumption.txt")

# Read the raw data into data
data <- read.table(data_file_path, header = TRUE, sep = ";", colClasses = c(rep("character",2), rep("numeric",7)), na.strings = "?")

# Use dplyr for data manipulation
library(dplyr)

d <- tbl_df(data)

rm("data")

# Filter only the specified date range
selected_date_data <- filter(d, Date == "2/2/2007" | Date == '1/2/2007')

# Plot the image and save it as plot1.png
png('./plot1.png')
hist(selected_date_data$Global_active_power, col = "red", main = "Global Active Power", xlab = "Global Active Power (kilowatts)")
dev.off()