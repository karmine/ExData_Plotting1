# This function plots the household sub_meterings as a function of the Time for three days. 
# It doesn't have any parameters.
# It returns the plot in one png file.

plot3 <- function() {
  
  # Including libraries
  # library(graphics)
  # library(grDevices)
  
  # Reading household data
  fDir <- paste(getwd(), "/", "household_power_consumption", ".txt", sep="")
  fData <- read.table(fDir, nrow = 2100000, sep = ";", header = TRUE, na.string = "?")
  
  # reading Febrary 1 and Febrary 2
  fDataDate <- split(fData, fData$Date)
  fDataDate1 <- fDataDate$"1/2/2007"
  fDataDate2 <- fDataDate$"2/2/2007"
  fDataDate <- rbind(fDataDate1, fDataDate2)
  
  # converting variables Date and Time in Date/Time classes. The result is stored in a new variable call DateTime
  fDataDate$DateTime <- strptime( paste( fDataDate$Date, fDataDate$Time ), "%d/%m/%Y %H:%M:%S" )
  
  # Creating png file
  png(file = "plot3.png") 
  plot(fDataDate$DateTime, fDataDate$Sub_metering_1, axes = FALSE, type = "l", xlab = NA, ylab = "Energy sub metering", col = "black")
  lines(fDataDate$DateTime, fDataDate$Sub_metering_2, col = "red")
  lines(fDataDate$DateTime, fDataDate$Sub_metering_3, col = "blue")
  box()
  legend("topright", pch = "-", lty = 1, col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
  Thursday <-as.numeric(as.POSIXct(strptime("1/2/2007 00:00:00", "%d/%m/%Y %H:%M:%S")))
  Friday <- as.numeric(as.POSIXct(strptime("2/2/2007 00:00:00", "%d/%m/%Y %H:%M:%S")))
  Saturday <- as.numeric(as.POSIXct(strptime("3/2/2007 00:00:00", "%d/%m/%Y %H:%M:%S")))
  axis(1, at = c(Thursday, Friday, Saturday),  lab = c("Thu", "Fri", "Sat"))
  axis(2, at = c(0, 10, 20, 30), lab=c("0", "10", "20", "30"))
  dev.off()
  
}
