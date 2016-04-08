Vagrant.configure(2) do |config|
  config.vm.hostname = 'concourse'

  config.vm.provider "virtualbox" do |v, override|
    v.memory = 1024
    v.cpus = 2
    v.name = 'concourse'

    override.vm.box = 'ubuntu/trusty64'
  end

  config.vm.provider :aws do |aws, override|
    aws.access_key_id = ENV['CC_AWS_ACCESS_KEY_ID']
    aws.secret_access_key = ENV['CC_AWS_SECRET_ACCESS_KEY']
    aws.keypair_name = ENV['CC_AWS_KEYPAIR'] || "concourse"
    aws.ami = ENV['CC_AWS_AMI'] || "ami-6177f712"
    aws.instance_type = ENV['CC_AWS_INSTANCE_TYPE'] || "t2.small"
    aws.subnet_id = ENV['CC_AWS_SUBNET_ID'] || nil
    aws.elastic_ip = ENV['CC_AWS_EIP'] || true
    aws.security_groups = [ ENV['CC_AWS_SEC_GRP'] ]
    aws.region = ENV['CC_AWS_REGION'] || 'eu-west-1'
    aws.user_data = "#cloud-config\ndisable_root: false"
    aws.tags = {
      'Name' => "concourse"
    }

    override.vm.box = "dummy"
    override.vm.box_url = "https://github.com/mitchellh/vagrant-aws/raw/master/dummy.box"
    override.ssh.username = "root"
    override.ssh.private_key_path = ENV['CC_PRIVATE_KEY_PATH']
  end

  ['setup-server', 'deploy-concourse', 'deploy-worker'].each do |playbook|
    config.vm.provision :ansible do |ansible|
      ansible.groups = {
          "app" => ["default"]
      }
      ansible.playbook = "#{playbook}.yml"
      ansible.extra_vars = {
        server_ip: '127.0.0.1'
      }
    end
  end
end
