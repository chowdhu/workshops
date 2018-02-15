#
# Cookbook:: tomcat
# Spec:: default
#
# Copyright:: 2018, The Authors, All Rights Reserved.

require 'spec_helper'

describe 'tomcat::default' do
  context 'Unit tests on RHEL7.4' do
    let(:chef_run) do
      # for a complete list of available platforms and versions see:
      # https://github.com/customink/fauxhai/blob/master/PLATFORMS.md
      runner = ChefSpec::ServerRunner.new(platform: 'redhat', version: '7.3')
      runner.converge(described_recipe)
    end

    it 'converges successfully' do
      expect { chef_run }.to_not raise_error
    end

   it 'Test: Include java package' do
	expect(chef_run).to include_recipe('tomcat::java')
   end

   it 'Test: Install wget' do
	expect(chef_run).to install_package('wget')
   end

   it 'Test: Check group tomcat' do
	expect(chef_run).to create_group('tomcat')
   end

   it 'Test: Check user tomcat' do
	expect(chef_run).to create_user('tomcat')
   end

   it 'Test: Create a service' do
	expect(chef_run).to create_template('/etc/systemd/system/tomcat.service')
   end

   it 'Test: service started' do
	expect(chef_run).to start_service('tomcat')
   end

  end
end
