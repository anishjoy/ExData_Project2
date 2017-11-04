setwd("C:/Users/anish/Desktop/Coursera/ExData_Project2")
# Download Data and Unzip
download.file("http://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip","./data/data.zip")
unzip("./data/data.zip",exdir="./data")

# read the data
NEI <- readRDS("./data/summarySCC_PM25.rds")
SCC <- readRDS("./data/Source_Classification_Code.rds")

# Load the library dplyr
library(dplyr)
library(ggplot2)

# Summarize data for Baltimore and California by SCC,fips,year
sum_yrSCC_balt_NEI<-NEI %>% 
  filter(fips %in% c("24510","06037") ) %>%
  group_by(SCC,fips,year) %>% 
  summarize(TotalEmission=sum(Emissions))
# Merge with SCC Data
merged_dat<-merge(sum_yrSCC_balt_NEI,SCC,by="SCC",all.x = TRUE)
# Select only those rows related to Vehicles 
merged_dat1<-merged_dat[grepl("[Vv]ehicle",merged_dat$SCC.Level.Two,ignore.case = TRUE) ,]
# Group by fips and year and then summarize
merged_dat2<-merged_dat1 %>% group_by(fips,year) %>%
  summarize(TotalEmission=sum(TotalEmission))
# Set Labels for fips
merged_dat2$fips<-factor(merged_dat2$fips,labels=c("California County","Baltimore"))
png("Plot6.png")
ggplot(merged_dat2,aes(as.factor(year),TotalEmission)) + 
        geom_bar(stat="identity",width=0.7)+facet_grid(.~fips) +
        ylab("Total PM25 Emissions (in Tons)") +
        xlab("Year") +
        ggtitle("Emissions in Baltimore and California related to Vehicles")
dev.off()

