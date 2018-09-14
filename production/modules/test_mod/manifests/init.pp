class test_mod ($file = '/tmp/TEST_FILE'){
  file { $file:
    ensure	=> absent,
    mode	=> '0644',
    content	=> 'This is a test file',
    }
}

