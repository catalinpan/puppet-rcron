# puppet-rcron

## Overview

This module install RCRON from source tarball. Note this is only tested on CentOS 6.5.

## Usage

```tarball_url``` defines the location of the RCRON .tar.gz package, the package should be in the form ```rcron-0.1.0.tar.gz``` or whatever the specified versions are.

The tar.gz from google page doesn't seems to work with this module, pull the code from svn and pack your own rcron tar.gz file.

```
svn co http://rcron.googlecode.com/svn/trunk/ rcron
```

The script will create also the state file ```/var/run/rcron/state``` with the value specified in ```default_state```

The module is based on the installation idea from MSMFG/puppet-s3fs module.


```
  class { 'rcron':
  	tarball_url	=> 'http://mydomain.com/rcron/',
    	rcron_version	=> '0.1.0',
  	}
```
```
  class { 'rcron::state':
	cluster_name    => 'Master',
	default_state   => 'active',
	nice_level      => '19',
  	}
```

## Dependency 
```
'maestrodev/wget', '>= 1.3.2'
```
