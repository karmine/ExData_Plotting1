# This function plots the household global minute-averaged active power as a function of the Time for three days. 
# It doesn't have any parameters.
# It returns the plot in one png file.

plot2 <- function() {
  
  # Including libraries
   library(graphics)
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
  png(file = "plot2.png") 
  plot(fDataDate$DateTime, fDataDate$Global_active_power, axes = FALSE, type = "l", xlab = NA, ylab = "Global Active Power (kilowatts)", lwd = 1)
  Thursday <-as.numeric(as.POSIXct(strptime("1/2/2007 00:00:00", "%d/%m/%Y %H:%M:%S")))
  Friday <- as.numeric(as.POSIXct(strptime("2/2/2007 00:00:00", "%d/%m/%Y %H:%M:%S")))
  Saturday <- as.numeric(as.POSIXct(strptime("3/2/2007 00:00:00", "%d/%m/%Y %H:%M:%S")))
  axis(1, at = c(Thursday, Friday, Saturday),  lab = c("Thu", "Fri", "Sat"))
  axis(2, at = c(0, 2, 4, 6), lab=c("0", "2", "4", "6"))
  box()
  dev.off()
  
}
