class nginx {

  case $::os['family']{
    'redhat' : {
      $package  = 'nginx'
      $owner    = 'root'
      $group    = 'root'
      $docroot  = '/var/www'
      $confdir  = '/etc/nginx'
      $blockdir =
      $logs     =
    }
      
    'debian' : {
      $package  = 'nginx'
      $owner    = 'root'
      $group    = 'root'
      $docroot  = '/var/www'
      $confdir  = '/etc/nginx'
      $blockdir =
      $logs     =
    }
        
    'windows' : {
      $package  = 'nginx'
      $owner    = 'Administrator'
      $group    = 'Administrator'
      $docroot  = 'C:/ProgramData/nginx/html'
      $confdir  = 'C:/ProgramData/nginx'
      $blockdir = 
      $logs     =
    }
    
    default :  {
      fail("Module ${module_name} not supported on ${os['family']}")
    }
  }
    package { $package :
    ensure => present,
    }

    File {
      ensure  => file,
      owner   => $owner,
      group   => $group,
      mode    => '0644',
    }
    
    file { $docroot:
      ensure  => directory,
    }

    file { $configdir:
      ensure  => directory,
      source  => 'puppet:///modules/nginx/nginx.conf',
      require => Package[$package],
    }

  file { 'default.conf':
    ensure  => file,
    path    => '/etc/nginx/conf.d/default.conf',
    source  => 'puppet:///modules/nginx/default.conf',
  }

  service { 'nginx':
    ensure => running,
    enable => true,
    subscribe => File['/etc/nginx/nginx.conf'],
  }

#   file { 'index.html':
#     ensure  => file,
#     path    => '/var/www/index.html',
#     source  => 'puppet:///modules/nginx/index.html',
#   }

}
