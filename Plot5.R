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
# Filter BAltimore data and group by SCC and year
sum_yrSCC_balt_NEI<-NEI %>% 
  filter(fips == "24510") %>%
  group_by(SCC,year) %>% 
  summarize(TotalEmission=sum(Emissions))
# Merge Data with SCC
merged_dat<-merge(sum_yrSCC_balt_NEI,SCC,by="SCC",all.x = TRUE)
# Select those sources related to Vehicles
merged_dat1<-merged_dat[grepl("[Vv]ehicle",merged_dat$SCC.Level.Two,ignore.case = TRUE) ,]
# GRoup by Year and summarize
merged_dat2<-merged_dat1 %>% group_by(year) %>%
  summarize(TotalEmission=sum(TotalEmission))
png("Plot5.png")
ggplot(merged_dat2,aes(as.factor(year),TotalEmission)) + 
        geom_bar(stat="identity", width = 0.6) + 
        ylab("Total PM25 Emissions (in Tons)") +
        xlab("Year") +
        ggtitle("Emissions in Baltimore related to Vehicles")
dev.off()



