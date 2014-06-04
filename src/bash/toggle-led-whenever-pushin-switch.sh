#!/bin/bash

# Constant
GPIO_DIR=/sys/class/gpio
SWITCH_GPIO_NUM=24
LED_GPIO_NUM=25

# Tear down for previous
echo $SWITCH_GPIO_NUM > $GPIO_DIR/unexport
echo $LED_GPIO_NUM > $GPIO_DIR/unexport

# Setup
echo $SWITCH_GPIO_NUM > $GPIO_DIR/export
SWITCH_GPIO_DIR=$GPIO_DIR/gpio$SWITCH_GPIO_NUM
echo in > $SWITCH_GPIO_DIR/direction

echo $LED_GPIO_NUM > $GPIO_DIR/export
LED_GPIO_DIR=$GPIO_DIR/gpio$LED_GPIO_NUM
echo out > $LED_GPIO_DIR/direction

# Main
led_status=0
previous_switch_status=0
while true
do
    # Whenever pushing a task switch, toggle to turn on LED and off.
    if [ $( cat $SWITCH_GPIO_DIR/value ) -eq 1 ]; then
        if [ $previous_switch_status -eq 0 ]; then
            if [ $led_status -eq 0 ]; then
                echo 1 > $LED_GPIO_DIR/value
                led_status=1
            else
                echo 0 > $LED_GPIO_DIR/value
                led_status=0
            fi
        fi
        previous_switch_status=1
    else
        previous_switch_status=0
    fi
    sleep .0625
done

