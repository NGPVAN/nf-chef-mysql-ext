group "mysql" do
    gid 114
    action :create
end

user "mysql" do
    uid 108
    gid "mysql"

    comment "MySQL Server,,,"
    home "/nonexistent"
    shell "/bin/false"
    system true
end

