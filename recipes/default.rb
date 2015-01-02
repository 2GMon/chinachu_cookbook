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

user node['chinachu']['user'] do
  action :create
  supports manage_home: true
  shell "/bin/bash"
  home "/home/#{node['chinachu']['user']}"
  notifies :modify, 'group[sudo]', :immediately
end

group 'sudo' do
  members node['chinachu']['user']
  append true
end

git "/home/#{node['chinachu']['user']}/chinachu" do
  repository 'git://github.com/kanreisa/Chinachu.git'
  user node['chinachu']['user']
  group node['chinachu']['user']
  notifies :run, 'execute[install_chinachu]', :immediately
end

execute "install_chinachu" do
  action :nothing
  group node['chinachu']['user']
  user node['chinachu']['user']
  cwd "/home/#{node['chinachu']['user']}/chinachu"
  environment('HOME' => '/home/chinachu')
  command "echo 1 | ./chinachu installer"
  not_if do
    File.exists?("/home/#{node['chinachu']['user']}/chinachu/node_modules") &&
    File.exists?("/home/#{node['chinachu']['user']}/chinachu/usr/bin/epgdump")
  end
  notifies :run, 'script[install_chinachu_init_script]', :immediately
end

script "install_chinachu_init_script" do
  action :nothing
  interpreter '/bin/bash'
  cwd "/home/#{node['chinachu']['user']}/chinachu"
  user 'root'
  group 'root'
  environment('USER' => node['chinachu']['user'])
  code <<-EOF
  ./chinachu service operator initscript > /tmp/chinachu-operator
  ./chinachu service wui initscript > /tmp/chinachu-wui
  chmod +x /tmp/chinachu-operator /tmp/chinachu-wui
  mv /tmp/chinachu-operator /tmp/chinachu-wui /etc/init.d/
  EOF
  not_if do
    File.exists?("/etc/init.d/chinachu-operator") &&
    File.exists?("/etc/init.d/chinachu-wui")
  end
end

%w!chinachu-operator chinachu-wui!.each do |srv|
  service srv do
    action [ :enable, :start ]
    supports restart: true
  end
end
