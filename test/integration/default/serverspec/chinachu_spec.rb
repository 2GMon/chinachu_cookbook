require 'serverspec'

set :backend, :exec

describe "packages installed" do
  %w!build-essential curl git-core libssl-dev yasm
  libtool autoconf libboost-all-dev expect!.each do |pkg|
    context package(pkg) do
      it { should be_installed }
    end
  end
end

describe "libyasm 1.2.0 installed" do
  %w!/usr/local/lib/libyasm.a
  /usr/local/include/libyasm.h
  /usr/local/include/libyasm-stdint.h!.each do |f|
    context file(f) do
      it { should be_file }
    end
  end

  context file('/usr/local/include/libyasm') do
    it { should be_directory }
  end
end

describe user('chinachu') do
  it { should exist }
  it { should belong_to_group 'sudo' }
  it { should have_home_directory '/home/chinachu' }
end

describe 'chinachu installed' do
  %w!/home/chinachu/chinachu
  /home/chinachu/chinachu/node_modules!.each do |f|
    context file(f) do
      it { should be_directory }
      it { should be_owned_by 'chinachu' }
      it { should be_mode 755 }
    end
  end

  %w!/home/chinachu/chinachu/.nave/node
  /home/chinachu/chinachu/.nave/npm!.each do |f|
    context file(f) do
      it { should be_symlink }
      it { should be_mode 777 }
      it { should be_owned_by 'chinachu' }
    end
  end

  %w!/home/chinachu/chinachu/usr/bin/avconv
  /home/chinachu/chinachu/usr/bin/avprobe
  /home/chinachu/chinachu/usr/bin/epgdump!.each do |f|
    context file(f) do
      it { should be_file }
      it { should be_mode 755 }
      it { should be_owned_by 'chinachu' }
    end
  end

  %w!/etc/init.d/chinachu-operator
  /etc/init.d/chinachu-wui!.each do |f|
    context file(f) do
      it { should be_file }
      it { should be_mode 755 }
      it {should be_owned_by 'root' }
    end
  end

  %w!chinachu-operator chinachu-wui!.each do |srv|
    context service(srv) do
      it { should be_enabled }
      it { should be_running }
    end
  end
end

describe 'nginx installed' do
  context package('nginx') do
    it { should be_installed }
  end

  context service('nginx') do
    it { should be_enabled }
    it { should be_running }
  end

  context file('/etc/nginx/nginx.conf') do
    it { should be_file }
    it { should be_mode 644 }
    it { should be_owned_by 'root' }
  end
end
