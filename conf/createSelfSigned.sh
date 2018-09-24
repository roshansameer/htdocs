#!/usr/bin/env bash
SSL_CRT_DIR=${SSL_CRT_DIR-./ssl.crt}
SSL_KEY_DIR=${SSL_KEY_DIR-./ssl.key}

# Set up SSL directory.
if [ ! -d $SSL_CRT_DIR ]; then
	# set up testing suite
	mkdir -p $SSL_CRT_DIR
fi

if [ ! -d $SSL_KEY_DIR ]; then
	# set up testing suite
	mkdir -p $SSL_KEY_DIR
fi

openssl req -new -sha256 -nodes -out server.csr -newkey rsa:2048 -keyout "$SSL_KEY_DIR"/server.key -config openssl.cnf
openssl x509 -req -in server.csr -CA rootCA.pem -CAkey rootCA.key -CAcreateserial -out "$SSL_CRT_DIR"/server.crt -days 500 -sha256 -extfile v3.ext

rm -f server.csr
rm -f rootCA.srl
