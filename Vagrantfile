raise 'Please upgrade to Vagrant >= 1.2' unless Gem::Version.new(Vagrant::VERSION) >= Gem::Version.new('1.2')
raise 'Please indicate me where your pdm code is by setting PDMCODE environment variable' unless ENV['PDMCODE']

Vagrant.configure('2') do |config|
  config.vm.box = "debian-rbenv-7.1.0"
  config.vm.box_url = 'https://s3.amazonaws.com/alvarobp-public/vagrant-boxes/debian-rbenv-7.1.0.box'
  config.vm.provider :virtualbox do |vb|
    vb.customize ["modifyvm", :id, "--memory", 1024]
    # vb.gui = true
  end
  config.vm.network :private_network, :ip => "10.10.3.25", :netmask => "255.255.255.0"
  config.vm.synced_folder ENV['PDMCODE'], "/home/vagrant/code/pdm", :nfs => true
  config.ssh.forward_agent = true

  config.vm.network :forwarded_port, :guest => 9292, :host => 9292 # sinatra
  config.vm.network :forwarded_port, :guest => 5901, :host => 5901 # vnc
end
