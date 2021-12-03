## plot total PM2.5 emissions  in the Baltimore City(fips == "24510") 
## from 1999 to 2008

## read in data
NEI <- readRDS("summarySCC_PM25.rds") ## 6,497,651*6

## calculate total emissions in the Baltimore City group by year
baltimore <- subset(NEI, NEI$fips == "24510")
emi_bal <- aggregate(Emissions ~ year, baltimore, sum)

## plot
png("plot2.png")
plot(emi_bal$year, emi_bal$Emissions, type="o", col="royalblue",
     main = expression("Baltimore Total"~PM[2.5]~"Emissions 1999-2008"),
     xlab = "Year", ylab = expression( PM[2.5]~"Emissions (tons)"))
dev.off()

