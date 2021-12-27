for item in [ $(ls /etc/openvpn/easy-rsa/keys/ | grep ovpn) ];do
echo -e "\033[1;90mSearching match for \033[1;37m$item\033[1;00m"
# cert expired in 10 days current year next month
expired_month_to_number=$(date -d "$(grep After /etc/openvpn/easy-rsa/keys/$item | awk '{print $4,$5,$7}')" +%m)
exp=$(date -d '+10 days' +%m)
if [[ $(grep After /etc/openvpn/easy-rsa/keys/$item | awk '{print $7}') = $(($(date -d '+10 days' +%Y))) && $((10#$expired_month_to_number - $exp)) = 1 && $(($(date -d '+10 days' +%d))) = $(grep After /etc/openvpn/easy-rsa/keys/$item | awk '{print $5}') ]]; then
echo $item >> /tmp/keys_to_renew.txt
echo -e "Match found for \033[1;92m$item\033[1;00m"
fi
# cert expired in 10 days next year
if [[ $(grep After /etc/openvpn/easy-rsa/keys/$item | awk '{print $7}') > $(($(date +%Y))) && $(grep After /etc/openvpn/easy-rsa/keys/$item | awk '{print $4}') = 'Jan' && $(($(date -d '+10 days' +%d))) = $(grep After /etc/openvpn/easy-rsa/keys/$item | awk '{print $5}') ]]; then
echo $item >> /tmp/keys_to_renew.txt
echo -e "Match found for \033[1;92m$item\033[1;00m"
fi
# cert expired in 10 days current month
if [[ $(grep After /etc/openvpn/easy-rsa/keys/$item | awk '{print $7}') = $(($(date -d '+10 days' +%Y))) && $(grep After /etc/openvpn/easy-rsa/keys/$item | awk '{print $4}') = $(date -d '+10 days' | awk '{print $2}') && $(($(date -d '+10 days' +%d))) = $(grep After /etc/openvpn/easy-rsa/keys/$item | awk '{print $5}') ]]; then
echo $item >> /tmp/keys_to_renew.txt
echo -e "Match found for \033[1;92m$item\033[1;00m"
#fi
done

if [ -f "/tmp/keys_to_renew.txt" ]; then
echo -e "\n\033[1;93mOne can find keys in \033[1;92m/tmp/keys_to_renew.txt\033[1;00m\n"
else
echo -e "\033[1;93m\nThere are no keys that should be renewed\033[1;00m\n"
fi
