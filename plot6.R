## plot Baltimore City and Los Angeles (fips == "06037") PM2.5 emissions
## from motor vehicle sources from 1999–2008
library(ggplot2)

## read in data
NEI <- readRDS("summarySCC_PM25.rds") ## 6,497,651*6
SCC <- readRDS("Source_Classification_Code.rds") ## 11,717*15
    
## filter motor vehicle-related data
motor_scc <- SCC[ grepl("[Vv]ehicle", SCC$SCC.Level.Two) ,"SCC"] 
motor_emi <- NEI[ (NEI$SCC %in% motor_scc), ]

## filter Baltimore (fips == "24510") and Los Angeles(fips == "06037")
motor_bmore_la <- subset(motor_emi, motor_emi$fips %in% c("24510","06037") )

## calculate total emissions group by year and city(fips)
motor_bmore_la <- aggregate(Emissions ~ year*fips , motor_bmore_la, sum)

## plot
png("plot6.png")
ggplot(data = motor_bmore_la, aes(x = year, y = Emissions, col=fips)) +
    geom_line() + 
    geom_point() +
    ggtitle(expression("Motor Vehicle "~PM[2.5]~"Emissions in Baltimore and Los Angeles 1999-2008")) +
    xlab("Year") +
    ylab(expression( PM[2.5]~"Emissions (tons)")) +
    theme(plot.title = element_text(hjust=0.5), legend.title = element_text(hjust = 0.5, face = "bold")) +
    scale_color_discrete(name = "City", breaks = c("24510","06037"), labels = c("Baltimore","Los Angeles"))
dev.off()    