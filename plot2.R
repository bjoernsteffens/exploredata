plot2 <- function() {
    
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
    
    par(oma=c(0,0,2,0))
    plot(df_a$DateTime,df_a$Global_active_power, type = "l", xlab = "", ylab = "Global Active Power (kilowatts)")
    mtext("Plot2", outer = TRUE, col = "black", cex = 2, adj = 0, padj = 0)
    
    # Copy to file
    dev.copy(device = png, "plot2.png")
    dev.off()
    
}