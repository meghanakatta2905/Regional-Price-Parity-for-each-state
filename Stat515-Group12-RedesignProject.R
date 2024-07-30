library(tidyverse)
library(ggplot2)
library(plotly)

inpdata <- read.csv("STAT_project_data.csv")
inpdata$MOM.CHANGE = as.numeric(sub("%", "",inpdata$MOM.CHANGE))
inpdata$YOY..CHANGE = as.numeric(sub("%", "",inpdata$YOY..CHANGE))

view(inpdata)
str(inpdata)

#point Graph for Average Rent
ggplot(inpdata, aes(x= reorder(CBSA, MEDIAN.RENT), y=MEDIAN.RENT,label=MEDIAN.RENT)) +
  
  geom_point( color="#3479C6", size=6, alpha=0.6) +
  labs(y="Average Rent Price",
       x="City",
       title="Average Rent prices by City")+
  geom_text(color = 'white', size = 2)+
  theme(axis.text.x = element_text(size = 10),
        axis.text.y = element_text(size = 6))+
  coord_flip()
#bar for YOY% change
ggplot(inpdata, aes(x = reorder(CBSA, YOY..CHANGE), y = YOY..CHANGE)) +
  geom_col(fill = "#C63D34") +
  labs(y="Year on year % change",
       x="City",
       title="Year-on-Year percentage Increase in Rent Prices by City")+
  theme(axis.text.x = element_text(size = 10),
        axis.text.y = element_text(size = 6))+
  coord_flip()

#bar for MOM% change
inpdata$MOM.CHANGE = as.numeric(sub("%", "",inpdata$MOM.CHANGE))
ggplot(inpdata, aes(x = reorder(CBSA, MOM.CHANGE), y = MOM.CHANGE)) +
  geom_col(fill = "#327704") +
  labs(y="Month On Month % change",
       x="City",
       title="Month On Month percentage Increase in Rent Prices by City")+
  theme(axis.text.x = element_text(size = 10),
        axis.text.y = element_text(size = 6))+
  coord_flip()

  