if node['mysql']['extended']['server_id'].nil?
    node['mysql']['extended']['server_id'] = Time.now.getutc.to_i
end

if not node['mysql']['extended']['tmpdir'].eql? '/tmp'
    directory node['mysql']['extended']['tmpdir'] do
        owner "mysql"
        group "mysql"
        mode "0755"
    end
end

if not node['mysql']['extended']['ramdisk'].nil?
    mount node['mysql']['extended']['tmpdir'] do
        device "none"
        fstype "tmpfs"
        options "defaults,size=#{node['mysql']['extended']['ramdisk']}"
        action [:mount, :enable]
        dump 0
        pass 0
    end
end

if not node['mysql']['extended']['datadir_device_mount_point'].nil?
    directory node['mysql']['extended']['datadir_device_mount_point'] do
        owner "mysql"
        group "mysql"
        mode "0755"
    end
end

if not node['mysql']['extended']['datadir_device'].nil?
    mount node['mysql']['extended']['datadir_device_mount_point'] do
        device node['mysql']['extended']['datadir_device']
        fstype "auto"
        options "defaults,nobootwait"
        action [:mount, :enable]
        dump 0
        pass 2
    end
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


