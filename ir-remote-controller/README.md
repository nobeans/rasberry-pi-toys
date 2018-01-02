# Raspberryで赤外線リモコン

## 赤外線を送信する

```
# 全部の設定を見る
$ irsend LIST "" ""

# bose向けの設定を見る
$ irsend LIST bose ""

# 送信する
$ irsend SEND_ONCE bose on
```


## 設定を追加する

```
# lircを止めてから
sudo service lirc stop

# 受信モードにする
sudo mode2 -d /dev/lirc0
```

を実行した、出力の最初の行(数字の大きなもの)を無視して、それ以外の数字をスペース区切りで列挙したものを取得する。

このディレクトリの既存の設定を参考にファイルを追加する。
データが不正だと、しれっと登録が空のようにみえるので注意。

`/etc/lirc/lircd.conf`に以下のように設定を反映する。

```
sudo sh -c "cat lirc-*.conf > /etc/lirc/lircd.conf"
```


## 参考URL

* https://qiita.com/KAKY/items/55e6c54fa2073cdc0bbe
* https://qiita.com/Library/items/35eec18fbe11387be6d5
* https://qiita.com/gao_/items/e8394656003f349952d6
* https://qiita.com/ponkio-o/items/4e7f8dd6e05378ca9ceb (重要)

