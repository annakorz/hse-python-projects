install.packages("tidyverse")
library(tidyverse)
data <- read.csv("/Users/ann/github/hse-python-projects/capstone_project/user_fake_authentic_2class.csv")
View(data)
names(data)[names(data) == 'pos'] <- 'Num_posts'
names(data)[names(data) == 'flw'] <- 'Num_following'
names(data)[names(data) == 'flg'] <- 'Num_followers'
names(data)[names(data) == 'bl'] <- 'Biography_length'
names(data)[names(data) == 'pic'] <- 'Picture_availability'
names(data)[names(data) == 'lin'] <- 'Link_availability'
names(data)[names(data) == 'cl'] <- 'Average_caption_len'
names(data)[names(data) == 'cz'] <- 'Caption_zero'
names(data)[names(data) == 'ni'] <- 'Non_image_perc'
names(data)[names(data) == 'erl'] <- 'Engagement_rate_likes'
names(data)[names(data) == 'erc'] <- 'Engagement_rate_comm'
names(data)[names(data) == 'lt'] <- 'Location_tag_perc'
names(data)[names(data) == 'hc'] <- 'Average_hashtag_count'
names(data)[names(data) == 'pr'] <- 'Promotional_keywords_in_hashtags'
names(data)[names(data) == 'fo'] <- 'Followers_keywords'
names(data)[names(data) == 'cs'] <- 'Cosine_similarity'
names(data)[names(data) == 'pi'] <- 'Post_interval_in_h'
names(data)[names(data) == 'class'] <- 'label'
data$label[data$label == "f"] <- "bot" 
data$label[data$label == "r"] <- "human" 
View(data)

bots <- data %>% 
  filter(label == "bot")

View(bots)

humans <- data %>% 
  filter(label == "human")

View(humans)

# usually x is independent var and y is dependent var
ggplot(data = bots,
       mapping = aes(x = Num_followers,
                     y = Num_following))+
  geom_point(size = 5)+
  geom_line(color = 'red')
  

ggplot(humans, aes(Num_followers, Num_following))+
  geom_point()+
  geom_line(color = 'red')

# Bots abnormal behaviour on instagram
data %>% 
  ggplot(aes(Average_hashtag_count, Followers_keywords, colour = label))+
  geom_point(size = 3, alpha = 0.5)+
 # geom_smooth(method = lm, se = F)+
 # facet_wrap(~Type)
  labs(x = "Average number of hashtags in a post",
       y = "Keywords in hashtags to attract followers",
         title = "Keywords in hashtags to hunt followers")+
  theme_bw()

data %>%
  ggplot(aes(x = Average_hashtag_count, 
        y = Promotional_keywords_in_hashtags,
        colour = label))+
  geom_point(size = 3, alpha = 0.5)+
  labs(x = "Average number of hashtags in a post",
       y = "Promotional keywords in hashtags",
       title = "Promotional keywords in hashtags")+
  theme_minimal()

# Followers vs Following
data %>% 
  ggplot(aes(x = Num_followers,
             y = Num_following,
             size = Num_posts,
             color = Non_image_perc))+
  geom_point()+
  facet_wrap(~label)+
  labs(title = "Followers vs Following",
       x = 'Number of followers',
       y = "Number of subscriptions")+
  theme_minimal()
  
# Likes vs Comments
data %>% 
  ggplot(aes(x = Engagement_rate_likes,
             y = Engagement_rate_comm,
             size = Num_posts,
             color = Biography_length))+
  geom_point()+
  facet_wrap(~label)

data %>% 
  ggplot(aes(Num_posts, Average_caption_len))+
  geom_point(aes(colour = label, 
                 size = Num_followers),
             alpha = 0.5)+
  geom_smooth(method = lm)+

data %>% 
  ggplot(aes(label, Num_posts))+
  geom_boxplot()+
  geom_point(alpha = 0.5, 
             aes(size = Biography_length, 
                 colour = Num_followers))+
  coord_flip()+
  theme_bw()


data %>% 
  ggplot(aes(Engagement_rate_likes, Engagement_rate_comm, colour = label))+
  geom_point()

humans %>% 
  ggplot(aes(Post_interval_in_h, Num_posts))+
  geom_point()

#Benford's Law analysis

install.packages("benford.analysis")
library(benford.analysis)
trends <- benford(data$Num_followers, 
                   number.of.digits = 2)
trends
plot(trends)

#Prints the digits by decreasing order of discrepancies
suspectsTable(trends)
#Get observations of the 2 most suspicious groups
suspects <- getSuspects(trends, data, how.many = 1)
head(suspects)
suspects[suspects$label == "bot"] # about 9300
suspects[suspects$label == "human"] #about 3000
#Prints the duplicates by decreasing order
head(duplicatesTable(trends))

#Gets the observations of the 2 values with most duplicates
duplicates <- getDuplicates(trends, data, how.many = 2)
head(duplicates)
#Gets the Mean Absolute Deviation
MAD(trends)

#Gets the Chi-squared test
chisq(trends)

# Gets observations  starting with 50 or 99
digits_50_and_99 <- getDigits(trends, data, digits=c(50, 99))

trends_bots <- benford(bots$Num_followers, 
                  number.of.digits = 2,
                  #discrete = T,
                  sign = "positive")
trends_bots
head(duplicatesTable(trends_bots))
plot(trends_bots)

trends_humans <- benford(humans$Num_followers, 
                  number.of.digits = 2,
                  #discrete = T,
                  sign = "positive")
trends_humans
head(duplicatesTable(trends_humans))
plot(trends_humans)
#First digit analysis: Initial test of sensibleness
#Second digit test: Used as an additional test to establish whether 
#the assumption of Benford's distribution is reasonable.

trends_bots_following <- benford(bots$Num_following, 
                  number.of.digits = 1,
                  discrete = T,
                  sign = "positive")
trends_bots_following
plot(trends_bots_following)

trends_humans_following <- benford(humans$Num_following, 
                                 number.of.digits = 1,
                                 discrete = T,
                                 sign = "positive")
trends_humans_following
plot(trends_humans_following)

trends_bots_cos <- benford(bots$Cosine_similarity, 
                                 number.of.digits = 1,
                                 discrete = T,
                                 sign = "positive")
trends_bots_cos
plot(trends_bots_cos)

trends_humans_cos <- benford(humans$Cosine_similarity, 
                                   number.of.digits = 1,
                                   discrete = T,
                                   sign = "positive")
trends_humans_cos
plot(trends_humans_cos)

bots_cos <- benford(bots$Cosine_similarity)
suspectsTable(bots_cos)

