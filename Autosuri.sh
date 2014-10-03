#!/bin/bash

  ##autosuricata.sh
  ##Written by @JakeKing 
  ##Build and configuration script for Suricata deployment on Ubuntu 12.04 systems.
  ##v 0.1
  ##Run as sudo!

  #allthethings
  surirepo=""
  env="production"
  osversion=12.04
  ruleversion=2014090101
  logdir=/var/log/suricata

  #check to see if suricata is already installed.
  if which suricata | grep -ci "suricata";
    then

      echo "Suricata is already installed, check 'which suricata' on this system, or query suricata -V"
      echo "If you wish to update suricata to a later release, please sudo apt-get update suricata."
      exit

  else

    #then check os version matches osversion.
    if lsb_release -d | grep -ci "$osversion";
        then

  #Add the Suricata stable repository
  echo "adding Suricata repository"
  sudo add-apt-repository -y ppa:oisf/suricata-stable
  sudo apt-get update
  #Add logging directory - otherwise suricata complains
  echo "Making the suricata logging directory."
  sudo mkdir $logdir
  #installing suricata
  echo "installing..."
  sudo apt-get -V install -y suricata

    else

  echo "OS version does not match script! Make sure you are using the right autosuricata! (or just modify the $osversion)"
    fi

            if ps ax | grep -v grep | grep -ci suricata;
              then

                echo "shutting down Suricata - it started after install!"
                pidkill=$(sudo cat /var/run/suricata.pid | sed 's/[^0-9]*//g')
                kill -9 $pidkill
                echo "Suricata is dead, lets continue!"

            else

                echo "Suricata is not running, so continuing the install!"

            fi
  fi

  echo "Getting the Suricata production yaml and hs-rules tarball."
  #get the predefined production suricata.yaml & from the suricata repo
  #                    wget $surirepo/suricata/config/$env/suricata.yaml -P /tmp
  #                    wget $surirepo/suricata/rules/$env/hs-rules.tar.gz -P /tmp

  echo "normally moving the rulesets to the right dir."
  #move files to the correct dir.
  #                    sudo mv /tmp/suricata.yaml /etc/suricata/
  #                    sudo tar -zxvf /tmp/hs-rules.tar.gz -C /etc/suricata/rules

  if cat /etc/suricata/rules/version.txt | grep -v grep | grep -ci $ruleversion;
    then

      echo "starting Suricata in Daemon mode, using the /etc/suricata/suricata.yaml file we just downloaded & custom suricata rules."
      sudo suricata -c /etc/suricata/suricata.yaml -i eth0 --init-errors-fatal -D
      suriproc=$(sudo cat /var/run/suricata.pid | sed 's/[^0-9]*//g')
      echo "Suricata running with $suriproc process ID"

    else

      echo "Something is wrong, check the version.txt in /etc/suricata/rules"
      echo "And match it to the ruleversion in this script."
      echo "You will probably need to manually wget the new rules, and start suricata after confirming they are correct"
      exit
  fi
