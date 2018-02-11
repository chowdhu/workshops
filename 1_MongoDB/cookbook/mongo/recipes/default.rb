#
# Cookbook:: mongo
# Recipe:: default
#
# Copyright:: 2018, The Authors, All Rights Reserved.

template '/etc/yum.repos.d/mongodb.repo' do
  source 'mongodb.repo.erb'
end

package 'mongodb-org'

service 'mongod' do
  action [:enable, :start]
end

