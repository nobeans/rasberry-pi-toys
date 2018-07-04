# Raspberryで赤外線リモコン on raspbian/stretch

OSのバージョンによって、設定が違うので注意する。

## 環境構築

Lircをインストールする。

```
sudo apt-get install lirc
```

設定を変更する。

```
sudo cp conf/lirc_options.conf /etc/lirc/lirc_options.conf
cat conf/lircd-*.conf | sudo tee /etc/lirc/lircd.conf
```

Lircのカーネルモジュールを有効にする(?)。

```
cat /boot/config.txt
...
dtoverlay=lirc-rpi
dtparam=gpio_in_pin=7
dtparam=gpio_out_pin=8
dtparam=gpio_in_pull=up
```

再起動する。

```
sudo reboot
```

`/dev/lirc0`ができていたら成功。

```
ls /dev/lirc*
```


## 赤外線を送信する

```
# 全部の設定を見る
irsend LIST "" ""

# bose向けの設定を見る
irsend LIST bose ""

# 送信する
irsend SEND_ONCE bose on
```


## 設定を追加する

```
# 受信モードにする
sudo mode2 -d /dev/lirc0
```

を実行してから、赤外線センサに向けて信号を送信すると、標準出力に送信データの情報が秋つ力される。
出力の最初の行(数字の大きなもの)を無視して、それ以外の数字をスペース区切りで列挙したものを取得する。

lircdサービスが起動していると、mode2コマンドが失敗するので、以下のコマンドで停止する。

```
sudo service lircd stop
```

赤外線データが取得できたら再び起動しておく。

```
sudo service lircd start
```

このディレクトリの既存の設定を参考にファイルを追加する。
データが不正だと、しれっと登録が空のようにみえるので注意。

`/etc/lirc/lircd.conf`に以下のように設定を反映する。

```
cat conf/lircd-*.conf | sudo tee /etc/lirc/lircd.conf
```


## 参考URL

* <https://qiita.com/KAKY/items/55e6c54fa2073cdc0bbe>
* <https://qiita.com/Library/items/35eec18fbe11387be6d5>
* <https://qiita.com/gao_/items/e8394656003f349952d6>
* <https://qiita.com/ponkio-o/items/4e7f8dd6e05378ca9ceb> (重要)
* <http://www.neko.ne.jp/~freewing/raspberry_pi/raspberry_pi_stretch_lirc_ir_remote_control_2017/> (for stretch)
