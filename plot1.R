##########################################################################################################
## plot1.R                                                                                              ##
## Have total emissions from PM2.5 decreased in the United States from 1999 to 2008? Using the          ##
## base plotting system, make a plot showing the total PM2.5 emission from all sources for each         ##
## of the years 1999, 2002, 2005, and 2008.                                                             ##
## Result: Based on the map, total emission from PM2.5 has decreased in the US from 1999 to 2008.       ##                                             ##
##########################################################################################################

## Read the emission from PM2.5 data                                                                    ##
print("Reading the PM2.5 in a dataframe")
NEI <- readRDS("c:./data/summarySCC_PM25.rds")

## Find a sum of all emissions across all sources & counties for every year from 1999 to 2008           ##
print("Find total Emission from PM2.5 per year, by agreggating on year")
NEI_sum_by_year <- aggregate(NEI["Emissions"], by=NEI[c("year")], FUN=sum)
 
## Plot year vs.total Emission values using base plotting system                                        ##
print("Plot graph of total emission vs. year")

png(filename="plot1.png", width = 480, height = 480)
with(NEI_sum_by_year, plot(year,Emissions,main="Total Emissions Across USA\n (plot1)",type= "o",lty=3,col="darkmagenta",col.main="blue",pch=1,xlab="Years", ylab="Total Emissions",col.axis = "red", col.lab = "blue"))
dev.off()

print("plot1 completed")
