+++
title = 'Haproxy for Alipay'
date = 2023-12-16T10:16:20+08:00
draft = false
+++

## Why Haproxy?

Because GitBundle want to use a server program to proxy tcp and http port, like the ssh port `22`, and https port `443`. And some other tcp port. And haproxy is known with its high availability, so GitBundle decide to use haproxy for the server program.

## Haproxy for Alipay

GitBundle order module have tried to use the modern configuration for haproxy with openssl, and eventually GitBundle can't receive the notify callback request.

### A bad configuration for haproxy without alipay notify callback request
```bash
# generated 2023-12-16, Mozilla Guideline v5.7, HAProxy 2.6.14, OpenSSL 3.0.2, modern configuration
# https://ssl-config.mozilla.org/#server=haproxy&version=2.6.14&config=modern&openssl=3.0.2&guideline=5.7
global
    # modern configuration
    ssl-default-bind-ciphersuites TLS_AES_128_GCM_SHA256:TLS_AES_256_GCM_SHA384:TLS_CHACHA20_POLY1305_SHA256
    ssl-default-bind-options prefer-client-ciphers no-sslv3 no-tlsv10 no-tlsv11 no-tlsv12 no-tls-tickets

    ssl-default-server-ciphersuites TLS_AES_128_GCM_SHA256:TLS_AES_256_GCM_SHA384:TLS_CHACHA20_POLY1305_SHA256
    ssl-default-server-options no-sslv3 no-tlsv10 no-tlsv11 no-tlsv12 no-tls-tickets
...
```


### The working configuration GitBundle used for alipay
```bash
# generated 2023-07-06, Mozilla Guideline v5.7, HAProxy 2.6.14, OpenSSL 3.0.2, intermediate configuration
# https://ssl-config.mozilla.org/#server=haproxy&version=2.6.14&config=intermediate&openssl=3.0.2&guideline=5.7
global
    # intermediate configuration
    ssl-default-bind-ciphers ECDHE-ECDSA-AES128-GCM-SHA256:ECDHE-RSA-AES128-GCM-SHA256:ECDHE-ECDSA-AES256-GCM-SHA384:ECDHE-RSA-AES256-GCM-SHA384:ECDHE-ECDSA-CHACHA20-POLY1305:ECDHE-RSA-CHACHA20-POLY1305:DHE-RSA-AES128-GCM-SHA256:DHE-RSA-AES256-GCM-SHA384:DHE-RSA-CHACHA20-POLY1305
    ssl-default-bind-ciphersuites TLS_AES_128_GCM_SHA256:TLS_AES_256_GCM_SHA384:TLS_CHACHA20_POLY1305_SHA256
    ssl-default-bind-options prefer-client-ciphers no-sslv3 no-tlsv10 no-tlsv11 no-tls-tickets

    ssl-default-server-ciphers ECDHE-ECDSA-AES128-GCM-SHA256:ECDHE-RSA-AES128-GCM-SHA256:ECDHE-ECDSA-AES256-GCM-SHA384:ECDHE-RSA-AES256-GCM-SHA384:ECDHE-ECDSA-CHACHA20-POLY1305:ECDHE-RSA-CHACHA20-POLY1305:DHE-RSA-AES128-GCM-SHA256:DHE-RSA-AES256-GCM-SHA384:DHE-RSA-CHACHA20-POLY1305
    ssl-default-server-ciphersuites TLS_AES_128_GCM_SHA256:TLS_AES_256_GCM_SHA384:TLS_CHACHA20_POLY1305_SHA256
    ssl-default-server-options no-sslv3 no-tlsv10 no-tlsv11 no-tls-tickets

    # curl https://ssl-config.mozilla.org/ffdhe2048.txt > /path/to/dhparam
    ssl-dh-param-file /etc/haproxy/dhparam
    log stdout format raw local0
...
```

### The full example GitBundle used with haproxy

```bash
# generated 2023-07-06, Mozilla Guideline v5.7, HAProxy 2.6.14, OpenSSL 3.0.2, intermediate configuration
# https://ssl-config.mozilla.org/#server=haproxy&version=2.6.14&config=intermediate&openssl=3.0.2&guideline=5.7
global
    # intermediate configuration
    ssl-default-bind-ciphers ECDHE-ECDSA-AES128-GCM-SHA256:ECDHE-RSA-AES128-GCM-SHA256:ECDHE-ECDSA-AES256-GCM-SHA384:ECDHE-RSA-AES256-GCM-SHA384:ECDHE-ECDSA-CHACHA20-POLY1305:ECDHE-RSA-CHACHA20-POLY1305:DHE-RSA-AES128-GCM-SHA256:DHE-RSA-AES256-GCM-SHA384:DHE-RSA-CHACHA20-POLY1305
    ssl-default-bind-ciphersuites TLS_AES_128_GCM_SHA256:TLS_AES_256_GCM_SHA384:TLS_CHACHA20_POLY1305_SHA256
    ssl-default-bind-options prefer-client-ciphers no-sslv3 no-tlsv10 no-tlsv11 no-tls-tickets

    ssl-default-server-ciphers ECDHE-ECDSA-AES128-GCM-SHA256:ECDHE-RSA-AES128-GCM-SHA256:ECDHE-ECDSA-AES256-GCM-SHA384:ECDHE-RSA-AES256-GCM-SHA384:ECDHE-ECDSA-CHACHA20-POLY1305:ECDHE-RSA-CHACHA20-POLY1305:DHE-RSA-AES128-GCM-SHA256:DHE-RSA-AES256-GCM-SHA384:DHE-RSA-CHACHA20-POLY1305
    ssl-default-server-ciphersuites TLS_AES_128_GCM_SHA256:TLS_AES_256_GCM_SHA384:TLS_CHACHA20_POLY1305_SHA256
    ssl-default-server-options no-sslv3 no-tlsv10 no-tlsv11 no-tls-tickets

    # curl https://ssl-config.mozilla.org/ffdhe2048.txt > /path/to/dhparam
    ssl-dh-param-file /etc/haproxy/dhparam
    log stdout format raw local0

defaults
    mode http
    log global
    option httplog
    option httpchk
    option forwardfor
    balance roundrobin
    timeout connect 5s
    timeout client  120s
    timeout server  120s
    maxconn 10000
    errorfile 400 /etc/haproxy/errors/400.http
    errorfile 403 /etc/haproxy/errors/403.http
    errorfile 408 /etc/haproxy/errors/408.http
    errorfile 500 /etc/haproxy/errors/500.http
    errorfile 502 /etc/haproxy/errors/502.http
    errorfile 503 /etc/haproxy/errors/503.http
    errorfile 504 /etc/haproxy/errors/504.http

frontend https
    # the certs folder includes, example.com.pem and example.com.pem.key
    # the haproxy document for ssl certs configuration
    # https://docs.haproxy.org/2.6/configuration.html#crt%20(Bind%20options)
    bind :80
    bind :443 ssl crt /nas/www/haproxy/certs alpn h2,http/1.1

    redirect scheme https code 301 if !{ ssl_fc }
    http-response set-header Strict-Transport-Security max-age=63072000

    acl is_dl req.hdr(host) -i dl.gitbundle.com
    redirect location https://gitbundle.com/gitbundle/gitbundle/releases code 301 if is_dl

    use_backend cors_backend if { method OPTIONS }
    use_backend gitbundle_servers if { req.hdr(host) -i gitbundle.com }
    use_backend gitbundle-blog_servers if { req.hdr(host) -i blog.gitbundle.com }
    use_backend gitbundle-docs_servers if { req.hdr(host) -i docs.gitbundle.com }
    use_backend gitbundle-plugins-docs_servers if { req.hdr(host) -i plugin-docs.gitbundle.com }
    use_backend marketplace_servers if { req.hdr(host) -i marketplace.gitbundle.com }
    use_backend static_servers if { req.hdr(host) -i static.gitbundle.com }

...
```

## Some useful references

- [haproxy documentation](https://docs.haproxy.org)
- [SSL Configuration Generator](https://ssl-config.mozilla.org)