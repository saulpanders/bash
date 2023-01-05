#!/bin/bash
# handles dependencies for capinternal
# should be run as root
#NOTE: hashicorp doesnt have kali-rolling supported, so im using Debian10 (buster) instead
# keyring should match: E8A0 32E0 94D8 EB4E A189 D270 DA41 8C88 A321 9F7B

# terraform install
terraform_install()
{
	echo "[+] Updating packages and attempting naieve terraform install"
	sudo apt-get -qq update
	sudo apt-get -qq install terraform
	sudo apt-get -qq update && sudo apt-get -qq install -y gnupg software-properties-common moreutils
	echo "[+] Pulling Hashicorp PGP key from internet"
	wget -q -O- https://apt.releases.hashicorp.com/gpg | gpg --dearmor > /usr/share/keyrings/hashicorp-archive-keyring.gpg
	echo "[+] Verifying keyring"
	gpg --no-default-keyring --keyring /usr/share/keyrings/hashicorp-archive-keyring.gpg --fingerprint
	echo "[+] Adding Hashicorp repo to system"
	echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com buster main" >>  /etc/apt/sources.list.d/hashicorp.list
	awk '!a[$0]++' /etc/apt/sources.list.d/hashicorp.list | sponge /etc/apt/sources.list.d/hashicorp.list
	echo "[+] Updating sources & installing Terraform"
	sudo apt -qq update && sudo apt-get -qq install terraform
}

ansible_install()
{
	# ansible install
	echo "[+] Installing ansible"
	sudo apt-get -qq install ansible
}

check()
{
	echo "[+] Verifying installed versions"
	terraform --version
	ansible --version
}

main()
{
	terraform_install
	ansible_install
	check
}

#actually running the thing
main
