class user_account ($username = 'homer'){

  user { $username:
    ensure	=> present,
    managehome	=> true,
  }
}
