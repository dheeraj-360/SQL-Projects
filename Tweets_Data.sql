SELECT TOP (1000) [UserID]
      ,[Gender]
      ,[LocationID]
      ,[City]
      ,[State]
      ,[StateCode]
      ,[Country]
      ,[TweetID]
      ,[Hour]
      ,[Day]
      ,[Weekday]
      ,[IsReshare]
      ,[Reach]
      ,[RetweetCount]
      ,[Likes]
      ,[Klout]
      ,[Sentiment]
      ,[Lang]
      ,[text]
  FROM [Practice_DB].[dbo].[tweets-engagement-metrics];


--1-Retrieve the total number of tweets in the dataset.

select count(TweetID) as no_of_tweets , count(distinct TweetID) as total_unique_tweets from [dbo].[tweets-engagement-metrics]



--2-Find the number of distinct users (UserID) in the dataset.

select count(distinct UserID) as  distinct_users from [dbo].[tweets-engagement-metrics]


--3-Calculate the average number of likes per tweet.

select TweetID,avg(likes*1.0) as avg_likes from [dbo].[tweets-engagement-metrics]
group by TweetID
order by avg(likes) desc



--4-Identify tweets where the sentiment is 'Positive.' Display the TweetID and sentiment.

select TweetID,Sentiment
from [dbo].[tweets-engagement-metrics]
where Sentiment >0




--5-Count the number of tweets where IsReshare is true (1).
select count(TweetID) as no_of_tweets
from [dbo].[tweets-engagement-metrics] where IsReshare = 1


--6-List the top 5 users with the highest Reach. Display their UserID and Reach.
select UserID , Reach from(
select UserID, Reach , DENSE_RANK() OVER(ORDER BY Reach desc) as rnk from
[dbo].[tweets-engagement-metrics]) b where rnk <=5

/*
select TOP 5 UserID, Reach 
from
[dbo].[tweets-engagement-metrics] order by reach desc 
*/



--7-Find the most common language (Lang) used in tweets.


select TOp 1 Lang, count(Lang) as lang_freq from [dbo].[tweets-engagement-metrics]
group by Lang order by count(Lang) desc
-- en(English)

--8-Determine the average Klout score for male (Gender = 'Male') users.

select avg(klout*1.0) as avg_male_klout_score from [dbo].[tweets-engagement-metrics]
where Gender='Male'



--9-Retrieve tweets posted on weekdays (Monday to Friday).

select weekday,count(TweetID) as weekday_tweets
from [dbo].[tweets-engagement-metrics] where Weekday not in('Saturday','Sunday')
GROUP BY Weekday


select count(TweetID) as weekday_tweets
from [dbo].[tweets-engagement-metrics] where Weekday not in('Saturday','Sunday')



--10-Identify tweets with a Klout score greater than 50. Display the TweetID and Klout.

select TweetID,Klout
from [dbo].[tweets-engagement-metrics] 
where Klout>50




--11-Count the number of tweets posted from the United States (Country = 'United States').

select count(TweetID) as no_of_tweets
from [dbo].[tweets-engagement-metrics] 
where Country='United States'



--12-List tweets with the highest number of retweets. Display the TweetID and RetweetCount.

select TOP 5 TweetID,RetweetCount from [dbo].[tweets-engagement-metrics]

order by RetweetCount desc



--13-Find tweets with sentiment 'Negative' and Klout score less than 40.

select TweetID from [dbo].[tweets-engagement-metrics]
where sentiment < 0 and Klout <40



--14-Calculate the average Likes for tweets posted on weekends (Saturday and Sunday).

select weekday,avg(likes*1.0) as avg_likes_weekend
from [dbo].[tweets-engagement-metrics]
where Weekday in('Saturday','Sunday')
group by Weekday
/*
select weekday,(sum(likes*1.0)/count(likes)) as avg_likes_weekend
from [dbo].[tweets-engagement-metrics]
where Weekday in('Saturday','Sunday')
group by Weekday*/





--15-Retrieve tweets posted in the city of 'New York.'

select TweetID,text as Tweet_Posted from [dbo].[tweets-engagement-metrics] where City = 'New York City'



--16-Identify tweets where Reach is greater than 1000. Display the TweetID and Reach.

select TweetID,Reach
from [dbo].[tweets-engagement-metrics]
where Reach > 1000




--17-Find the user (UserID) with the highest total engagement (sum of RetweetCount and Likes).

WITH CTE as(
select 
userID , sum(RetweetCount) as Total_Retweets , sum(Likes) as Total_Likes 
from [dbo].[tweets-engagement-metrics]
Group by UserID)
 
select UserID,  Total_Retweets, Total_Likes 
from CTE
where Total_Retweets = (select max(Total_Retweets) from CTE) and 
Total_Likes  = (select max(Total_Likes) from CTE)


--18-List tweets with sentiment 'Neutral' and Lang as 'English.'

Select TweetID,text as Tweet
from [dbo].[tweets-engagement-metrics]
where sentiment=0 and Lang ='en'


--19-Calculate the total engagement (sum of RetweetCount and Likes) for each tweet.
select TweetID,text as Tweet, (sum(RetweetCount)+sum(Likes)) as Total_engagement_for_each_tweet
from [dbo].[tweets-engagement-metrics]
Group by TweetID,text 
order by (sum(RetweetCount)+sum(Likes)) desc






--20-Retrieve tweets with sentiment 'Positive' or 'Neutral' and Lang as 'English'  or 'Spanish.'

select TweetID
from [dbo].[tweets-engagement-metrics]
where sentiment >0 and (Lang = 'en' or Lang = 'es')

--en(spanish language code)



