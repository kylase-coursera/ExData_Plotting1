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
# Use lubridate for date parsing
library(lubridate)

d <- tbl_df(data)

rm("data")

# Filter only the specified date range
# then process the date and time column into one new column called DateTime
# Select global active power data along with DateTime
selected_data <- filter(d, Date == "2/2/2007" | Date == '1/2/2007') %>% 
  mutate(DateTime = dmy_hms(paste(Date, Time))) %>%
    select(Global_active_power, DateTime)

# Plot the image and save it as plot2.png
png('./plot2.png')
plot(selected_data$DateTime, selected_data$Global_active_power, type = "l", xlab = "", ylab = "Global Active Power (kilowatts)")
dev.off()