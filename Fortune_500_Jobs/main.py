import tweepy
import pandas as pd
import re
tweet_info_df = []
twitter_user_info_df = []
twitter_hashtags_df = []
consumer_key="lvc6xmqOfUqOezSVO5eLT75GH"
consumer_secret="UeKPGEQVAv8DFpXAmYJysLg9R8nM3umlQ8wbRD76hRKNlxzTNg"
access_token="1591050207160049668-enzKWeCoGK8SAgH7SE694BDJJESuEI"
access_token_secret="WNJ6ZnGuXMKRN6vH8j6yquE7H45kebxx4Mf8SLnVdTRlc"

auth = tweepy.OAuthHandler(consumer_key, consumer_secret)
auth.set_access_token(access_token, access_token_secret)
api = tweepy.API(auth)
extracted_company_tweets = []
company_twitter_profile_names_df = pd.read_excel('Fortune_500_Twitter_Handle_List.xlsx', sheet_name="Sheet1")
for i in range(len(company_twitter_profile_names_df)):
    scrn_name = company_twitter_profile_names_df.loc[i, "Fortune_500"]
    for tweet in tweepy.Cursor(api.user_timeline, screen_name=scrn_name, tweet_mode="extended").items(200):
        extracted_company_tweets.append(tweet)

tweet_id = []
twitter_handle_id = []
twitter_handle_name = []
tweet_text = []
tweet_urls = []
tweet_fav_counts = []
created_at = []

for i in extracted_company_tweets:
  tweet_id.append(i.id_str)
  twitter_handle_id.append(i.user.id)
  twitter_handle_name.append(i.user.screen_name)
  tweet_text.append(i.full_text)
  if i.entities["urls"]:
    tweet_urls.append(i.entities["urls"][0]["url"])
  else:
    tweet_urls.append("")
  tweet_fav_counts.append(i.favorite_count)
  created_at.append(i.created_at)

tweet_info_df = pd.DataFrame({"tweet_id":tweet_id, "twitter_handle_id":twitter_handle_id, "tweet_text":tweet_text, "tweet_urls":tweet_urls, "tweet_favorite_count":tweet_fav_counts, "created_at":created_at})

twitter_handle_id = []
twitter_handle_name = []
profile_image_url = []
description = []
followers_count = []
following_count = []
verified = []
acc_created_at = []

for i in extracted_company_tweets:
  twitter_handle_id.append(i.user.id_str)
  twitter_handle_name.append(i.user.screen_name)
  profile_image_url.append(i.user.profile_image_url)
  description.append(i.user.description)
  followers_count.append(i.user.followers_count)
  following_count.append(i.user.friends_count)
  verified.append(i.user.verified)
  acc_created_at.append(i.user.created_at)

twitter_user_info_df = pd.DataFrame({"twitter_handle_id":twitter_handle_id,
                                     "twitter_handle_name":twitter_handle_name,
                                     "profile_image_url":profile_image_url,
                                     "description":description,
                                     "followers_count":followers_count,
                                     "following_count":following_count,
                                     "verified":verified,
                                     "account_created_at":acc_created_at})
twitter_user_info_df = twitter_user_info_df.drop_duplicates()

tweet_id_hashtags = []
hashtags = []

for i in extracted_company_tweets:
  hashtag = re.findall("#([a-zA-Z0-9_]{1,50})", i.full_text)
  hashtags.append(hashtag)
  tweet_id_hashtags.append(i.id_str)
twitter_hashtags_df = pd.DataFrame({"tweet_id":tweet_id_hashtags, "hashtag":hashtags})
twitter_hashtags_df_1 = twitter_hashtags_df.hashtag.apply(pd.Series, dtype=object) \
    .merge(twitter_hashtags_df, right_index = True, left_index = True) \
    .drop(["hashtag"], axis = 1) \
    .melt(id_vars = ['tweet_id'], value_name = "hashtags") \
    .drop("variable", axis = 1)\
    .dropna()

from sqlalchemy import create_engine
my_conn = create_engine("sqlite:///Jobs.db", echo = True)
twitter_user_info_df.to_sql(con=my_conn,name='company_twitter_profile',if_exists='append',index=False)
twitter_hashtags_df_1.to_sql(con=my_conn,name='company_tweet_hashtags',if_exists='append',index=False)
tweet_info_df.to_sql(con=my_conn, name='company_tweets_info',if_exists='append', index=False)