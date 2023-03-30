#!/bin/bash
sudo kubeadm init --apiserver-advertise-address=192.168.56.2 --pod-network-cidr=10.244.0.0/16