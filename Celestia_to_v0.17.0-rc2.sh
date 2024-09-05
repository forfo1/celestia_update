#!/bin/bash

#31: Red
#32: Green
#33: Yellow
#34: Blue
#35: Magenta
#36: Cyan

# Function to display colored text
print_color() {
    COLOR=$1
    TEXT=$2
    echo -e "\e[${COLOR}m${TEXT}\e[0m"
}

# Function for colored read command
read_color() {
    COLOR=$1
    PROMPT=$2
    shift 2
    echo -e "\e[${COLOR}m${PROMPT}\e[0m"
    read "$@"
}

# Function to prompt user to press any key to continue
press_any_key() {
    echo -e "\e[36mPress any key to continue...\e[0m"
    read -n 1 -s  # -n 1 reads 1 character, -s hides the input
}

# Install KOREAN

print_color "36" "Install KOREAN"

sudo apt-get install language-pack-ko -y

sudo locale-gen ko_KR.UTF-8

sudo update-locale LANG=ko_KR.UTF-8 LC_MESSAGES=POSIX


print_color "36" "한글설치완료"


# commands

sudo systemctl disable celestia-light
sudo systemctl stop celestia-light

cd $HOME/celestia-node

git fetch

git checkout tags/v0.17.0-rc2


make build
sudo make install

sudo systemctl daemon-reload
sudo systemctl enable celestia-light
sudo systemctl start celestia-light

print_color "35" "10초만 대기" 
sleep 10

celestia version
sudo systemctl status celestia-light

print_color "31" "celestia version에서 Semantic version, v0.17.0-rc2 확인" 
print_color "32" "sudo systemctl status celestia-light, active (running) 확인" 

print_color "33" "screen -r Celestia" 
print_color "34" "sudo journalctl -u celestia-light -f" 
print_color "36" "하고싶으면하고 싫으면말고 스크린부분은 안해도 큰상관없긔" 


press_any_key



exec bash

