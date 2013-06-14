
#TODO: significant validation required for the quantum setup

#I know, this is HIGHLY insecure
$one_to_rule_them_all = 'admin'
$controller_node_int_address  = '10.10.100.51'
$controller_node_pub_address   = '192.168.100.51'
$private_interface = 'eth1'
  
node /ctl.cloudcomplab.dev/ {

	include 'apache'

  $public_interface = 'eth2'
  #is this needed anymore with nova-conductor?
  #$sql_connection         = "mysql://nova:${nova_db_password}@${controller_node_int_address}/nova"

  class { 'openstack::controller':
		
		#network
		public_address          => $ipaddress_eth2,
		internal_address        => $controller_node_int_address,
		admin_address           => $controller_node_int_address,
		public_interface        => $public_interface,
    private_interface       => $private_interface,
    
    #quantum - ?
    external_bridge_name    => 'br-ex',
    bridge_interface        => $public_interface, # what br-ex gets connected to
    metadata_shared_secret  => $one_to_rule_them_all,
    ovs_local_ip            => $controller_node_int_address,
    
    enabled_apis            => 'ec2,osapi_compute,metadata',
    verbose                 => 'True',
    
    #passwords
		admin_email             => 'me@here.com',
		admin_password          => $one_to_rule_them_all,
		rabbit_password         => $one_to_rule_them_all,
		keystone_db_password    => $one_to_rule_them_all,
		keystone_admin_token    => $one_to_rule_them_all,
		glance_db_password      => $one_to_rule_them_all,
		glance_user_password    => $one_to_rule_them_all,
		nova_db_password        => $one_to_rule_them_all,
		nova_user_password      => $one_to_rule_them_all,
		secret_key              => $one_to_rule_them_all,
		quantum_user_password   => $one_to_rule_them_all,
		quantum_db_password     => $one_to_rule_them_all,
		cinder_user_password    => $one_to_rule_them_all,
		cinder_db_password      => $one_to_rule_them_all,
  }
  
	class { 'openstack::auth_file':
		admin_password       => 'admin',
		keystone_admin_token => 'admin',
		controller_node      => '127.0.0.1',
	}
}	

node /cmp.cloudcomplab.dev/ {
  
  #class { 'cinder::setup_test_volume': } -> Service<||>
	
	class {'openstack::compute':

    #passwords
    rabbit_password         => $one_to_rule_them_all,
    nova_user_password      => $one_to_rule_them_all,
    nova_db_password        => $one_to_rule_them_all,
    quantum_user_password   => $one_to_rule_them_all,
    cinder_db_password      => $one_to_rule_them_all,
    	  
		#network
		private_interface       => $private_interface,
		internal_address        => $ipaddress_eth1,
		
		#database
		db_host                 => $controller_node_int_address,

		#quantum
		ovs_local_ip            => $ipaddress_eth1,
		quantum_auth_url        => "http://${controller_node_int_address}:35357/v2.0",
    keystone_host           => $controller_node_int_address,
    quantum_host            => $controller_node_int_address,
   
		#misc
		libvirt_type            => 'qemu',
		setup_test_volume       => true,
		verbose                 => true,
		rabbit_host             => $controller_node_int_address,
		glance_api_servers      => "${controller_node_int_address}:9292",
		vncproxy_host           => $controller_node_int_address,
	}
}

