## plot U.S. PM2.5 emissions from coal combustion-related sources  from 1999–2008
library(ggplot2)

## read in data
NEI <- readRDS("summarySCC_PM25.rds") ## 6,497,651*6
SCC <- readRDS("Source_Classification_Code.rds") ## 11,717*15

## filter out coal combustion-related data
coal_scc <- SCC[ grepl("[Cc]ombustion", SCC$SCC.Level.One) & grepl("[Cc]oal", SCC$SCC.Level.Three), "SCC" ] 
coal_emi <- NEI[ (NEI$SCC %in% coal_scc), ]

## calculate total emissions in the U.S. group by year
coal_emi_us <- aggregate(Emissions ~ year, coal_emi, sum)

## plot
png("plot4.png")
ggplot(data = coal_emi_us, aes(x = year, y = Emissions)) +
    geom_line(color="seagreen") + 
    geom_point(color="seagreen") +
    ggtitle(expression("U.S. Coal Combustion "~PM[2.5]~"Emissions 1999-2008")) +
    xlab("Year") +
    ylab(expression( PM[2.5]~"Emissions (tons)")) +
    theme(plot.title = element_text(hjust=0.5))
dev.off()

