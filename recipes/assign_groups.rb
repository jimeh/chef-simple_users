group_additions = {}

data_bag('users').each do |login|
  u             = data_bag_item("users", login)
  u["username"] = login    if u["username"].nil?
  u["action"]   = "create" if u["action"].nil?


  if !u["groups"].nil? && u["action"] != "remove"
    u["groups"].each do |group_name|
      group_additions[group_name] ||= []
      group_additions[group_name] << u["username"]
    end
  end
end

group_additions.each do |group_name, group_members|
  group group_name do
    members group_members
    append true
  end
end
