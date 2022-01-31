for item in [ $(ls /etc/openvpn/easy-rsa/keys/ | grep ovpn) ];do
echo -e "\033[1;90mSearching match for \033[1;37m$item\033[1;00m"
if [[ $(grep After /etc/openvpn/easy-rsa/keys/$item | awk '{print $7}') = $(date +%Y) && $(grep After /etc/openvpn/easy-rsa/keys/$item | awk '{print $4}') = $(date +%b) && $(grep After /etc/openvpn/easy-rsa/keys/$item | awk '{print $5}') < $(date +%d) ]]; then
echo $item >> /tmp/keys_expired.txt
echo -e "Match found for \033[1;92m$item\033[1;00m"
fi
done

if [ -f "/tmp/keys_expired.txt" ]; then
echo -e "\n\033[1;93mOne can find keys in \033[1;92m/tmp/keys_expired.txt\033[1;00m\n"
else
echo -e "\033[1;93m\nThere are no keys that should be renewed\033[1;00m\n"
fi
