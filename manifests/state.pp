class rcron::state ( $cluster_name = undef, $default_state = undef, $nice_level = undef, ) {

  if $cluster_name and $default_state {
	file { [ "/usr/local/etc/", "/usr/local/etc/rcron/" ] :
		ensure => "directory",
		owner  => "root",
		group  => "root",
		mode   => 750,
		}
    file { '/usr/local/etc/rcron/rcron.conf':
      ensure => present,
      owner => root,
      group => root,
      mode => 600,
      content => template("rcron/rcron.conf"),
    		}
        file { [ "/var/run/rcron/" ] :
                ensure => "directory",
                owner  => "root",
                group  => "root",
                mode   => 750
		}
    file { '/var/run/rcron/state':
      ensure => present,
      owner => root,
      group => root,
      mode => 600,
      content => template("rcron/state"),
                }
  }

}
