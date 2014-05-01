include_recipe "simple_users::install_packages"
include_recipe "simple_users::create_users"
include_recipe "simple_users::install_ssh_keys"
include_recipe "simple_users::assign_groups"
