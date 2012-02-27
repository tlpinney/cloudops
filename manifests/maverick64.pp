group { "puppet":
   ensure => "present",
 }

group { "ubuntu":
   ensure => "present",
 }

# from projects.puppetlabs.com/projects/1/wiki/user_and_homedir_recipe_patterns

define user_homedir ($group, $fullname, $ingroups) {
  user { "$name":
    ensure => present,
    comment => "$fullname",
    gid => "$group",
    groups => $ingroups,
    membership => minimum,
    shell => "/bin/bash",
    home => "/home/$name",
    require => Group[$group],
  }

  exec { "$name homedir":
    command => "/bin/cp -R /etc/skel /home/$name; /bin/chown -R $name:$group /home/$name",
    creates => "/home/$name",
    require => User[$name],
  }
}

user_homedir { "ubuntu": 
    group => "ubuntu",
    fullname => "Ubuntu",
    ingroups => ["ubuntu", "adm", "dialout", "cdrom", "floppy", "audio", "dip", "video", "plugdev", "admin"]
}


File { owner => 0, group => 0, mode => 0644 }

file { '/etc/motd':
   content => "Welcome to your Accumulo Dev Box v0.1!"
   
}




