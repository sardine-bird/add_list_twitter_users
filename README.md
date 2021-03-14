# add_list_twitter_usrs
特定のツイートをしたユーザーを一つのリストにまとめるツール(Ruby)
## 使い方
'''
rbuy add_list.rb
'''

## 背景
[技育祭2021]()参加中に、「参加者をひとつのリストにまとめてみたいな」と思いつき作成。
一般化のために、検索する単語などを標準入力に変更。

- 実際に作成したリスト：[技育祭2021参加者](https://twitter.com/i/lists/1370606588638109698)

## 注意点
twitter apiの仕様上、多数(>100)のユーザーを短時間にリスト追加するとリスト追加の制限を受ける。

制限は24時間程度で解除されたが、複数回繰り返した場合には凍結などの処置を受ける可能性もある。

あまり大規模には使用することは出来ない。

## 参考
- [twitter gem 公式ドキュメント](https://www.rubydoc.info/gems/twitter)
- [目的のハッシュタグを含むツイートを取得する|Qiita](https://qiita.com/abe-perorist/items/bc779e066a2eade6dfc4)
- [Twitter gemでツイート検索する場合の要点、及び:since_id指定を有効にするモンキーパッチ|Qiita](https://qiita.com/riocampos/items/6999a52460dd7df941ea)
- [Dotenv使ってみた|Qiita](https://qiita.com/ogawatti/items/e1e612b793a3d51978cc)
