if node["platform"] == "ubuntu"
  case node["platform_version"]
  when "12.04"
    package "libshadow-ruby1.8"
  end
end

data_bag('users').each do |login|
  u             = data_bag_item("users", login)
  u["username"] = login    if u["username"].nil?
  u["action"]   = "create" if u["action"].nil?


  home_basedir = node["platform_family"] == "mac_os_x" ? "/Users" : "/home"
  home_dir = u["home"] ? u["home"] : "#{home_basedir}/#{u["username"]}"


  user u["username"] do
    uid       u["uid"]       if u["uid"]
    gid       u["gid"]       if u["gid"]
    home      home_dir
    shell     u["shell"]     if u["shell"]
    password  u["password"]  if u["password"]
    system    u["system"]    if u["system"]
    action    u["action"]
    comment   u["comment"]   if u["comment"]

    supports(
      :manage_home => !!u["manage_home"],
      :non_unique  => !!u["non_unique"])
  end
end
