#! /usr/bin/env bash

# TODO: I'd like this to use librarian-puppet eventually

cd modules
git clone https://github.com/dizz/puppet-openstack.git openstack

cd openstack
rake modules:clone

cd ../..