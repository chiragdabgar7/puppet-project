class blogpost {
  class { '::mysql::server':
    root_password	=> 'qwedsa',
    override_options	=> { 'mysqld' => { 'max_connections' => 1024 } },
  }
  mysql::db { 'statedb':
    user	=> 'admin',
    password	=> 'qwedsa',
    host	=> 'puppet-master',
    sql 	=> '/tmp/states.sql',
    require	=> File['/tmp/states.sql']
  }  

  file { "/tmp/states.sql":
    ensure	=> present,
    source	=> "puppet:///modules/blogpost/states.sql",
  }

  mysql_user { 'admin@localhost':
    ensure	=> present,
    max_connections_per_hour => '60',
    max_queries_per_hour     => '120',
    max_updates_per_hour     => '120',
    max_user_connections     => '10',
  }
 
   mysql_grant { 'admin@localhost/statedbl.states':
    ensure     => 'present',
    options    => ['GRANT'],
    privileges => ['ALL'],
    table      => 'statedbl.states',
    user       => 'admin@localhost',
  }

}
