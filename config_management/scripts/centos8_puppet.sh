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
echo "Installing Puppet RHEL 8 Repo"
echo ""
sudo rpm -Uvh https://yum.puppet.com/puppet-release-el-8.noarch.rpm

echo ""
echo "Installing Puppet Agent"
echo ""
sudo dnf install -y puppet-agent

