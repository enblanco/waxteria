raise 'Please define PDMCODE environment variable pointing to a directory containing the pdm repository. Make sure it is the real thing (not a symlink).' unless ENV['PDMCODE']

raise 'Please upgrade to Vagrant >= 1.2' unless Gem::Version.new(Vagrant::VERSION) >= Gem::Version.new('1.2')

Vagrant.configure('2') do |config|
  # Download and add box with:
  # cd /tmp
  # curl -O https://s3.amazonaws.com/alvarobp-public/vagrant-boxes/debian-rbenv-7.1.0.box
  # vagrant box add debian-rbenv-7.1.0 debian-rbenv-7.1.0.box
  config.vm.box = "debian-rbenv-7.1.0"
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
