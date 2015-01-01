#
# Cookbook Name:: chinachu
# Recipe:: default
#
# Copyright 2015, Takaaki TSUJIMOTO
#
# All rights reserved - Do Not Redistribute
#
%w!build-essential curl git-core libssl-dev yasm
  libtool autoconf libboost-all-dev!.each do |pkg|
  package pkg do
    action :install
  end
end

user 'chinachu' do
  action :create
  supports manage_home: true
  home "/home/chinachu"
  notifies :modify, 'group[sudo]', :immediately
end

group 'sudo' do
  action :modify
  members 'chinachu'
  append true
end
