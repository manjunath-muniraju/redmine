#!/bin/bash
apt update
apt upgrade -y
apt install git curl libssl-dev libreadline-dev checkinstall zlib1g-dev autoconf bison build-essential libyaml-dev libreadline-dev libncurses5-dev libffi-dev libgdbm-dev -y
apt-get install build-essential -y
apt-get install libaio-dev -y
curl -fsSL https://github.com/rbenv/rbenv-installer/raw/HEAD/bin/rbenv-installer | bash
echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bashrc
echo 'export LD_LIBRARY_PATH="/opt/oracle/instantclient_21_10:$LD_LIBRARY_PATH"' >> ~/.bashrc
echo 'export OCI_PATH="/opt/oracle/instantclient_21_10:$OCI_PATH"' >> ~/.bashrc
cd /opt/oracle/instantclient_21_10
ln -s libclntsh.so.21.1 libclntsh.so
cd $HOME
echo 'eval "$(rbenv init -)"' >> ~/.bashrc
source ~/.bashrc
rbenv install 3.1.3
rbenv global 3.1.3
gem install bundler
gem install rails -v 6.1.7
bundle config set --local without 'development test';
bundle install;
bundle exec rake generate_secret_token;
mkdir -p tmp tmp/pdf public/plugin_assets
chown -R redmine:redmine files log tmp public/plugin_assets
chmod -R 755 files log tmp public/plugin_assets
