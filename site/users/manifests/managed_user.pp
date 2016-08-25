define user::managed_user (
  $user,
  $home = '/home/${user}',
  $group = 'gid',
  $shell = '/bin/bash',
) {
  user { "${user}":
    ensure => present,
  }
}
