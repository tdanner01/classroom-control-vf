define user::managed_user (
  $group = $title,
)
  {
  user { $title:
    ensure => present,
  }
  file { "/home/${title}:
    ensure +> directory,
    owner => $title,
    group => $group,
    
  }
  file { "/ho,me/$title/.ssh":
    ensure => directory,
    owner
    group => $group,
    mode
}
