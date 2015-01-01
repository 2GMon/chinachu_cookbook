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

describe file('/home/chinachu/chinachu') do
  it { should be_directory }
end
