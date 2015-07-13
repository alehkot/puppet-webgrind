# == Class: webgrind
#
# This class installs the webgrind package along with the necessary configuration
# files and a virtual host for accessing the output.
#
# === Parameters
#
# [*domain*]
#   The default domain. Defaults to 'webgrind.drupal.dev'.
#
# === Examples
#
#   class { 'webgrind': }
#
# === Requirements
#
class webgrind() {   
  exec { 'exec mkdir -p /usr/share/php/webgrind/source':
    command => "mkdir -p /usr/share/php/webgrind/source",
    creates => '/usr/share/php/webgrind/source',
  }  

  exec { 'php-download-webgrind':
    cwd     => '/tmp',
    command => 'wget https://webgrind.googlecode.com/files/webgrind-release-1.0.zip',
    creates => "/usr/share/php/webgrind/source/index.php",
  }

  exec { 'php-extract-webgrind':
    cwd     => '/tmp',
    command => 'unzip webgrind-release-1.0.zip',
    creates => "/usr/share/php/webgrind/source/index.php",
    require => Exec['php-download-webgrind'],
  }

  exec { 'php-move-webgrind':
    command => "cp -r /tmp/webgrind/* /usr/share/php/webgrind/source",
    creates => "/usr/share/php/webgrind/source/index.php",
    require => [ Exec['php-extract-webgrind'], Exec['exec mkdir -p /usr/share/php/webgrind/source'] ],
  }
}
