class rcron ( $rcron_version = '0.1.0', $tarball_url, $tarball_dir = '/tmp' ) {

  Exec {
    path => '/usr/bin/:/bin:/usr/sbin:/sbin',
  }

  package { [
            'gcc',
            'libstdc++-devel',
            'gcc-c++',
            'libcurl-devel',
            'libxml2-devel',
	    'flex',
	    'byacc',
            ]:
    ensure => installed,
    before => [ Exec['compile-rcron'], ],
  }

  $rcron_tarball = "rcron-${rcron_version}.tar.gz"

  include wget


  # Installl RCRON
  wget::fetch { 'rcron':
    source      => "${tarball_url}/${rcron_tarball}",
    destination => "${tarball_dir}/${rcron_tarball}",
  }
  exec {'extract-rcron':
    cwd     => "${tarball_dir}",
    command => "tar -xvf ${rcron_tarball}",
    creates => "${tarball_dir}/rcron-${rcron_version}",
    require => Wget::Fetch['rcron'],
  }
  exec {'configure-rcron':
	cwd      => "${tarball_dir}/rcron-${rcron_version}/",
	provider => 'shell',
	command  => "./configure",
	creates  => "${tarball_dir}/rcron-${rcron_version}/Makefile",
	require  => Exec['extract-rcron'],
  }
  exec {'compile-rcron':
	cwd      => "${tarball_dir}/rcron-${rcron_version}/",
	provider => 'shell',
	command  => "make && make install",
	onlyif   => "/usr/bin/test ! -f /usr/local/bin/rcron",
	require  => Exec['configure-rcron'],
  }

}
