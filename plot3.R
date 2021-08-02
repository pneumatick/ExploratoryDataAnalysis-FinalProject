library('ggplot2')

# Download data if necessary
if (!file.exists("FNEI_data.zip")) {
  download.file(url = "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip",
                destfile = "FNEI_data.zip")
  unzip("FNEI_data.zip")
}

# Read data
NEI <- readRDS("summarySCC_PM25.rds")

# Prepare data for plotting
baltimore <- NEI[NEI$fips == "24510", ]

# Create the plot
plot <- ggplot(baltimore, aes(year, log10(Emissions), xlab = "Years")) 
plot + geom_point(aes(color = factor(type), shape = factor(type)), size = 1) + labs(title = "Emissions from Different Source Types in Baltimore", x = "Years", y = "Log 10 of PM2.5 Emissions (in tons)")

# Export the plot as a PNG
dev.copy(png, file = "plot3.png")
dev.off()