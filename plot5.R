###############################################################################################################
## plot5.R                                                                                                   ##
## Question: How have emissions from motor vehicle sources changed from 1999-2008 in Baltimore City?         ##
## Result: Based on the map, emissions from motor vehicle source has increased between 1999 & 2002, but      ##
##         decreased from 2002 to 2005, however still higher than 1999. It has decreased from 2005 to 2008   ##
##         lower than all prior years- 1999 thru 2005.                                                       ##
###############################################################################################################

## Read the emission from PM2.5 data and replace NA with missing values                                      ##                                                                        ##
print("Reading the PM2.5 in a dataframe and replace NA with missing values")
NEI <- readRDS("c:./data/summarySCC_PM25.rds")
NEI[NEI == '   NA'] <- NA

## Extract the data for Baltimore city(fips == "24510")                                                      ##
print("Extracting Emission data for Baltimore City for all years")      
NEI_Baltimore <- NEI[with(NEI, fips %in% c("24510")), ]


## Read the Source Classification Code Data                                                                  ##
print("Reading the Source Code Classification data in a dataframe")
SCC <- readRDS("C:./data/Source_Classification_Code.rds")

## Extract Source Code data for Motor Vehicle   related sources                                              ##                                                                           ##
print("Searching Short.Name in the Source Code Classification data for the string  'Motor' ")
gr_Motor <-grepl("Motor",SCC$Short.Name)
SCC_Motor <- SCC[gr_Motor, c("SCC","Short.Name","EI.Sector")]

print("Searching Short.Name in the Source Code Classification data containing 'Motor' for the string  'Veh' ")
gr_Veh <-grepl("Veh",SCC_Motor$Short.Name)
SCC_Motor_Veh <- SCC_Motor[gr_Veh, ]


## Merge Emission data with the SCC Motor Vehicle data                                                      ##
print("Merging Emission data with Source Code Classification for Motor Vehicl by SCC code ")
NEI_Baltimore_MotorVehicle_With_NA <- merge(NEI_Baltimore,SCC_Motor_Veh,by = "SCC")

## Remove rows with missing values in county code (fips)                                                    ##
NEI_Baltimore_MotorVehicle <- NEI_Baltimore_MotorVehicle_With_NA[!is.na(NEI_Baltimore_MotorVehicle_With_NA$fips),]

## Find a sum of all emissions in Baltimore city across all Motor Vehicle sources for every year from 1999 to 2008         ##
print("For Baltimore city find total Emission from PM2.5 per year for all Motor Vehicle sources, by agreggating on year")
NEI_Baltimore_MotorVehicle_sum_by_year <- aggregate(NEI_Baltimore_MotorVehicle["Emissions"], by=NEI_Baltimore_MotorVehicle[c("year")], FUN=sum)


## Plot year vs.total Emission values for Baltimore city for all Motor Vehicle sourse using base plotting system          ##

print("Plot graph of total emission vs. year for Baltimore city for Motor Vehicle sources, creating plot5.png")

png(filename="plot5.png", width = 480, height = 480)
with(NEI_Baltimore_MotorVehicle_sum_by_year, plot(year,Emissions,main="Emissions for Baltimore with Motor Vehicle Sources\n (plot5)",type= "o",lty=3,col="darkmagenta",col.main="blue",pch=1,xlab="Years", ylab="Total Emissions",col.axis = "red", col.lab = "blue"))

dev.off()

print("plot5 completed")
