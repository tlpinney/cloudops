
file { "/etc/hadoop/conf/hadoop-env.sh" :
   owner => root,
   group => hadoop,
   source => "/home/ubuntu/cloudops/configs/hadoop-env.sh",
   mode => 644
}

file { "/etc/hadoop/conf/core-site.xml" :
   owner => root,
   group => hadoop,
   mode => 644,
   content => template("/home/ubuntu/cloudops/configs/core-site.erb")
}

file { "/etc/hadoop/conf/hdfs-site.xml" :
   owner => root,
   group => hadoop,
   mode => 644,
   source => "/home/ubuntu/cloudops/configs/hdfs-site.xml"
}

file { "/etc/hadoop/conf/mapred-site.xml" :
   owner => root,
   group => hadoop,
   mode => 644,
   content => template("/home/ubuntu/cloudops/configs/mapred-site.erb")
}

file { "/etc/zookeeper/zoo.cfg" :
   owner => root,
   group => root,
   mode => 644,
   source => "/home/ubuntu/cloudops/configs/zoo.cfg"
}

file { "/home/ubuntu/accumulo/conf/accumulo-env.sh" :
   owner => ubuntu,
   group => ubuntu,
   mode => 644,
   source => "/home/ubuntu/cloudops/configs/accumulo-env.sh"
}

file { "/home/ubuntu/accumulo/conf/accumulo-site.xml" :
   owner => ubuntu,
   group => ubuntu,
   mode => 644,
   content => template("/home/ubuntu/cloudops/configs/accumulo-site.erb")
}


file { "/home/ubuntu/accumulo/conf/masters" :
   owner => ubuntu,
   group => ubuntu,
   mode => 644,
   content => template("/home/ubuntu/cloudops/configs/masters.erb")
}


file { "/home/ubuntu/accumulo/conf/slaves" :
   owner => ubuntu,
   group => ubuntu,
   mode => 644,
   content => template("/home/ubuntu/cloudops/configs/slaves.erb")
}

file { "/home/ubuntu/accumulo/conf/tracers" :
   owner => ubuntu,
   group => ubuntu,
   mode => 644,
   content => template("/home/ubuntu/cloudops/configs/tracers.erb")
}

file { "/home/ubuntu/accumulo/conf/gc" :
   owner => ubuntu,
   group => ubuntu,
   mode => 644,
   content => template("/home/ubuntu/cloudops/configs/gc.erb")
}

file { "/home/ubuntu/accumulo/conf/monitor" :
   owner => ubuntu,
   group => ubuntu,
   mode => 644,
   content => template("/home/ubuntu/cloudops/configs/monitor.erb")
}

file { "/home/ubuntu/accumulo/conf/accumulo-metrics.xml" :
   owner => ubuntu,
   group => ubuntu,
   mode => 644,
   source => "/home/ubuntu/cloudops/configs/accumulo-metrics.xml"
}


exec { "Add servers ip address to known_hosts":
   cwd => "/home/ubuntu",
   user => "ubuntu",
   group => "ubuntu",
   command => "ssh-keyscan $ipaddress >> ~/.ssh/known_hosts && touch /home/ubuntu/known_hosts_added.log",
   creates => "/home/ubuntu/known_hosts_added.log",
   path => ["/usr/bin", "/usr/sbin"]
}



