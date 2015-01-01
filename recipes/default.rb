#
# Cookbook Name:: chinachu
# Recipe:: default
#
# Copyright 2015, Takaaki TSUJIMOTO
#
# All rights reserved - Do Not Redistribute
#

user 'chinachu' do
  action :create
  supports mnage_home: true
end

group 'sudo' do
  action :modify
  members 'chinachu'
  append true
end
