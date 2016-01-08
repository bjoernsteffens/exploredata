plot4 <- function() {
    
    #
    # Plot 1
    #
    library(data.table)
    df_a <- fread("household_power_consumption.txt", sep = ";", header = TRUE, na.strings = "?") #, colClasses = c("Character","Character", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric"))
    
    # Transform to a data.frame and use only complete values
    # and subset the data.frame. (fread + subset) mush faster than anything else
    df_a <- as.data.frame(df_a[complete.cases(df_a),])
    df_a <- df_a[df_a$Date=='1/2/2007' | df_a$Date=='2/2/2007',]
    
    # Fix the date and time column and create a new variable
    # If you do not convert this with strptime when the plot
    # function will not understand this. That is the key to 
    # this solution.
    df_a$DateTime <- strptime(paste(df_a$Date, df_a$Time, sep = " "), format = "%d/%m/%Y %H:%M:%S")

    #
    # Setup plotting area 2x2 + Fix for legend cropping
    png(filename = "plot4.png", width = 960, height = 960)
    par(mfrow = c(2,2), oma=c(0,0,2,0))
    plot(df_a$DateTime,df_a$Global_active_power, type = "l", xlab = "", ylab = "Global Active Power (kilowatts)")

    #
    # Plot 2
    #
    plot(df_a$DateTime,df_a$Voltage, type = "l", xlab = "datetime", ylab = "Voltage")
    
    #
    # Plot 3
    #

    # First line with black
    plot(df_a$DateTime,df_a$Sub_metering_1, type = "l", xlab = "", ylab = "Energy sub metering")
    
    #Second line in addition with blue
    par(col = "blue")
    lines(df_a$DateTime,df_a$Sub_metering_2, col = "blue")
    
    #Second line in addition with blue
    lines(df_a$DateTime,df_a$Sub_metering_3, col = "red")
    
    # Adding legend and title
    par(col = "black")
    legend("topright", c("Sub_metering1","Sub_metering2","Sub_metering3"), pch = c(45,45,45), col = c("black","red","blue"), lty = 1, lwd  = 4)  

    #
    # Plot 4
    #
    plot(df_a$DateTime,df_a$Global_reactive_power, type = "l", xlab = "datetime", ylab = "Global_reactive_power")
            
    #Adding Global Title
    mtext("Plot4", outer = TRUE, col = "black", cex = 2, adj = 0, padj = 0)
    dev.off()
    
}
