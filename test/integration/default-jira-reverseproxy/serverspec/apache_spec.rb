require 'serverspec'

# Required by serverspec
set :backend, :exec

## Use Junit formatter output, supported by jenkins
#require 'yarjuf'
#RSpec.configure do |c|
#    c.formatter = 'JUnit'
#end


describe service('httpd'), :if => os[:family] == 'redhat' do
  it { should be_enabled }
  it { should be_running }
end

describe service('apache2'), :if => os[:family] == 'ubuntu' do
  it { should be_enabled }
  it { should be_running }
end

describe command('apachectl -M'), :if => os[:family] == 'redhat' do
  its(:stdout) { should match /proxy/ }
  its(:stdout) { should match /remoteip/ }
  its(:stdout) { should match /rewrite/ }
  its(:stdout) { should match /ratelimit/ }
  its(:exit_status) { should eq 0 }
end

describe command('apache2ctl -M'), :if => os[:family] == 'ubuntu' do
  its(:stdout) { should match /proxy/ }
  its(:stdout) { should match /remoteip/ }
  its(:stdout) { should match /rewrite/ }
  its(:stdout) { should match /ratelimit/ }
  its(:exit_status) { should eq 0 }
end

describe port(80) do
  it { should be_listening.with('tcp6') }
end
