#
# Cookbook Name:: chinachu
# Recipe:: default
#
# Copyright 2015, Takaaki TSUJIMOTO
#
# All rights reserved - Do Not Redistribute
#
%w!build-essential curl git-core libssl-dev yasm
  libtool autoconf libboost-all-dev expect!.each do |pkg|
  package pkg do
    action :install
  end
end

execute 'install_yasm' do
  command "wget -O - http://www.tortall.net/projects/yasm/releases/yasm-1.2.0.tar.gz | tar zxvf - && cd yasm-1.2.0
./configure --prefix /usr/local && make && make install
"
  user "root"
  cwd "/root"
  not_if do
    File.exists?("/usr/local/include/libyasm") &&
      File.exists?("/usr/local/lib/libyasm.a")
  end
end

user 'chinachu' do
  action :create
  supports manage_home: true
  home "/home/chinachu"
  notifies :modify, 'group[sudo]', :immediately
end

group 'sudo' do
  members 'chinachu'
  append true
  notifies :sync, 'git[/home/chinachu/chinachu]', :immediately
end

git '/home/chinachu/chinachu' do
  repository 'git://github.com/kanreisa/Chinachu.git'
  user 'chinachu'
end
