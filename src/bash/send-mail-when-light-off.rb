# -*- coding: utf-8 -*-
require 'pi_piper'
require 'action_mailer'
require 'yaml'

#
# $HOME/.mail-conf/yaml
# smtp:
#   address:   xxxx
#   port:      xxxx
#   domain:    xxxx
#   user_name: xxxx
#   password:  xxxx
#
# mail:
#   to:        xxxx
#   from:      xxxx
#
$config = YAML.load_file("#{ENV["HOME"]}/.mail-conf.yaml")

ActionMailer::Base.delivery_method = :smtp
ActionMailer::Base.smtp_settings = {
  address:   $config["smtp"]["address"],
  port:      $config["smtp"]["port"],
  domain:    $config["smtp"]["domain"],
  user_name: $config["smtp"]["user_name"],
  password:  $config["smtp"]["password"],
  authentication: 'plain',
}

class Notifier < ActionMailer::Base
  def sendmail(body)
    mail(
      to:      $config["mail"]["to"],
      from:    $config["mail"]["from"],
      subject: 'Changed lightness',
      body:    body.to_s
    ).deliver
  end
end

lastLightLevel = 0
loop do
  lightLevel = 0
  PiPiper::Spi.begin do |spi|
    raw = spi.write [0b01101000,0]
    lightLevel = ((raw[0]<<8) + raw[1]) & 0x03FF
  end
  puts "#{lastLightLevel} -> #{lightLevel}"
  if lightLevel < lastLightLevel - 5 then
    puts "Sending..."
    Notifier.sendmail("現在の部屋の明かりの値は#{lightLevel}です。(元の明るさ: #{lastLightLevel})")
    puts "Sent."
  end
  lastLightLevel = lightLevel
  sleep 60 # sec
end
