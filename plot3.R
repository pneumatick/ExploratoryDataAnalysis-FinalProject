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
typeData <- with(baltimore, aggregate(Emissions, list(year, type), sum))
plot <- with(typeData, qplot(Group.1, x, data = typeData, color = Group.2))
plot +
  geom_point(size = 1) +
  geom_line(size = 1) +
  labs(title = "Emissions from Different Source Types in Baltimore",
       x = "Years",
       y = "Total PM2.5 Emissions (in tons)") + 
  guides(color=guide_legend(title="Type"))

# Export the plot as a PNG
dev.copy(png, file = "plot3.png")
dev.off()