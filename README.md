#### Added note
  For my iOS client to work, the endpoint needed to be the public IPv6 of the host machine.
  ```shell
  ifconfig en0
  ```
  
  Look for the line with the "secured" address.
  ```shell
  inet6 AAAA:BBBB:CCCC:DDDD:EEEE:fff:000:1111 prefixlen 64 autoconf secured
  ``` 
  
  Client config entry looks like:
  ```shell
  Endpoint = [AAAA:BBBB:CCCC:DDDD:EEEE:fff:000:1111]:51820
  ```
