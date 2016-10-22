#################################################################################################################
## plot4.R                                                                                                     ##
## Question: Across the United States, how have emissions from coal combustion-related sources changed from    ##
##           1999-2008?                                                                                        ##
## Result:   Based on the map, across the United states, emission from coal combustion-related sources has     ##
##           decreased from 1999 to 2008.                                                                      ##          
#################################################################################################################

## Read the emission from PM2.5 data and then replace NA with missing value                                    ##
print("Reading the PM2.5 in a dataframe & Replacing NA with missing value")
NEI <- readRDS("c:./data/summarySCC_PM25.rds")
NEI[NEI == '   NA'] <- NA

## Read the Source Classification Code Data                                                                    ##
print("Reading the Source Code Classification data in a dataframe")
SCC <- readRDS("C:./data/Source_Classification_Code.rds")

## Extract Source Code data for Coal Combustion related sources                                                ##                                                                           ##
print("Searching EI.Secotor in the Source Code Classification data for the string  'Coal' ")
gr <-grepl("Coal",SCC$EI.Sector)
SCC_Coal <- SCC[gr, c("SCC","EI.Sector")]

## Merge Emission data with the SCC Coal Data                                                                  ##
print("Merging Emission data with Source Code Classification for 'Coal' by SCC code ")
NEI_Coal_With_NA <- merge(NEI,SCC_Coal,by = "SCC")

## Remove rows with missing values in county code (fips)                                                       ##
NEI_Coal <- NEI_Coal_With_NA[!is.na(NEI_Coal_With_NA$fips),]

## Find a sum of all emissions across all sources & counties for every year from 1999 to 2008                  ##
print("Find total Emission from PM2.5 per year, by agreggating on year")
NEI_Coal_sum_by_year <- aggregate(NEI_Coal["Emissions"], by=NEI_Coal[c("year")], FUN=sum)

## Plot year vs.total Emission values using base plotting system                                               ##

print("Plot graph of total emission vs. year for Coal Combustion-related sources ")

png(filename="plot4.png", width = 480, height = 480)
with(NEI_Coal_sum_by_year, plot(year,Emissions,main="Emissions Across USA for Coal Combustion sources\n (plot4)",type= "o",lty=3,col="darkmagenta",col.main="blue",pch=1,xlab="Years", ylab="Total Emissions",col.axis = "red", col.lab = "blue"))

dev.off()

print("plot4 completed")

