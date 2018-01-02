#!/bin/bash -x

echo "Starting..."

echo 2 > /sys/class/gpio/export #「GPIO2」を使う
sleep 1

echo out > /sys/class/gpio/gpio2/direction #「GPIO2」を出力用に使う

echo 1 > /sys/class/gpio/gpio2/value #点灯
sleep 1                              #1秒休む
echo 0 > /sys/class/gpio/gpio2/value #消灯
sleep 1

echo 1

echo 1 > /sys/class/gpio/gpio2/value
sleep 1
echo 0 > /sys/class/gpio/gpio2/value
sleep 1

echo 2

echo 1 > /sys/class/gpio/gpio2/value
sleep 1
echo 0 > /sys/class/gpio/gpio2/value
sleep 1

echo 3

echo 2 > /sys/class/gpio/unexport #「GPIO2」の使用を終了

echo "Done."
