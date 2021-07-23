# Download data if necessary
if (!file.exists("FNEI_data.zip")) {
  download.file(url = "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip",
                destfile = "FNEI_data.zip")
  unzip("FNEI_data.zip")
}

# Read data
NEI <- readRDS("summarySCC_PM25.rds")

# Prepare data for plotting
f <- factor(NEI$year)

# Create the plot
plot(f, col = unique(NEI$year), xlab = "Years", ylab = "PM2.5 Emmisions (tons)")
legend("topleft", lty = 1, col = unique(NEI$year), legend = unique(NEI$year))
par(bg = "white")

# Export the plot as a PNG
dev.copy(png, file = "plot1.png")
dev.off()