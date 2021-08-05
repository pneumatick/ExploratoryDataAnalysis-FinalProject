# Download data if necessary
if (!file.exists("FNEI_data.zip")) {
  download.file(url = "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip",
                destfile = "FNEI_data.zip")
  unzip("FNEI_data.zip")
}

# Read data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Prepare data for plotting
baltimore <- NEI[NEI$fips == "24510", ]
mobileSCC <- SCC[SCC$SCC.Level.One == "Mobile Sources", ]
mobileBalt <- baltimore[mobileSCC$SCC %in% baltimore$SCC, ]

# Create the plot
with(mobileBalt, plot(aggregate(Emissions, list(year), sum), xlab = "Years", ylab = "Total PM2.5 Emissions from Motor Vehicles (in tons)", type = "b"))
title(main = "Emissions from Motor Vehicle Sources in Baltimore")
par(bg = "white")

# Export the plot as a PNG
dev.copy(png, file = "plot5.png")
dev.off()