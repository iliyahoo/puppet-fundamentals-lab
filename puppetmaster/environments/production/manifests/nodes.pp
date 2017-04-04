node "wiki" {
  hiera_include('classes')
}


node "wikitest" {
  hiera_include('classes')
}


node "winadmin" {
  hiera_include('classes')
}


class linux {

  $vim = $osfamily ? {
    'redhat' => 'vim-enhanced',
    'debian' => 'vim',
    default => 'vim',
  }

  $admintools = ['screen', 'git', 'telnet', $vim]

  package { $admintools:
    ensure => 'installed',
  }

  $ntpservice = $osfamily ? {
    'redhat' => 'ntpd',
    'debian' => 'ntp',
    default => 'ntp',
  }

  file { '/info.txt':
    ensure  => 'present',
    content => inline_template("Created by Puppet at <%= Time.now %>\n"),
  }

  package { 'ntp':
    ensure => 'installed',
  }

  service { $ntpservice:
    ensure => 'running',
    enable => true,
  }

}
