plot3 <- function() {
    
    library(data.table)
    df_a <- fread("household_power_consumption.txt", sep = ";", header = TRUE, na.strings = "?") #, colClasses = c("Character","Character", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric"))
    
    # Transform to a data.frame and use only complete values
    # and subset the data.frame
    df_a <- as.data.frame(df_a[complete.cases(df_a),])
    df_a <- df_a[df_a$Date=='1/2/2007' | df_a$Date=='2/2/2007',]
    
    # Fix the date and time column and create a new variable
    # If you do not convert this with strptime when the plot
    # function will not understand this. That is the key to 
    # this solution.
    df_a$DateTime <- strptime(paste(df_a$Date, df_a$Time, sep = " "), format = "%d/%m/%Y %H:%M:%S")
    
    # Fix for legend cropping
    png(filename = "plot3.png", width = 480, height = 480)
    
    par(oma=c(0,0,2,0))
    # First line with black
    plot(df_a$DateTime,df_a$Sub_metering_1, type = "l", xlab = "", ylab = "Energy sub metering")
    
    #Second line in addition with blue
    par(new = TRUE, col = "blue")
    lines(df_a$DateTime,df_a$Sub_metering_2, col = "blue")
    
    #Second line in addition with blue
    par(new = TRUE)
    lines(df_a$DateTime,df_a$Sub_metering_3, col = "red")
   
    # Adding legend and title
    par(col = "black")
    legend("topright", c("Sub_metering1","Sub_metering2","Sub_metering3"), pch = c(45,45,45), col = c("black","red","blue"), lty = 1, lwd  = 4)  
    mtext("Plot3", outer = TRUE, col = "black", cex = 2, adj = 0, padj = 0)
    
    dev.off()
    
}
