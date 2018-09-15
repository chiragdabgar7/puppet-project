node default {
file { '/tmp/test':
  ensure	=> absent,
  content	=> "Hey i am a file",
  mode		=> '0644',
}

#lookup('users').each | String $username | {
#  user { $username:
#    ensure	=> present,
#    }
#  }

docker::run { 'hello-alpine':
  ensure	=> absent,
  image		=> 'alpine',
  command	=> '/bin/sh -c "while true; do echo Hello, world; sleep 1; done"',
 }
  class {test_mod:}
}

#node definition for puppet-agent1
node 'puppet-agent1' {
include ::mysql::server
include docker
include test_mod
#include blogpost
  file { '/tmp/test.txt':
    ensure	=> present,
    content	=> "Hey i am in agent",
    mode	=> '0644',
  }


#lookup('users').each | String $username | {
#  user { $username:
#    ensure      => absent,
#    managehome	=> true,
#    }
#  }  

cron { 'cron-example':
    ensure	=> absent,
    command	=> '/bin/date +%F',
    user	=> ['brady','katy','charles'],
    hour	=> '0',
    minute	=> '0',
    weekday	=> ['Saturday', 'Sunday'],
  }
test_mod::users {'homer2':}

lookup('users').each | String $username | {
  test_mod::users { $username:}
  }

docker::swarm { 'cluster_manager':
  init			=> true,
  advertise_addr	=> '192.168.56.20',
  listen_addr		=> '192.168.56.20',
#  manager_ip		=> '192.168.56.10',
#  token			=> 'SWMTKN-1-4680via8tqa5jz3gnyh1ecf3dh9qr9cdb9jvowehd2y3kcblvb-e4mql3sqfh5tts07pjsn1f504',
}

docker_network { 'my_net':
  ensure	=> present,
  driver	=> overlay,
  subnet	=> '192.168.56.0/24',
  gateway	=> '192.168.56.1',
  ip_range	=> '192.168.56.1/24',
}
}

#node definition for puppet-agent2
node 'puppet-agent2' {
    file { '/tmp/test.txt':
    ensure      => present,
    content     => "Hey i am in agent1",
    mode        => '0644',
  }

  user { 'tom':
    ensure      => present,
    managehome  => true,
  }
  
#  lookup('users').each | String $username | {
#  user { $username:
#    ensure      => present,
#    managehome  => true,
#    }
#  }
  class {user_account:
    username        => 'dash',
  }
}
