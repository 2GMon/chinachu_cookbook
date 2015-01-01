require 'serverspec'

set :backend, :exec

describe user('chinachu') do
  it { should exist }
  it { should belong_to_group 'sudo' }
  it { should have_home_directory '/home/chinachu' }
end
