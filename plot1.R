plot1 <- function() {
    
    # How much memory do I need to read the full file roughly?
    # Numeric = 8 bytes
    # Char = 8 bytes
    #
    # Numeric values 2,075,259 * 7 = 13 MB
    # Characters
    #   Date = "dd/mm/YYYY" => 10 * 8 * 2,075,259 = 158 MB
    #   Time = "hh:mm:ss" => 8 * 8 * 2,075,259 = 126 MB
    #
    # Total Memory = 13 + 158 + 126 MB = 297 MB < 64 GB, we're ok.
    
    # Check out the data set
    library(data.table)
    df_a <- fread("household_power_consumption.txt", sep = ";", header = TRUE, na.strings = "?", colClasses = c("Date","Time", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric"))
    dim(df_a)
    names(df_a)
    sapply(df_a, class)
    summary(df_a)
    
    #
    # working with fread and subsetting was faster than filtering while
    # reading. So in my case I had enough memory so I would do fread.
    # However documenting the code here for the filtered read as I 
    # may need that in the future
    
    # Transform to a data.frame and use only complete values
    # and subset the data.frame
    df_b <- as.data.frame(df_a[complete.cases(df_a),])
    df_b <- df_b[df_b$Date=='1/2/2007' | df_b$Date=='2/2/2007',]
    hist(df_b$Global_active_power, xlab = "Global Active Power (kilowatts)", main = "Global Active Power", col = "red")    
    
    
    # Read the file with filters and visualize the plot before
    # sending to file
    install.packages("sqldf")
    library(sqldf)
    df_aa <- read.csv.sql("household_power_consumption.txt", sep = ";", header = TRUE, "select * from file where Date='1/2/2007' or Date='2/2/2007'")
    
    par(oma=c(0,0,2,0))
    hist(df_aa$Global_active_power, xlab = "Global Active Power (kilowatts)", main = "Global Active Power", col = "red")    
    mtext("Plot1", outer = TRUE, col = "black", cex = 2, adj = 0, padj = 0)
    
    # Copy to file
    dev.copy(device = png, "plot1.png")
    dev.off()
        
}