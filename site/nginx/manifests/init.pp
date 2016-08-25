class nginx {

  package { 'nginx':
    ensure => present,
  }

  file { '/var/www':
    ensure  => directory,
    owner   => 'root',
    group   => 'root',
    mode    => '0755',
  }
  
  file { 'index.html':
    ensure  => file,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    path    => '/var/www/index.html',
    source  => 'puppet:///modules/nginx/index.html',
  }

  file { 'nginx.conf':
    ensure  => file,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    path    => '/etc/nginx/nginx.conf',
    source  => 'puppet:///modules/nginx/nginx.conf',
    require => Package['nginx'],
  }

  file { 'default.conf':
    ensure  => file,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    path    => '/etc/nginx/conf.d/default.conf',
    source  => 'puppet:///modules/nginx/default.conf',
  }

  service { 'nginx.conf':
    ensure => running,
    enable => true,
    subscribe => File['/etc/nginx/nginx.conf'],
  }

}
