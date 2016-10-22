###############################################################################################################
## plot6.R                                                                                                   ##
## Question: Compare emissions from motor vehicle sources in Baltimore City with emissions from motor        ##
##           vehicle sources in Los Angeles County, California (fips == "06037"). Which city has seen        ##
##           greater changes over time in motor vehicle emissions?                                           ##
## Result: Based on the map, Baltimore has more variation in the emission than Los Angeles. Los Angeles had  ##
##         steady increase in emission from 1999 till 2005, and then slight decline in 2008.                 ##
##         Baltimore has sudden inccrease in emission from 1999 to 2002, slight decline in 2005 and then     ##
##         sharp decline from 2005 to 2008, but still slightly lower than 1999.                              ##
###############################################################################################################

## Read the emission from PM2.5 data and replace NA with missing values                                      ##                                                                        ##
print("Reading the PM2.5 in a dataframe and replace NA with missing values")
NEI <- readRDS("c:./data/summarySCC_PM25.rds")
NEI[NEI == '   NA'] <- NA

## Extract the data for Baltimore city(fips == "24510")                                                      ##
print("Extracting Emission data for Baltimore City for all years")      
NEI_Baltimore <- NEI[with(NEI, fips %in% c("24510")), ]

## Extract the data for Los Angeles city(fips == "06037")                                                    ##
print("Extracting Emission data for Los Angeles City for all years")      
NEI_LA <- NEI[with(NEI, fips %in% c("06037")), ]


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


## Merge Emission data with the SCC Motor Vehicle data for Baltimore                                        ##
print("Merging Emission data with Source Code Classification for Motor Vehicl by SCC code for Baltimore")
NEI_Baltimore_MotorVehicle_With_NA <- merge(NEI_Baltimore,SCC_Motor_Veh,by = "SCC")

## Remove rows with missing values in county code (fips)                                                    ##
NEI_Baltimore_MotorVehicle <- NEI_Baltimore_MotorVehicle_With_NA[!is.na(NEI_Baltimore_MotorVehicle_With_NA$fips),]

## Merge Emission data with the SCC Motor Vehicle data for Los Angeles                                      ##
print("Merging Emission data with Source Code Classification for Motor Vehicl by SCC code for Los Angeles ")
NEI_LA_MotorVehicle_With_NA <- merge(NEI_LA,SCC_Motor_Veh,by = "SCC")

## Remove rows with missing values in county code (fips)                                                    ##
NEI_LA_MotorVehicle <- NEI_LA_MotorVehicle_With_NA[!is.na(NEI_LA_MotorVehicle_With_NA$fips),]

## Find a sum of all emissions in Baltimore city across all Motor Vehicle sources for every year from 1999 to 2008         ##
print("For Baltimore city find total Emission from PM2.5 per year for all Motor Vehicle sources, by agreggating on year")
NEI_Baltimore_MotorVehicle_sum_by_year <- aggregate(NEI_Baltimore_MotorVehicle["Emissions"], by=NEI_Baltimore_MotorVehicle[c("year")], FUN=sum)

## Find a sum of all emissions in Los Angeles city across all Motor Vehicle sources for every year from 1999 to 2008      ##
print("For Los Angeles find total Emission from PM2.5 per year for all Motor Vehicle sources, by agreggating on year")
NEI_LA_MotorVehicle_sum_by_year <- aggregate(NEI_LA_MotorVehicle["Emissions"], by=NEI_LA_MotorVehicle[c("year")], FUN=sum)

## Plot year vs.total Emission values for Baltimore city for all Motor Vehicle sourse using base plotting system          ##

print("Plot graph of total emission vs. year for Baltimore city for Motor Vehicle sources, creating plot5.png")

png(filename="plot6.png", width = 480, height = 480)

par(mfrow=c(1,2),oma=c(0,0,2,0))

with(NEI_Baltimore_MotorVehicle_sum_by_year, plot(year,Emissions,main="Baltimore City",type= "o",lty=3,col="darkmagenta",col.main="blue",pch=1,ylim = c(0, 100),xlab="Years", ylab="Total Emissions",col.axis = "red", col.lab = "blue"))
with(NEI_LA_MotorVehicle_sum_by_year, plot(year,Emissions,main="Los Angeles City",type= "o",lty=3,col="darkmagenta",col.main="blue",pch=1,ylim = c(0, 100),xlab="Years", ylab="Total Emissions",col.axis = "red", col.lab = "blue"))
mtext("Emissions for Motor Vehicle Sources\n (plot6)", outer=TRUE)

dev.off()

print("plot6 completed") 
