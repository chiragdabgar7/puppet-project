define test_mod::users(
  $ensure	= present,
  $username	= undef,
  $managehome	= true,
  $key		= undef
  ){
  
  user { $title:
    ensure	=> $ensure,
    managehome	=> $managehome,
  }

  file { "/home/${title}/.ssh":
    ensure	=> directory,
    owner	=> $title,
    group	=> $title,
    mode	=> '0700',
  }

 
}
