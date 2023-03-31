    # -*- mode: ruby -*-
    # vi:set ft=ruby sw=2 ts=2 sts=2:

    # Xác định số lượng máy control plane (MASTER_NODE) và máy node (WORKER_NODE)
    NUM_MASTER_NODE = 1
    NUM_WORKER_NODE = 1

    IP_NW = "192.168.56."
    MASTER_IP_START = 1
    NODE_IP_START = MASTER_IP_START + 1

    # Tất cả thiết lập Vagrant được khai báo dưới đây. Số "2" trong Vagrant.configure
    # là thiết lập phiên bản sử dụng
    # Đừng thay đổi trừ khi bạn biết mình đang làm gì

    Vagrant.configure("2") do |config|

    # Để tham khảo thêm, xem tài liệu tại
    # https://docs.vagrantup.com.

    # Tất cả môi trường mà Vagrant xây dựng đều cần một box. Bạn có thể tìm các
    # box tại https://vagrantcloud.com/search.
    # Đây là một số thông tin chi tiết về vagrant box "ubuntu/bionic64":
        # Hệ điều hành: Ubuntu 18.04 LTS (Bionic Beaver)
            # Ubuntu 18.04 LTS sẽ được cập nhật bảo mật và sửa lỗi 
            # từ Canonical, công ty đứng sau Ubuntu, cho đến tháng 4 năm 2023 
            # đối với bản desktop và server, và đến tháng 4 năm 2028 đối 
            # với bản server có Extended Security Maintenance (ESM).
        # Kiến trúc: x86_64 (64-bit)
        # Dung lượng bộ nhớ: 10 GB
        # RAM: 2 GB
        # CPUs: 2
        # Giao diện đồ họa: None (headless)
        # Người tạo: VirtualBox

    config.vm.box = "ubuntu/bionic64"

    # Tắt tính năng tự động cập nhật của box. Nếu tắt,
    # boxes sẽ chỉ kiểm tra cập nhật khi người dùng chạy
    # `vagrant box outdated`. Không khuyến khích.

    config.vm.box_check_update = false
    # config.vm.network "public_network"

    # Xem thêm tài liệu của Virtual box tại
    # https://developer.hashicorp.com/vagrant/docs/providers/virtualbox/configuration

    # Khởi tạo Control Plane
    (1..NUM_MASTER_NODE).each do |i|
        config.vm.define "kubemaster" do |node|
            node.vm.provider "virtualbox" do |vb|
                vb.name = "kubemaster"
                vb.memory = 2048
                vb.cpus = 2
            end
            node.vm.hostname = "kubemaster"
            node.vm.network :private_network, ip: IP_NW + "#{MASTER_IP_START + i}"
            node.ssh.insert_key = false
            node.ssh.forward_agent = true
            node.ssh.private_key_path = ["~/.vagrant.d/insecure_private_key","~/.ssh/id_rsa.bk"]
            node.vm.provision "file", source: "deploy.sh" , destination: "/home/vagrant/"
            node.vm.provision "shell", inline: "sudo chmod +x /home/vagrant/deploy.sh && sudo /home/vagrant/deploy.sh"
            node.vm.synced_folder "./k8sconfig", "/home/vagrant/k8sconfig", :mount_options => ['dmode=774','fmode=775']
        end
    end



    # Khởi tạo Nodes
    (1..NUM_WORKER_NODE).each do |i|
        config.vm.define "kubenode0#{i}" do |node|
            node.vm.provider "virtualbox" do |vb|
                vb.name = "kubenode0#{i}"
                vb.memory = 2048
                vb.cpus = 2
            end
            node.vm.hostname = "kubenode0#{i}"
            node.vm.network :private_network, ip: IP_NW + "#{NODE_IP_START + i}"
            # node.vm.network :hostonly, ip: "10.0.2.2" + "#{NODE_IP_START + i}", :netmask => "255.255.255.0"
            node.ssh.insert_key = false
            node.ssh.forward_agent = true
            node.ssh.private_key_path = ["~/.vagrant.d/insecure_private_key","~/.ssh/id_rsa.bk"]
            node.vm.provision "file", source: "deploy.sh" , destination: "/home/vagrant/"
            node.vm.provision "shell", inline: "sudo chmod +x /home/vagrant/deploy.sh && sudo /home/vagrant/deploy.sh"
        end
    end
    end

