
file { "/etc/hadoop/conf/hadoop-env.sh" :
   owner => root,
   group => hadoop,
   source => "/home/ubuntu/cloudops/configs/hadoop-env.sh",
   mode => 644
}





