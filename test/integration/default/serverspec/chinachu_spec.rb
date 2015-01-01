require 'serverspec'

set :backend, :exec

describe "packages installed" do
  %w!build-essential curl git-core libssl-dev yasm
  libtool autoconf libboost-all-dev!.each do |pkg|
    context package(pkg) do
      it { should be_installed }
    end
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
