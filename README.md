# openvpn_keys_to_renew

Bash scripts to get openvpn expired keys and keys to be renewed in few days.

'keys_expired.sh' gets expired keys in current month by current date.                                   

'keys_to_renew_concrete_date.sh' gets keys that gonna be expired in 10 [default value] days. 

One may change [default value] in 3rd line as one likes.

'keys_to_renew_range_date.sh' gets keys that gonna be expired in range date [default value] days. 

One may change [default value] in 2nd line as one likes.

Path to keys (\*.ovpn) storage should be substituted for actual one if necessary. 
