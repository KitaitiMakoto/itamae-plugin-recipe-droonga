execute "daemon-reload" do
  command "systemctl daemon-reload"
  action :nothing
end

%w[
  build-essential
  libssl-dev
  zlib1g-dev
  libreadline6-dev
].each do |pkg|
  package pkg
end

execute "install ruby" do
  command "cd /usr/local/src && " +
          "curl https://cache.ruby-lang.org/pub/ruby/2.2/ruby-2.2.3.tar.gz | " +
          "tar xzf - && " +
          "cd ruby-2.2.3 && " +
          "./configure && " +
          "make && " +
          "make install && " +
          "gem update --system && " +
          "gem update"
  not_if "type ruby"
end

execute "curl -sL https://deb.nodesource.com/setup_0.12 | bash" do
  not_if "test -e /etc/apt/sources.list.d/nodesource.list"
end

execute "sudo apt-get install -y nodejs" do
  not_if "type node"
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

template "/etc/logrotate.d/droonga-engine" do
  owner "root"
  group "root"
  mode  "644"
end

template "/etc/logrotate.d/droonga-http-server" do
  owner "root"
  group "root"
  mode  "644"
end

service "droonga-engine" do
  action [:enable, :start]
end

service "droonga-http-server" do
  action [:enable, :start]
end
