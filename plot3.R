## plot total PM2.5 emissions  in the Baltimore City(fips == "24510")
## from 1999 to 2008 group by types
library(ggplot2)

## read in data
NEI <- readRDS("summarySCC_PM25.rds") ## 6,497,651*6

## calculate total emissions in the Baltimore City group by year and type
baltimore <- subset(NEI, NEI$fips == "24510")
baltimore_type <- aggregate(Emissions ~ year + type, baltimore, sum)

## plot
png("plot3.png")
ggplot(data = baltimore_type, aes(x = year, y = Emissions, col = type)) +
    geom_line() + 
    geom_point() + 
    ggtitle(expression("Baltimore "~PM[2.5]~"Emissions by Source 1999-2008")) +
    xlab("Year") + 
    ylab(expression( PM[2.5]~"Emissions (tons)")) +
    scale_colour_discrete(name = "Source Type") +
    theme(plot.title = element_text(hjust = 0.5),legend.title = element_text(face = "bold"))
dev.off()
