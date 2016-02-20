install.packages("Rfacebook")
install.packages("httpuv")
install.packages("RColorBrewer")
install.packages("RCurl")
install.packages("rjson")
install.packages("httr")
install.packages("car")

library(Rfacebook)
library(httpuv)
library(RColorBrewer)
library(car)

#Set-up for Facebook Connection
myaccess_token=###insert_your_access_token_here###
mypage_id=###insert_your_page_id_here###
options(RcurlOptions=list(verbose=FALSE,
                          capath=system.file("CurlSSL",
                                             "cacert.pem",
                                             package="Rcurl"),
                          ssl.verifypeer=FALSE))
#Get page I want to analyze
page <- getPage(mypage_id, myaccess_token, n= 100)
#Facebook time format
f = "%Y-%m-%dT%H:%M:%S%z"
#Get post creation date in POSIXt format
createdtime = strptime(page$created_time, f)
#Round it by hours
createdtime = round(createdtime, units="hours")
#Use only the hour of the date
hourtable = createdtime$hour
#Make tables using the like_count, share_count and comment_count
likesbytime = table(page$likes_count,hourtable)
sharesbytime = table(page$shares_count,hourtable)
commentsbytime = table(page$comments_count,hourtable)
#Plot them
scatterplot( page$likes_count ~ hourtable, data = page,
             xlab = "Hour of created post",  ylab = "Number of likes",
             main = "Like count by hour of creation")
scatterplot( page$shares_count ~ hourtable, data = page,
             xlab = "Hour of created post",  ylab = "Number of shares",
             main = "Share count by hour of creation")
scatterplot( page$comments_count ~ hourtable, data = page,
             xlab = "Hour of created post",  ylab = "Number of comments",
             main = "Comment count by hour of creation")
