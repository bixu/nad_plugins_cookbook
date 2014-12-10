remote_file "#{Chef::Config[:file_cache_path]}/#{node['nad_plugins']['repo']}-#{node['nad_plugins']['git_revision']}" do
  source node['nad_plugins']['git_location']
  notifies :run, "bash[install_nad_plugins]"
end

bash "install_nad_plugins" do
  action :nothing
  code <<-EOH
  set -e
  tar -xzf #{node['nad_plugins']['repo']}-#{node['nad_plugins']['git_revision']}
  rsync -av #{node['nad_plugins']['repo']}-#{node['nad_plugins']['git_revision']}/node-agent.d #{node['nad']['install_path']}/node-agent.d
  EOH
end
