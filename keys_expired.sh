for item in [ $(ls /etc/openvpn/easy-rsa/keys/ | grep ovpn) ];do
if [[ $(grep After /etc/openvpn/easy-rsa/keys/$item | awk '{print $7}') = $(date +%Y) && $(grep After /etc/openvpn/easy-rsa/keys/$item | awk '{print $4}') = $(date +%b) && $(grep After /etc/openvpn/easy-rsa/keys/$item | awk '{print $5}') < $(date +%d) ]]; then
echo $item >> /tmp/keys_expired.txt
fi
done
