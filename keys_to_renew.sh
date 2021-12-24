for item in [ $(ls /etc/openvpn/easy-rsa/keys/ | grep ovpn) ];do
# cert expired in 10 days current year next month
if [[ $(grep After /etc/openvpn/easy-rsa/keys/$item | awk '{print $7}') = $(date +%Y) && $(($(date -d '+10 days' +%m))) > $(($(date +%m))) && $(grep After /etc/openvpn/easy-rsa/keys/$item | awk '{print $5}') < 11 ]]; then
echo $item >> /tmp/keys_to_renew.txt
fi
# cert expired in 10 days next year
if [[ $(grep After /etc/openvpn/easy-rsa/keys/$item | awk '{print $7}') > $(($(date +%Y))) && $(($(date -d '+10 days' +%m))) < $(($(date +%m))) && $(grep After /etc/openvpn/easy-rsa/keys/$item | awk '{print $4}') = 'Jan' && $(grep After /etc/openvpn/easy-rsa/keys/$item | awk '{print $5}') < 11 ]]; then
echo $item >> /tmp/keys_to_renew.txt
fi
# cert expired in 10 days current month
if [[ $(grep After /etc/openvpn/easy-rsa/keys/$item | awk '{print $7}') = $(date +%Y) && $(grep After /etc/openvpn/easy-rsa/keys/$item | awk '{print $4}') = $(date +%b) && $(($(date +%d)+10)) = $(grep After /etc/openvpn/easy-rsa/keys/$item | awk '{print $5}') ]]; then
echo $item >> /tmp/keys_to_renew.txt
fi
done
