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

def read_listed_users
	@list=nil
	puts "アカウントを追加したいtiwtterリストの名前を教えてください"
	adding_list_name=gets.chomp
	@client.lists.each do |l|
		@list=l if l.name==adding_list_name
		break unless @list==nil
	end

	@listed_users_id=[]
	@client.list_members(@list).each do |list_member|
		@listed_users_id << list_member.screen_name
	end
end

def serach_matched_users
	counts=0
	puts "検索ワード(ハッシュタグなど)を入力して下さい。\n
				複数ある場合は半角スペースを空けること"
	search_words=gets.chomp
	users_id=[]
	
	puts "取得したツイート数(進捗)："
	@client.search("#{search_words} -rt", ilang: 'ja', result_type: 'mixed', count: 50).map do |tweet|
		users_id << tweet.user.screen_name
		counts+=1
		puts counts if counts%100==0
		break if counts==500
	end
	puts "取得したツイート数(最終結果)：#{counts}"

	@add_list_users_id=users_id.uniq-@listed_users_id
end

def add_list
	add_counts=0
	puts "リストに追加するユーザー数：#{@add_list_users_id.length}"
	puts "リストに追加したユーザー数(進捗)："
	@add_list_users_id.each do |add_list_user_id|
		@client.add_list_member(@list.slug, add_list_user_id)
		add_counts+=1
		puts add_counts if add_counts%20==0
	end
	puts "リストに追加したユーザー数(最終結果)：#{add_counts}"
end

def main
	read_listed_users
	serach_matched_users
	add_list
end

main
