:local listname "googlevideo";
:local listurl "https://raw.githubusercontent.com/zainarbani/address-list/main/googlevideo-sg-ipv4.txt";

:local addList do={
 :local dat ([/tool fetch url=$1 output=user as-value]->"data");
 :while ([:len $dat] != 0) do={
  /ip firewall address-list add list=$2 address=[:pick $dat 0 [:find $dat "\n"]]
  :set $dat [:pick $dat ([:find $dat "\n"]+1) [:len $dat]];
 }
}

/ip firewall address-list remove [find where list=$listname]
$addList $listurl $listname
