#################################################################################################################
## plot3.R                                                                                                     ##
## Question: Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad) variable,   ##
##           which of these four sources have seen decreases in emissions from 1999-2008 for Baltimore City?   ##
##           Which have seen increases in emissions from 1999-2008? Use the ggplot2 plotting system to make a  ##
##           plot answer this question.                                                                        ##
## Result:   Based on the map, total emission from PM2.5 has decreased in the Baltimore city from 1999 to 2008 ##          
##           for source types "Non-Road", "On-Road", and "NonPoint".                                           ##
##           Total emission from PM2.5 has increased in the Baltimore city from 1999 to 2008 for source type   ##
##           "Point".                                                                                          ##   
#################################################################################################################

library(ggplot2)
## Read the emission from PM2.5 data                                                                           ##
print("Reading the PM2.5 in a dataframe")
NEI <- readRDS("c:./data/summarySCC_PM25.rds")

## Extract the data for Baltimore city(fips == "24510")                                                        ##
print("Extracting Emission data for Baltimore City for all years")      
NEI_Baltimore <- NEI[with(NEI, fips %in% c("24510")), ]

## Find a sum of all emissions in Baltimore city across all sources for every year and type from 1999 to 2008  ##
print("For Baltimore city find total Emission from PM2.5 for every year and type, by agreggating on year & type")
NEI_Baltimore_sum_by_year_type <- aggregate(NEI_Baltimore["Emissions"], by=NEI_Baltimore[c("year","type")], FUN=sum)
 
## Plot year vs.total Emission values for Baltimore city using ggplot2 plotting system                         ##
print("Plot graph of total emission vs. year for Baltimore city, creating plot3.png")
png(filename="plot3.png", width = 480, height = 480)
g <- ggplot(NEI_Baltimore_sum_by_year_type, aes(year,Emissions))
print(g+geom_line(size=1,linetype=1,alpha=1,aes(color = type)) + labs(title="Emission Per Source Type for Baltimore\n (plot3)") + labs(x="Years",y="Total Emission"))
dev.off()
print("plot3 completed")

