#!/bin/bash

# component=$1
# dnf install ansible -y
# ansible-pull -U https://github.com/daws-86s/ansible-roboshop-roles-tf.git -e component=$component main.yaml
# git clone ansible-playbook
# cd ansible-playbook
# ansible-playbook -i inventory main.yaml

REPO_URL="https://github.com/daws-86s/ansible-roboshop-roles-tf.git"
REPO_DIR="/opt/roboshop/ansible"

component="$1"

dnf install -y ansible git
mkdir -p $REPO_DIR

# Ensure repo directory exists
if [[ ! -d "$REPO_DIR" ]]; then
  echo "🔄 Cloning repository..."
  git clone "$REPO_URL" "$REPO_DIR"
else
  echo "📥 Repository exists, pulling latest changes..."
  cd "$REPO_DIR"
  git reset --hard
  git pull
fi

mkdir -p /var/log/roboshop
touch /var/log/roboshop/ansible.log

cd $REPO_DIR/ansible-roboshop-roles-tf

ansible-playbook -e component=$component main.yaml