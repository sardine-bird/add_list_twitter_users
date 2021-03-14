require 'twitter' #twitterの読み込み
require 'dotenv'
Dotenv.load

#作成したTwitterアプリにアクセスする情報を記載する
@client = Twitter::REST::Client.new do |config|
    config.consumer_key = ENV['twitter_api_key']
    config.consumer_secret = ENV['twitter_api_key_secret']
    config.access_token = ENV['twitter_access_token']
    config.access_token_secret = ENV['twitter_access_token_secret']
end

## 本番
def read_listed_users
	@list=nil

	@client.lists.each do |l|
		@list=l if l.name=="技育祭2021参加者" #ここを変更すると追加先のリストを変えることが出来る。
	end

	@listed_users_id=[]
	@client.list_members(@list).each do |list_member|
		@listed_users_id << list_member.screen_name
	end
end

def serach_matched_users
	counts=0
	tag="#技育祭" #ここを変更すると検索するタグを変えることが出来る。
	users_id=[]

	@client.search("#{tag}", ilang: 'ja', result_type: 'mixed', count: 50).map do |tweet|
		users_id << tweet.user.screen_name
		counts+=1
		p counts if counts%100==0
		break if counts==500
	end
	p "#{counts}/"

	@add_list_users_id=users_id.uniq-@listed_users_id
end

def add_list
	add_counts=0
	p "add_list_users=#{@add_list_users_id.length}"
	@add_list_users_id.each do |add_list_user_id|
		@client.add_list_member(@list.slug, add_list_user_id)
		add_counts+=1
		p "##{add_counts}" if add_counts%10==0
	end
	p "##{add_counts}/"
end

def main
	read_listed_users
	serach_matched_users
	add_list
end

main
