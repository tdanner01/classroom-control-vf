class skeleton {
	  	file { '.bashrc':
		  ensure => present
		  path   => /etc/skel
		}
	}
