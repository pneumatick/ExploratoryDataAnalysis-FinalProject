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
la <- NEI[NEI$fips == "06037", ]
mobileSCC <- SCC[SCC$SCC.Level.One == "Mobile Sources", ]
mobileBalt <- baltimore[mobileSCC$SCC %in% baltimore$SCC, ]
mobileLA <- la[mobileSCC$SCC %in% la$SCC, ]
mobileBaltData <- aggregate(mobileBalt$Emissions, list(mobileBalt$year), sum)
mobileLAData <- aggregate(mobileLA$Emissions, list(mobileLA$year), sum)
dataRange <- range(mobileBaltData, mobileLAData)

# Create the plot
par(bg = "white", mfrow = c(1, 2))
with(mobileBalt, plot(mobileBaltData, col = "blue", ylab = "Total PM2.5 Emissions from Motor Vehicles (in tons)", xlab = "Years", ylim = dataRange, type = "b"))
legend("topleft", legend = c("Baltimore", "Los Angeles"), pch = "l", col = c("blue", "red"))
with(mobileLA, plot(mobileLAData, col = "red", ylab = "Total PM2.5 Emissions from Motor Vehicles (in tons)", xlab = "Years", ylim = dataRange, type = "b"))

# Export the plot as a PNG
dev.copy(png, file = "plot6.png")
dev.off()