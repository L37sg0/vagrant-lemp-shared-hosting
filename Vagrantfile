SERVICES = {
  'db' => {
    ip: '192.168.56.11',
  },
  'web' => {
    ip: '192.168.56.12',
    ports: { 80 => 8080 }
  }
}

Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/jammy64"

  config.vm.define "db" do |db|
        db.vm.provision :shell,
            path: "shell/bs-db.sh"
        db.vm.hostname = "db"
        db.vm.network "private_network", ip: SERVICES['db'][:ip]
        db.vm.synced_folder "./etc/mysql/custom", "/etc/mysql/conf.d/custom",
            owner: "vagrant",
            group: "root"
  end

  config.vm.define "web" do |web|
        web.vm.provision :shell,
            path: "shell/bs-web.sh"

        web.vm.provision "file",
            source: "./tmp/sftp.conf",
            destination: "/tmp/sftp.conf"
        web.vm.provision :shell,
            path: "shell/configure-sftp.sh"

        web.vm.hostname = "web"

        web.vm.network "private_network", ip: SERVICES['web'][:ip]
        web.vm.network "forwarded_port", guest: 80, host: 8080

        web.vm.synced_folder ".", "/var/www",
            owner: "vagrant",
            group: "www-data",
            mount_options: ["dmode=775", "fmode=664"]
        web.vm.synced_folder "./etc/nginx/sites-available", "/etc/nginx/sites-available",
            owner: "vagrant",
            group: "root"
        web.vm.synced_folder "./etc/php/custom", "/etc/php/8.1/fpm/conf.d/custom",
            owner: "vagrant",
            group: "root"

  end

end