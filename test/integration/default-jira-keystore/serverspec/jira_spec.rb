require 'serverspec'

# Required by serverspec
set :backend, :exec

## Use Junit formatter output, supported by jenkins
#require 'yarjuf'
#RSpec.configure do |c|
#    c.formatter = 'JUnit'
#end


describe service('jira') do
  it { should be_enabled }
  it { should be_running }
end  

describe command('java -version') do
  its(:stderr) { should match /1.8/ }
  its(:exit_status) { should eq 0 }
end

describe process("java") do
  its(:user) { should eq "jira" }
  its(:args) { should match /-Djira.home=\/var\/atlassian\/application-data\/jira/ }
end

## missing 'ss' on centos/redhat7? ensure iproute package present
describe port(8080) do
  it { should be_listening.with('tcp') }
end

describe file('/opt/atlassian/jira/current/conf/server.xml') do
  it { should be_file }
  its(:content) { should match /Atlassian JIRA Standalone Edition Tomcat Configuration/ }
  its(:content) { should match /<Connector port="8080"/ }
end
describe file('/opt/atlassian/jira/current/logs/catalina.out') do
  it { should be_file }
  its(:content) { should match /Server version:/ }
  its(:content) { should match /JIRA starting.../ }
  its(:content) { should match /Java Compatibility Information/ }
  its(:content) { should match /Starting ProtocolHandler \[http-nio-8080\]/ }
#  its(:content) { should_not match /ERROR / }
end
