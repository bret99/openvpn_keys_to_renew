for item in $(ls /etc/openvpn/easy-rsa/keys/ | grep ovpn);do
echo -e "\033[1;90mSearching match for \033[1;37m$item\033[1;00m"
for expire_date in {1..16};do
if [[ $(grep After /etc/openvpn/easy-rsa/keys/$item | awk '{print $4,$5,$7}') = $((date -d "+$expire_date days")| awk '{print $2,$3,$6}') ]]; then
echo $item >> /tmp/keys_to_renew.txt
echo -e "Match found for \033[1;92m$item\033[1;00m"
fi
done
done

if [ -f "/tmp/keys_to_renew.txt" ]; then
#cat /tmp/keys_to_renew.txt | sort -u > /tmp/keys_to_renew.txt
echo -e "\n\033[1;93mOne can find keys in \033[1;92m/tmp/keys_to_renew.txt\033[1;00m\n"
else
echo -e "\033[1;93m\nThere are no keys that should be renewed\033[1;00m\n"
fi
