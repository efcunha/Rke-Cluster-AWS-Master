#!/bin/bash

# Instale utils e aws cli v2
sudo curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
sudo zypper --non-interactive update
sudo zypper --non-interactive install jq
sudo zypper --non-interactive update
sudo zypper --non-interactive install zip
sudo zypper --non-interactive install unzip
sudo unzip awscliv2.zip
sudo ./aws/install

#Instala o yq
sudo wget https://github.com/mikefarah/yq/releases/download/v4.12.0/yq_linux_amd64 -O /usr/bin/yq && chmod +x /usr/bin/yq

# Comandos para todos os nós K8s
sudo zypper --non-interactive update
sudo zypper --non-interactive install docker

# desativa o swap
# O agendador do Kubernetes determina o melhor nó disponível no
# para implantar os pods recém-criados. Se a troca de memória for permitida
# ocorra em um sistema host, isso pode levar a desempenho e estabilidade
# problemas no Kubernetes.
# Por esse motivo, o Kubernetes exige que você desative a troca no sistema host.
# Se o swap não estiver desabilitada, o serviço kubelet não iniciará nos mestres e nós
sudo sed -i '/ swap / s/^\(.*\)$/#\1/g' /etc/fstab
sudo swapoff -a

#Confirme se o grupo docker foi criado no sistema
sudo groupadd docker

# Adicione o usuário atual do sistema ao grupo do Docker, bem como o usuário ec2-user
sudo gpasswd -a $USER docker
sudo usermod -a -G docker ec2-user
grep /etc/group -e "docker"

# Iniciar e habilitar Serviços
sudo systemctl daemon-reload 
sudo systemctl restart docker
sudo systemctl enable docker

# Modifica a configuração do setting
# Configura sysctl.
sudo modprobe overlay
sudo modprobe br_netfilter

sudo tee /etc/sysctl.d/kubernetes.conf<<EOF
net.bridge.bridge-nf-call-ip6tables = 1
net.bridge.bridge-nf-call-iptables = 1
net.ipv4.ip_forward = 1
EOF

sudo sysctl --system

# Certifique-se de que o módulo br_netfilter esteja carregado
lsmod | grep br_netfilter

# Baixe o arquivo yaml do cluster do bucket do S3
aws s3 cp s3://your-rke-cluster-config-bucket/cluster.yml ./

# Obtenha o valor do número existente de nós listados no arquivo de configuração e use isso
# número para criar uma nova listagem de nós no array
aws configure set region eu-west-1
HOSTNAME="$(curl http://169.254.169.254/latest/meta-data/local-ipv4)" NUMBER_OF_NODES="$(yq eval '.nodes | length' cluster.yml)" yq eval -i '
  .nodes[env(NUMBER_OF_NODES)].address = env(HOSTNAME) |
  .nodes[env(NUMBER_OF_NODES)].user = "ec2-user" |
  .nodes[env(NUMBER_OF_NODES)].role[0] = "controlplane" |
  .nodes[env(NUMBER_OF_NODES)].role[1] = "etcd"
' ./cluster.yml

# Faça upload do arquivo cluster.yml para o bucket do S3
aws s3 cp ./cluster.yml s3://your-rke-cluster-config-bucket