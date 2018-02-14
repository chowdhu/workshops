#
# Cookbook:: mongo
# Spec:: default
#
# Copyright:: 2018, The Authors, All Rights Reserved.

require 'spec_helper'

describe 'mongo::default' do
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

   it 'Test: create yum repo for mongo' do
	expect(chef_run).to create_template('/etc/yum.repos.d/mongodb.repo')
   end

   it 'Test: Install mongo' do
	expect(chef_run).to install_package('mongodb-org')
   end

   it 'Test: mongo service started' do
	expect(chef_run).to start_service('mongod')
   end

   it 'Test: mongo service enabled' do
	expect(chef_run).to enable_service('mongod')
   end
end
end
