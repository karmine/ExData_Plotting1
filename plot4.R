# This function plots the household the global active power, the global reactive power, the Voltage and the energy Sub_metering                                 
# as a function of the Time for three days.  
# It doesn't have any parameters.
# It returns the plot in one png file.

plot4 <- function() {
  
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
  png(file = "plot4.png") 
  par(mfrow = c(2, 2)) 
  with(fDataDate, {
    plot(fDataDate$DateTime, fDataDate$Global_active_power, axes = FALSE,type = "l", xlab = NA, ylab = "Global Active Power")
    box()
    Thursday <-as.numeric(as.POSIXct(strptime("1/2/2007 00:00:00", "%d/%m/%Y %H:%M:%S")))
    Friday <- as.numeric(as.POSIXct(strptime("2/2/2007 00:00:00", "%d/%m/%Y %H:%M:%S")))
    Saturday <- as.numeric(as.POSIXct(strptime("3/2/2007 00:00:00", "%d/%m/%Y %H:%M:%S")))
    axis(1, at = c(Thursday, Friday, Saturday),  lab = c("Thu", "Fri", "Sat"))
    axis(2, at = c(0, 2, 4, 6), lab=c("0", "2", "4", "6"))
    plot(fDataDate$DateTime, fDataDate$Voltage, lwd = 1, axes = FALSE, type = "l", xlab = "datetime", ylab = "Voltage")
    box()
    axis(1, at = c(Thursday, Friday, Saturday),  lab = c("Thu", "Fri", "Sat"))
    axis(2, at = c(234, 238, 242, 246), lab=c("234", "238", "242", "246"))
    with(fDataDate, {
      plot(fDataDate$DateTime, fDataDate$Sub_metering_1, axes = FALSE, type = "l", xlab = NA, ylab = "Energy sub metering", col = "black")
      lines(fDataDate$DateTime, fDataDate$Sub_metering_2, col = "red")
      lines(fDataDate$DateTime, fDataDate$Sub_metering_3, col = "blue")
      legend("topright", pch = "-", cex = 0.8, box.lty = 0, col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
      box()
      axis(1, at = c(Thursday, Friday, Saturday),  lab = c("Thu", "Fri", "Sat"))
      axis(2, at = c(0, 10, 20, 30), lab=c("0", "10", "20", "30"))
    })
    plot(fDataDate$DateTime, fDataDate$Global_reactive_power, lwd = 1, axes = FALSE, type = "l", xlab = "datetime", ylab = "Global_reactive_power")
    box()
    axis(1, at = c(Thursday, Friday, Saturday),  lab = c("Thu", "Fri", "Sat"))
  })
  dev.off()
  
}
