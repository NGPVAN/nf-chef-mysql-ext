directory "/mnt/dbtmp" do
    owner "mysql"
    group "mysql"
    mode "0755"
end

mount "/mnt/dbtmp" do
    device "none"
    fstype "tmpfs"
    options "defaults,size=10M"
    action [:mount, :enable]
    dump 0
    pass 0
end

template "/etc/apparmor.d/local/usr.sbin.mysqld" do
    source "apparmor.erb"
end

template "#{node['mysql']['confd_dir']}/extended.cnf" do
    source "extended.erb"
    owner "root" unless platform? 'windows'
    group node['mysql']['root_group'] unless platform? 'windows'
    mode "0644"
    case node['mysql']['reload_action']
    when 'restart'
        notifies :restart, resources(:service => "mysql"), :immediately
    when 'reload'
        notifies :reload, resources(:service => "mysql"), :immediately
    else
        Chef::Log.info "my.cnf updated but mysql.reload_action is #{node['mysql']['reload_action']}. No action taken."
    end
end


