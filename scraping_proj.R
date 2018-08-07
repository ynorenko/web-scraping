library(dplyr)
library(ggplot2)
library(RColorBrewer)
library(scales)
library(ggcorrplot)
library(data.table)

travel_paid = read.csv('travel_paid.csv', header = F, col.names = c('Name', 'Category', 'Developer','Ads', 'Rating' ,'Number Of Reviews', 'Size', 'Installs', 'Price'), na.strings = c("", "NA"), stringsAsFactors = F)

travel_free = read.csv('travel_free.csv', header = F, col.names = c('Name', 'Category', 'Developer','Ads', 'Rating' ,'Number Of Reviews', 'Size', 'Installs', 'Price'), na.strings = c("", "NA"), stringsAsFactors = F)

travel_free$Price = 0

social_paid = read.csv('social_paid.csv', header = F, col.names = c('Name', 'Category', 'Developer','Ads', 'Rating' ,'Number Of Reviews', 'Size', 'Installs', 'Price'), na.strings = c("", "NA"), stringsAsFactors = F)

social_free = read.csv('social_free.csv', header = F, col.names = c('Name', 'Category', 'Developer','Ads', 'Rating' ,'Number Of Reviews', 'Size', 'Installs', 'Price'), na.strings = c("", "NA"), stringsAsFactors = F)

social_free$Price = 0

news_paid = read.csv('news_paid.csv', header = F, col.names = c('Name', 'Category', 'Developer','Ads', 'Rating' ,'Number Of Reviews', 'Size', 'Installs', 'Price'), na.strings = c("", "NA"), stringsAsFactors = F)

news_free = read.csv('news_free.csv', header = F, col.names = c('Name', 'Category', 'Developer','Ads', 'Rating' ,'Number Of Reviews', 'Size', 'Installs', 'Price'), na.strings = c("", "NA"), stringsAsFactors = F)

news_free$Price = 0

medical_paid = read.csv('medical_paid.csv', header = F, col.names = c('Name', 'Category', 'Developer','Ads', 'Rating' ,'Number Of Reviews', 'Size', 'Installs', 'Price'), na.strings = c("", "NA"), stringsAsFactors = F)

medical_free = read.csv('medical_free.csv', header = F, col.names = c('Name', 'Category', 'Developer','Ads', 'Rating' ,'Number Of Reviews', 'Size', 'Installs', 'Price'), na.strings = c("", "NA"), stringsAsFactors = F)

medical_free$Price = 0

health_paid = read.csv('health_paid.csv', header = F, col.names = c('Name', 'Category', 'Developer','Ads', 'Rating' ,'Number Of Reviews', 'Size', 'Installs', 'Price'), na.strings = c("", "NA"), stringsAsFactors = F)

health_free = read.csv('health_free.csv', header = F, col.names = c('Name', 'Category', 'Developer','Ads', 'Rating' ,'Number Of Reviews', 'Size', 'Installs', 'Price'), na.strings = c("", "NA"), stringsAsFactors = F)

health_free$Price = 0

finance_paid = read.csv('finance_paid.csv', header = F, col.names = c('Name', 'Category', 'Developer','Ads', 'Rating' ,'Number Of Reviews', 'Size', 'Installs', 'Price'), na.strings = c("", "NA"), stringsAsFactors = F)

finance_free = read.csv('finance_free.csv', header = F, col.names = c('Name', 'Category', 'Developer','Ads', 'Rating' ,'Number Of Reviews', 'Size', 'Installs', 'Price'), na.strings = c("", "NA"), stringsAsFactors = F)

finance_free$Price = 0

enter_paid = read.csv('enter_paid.csv', header = F, col.names = c('Name', 'Category', 'Developer','Ads', 'Rating' ,'Number Of Reviews', 'Size', 'Installs', 'Price'), na.strings = c("", "NA"), stringsAsFactors = F)

enter_free = read.csv('enter_free.csv', header = F, col.names = c('Name', 'Category', 'Developer','Ads', 'Rating' ,'Number Of Reviews', 'Size', 'Installs', 'Price'), na.strings = c("", "NA"), stringsAsFactors = F)

enter_free$Price = 0

education_paid = read.csv('education_paid.csv', header = F, col.names = c('Name', 'Category', 'Developer','Ads', 'Rating' ,'Number Of Reviews', 'Size', 'Installs', 'Price'), na.strings = c("", "NA"), stringsAsFactors = F)

education_free = read.csv('education_free.csv', header = F, col.names = c('Name', 'Category', 'Developer','Ads', 'Rating' ,'Number Of Reviews', 'Size', 'Installs', 'Price'), na.strings = c("", "NA"), stringsAsFactors = F)

education_free$Price = 0

business_paid = read.csv('business_paid.csv', header = F, col.names = c('Name', 'Category', 'Developer','Ads', 'Rating' ,'Number Of Reviews', 'Size', 'Installs', 'Price'), na.strings = c("", "NA"), stringsAsFactors = F)

business_free = read.csv('business_free.csv', header = F, col.names = c('Name', 'Category', 'Developer','Ads', 'Rating' ,'Number Of Reviews', 'Size', 'Installs', 'Price'), na.strings = c("", "NA"), stringsAsFactors = F)

business_free$Price = 0

books_paid = read.csv('books_paid.csv', header = F, col.names = c('Name', 'Category', 'Developer','Ads', 'Rating' ,'Number Of Reviews', 'Size', 'Installs', 'Price'), na.strings = c("", "NA"), stringsAsFactors = F)

books_free = read.csv('books_free.csv', header = F, col.names = c('Name', 'Category', 'Developer','Ads', 'Rating' ,'Number Of Reviews', 'Size', 'Installs', 'Price'), na.strings = c("", "NA"), stringsAsFactors = F)

books_free$Price = 0

food_paid = read.csv('food_paid.csv', header = F, col.names = c('Name', 'Category', 'Developer','Ads', 'Rating' ,'Number Of Reviews', 'Size', 'Installs', 'Price'), na.strings = c("", "NA"), stringsAsFactors = F)

food_free = read.csv('food_free.csv', header = F, col.names = c('Name', 'Category', 'Developer','Ads', 'Rating' ,'Number Of Reviews', 'Size', 'Installs', 'Price'), na.strings = c("", "NA"), stringsAsFactors = F)

food_free$Price = 0

#complete app info 
apps = rbind(travel_free, travel_paid, social_free, social_paid, news_free, news_paid, medical_free, medical_paid, health_free, health_paid, finance_free, finance_paid, enter_free, enter_paid, education_free, education_paid,
            business_free, business_paid, books_free, books_paid, food_free, food_paid)

#converting to numeric 
apps$Number.Of.Reviews = as.numeric(gsub(",", "", apps$Number.Of.Reviews))
apps$Installs = as.numeric(gsub(",", "", apps$Installs))

#count number of apps in each category 
apps_1 = apps %>%
  mutate(paid_free = ifelse(Price == 0, 0 , 1)) %>%
  group_by(Category, paid_free) %>%
  summarise(Number = n())

#plot number of apps by category 
apps_2 = apps %>%
  group_by(Category) %>%
  summarise(Number = n()) 

ggplot(apps_2, aes(x = "", y = Number, fill = Category)) + geom_bar(width = 1, stat = 'identity') + coord_polar(theta = "y", start = 0) +
  scale_fill_brewer(palette = 'Paired') + geom_text(aes(label = Number), position = position_stack(vjust = 0.5), color = "black") +
  ggtitle('Number of Apps by Category') + theme(plot.title = element_text(hjust = 0.5),  axis.title.y=element_blank(), axis.title.x=element_blank()) 

#plot number of free apps vs number of paid apps 
ggplot(apps_1, aes(Category, Number, fill = factor(paid_free))) + geom_bar(stat = 'identity') + 
  theme(legend.title=element_blank(), plot.title = element_text(hjust = 0.5), legend.position="bottom") + 
  ggtitle('Number of Free Apps vs Number of Paid Apps by Category') + 
  scale_fill_brewer(labels = c("Free", "Paid"), palette = 'Paired') 

# number of installs
apps1 = copy(apps)
apps1$Installs = cut(apps$Installs, breaks=c(-Inf, 5, 10, 50, 100, 500, 1000, 5000, 10000, 50000, 100000, 500000,1000000, 5000000, 10000000, 50000000, 100000000, 500000000,1000000000, 5000000000))
labels = c('0-5', '5-10', '10-50', '50-100', '100-500', '500-1K', '1K-5K', '5K-10K', '10K-50K', '50K-100K', '100K-500K', '500K-1M', '1M-5M', '5M-10M', '10M-50M', '50M-100M', '100M-500M', '500M-1B', '1B-5B')

ggplot(apps1, aes(Installs)) + geom_bar(stat = 'count', fill = "#56B4E9") + scale_x_discrete(labels = labels)+
  theme(axis.text.x=element_text(angle=90,hjust=1,vjust=0.5), plot.title = element_text(hjust = 0.5)) + ggtitle('Number of Installs') +
  geom_text(stat = 'count', aes(label=..count..), vjust=-1)

#distribution of user ratings 
apps_r = apps %>%
  mutate(paid_free = ifelse(Price == 0, 0 , 1))
apps_r$paid_free = factor(apps_r$paid_free, labels = c('Free', 'Paid'))

ggplot(apps_r, aes(Rating)) + geom_bar(stat = 'count', fill = "darkorchid3") + scale_x_reverse(breaks = seq(1, 5, by = 0.2)) +
  ggtitle('Distribution of User Ratings') + theme(plot.title = element_text(hjust = 0.5)) + geom_text(stat = 'count', aes(label=..count..), vjust=-1)

# number of reviews as % of installs; removed outliers 
apps_3 = apps %>%
  mutate(Percent = Number.Of.Reviews/Installs*100) %>%
  filter(Installs !=0, Percent <10) 

ggplot(apps_3, aes(reorder(Category, -Percent), y =Percent, fill = Category)) + geom_boxplot() +
  scale_fill_brewer(palette = 'Paired') + ggtitle('Number of Reviews as Percent of Installs') +
  theme(plot.title = element_text(hjust = 0.5)) + theme(legend.position="none") + xlab('Category') 

#calculating mean incl all data (average number of reviews as % of installs)
apps_4 = apps %>%
  mutate(Percent = Number.Of.Reviews/Installs*100) %>%
  filter(Installs !=0, Percent <100) %>%
  group_by(Category) %>%
  summarise(Percent = mean(Percent, na.rm = T))

ggplot(apps_4, aes(reorder(Category, -Percent), Percent, fill = Category)) + geom_bar(stat = 'identity') + scale_fill_brewer(palette = 'Paired') +
  xlab('Category') + ggtitle('Average Number of Reviews as Percent of Installs') +
  theme(plot.title = element_text(hjust = 0.5)) + theme(legend.position="none")
   
# percent of apps that have ads ( free and paid )
apps_a = apps[grepl('Ads', apps$Ads),] # apps with adds 
apps_na = apps[!grepl('Ads', apps$Ads),] # apps without adds 

nrow(filter(apps_a, Price == 0)) # Free apps that have ads 937 
nrow(filter(apps_a, Price != 0)) # Paid apps that have ads 63 

nrow(filter(apps, Price == 0)) # Free apps 1835 58% 
nrow(filter(apps, Price != 0)) # Paid apps 1309 42%

Free = round(nrow(filter(apps, Price == 0))/nrow(apps)*100,0)
Paid = round(nrow(filter(apps, Price != 0))/nrow(apps)*100,0) 
Type = c('Free', 'Paid')
Number = c(Free, Paid)

data = data_frame(Type, Number)

ggplot(data, aes(x = "", y = Number, fill = Type)) + geom_bar(width = 1, stat = 'identity') + coord_polar(theta = "y", start = 0) +
  scale_fill_brewer(palette = 'Paired') + geom_text(aes(label = Number), position = position_stack(vjust = 0.5), color = "black") +
  ggtitle('Percent of Free and Paid Apps') + theme(plot.title = element_text(hjust = 0.5),  axis.title.y=element_blank(), axis.title.x=element_blank(), legend.position="bottom", legend.title=element_blank()) 

937/1835 #51% - Free apps with ads 
63/1309 #0.05% - Paid apps with ads 

Type = c('Free', 'Paid')
Number = c(51, 0.05)

data1 = data_frame(Type, Number)

ggplot(data1, aes(x = Type, y = Number, fill = Type)) + geom_bar(stat = 'identity') + 
  scale_fill_brewer(palette = 'Paired') + geom_text(aes(label = Number), position = position_stack(vjust = 0.5), color = "black") +
  ggtitle('Percent of Apps That Contain Ads') + theme(plot.title = element_text(hjust = 0.5),  axis.title.y=element_blank(), axis.title.x=element_blank()) 

#in app purchases 
apps_p = apps %>%
  filter(Price == 0)

nrow(apps_p[grepl('purchases', apps_p$Ads),]) #470

nrow(filter(apps, Price == 0)) # Free apps 1835 

`Offers in-app purchases` = round(nrow(apps_p[grepl('purchases', apps_p$Ads),])/nrow(filter(apps, Price == 0))*100,0)

Number = c(26, 74)
Feature = c('Offers in-app purchases', 'No in-app purchases')

data2 = data_frame(Type, Feature)

ggplot(data2, aes(x = "", y = Number, fill = Feature)) + geom_bar(width = 1, stat = 'identity') + coord_polar(theta = "y", start = 0) +
  scale_fill_brewer(palette = 'Set3') + geom_text(aes(label = Number), position = position_stack(vjust = 0.5), color = "black") +
  ggtitle('Percent of Free Apps with In-app Purchases') + theme(plot.title = element_text(hjust = 0.5),  axis.title.y=element_blank(), axis.title.x=element_blank(), legend.position="bottom", legend.title=element_blank()) 

# correlations
apps_cor = apps %>%
  mutate(Ads = ifelse(grepl('Ads', apps$Ads) == TRUE, 1 , 0)) %>%
  select(-c('Name', 'Category', 'Developer')) %>%
  rename(`Number of Reviews` = 'Number.Of.Reviews')

cor(apps_cor, use="complete.obs")

ggcorrplot(cor(apps_cor, use="complete.obs"), hc.order = TRUE, 
           type = "lower", 
           lab = TRUE, 
           lab_size = 4, 
           tl.cex = 15,
           method="circle", 
           colors = c("tomato2", "white", "springgreen3"), 
           title="Correlations", 
           ggtheme=theme_bw) + theme(plot.title = element_text(size=15)) +
  theme(plot.title = element_text(hjust = 0.5), legend.title = element_text(size=12),
        legend.text = element_text(size=10)) +
  scale_size_continuous(range = c(12, 20))

apps_cor = filter(apps, Price<150)

ggplot(apps_cor, aes(x = Rating, y = Price)) + geom_point(color = 'Blue') + ggtitle('Correlation Between Rating and Price (0.05)') +
  theme(plot.title = element_text(hjust = 0.5))

#price 
apps_paid = apps %>%
  filter(Price != 0) 

apps_paid$Price = cut(apps_paid$Price, breaks=c(0.5, 1, 2, 3, 4, 6, 10, 30, 60, 100,400))
labels1 = c('0.5-1', '1-2', '2-3', '3-4', '4-6', '6-10', '10-30', '30-60', '60-100', '100-400')

ggplot(apps_paid, aes(Price)) + geom_bar(stat = 'count', fill = "deeppink4") +scale_x_discrete(labels = labels1) +
  theme(axis.text.x=element_text(angle=90,hjust=1,vjust=0.5), plot.title = element_text(hjust = 0.5)) + ggtitle('Price Distribution') + xlab('Price (USD)')

apps_paid2 = apps_paid %>%
  group_by(Price) %>%
  summarise(Installs = sum(Installs))

ggplot(apps_paid2, aes(Price, Installs)) + geom_bar(stat = 'identity', fill = 'khaki4') + ggtitle('Distribution of Installs of Paid Apps') +
  theme(axis.text.x=element_text(angle=90,hjust=1,vjust=0.5), plot.title = element_text(hjust = 0.5)) + scale_x_discrete(labels = labels1) + scale_y_continuous(labels = scales::comma)

#size
apps_size = apps %>%
  group_by(Category) %>%
  summarise(Size = round(mean(Size, na.rm = T)),0)

ggplot(apps_size, aes(reorder(Category, -Size), Size)) + geom_bar(stat = 'identity', fill = "coral2") + theme(plot.title = element_text(hjust = 0.5)) + ggtitle('Average Size by Category') + 
  xlab('Category') + geom_text(aes(y = Size, label = Size), vjust=-1)

mean(apps$Size, na.rm = T)

#number of developers by category 
dev = apps %>%
  group_by(Category) %>%
  summarise(Number = n_distinct(Developer))

ggplot(dev, aes(reorder(Category,-Number), Number, fill = Category)) + geom_bar(stat = 'identity') + xlab('Category') + scale_fill_brewer(palette = 'Paired') +
  theme(plot.title = element_text(hjust = 0.5), legend.position="none") + ggtitle('Number of App Developers by Category')
 
dev1 = apps %>%
  group_by(Developer, Category) %>%
  summarise(count = n()) %>%
  group_by(Developer) %>%
  summarise(`Number of Categories` = n())

ggplot(dev1, aes(`Number of Categories`)) + geom_bar(stat = 'count', fill = "Green4") + ggtitle('Number of App Developers by Contribution to Each Category') +
  geom_text(stat = 'count', aes(label=..count..), vjust=-1) + theme(plot.title = element_text(hjust = 0.5))



