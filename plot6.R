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

# Create the plot
par(bg = "white", mfrow = c(1, 2))
with(mobileBalt, boxplot(log10(Emissions) ~ year, col = "blue", ylab = "Log10 of PM2.5 Emissions from Motor Vehicles (in tons)", xlab = "Years", ylim = c(-10, 4)))
legend("bottomleft", legend = c("Baltimore", "Los Angeles"), pch = "l", col = c("blue", "red"))
with(mobileLA, boxplot(log10(Emissions) ~ year, col = "red", ylab = "Log10 of PM2.5 Emissions from Motor Vehicles (in tons)", xlab = "Years", ylim = c(-10, 4)))

# Export the plot as a PNG
dev.copy(png, file = "plot6.png")
dev.off()