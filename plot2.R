###############################################################################################################
## plot2.R                                                                                                   ##
## Have total emissions from PM2.5 decreased in the Baltimore City, Maryland (fips == "24510") from          ##
## 1999 to 2008? Use the base plotting system to make a plot answering this question.                        ##
## Result: Based on the map, total emission from PM2.5 has decreased in the Baltimore city from 1999 to 2008 ##                                                                            ##    
###############################################################################################################

## Read the emission from PM2.5 data                                                                         ##
print("Reading the PM2.5 in a dataframe")
NEI <- readRDS("c:./data/summarySCC_PM25.rds")

## Extract the data for Baltimore city(fips == "24510")                                                      ##
print("Extracting Emission data for Baltimore City for all years")      
NEI_Baltimore <- NEI[with(NEI, fips %in% c("24510")), ]

## Find a sum of all emissions in Baltimore city across all sources for every year from 1999 to 2008         ##
print("For Baltimore city find total Emission from PM2.5 per year, by agreggating on year")
NEI_Baltimore_sum_by_year <- aggregate(NEI_Baltimore["Emissions"], by=NEI_Baltimore[c("year")], FUN=sum)
 
## Plot year vs.total Emission values for Baltimore city using base plotting system                          ##

print("Plot graph of total emission vs. year for Baltimore city, creating plot2.png")
png(filename="plot2.png", width = 480, height = 480)
with(NEI_Baltimore_sum_by_year, plot(year,Emissions,main="Total Emissions Across Baltimore\n (plot2)",type= "o",lty=3,col="darkmagenta",col.main="blue",pch=1,xlab="Years", ylab="Total Emissions",col.axis = "red", col.lab = "blue"))
dev.off()
print("plot2 completed")
