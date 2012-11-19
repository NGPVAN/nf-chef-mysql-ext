default['mysql']['extended']['server_id'] = nil

default['mysql']['extended']['character_set'] = 'utf8'
default['mysql']['extended']['collation'] = 'utf8_unicode_ci'

default['mysql']['extended']['tmpdir'] = '/tmp'
default['mysql']['extended']['datadir'] = '/var/lib/mysql'
default['mysql']['extended']['datadir_device'] = nil
default['mysql']['extended']['datadir_device_mount_point'] = nil

default['mysql']['extended']['log_bin'] = '/var/lib/mysql/binlog'


default['mysql']['extended']['general_log_file'] = nil
default['mysql']['extended']['general_log'] = 0

default['mysql']['extended']['slow_query_log_file'] = nil
default['mysql']['extended']['slow_query_log'] = 0

default['mysql']['extended']['tmp_table_size'] = '16M'

default['mysql']['extended']['ramdisk'] = nil

