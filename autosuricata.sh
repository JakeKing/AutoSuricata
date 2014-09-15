##THIS WILL NOT WORK##
##PLEASE CHECK BACK SOON FOR PROGRESS :)##

## AutoSuricata v0.1
## @JakeKing
## All bullshit, Ubuntu 12.04
## Oinkmaster, Suricata and GO!

ECHO "The following script is designed to make installation of Suricata and Oinkmaster fluent and easy."
ECHO "There are a number of options to choose from, so ensure you have taken a look at the readme : github.com/jakeking/autosuricata"
ECHO "Please, take note that this is in the VERY early stages of development and will need serious work to be on par with AutoSnort"

ECHO " Adding Repo's"
cd ~
sudo add-apt-repository ppa:oisf/suricata-stable
sudo apt-get update


ECHO " Installing Suricata and associated packages"
sudo apt-get install suricata


ECHO " Installing Oinkmaster"
sudo apt-get install oinkmaster

ECHO " Editing /etc/oinkmaster.conf with Emerging Threats Ruleset for Suricata"
ECHO " If this fails, manually add the Suricata repo http://rules.emergingthreats.net/open/suricata/emerging.rules.tar.gz"
etversion=$(curl http://rules.emergingthreats.net/open/suricata/version.txt)
ECHO " You are getting the $etversion rules from Emerging Threats."

sudo vim /etc/oinkmaster.conf

ECHO " Fixing some rules, etc"
ECHO " Ad the classification file and reference config file to the /etc/oinkmaster.conf"
cd /etc
sudo oinkmaster -C /etc/oinkmaster.conf -o /etc/suricata/rules

ECHO " Creating directories, pulling down rules and fixing some things"

ECHO " Starting Suricata!"

ECHO " Testing Suricata with testmyids.com"

ECHO " Now check logs!"
