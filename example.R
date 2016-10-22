NEI_sub1 <- NEI[NEI$year %in% c(1999,2008), ]
NEI_sub2 <- NEI[with(NEI, year %in% c(1999,2008)), ]
boxplot(Emissions~year, NEI_sub1, xlab="Year", ylab="Emissions",col.axis = "blue", col.lab = "red")
title(main="Emmissions")
NEI_sub3 <- NEI[with(NEI, fips %in% c("09001")), ]
f1 <- sapply(split(NEI,NEI$fips),nrow)
f2 <- sapply(split(NEI,list(NEI$fips,NEI$year)),nrow) 
s2 <- split(NEI,list(NEI$fips,NEI$year))
f2 <- sapply(s2,nrow)
NEI_09001_1999 <- NEI_fips_09001[with(NEI_fips_09001, year %in% c("1999")), ]
boxplot(Emissions~year, NEI_09001_1999_2008, xlab="Year", ylab="Emissions",col.axis = "blue", col.lab = "red")

cdata <- aggregate(NEI_09001_1999_2008["Emissions"], by=NEI_09001_1999_2008[c("fips","year")], FUN=sum)

NEI_sum <- aggregate(NEI["Emissions"], by=NEI[c("fips","year")], FUN=sum)
with(NEI_sum, plot(year,log10(Emissions)))
with(NEI_sum, plot(year,Emissions))

NEI_mean <- aggregate(NEI["Emissions"], by=NEI[c("fips","year")], FUN=mean)
with(NEI_mean, plot(year,log10(Emissions)))
with(NEI_mean, plot(year,Emissions,main="Year vs. Mean Emissions Plot",pch=1,xlab="Year", ylab="Mean Emissions",col.axis = "red", col.lab = "blue"))

with(NEI, plot(year,log10(Emissions)))
#with(NEI, plot(year,Emissions))
with(NEI, plot(year,Emissions,main="Emissions vs. Year Plot",pch=1,xlab="Year", ylab="Emissions",col.axis = "red", col.lab = "blue"))

NEI_sum_by_year <- aggregate(NEI["Emissions"], by=NEI[c("year")], FUN=sum)
with(NEI_sum_by_year, plot(year,Emissions,main="Year vs. Total Emissions Plot",pch=1,xlab="Year", ylab="Total Emissions",col.axis = "red", col.lab = "blue"))
with(NEI_sum_by_year, plot(year,log10(Emissions),main="Year vs. Total Emissions (log) Plot",pch=1,xlab="Year", ylab="Total Emissions",col.axis = "red", col.lab = "blue"))


qplot(year,Emissions,data=NEI_Baltimore_sum_by_year_type,color=type, geom = c("point","smooth"))

gr <-grepl("Coal",SCC$EI.Sector)
SCC_Coal <- SCC[gr, ]
head(SCC_Coal)

NEI2 <- readRDS("c:./data/summarySCC_PM25.rds", na.strings=c("NA", "NULL"))
NEI_Coal_By_fips_year_mean_1999 <- NEI_Coal_By_fips_year_mean[with(NEI_Coal_By_fips_year_mean, year %in% c("1999")), ]
NEI_Coal_By_fips_year_mean_2002 <- NEI_Coal_By_fips_year_mean[with(NEI_Coal_By_fips_year_mean, year %in% c("2002")), ]
NEI_Coal_By_fips_year_mean_2005 <- NEI_Coal_By_fips_year_mean[with(NEI_Coal_By_fips_year_mean, year %in% c("2005")), ]
NEI_Coal_By_fips_year_mean_2008 <- NEI_Coal_By_fips_year_mean[with(NEI_Coal_By_fips_year_mean, year %in% c("2008")), ]



cnt_1999 <- NEI_Coal[with(NEI_Coal, year %in% c("1999")),c("fips")]
cnt_2002 <- NEI_Coal[with(NEI_Coal, year %in% c("2002")),c("fips")]
cnt_2005 <- NEI_Coal[with(NEI_Coal, year %in% c("2005")),c("fips")]
cnt_2008 <- NEI_Coal[with(NEI_Coal, year %in% c("2008")),c("fips")]
all_cnt <- intersect(cnt_1999,cnt_2002)
all_cnt <- intersect(all_cnt,cnt_2005)
all_cnt <- intersect(all_cnt,cnt_2008)

NEI_Coal_all <- NEI_Coal[with(NEI_Coal, fips %in% all_cnt),]

NEI_Coal_all_sum_by_year <- aggregate(NEI_Coal_all["Emissions"], by=NEI_Coal_all[c("year")], FUN=sum)
NEI_Coal_sum_by_year <- aggregate(NEI_Coal["Emissions"], by=NEI_Coal[c("year")], FUN=sum)

NEI_Coal_With_NA_sum_by_year <- aggregate(NEI_Coal_With_NA["Emissions"], by=NEI_Coal_With_NA[c("year")], FUN=sum)

