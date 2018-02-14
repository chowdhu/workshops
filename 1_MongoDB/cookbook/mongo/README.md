# MongoDB
Use this Chef recipe to successfully install MongoDB on a RHEL-based system.

# About this recipe
Use this Chef recipe to successfully install MongoDB on a RHEL-based system.

# Prerequistes
* Provision a RHEL system(This will act as a node where we will install MongoDB)
* Hosted chef or Chef server  
* Workstation with chefDK installed and configured to talk to the Chef Server

# Instructions
Perform the following on the workstation

* git clone https://github.com/chowdhu/workshops.git
* cd workshops/1_MongoDB/cookbook
* Upload the recipe to the Chef repo
	* knife upload cookbook mongo
* Retrieve cookbook list and validate
	* knife cookbook list
* Bootstrap the provisioned node using key based authentication
	* knife bootstrap 54.91.78.126 --ssh-user ec2-user --sudo --identity-file ~/.ssh/awskey.pem --node-name node1-rhel-mongo --run-list 'recipe[mongo]'
* Bootstrap the provisioned node using password authentication
	* knife bootstrap <ipaddress> --ssh-user <USER> --ssh-password <password> --sudo --use-sudo-password --node-name <node1-centos-mongo> --run-list <'recipe[default]'>
* Test it again
	* knife ssh 'name:node1-rhel-mongo' 'sudo chef-client' --ssh-user ec2-user --identity-file ~/.ssh/awskey.pem
