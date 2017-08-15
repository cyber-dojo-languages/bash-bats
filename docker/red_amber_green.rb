
lambda { |stdout,stderr,status|
  output = stdout + stderr
  return :green if status === 0
  return :amber if /.*: line \d+:/.match(output) && status === 1
  return :red
}

#RED
#not ok 1 life the universe and everything
## (in test file test_hiker.sh, line 7)
##   `[ "$actual" == "42" ]' failed
#stderr ==
#status == 1

#AMBER
#not ok 1 life the universe and everything
## (in test file test_hiker.sh, line 7)
##   `[ "$actual" == "42" ]' failed
## ./hiker.sh: line 5: 6 * 9sdsd: value too great for base (error token is "9sdsd")
#stderr ==
#status == 1