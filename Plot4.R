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
# Summarize by the SCC and year
sum_yrSCC_NEI<-NEI %>% 
  group_by(SCC,year) %>% 
  summarize(TotalEmission=sum(Emissions))
#Merge with SCC data
merged_dat<-merge(sum_yrSCC_NEI,SCC,by="SCC")
# Select rows related to Coal Combustion
merged_dat1<-merged_dat[grepl("Combustion",merged_dat$SCC.Level.One,ignore.case = TRUE) 
                        & grepl("Coal",merged_dat$SCC.Level.Four,ignore.case = TRUE),]
# Group by year
merged_dat2<-merged_dat1 %>% group_by(year) %>%
  summarize(TotalEmission=sum(TotalEmission))
png("Plot4.png")
ggplot(merged_dat2,aes(as.factor(year),TotalEmission)) + 
        geom_bar(stat="identity",width = 0.6) +
        ylab("Total PM25 Emissions (in Tons)") +
        xlab("Year") +
        ggtitle("Emissions in US related to Coal Combustion")
dev.off()


