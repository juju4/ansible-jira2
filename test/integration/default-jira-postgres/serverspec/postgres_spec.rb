require 'serverspec'

# Required by serverspec
set :backend, :exec

# RedHat only for now
#var_dir = '/var/lib/pgsql'
var_dir = '/var/lib/pgsql/9.6'

describe service('postgresql'), :if => os[:family] == 'ubuntu' do
  it { should be_enabled   }
  it { should be_running   }
end

describe service('postgresql-9.6'), :if => os[:family] == 'redhat' do
  it { should be_enabled   }
  it { should be_running   }
end

describe process("postmaster"), :if => os[:family] == 'redhat' do
  its(:user) { should eq "postgres" }
end
describe process("postgres"), :if => os[:family] == 'ubuntu' do
  its(:user) { should eq "postgres" }
  its(:args) { should match /main\/postgresql.conf/ }
end

describe port(5432) do
  it { should be_listening }
end

describe file('/var/lib/postgresql/9.5/main'), :if => os[:family] == 'ubuntu' && os[:release] == '16.04' do
  it { should be_directory }
end
describe file('/etc/postgresql/9.5/main'), :if => os[:family] == 'ubuntu' && os[:release] == '16.04' do
  it { should be_directory }
end
describe file('/etc/postgresql/9.5/main/pg_hba.conf'), :if => os[:family] == 'ubuntu' && os[:release] == '16.04' do
  it { should be_file }
end
describe file('/usr/lib/postgresql/9.5/bin'), :if => os[:family] == 'ubuntu' && os[:release] == '16.04' do
  it { should be_directory }
end

describe file('/var/lib/postgresql/9.3/main'), :if => os[:family] == 'ubuntu' && os[:release] == '14.04' do
  it { should be_directory }
end
describe file('/etc/postgresql/9.3/main'), :if => os[:family] == 'ubuntu' && os[:release] == '14.04' do
  it { should be_directory }
end
describe file('/etc/postgresql/9.3/main/pg_hba.conf'), :if => os[:family] == 'ubuntu' && os[:release] == '14.04' do
  it { should be_file }
end
describe file('/usr/lib/postgresql/9.3/bin'), :if => os[:family] == 'ubuntu' && os[:release] == '14.04' do
  it { should be_directory }
end

describe file("#{var_dir}"), :if => os[:family] == 'redhat' do
  it { should be_directory }
end
describe file("#{var_dir}/data/pg_hba.conf"), :if => os[:family] == 'redhat' do
  it { should be_file }
end
