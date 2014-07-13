# This function plots the household global minute-averaged active power 
# It doesn't have any parameters.
# It returns the histogram in one png file.

plot1 <- function() {
  
  # Including libraries
  library(graphics)
  library(grDevices)
  
  # Reading household data
  fDir <- paste(getwd(), "/", "household_power_consumption", ".txt", sep="")
  fData <- read.csv(fDir, nrow = 2100000, sep = ";", header = TRUE, na.string = "?")
  
  # reading Febrary 1 and Febrary 2
  fDataDate <- split(fData, fData$Date)
  fDataDate1 <- fDataDate$"1/2/2007"
  fDataDate2 <- fDataDate$"2/2/2007"
  fDataDate <- rbind(fDataDate1, fDataDate2)
  
  # Making histogram
  h <-  hist(fDataDate$Global_active_power)
  h$breaks <- h$breaks/max(h$breaks)*6 # Normalize x label to 6   
  
  # Creating png file
  png( file = "plot1.png") 
  plot(h,col = "red", main = "Global Active Power", xlab = "Global Active Power (kilowatts)")
  dev.off()
  
}
  

