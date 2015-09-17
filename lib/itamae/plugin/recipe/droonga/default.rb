execute "daemon-reload" do
  command "systemctl daemon-reload"
  action :nothing
end

execute "curl https://raw.githubusercontent.com/droonga/droonga-engine/master/install.sh | bash" do
  not_if "type droonga-engine"
end

file "/etc/init.d/droonga-engine" do
  action :delete
end

execute "curl https://raw.githubusercontent.com/droonga/droonga-http-server/master/install.sh | bash" do
  not_if "type droonga-http-server"
end

file "/etc/init.d/droonga-http-server" do
  action :delete
end

template "/lib/systemd/system/droonga-engine.service" do
  owner "root"
  group "root"
  mode  "644"
  notifies :run, "execute[daemon-reload]"
end

template "/lib/systemd/system/droonga-http-server.service" do
  owner "root"
  group "root"
  mode  "644"
  notifies :run, "execute[daemon-reload]"
end

service "droonga-engine" do
  action [:enable, :start]
end

service "droonga-http-server" do
  action [:enable, :start]
end
