data_bag('users').each do |login|
  u             = data_bag_item("users", login)
  u["username"] = login    if u["username"].nil?
  u["action"]   = "create" if u["action"].nil?


  home_basedir = node["platform_family"] == "mac_os_x" ? "/Users" : "/home"
  home_dir = u["home"] ? u["home"] : "#{home_basedir}/#{u["username"]}"


  if u["ssh_keys"] && !!u["manage_home"] && u["action"] == "create"
    directory "#{home_dir}/.ssh" do
      owner u['username']
      group u['gid'] || u['username']
      mode "0700"
    end

    template "#{home_dir}/.ssh/authorized_keys" do
      source "authorized_keys.erb"
      owner u["username"]
      group u["gid"] || u["username"]
      mode "0600"
      variables :ssh_keys => u["ssh_keys"]
    end
  end
end
