## plot Baltimore City(fips == "24510") PM2.5 emissions from motor vehicle sources from 1999–2008
library(ggplot2)

## read in data
NEI <- readRDS("summarySCC_PM25.rds") ## 6,497,651*6
SCC <- readRDS("Source_Classification_Code.rds") ## 11,717*15
    
## filter out motor vehicle-related data
motor_scc <- SCC[ grepl("[Vv]ehicle", SCC$SCC.Level.Two) ,"SCC"] 
motor_emi <- NEI[ (NEI$SCC %in% motor_scc), ]

## filter out Baltimore City (fips == "24510")
motor_baltimore <- subset(motor_emi, motor_emi$fips == "24510")

## calculate total emissions in the Baltimore City group by year
motor_baltimore <- aggregate(Emissions ~ year, motor_baltimore, sum)

## plot
png("plot5.png")
ggplot(data = motor_baltimore, aes(x = year, y = Emissions)) +
    geom_line(color="violetred") + 
    geom_point(color="violetred") +
    ggtitle(expression("Baltimore Motor Vehicle "~PM[2.5]~"Emissions 1999-2008")) +
    xlab("Year") +
    ylab(expression( PM[2.5]~"Emissions (tons)")) +
    theme(plot.title = element_text(hjust=0.5))
dev.off()
