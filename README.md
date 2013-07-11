# README

This project will setup an all-in-one Grizzly installation using the combination of puppet and vagrant.

To get started:

1. Install virtualbox and vagrant
2. `cd $project-name`
3. Get the required puppet modules `./get_modules.sh`
4. `vagrant up`
5. Have a coffee

## Status
Basic services are operational. Minor updates required for network configuration (/etc/network/interfaces). Using [mseknibilel's](https://github.com/mseknibilel/OpenStack-Grizzly-Install-Guide) guide to perform the basic validation.

If you have changes, send a pull request! All pull requests happily received.
