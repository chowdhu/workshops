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
describe port(8080) do
  it { should be_listening }
  its('protocols') { should cmp 'tcp' }
end

describe package('java-1.7.0-openjdk-devel') do
  it { should be_installed }
end

describe service('tomcat') do
  it { should be_enabled }
  it { should be_running }
end

#gid 0 is root 
describe group('tomcat') do
  it { should exist }
  its('gid') { should_not eq 0 }
end

#uid 0 is root 
describe user('tomcat') do
  it { should exist }
  its('uid') { should_not eq 0 }
  its('groups') { should eq ['tomcat'] }
end

describe file('/etc/ssh/sshd_config') do
  its('content') { should match(/PasswordAuthentication no/) }
  its('content') { should match(/UsePAM yes/) }
  its('content') { should match(/#PermitRootLogin/) }
end
