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
combSCC <- SCC[grep("Combustion", SCC$SCC.Level.One), ]
coalCombSCC <- combSCC[grep("Coal", SCC$Short.Name), ]
coalComb <- NEI[coalCombSCC$SCC %in% NEI$SCC, ]

# Create the plot
with(coalComb, boxplot(log10(Emissions) ~ year, xlab = "Years", ylab = "Log 10 of PM2.5 Emissions (in tons)"))
title(main = "National Emissions from Coal Combustion Sources")
par(bg = "white")

# Export the plot as a PNG
dev.copy(png, file = "plot4.png")
dev.off()