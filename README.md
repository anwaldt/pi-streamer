Start an MP3 stream with a simple SuperCollider test sound.
Runs on a Raspberry PI, configured as WiFi hotspot.

# WiFi Hotspot


## Setup

### /etc/network/interfaces

/etc/network/interfaces contains network interface configuration 
information for the ifup and ifdown commands. 
This one is configured for use with dhcpcd (/etc/dhcpcd.conf):

		# Include files from /etc/network/interfaces.d:
		source-directory /etc/network/interfaces.d

		# Wifi
		auto wlan0
		allow-hotplug wlan0
		iface wlan0 inet manual
		wireless-power off



### /etc/dhcpcd.conf

dhcpcd is a DHCP and DHCPv6 client. 

		interface wlan0
        static ip_address=10.11.12.1/24
        nohook wpa_supplicant


### /etc/dnsmasq.conf

Dnsmasq is a lightweight, easy to configure, DNS forwarder and DHCP server.

		interface=wlan0
		dhcp-range=10.11.12.100,10.11.12.200,255.255.255.0,24h


### /etc/hostapd/hostapd.conf

Hostapd (Host access point daemon) is a user space software 
access point capable of turning normal network interface cards into 
access points and authentication servers.


		interface=wlan0
		#bridge=br0
		hw_mode=g
		channel=7
		wmm_enabled=0
		macaddr_acl=0
		auth_algs=1
		ignore_broadcast_ssid=0
		wpa=2
		wpa_key_mgmt=WPA-PSK
		wpa_pairwise=TKIP
		rsn_pairwise=CCMP
		ssid=STREAM_NET
		wpa_passphrase=12345678

### /etc/default/hostapd

		DAEMON_CONF="/etc/hostapd/hostapd.conf"

Enable all services.

## Deactivate Hotspot

For connectig to WiFis:


		sudo systemctl stop hostapd.service

Comment the changes in /etc/dhcpcd.conf and restart service:


		sudo systemctl restart dhcpcd.service


# Services

This is a dirty hack in jack-dependent services:

ExecStartPre=/bin/sleep 2 
