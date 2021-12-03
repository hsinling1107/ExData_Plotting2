## plot total PM2.5 emissions  in the U.S. from 1999 to 2008

## read in data
NEI <- readRDS("summarySCC_PM25.rds") ## 6,497,651*6

## calculate total emissions in the U.S. group by year
emi_us <- aggregate(Emissions ~ year, NEI, sum)

## plot
png("plot1.png")
plot(emi_us$year, emi_us$Emissions, type="o", col="royalblue",
     main = expression("U.S.Total"~PM[2.5]~"Emissions 1999-2008"),
     xlab = "Year", ylab = expression( PM[2.5]~"Emissions (tons)"))
dev.off()
             
    