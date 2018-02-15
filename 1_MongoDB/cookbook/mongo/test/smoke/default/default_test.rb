# # encoding: utf-8

# Inspec test for recipe mongo::default

# The Inspec reference, with examples and extensive documentation, can be
# found at http://inspec.io/docs/reference/resources/

#my instance is on EC2 
unless os.windows?
  describe user('root') do
    it { should exist }
  end
end

#Running on default port
describe port(27017) do
  it { should be_listening }
  its('protocols') { should cmp 'tcp' }
end

describe package('mongodb-org') do
  it { should be_installed }
end

describe service('mongod') do
  it { should be_enabled }
  it { should be_running }
end

describe file('/etc/ssh/sshd_config') do
  its('content') { should match(/PasswordAuthentication no/) }
  its('content') { should match(/UsePAM yes/) }
  its('content') { should match(/#PermitRootLogin/) }
end

#describe sshd_config do
#  its('PasswordAuthentication') { should cmp 'no' }
#  its('UsePAM') { should eq 'yes' }
#end
