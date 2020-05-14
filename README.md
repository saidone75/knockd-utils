# knockd-utils
Simple scripts for generating one time sequences for [knockd](https://zeroflux.org/projects/knock) and for knocking a host with either netcat or nmap. Sequences are made of three to four unprivileged ports numbers (1024-65535).

Examples:
* generating sequences
```console
$ knockd_otp.sh -n 10
 17620,10384,22548
 8039,11811,4352
 2540,13981,16799
 16942,16627,27591
 7305,32309,8245
 26823,28643,9771,28911
 2196,12782,9361,3344
 10692,16632,20031,22098
 28825,5720,21644,10606
 6621,27957,21833
 ```
* knocking a host
 ```console
 $ knock.sh -h 192.168.33.10 -s 17620,10384,22548
knock.sh started
knock.sh done!
```

## License
Copyright (c) 2020 Saidone

Distributed under the MIT License
