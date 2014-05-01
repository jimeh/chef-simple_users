data_bag('users').each do |login|
  u             = data_bag_item("users", login)
  u["username"] = login    if u["username"].nil?
  u["action"]   = "create" if u["action"].nil?


  if !u["packages"].nil? && u["action"] != "remove"
    u["packages"].each do |pkgname|
      package(pkgname) { action :install }
    end
  end
end
