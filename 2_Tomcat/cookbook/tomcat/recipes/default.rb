#
# Cookbook:: tomcat
# Recipe:: default
#
# Copyright:: 2018, The Authors, All Rights Reserved.

#Install the wget and java packages
#['wget','java-1.7.0-openjdk-devel'].each do |p|
#  package p do
#    action :install
#  end
#end

include_recipe 'tomcat::java'
package 'wget'

#Create a group called tomcat
group 'tomcat'

#Create a user called tomcat with group tomcat
user 'tomcat' do
  group 'tomcat'
  shell '/bin/nologin'
  home '/opt/tomcat'
  manage_home  false
end

#Creates a directory
directory 'createDir' do
  owner 'tomcat'
  group 'tomcat'
  mode '0755'
  path '/opt/tomcat'
  action :create
end

tcBinary = 'apache-tomcat-8.5.28.tar.gz'

#Download the binary
remote_file 'downloadBinary' do
  source 'http://archive.apache.org/dist/tomcat/tomcat-8/v8.5.28/bin/'+ tcBinary
  owner 'root'
  group 'root'
  mode '0755'
  path '/tmp/'+ tcBinary
  action :create
end

#Execute command
execute 'extractTar' do
  command 'tar xvf '+ tcBinary + ' -C /opt/tomcat --strip-components=1'
  cwd '/tmp'
  user 'root'
  not_if { File.exists?(tcBinary) }
end


#This bash script will download the tar file untars it and modifies permissions of the directory
bash 'install_tomcat' do
  user 'root'
  cwd '/tmp'
  code <<-EOH
  sudo chgrp -R tomcat /opt/tomcat
  sudo chmod -R g+r /opt/tomcat/conf
  sudo chmod g+x /opt/tomcat/conf
  sudo chown -R tomcat /opt/tomcat/webapps/ /opt/tomcat/work/ /opt/tomcat/temp/ /opt/tomcat/logs/
  EOH
end

#Create a service with the contents of the template
template '/etc/systemd/system/tomcat.service' do
  source 'tomcat.service.erb'
end

#Start and enable tomcat service on startup
#Enable a service after a restart or reload
service "tomcat" do
  supports :restart => true, :reload => true
  action [:enable,:start]
end
