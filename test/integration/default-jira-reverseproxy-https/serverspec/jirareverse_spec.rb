require 'serverspec'

# Required by serverspec
set :backend, :exec

## Use Junit formatter output, supported by jenkins
#require 'yarjuf'
#RSpec.configure do |c|
#    c.formatter = 'JUnit'
#end

describe command('curl -vkL https://localhost') do
  its(:stdout) { should match /<title>Jira - Jira setup<\/title>/ }
  its(:stdout) { should match /Set up application properties/ }
  its(:exit_status) { should eq 0 }
end

