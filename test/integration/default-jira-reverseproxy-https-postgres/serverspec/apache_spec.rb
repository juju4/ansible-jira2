require 'serverspec'

# Required by serverspec
set :backend, :exec

## Use Junit formatter output, supported by jenkins
#require 'yarjuf'
#RSpec.configure do |c|
#    c.formatter = 'JUnit'
#end


describe service('apache2') do
  it { should be_enabled }
  it { should be_running }
end  

describe command('apache2ctl -M') do
  its(:stdout) { should match /proxy/ }
  its(:stdout) { should match /remoteip/ }
  its(:stdout) { should match /rewrite/ }
  its(:stdout) { should match /ratelimit/ }
  its(:exit_status) { should eq 0 }
end

describe port(443) do
  it { should be_listening.with('tcp') }
end
