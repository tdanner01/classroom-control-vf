apache::vhost { 'elmo.puppet.com':
port => '80',
docroot => '/var/www/muppets/elmo',
options => 'Indexes MultiViews',
notify => Service['httpd'],
}
