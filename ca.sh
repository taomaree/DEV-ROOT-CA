
test -f ca-rsa.pem || cfssl gencert -initca ca-csr-rsa.json | cfssljson -bare ca-rsa

test -f ca-ecc.pem || cfssl gencert -initca ca-csr-ecc.json | cfssljson -bare ca-ecc

openssl x509 -in ca-rsa.pem -text

openssl x509 -in ca-ecc.pem -text

SAN=${SAN:-"127.0.0.1,example.com,*.example.com"}
test -f web.pem || cfssl gencert -ca=ca-ecc.pem -ca-key=ca-ecc-key.pem -config=ca-config.json -hostname=${SAN} -profile=ca web-csr.json | cfssljson -bare web

test -f legacy.pem || cfssl gencert -ca=ca-ecc.pem -ca-key=ca-ecc-key.pem -config=ca-config.json -hostname=${SAN} -profile=ca legacy-csr.json | cfssljson -bare legacy

openssl x509 -in web.pem -text | grep DNS
openssl x509 -in legacy.pem -text | grep DNS




