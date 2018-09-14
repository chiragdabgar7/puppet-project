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
include apache
include docker
include test_mod
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

#  file { '/examples/Dockerfile':
#     source	=> '/examples/Dockerfile',
#     notify 	=> Docker::Image['sample-ubuntu'],
#  }

#  docker::image { 'sample-ubuntu':
#    ensure	=> 'present',
#  }
  
#  docker::run { 'cont-ubuntu-16.04':
#    image	=> 'ubuntu:16.04',
#    ports	=> ['22'],
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
}

#node definition for puppet-agent2
node 'puppet-agent2' {
include apache
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
