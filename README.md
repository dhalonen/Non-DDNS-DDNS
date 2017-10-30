# non-DDNS DDNS

Dynamic DNS is useful & popular. It allows one to maintain a human comprehendible name that maps to your home IP address. (Most ISP’s provide DHCP which means your home’s IP address can change without notice.) Dynamic DNS maintains a mapping for you.

There are several companies that provide free DDNS (Dynamic DNS) services. These are pretty easy to use and the cost is often completely free of charge.

However, these guys remain a “middle-man” and another account or site you have to pay some attention to. You also give up another bit of information about yourself, that maybe you just don’t have to. Here is an option that gets around that: 

    Use the Linux OS in your router to keep you informed of your IP address change.

It’s actually pretty simple: have your router periodically check it’s IP address. If the address has changed, notify yourself of the update!

I have setup an Ubiquity EdgeRouter X to do exactly that. It’s based on Debian Linux. The high-level steps are:
1.	Check the WAN IP address via one of the IP options (ip addr show eth0)
2.	If it’s different from last IP address
3.	Send the new IP address to yourself (smtp)
    Alternatively, use scp to copy the new ip to some location, update a database with the entry.
    Multiple updates are also possible: update your team, a set of test machines, etc.
4.	Save the new IP address for the next check
5.	Save steps 1-4 in a shell script and schedule as a cron job

All in all, very simple.
