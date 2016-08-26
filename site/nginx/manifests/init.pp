class nginx {

  case $::os['family']{
    'redhat', 'debian' : {
      $package  = 'nginx'
      $owner    = 'root'
      $group    = 'root'
      $docroot  = '/var/www'
      $confdir  = '/etc/nginx'
      $blockdir = '/etc/nginx/conf.d'
      $logs     = '/var/log/nginx'
    }
      
    'windows' : {
      $package  = 'nginx'
      $owner    = 'Administrator'
      $group    = 'Administrator'
      $docroot  = 'C:/ProgramData/nginx/html'
      $confdir  = 'C:/ProgramData/nginx'
      $blockdir = 'C:/ProgramData/nginx/conf.d'
      $logs     = 'C:/ProgramData/nginx/logs'
    }
    
    default :  {
      fail("Module ${module_name} not supported on ${os['family']}")
    }
  }
  
    $user = $::os['family'] ? {
      'redhat'  => 'nginx',
      'debian'  => 'www',
      'windows' => 'nobody',
      default   => 'nobody',
    }

    package { $package :
    ensure => present,
    }

    File {
#      ensure  => file,
      owner   => $owner,
      group   => $group,
      mode    => '0644',
    }
    
    file { $docroot:
      ensure  => directory,
    }

    file { $confdir:
      ensure  => directory,
      source  => 'puppet:///modules/nginx/nginx.conf',
      require => Package[$package],
    }

    file { $blockdir:
      ensure  => directory,
      source  => 'puppet:///modules/nginx/default.conf',
    }

    file { $logs:
      ensure  => directory,
    }

    service { 'nginx':
      ensure    => running,
      enable    => true,
      subscribe => [ File[$confdir], File[$blockdir] ],
    }

   file { 'index.html':
     ensure  => file,
     path    => '/var/www/index.html',
     source  => 'puppet:///modules/nginx/index.html',
   }

}
