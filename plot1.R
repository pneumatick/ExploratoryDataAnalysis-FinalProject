# Download data if necessary
if (!file.exists("FNEI_data.zip")) {
  download.file(url = "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip",
                destfile = "FNEI_data.zip")
  unzip("FNEI_data.zip")
}

# Read data
NEI <- readRDS("summarySCC_PM25.rds")

# Create the plot
with(NEI, plot(aggregate(Emissions, list(year), sum), xlab = "Years", ylab = "Total PM2.5 Emissions (in tons)", type = "b"))
title(main = "National Emissions")
par(bg = "white")

# Export the plot as a PNG
dev.copy(png, file = "plot1.png")
dev.off()