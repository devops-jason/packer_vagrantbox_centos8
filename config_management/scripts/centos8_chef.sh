trap 'exit' ERR

echo ""
echo "Updating Old Packages"
echo ""
sudo dnf upgrade -y

echo ""
echo "Enabling Chrony On Boot"
echo ""
sudo systemctl enable chronyd

echo ""
echo "Installing Chef Infra Client"
echo ""
sudo rpm -Uvh /vagrant/chef-14.15.6-1.el7.x86_64.rpm

