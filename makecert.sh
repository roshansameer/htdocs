#!/usr/bin/env bash
# usage: makecert.sh <cert-name>

CA_NAME=${1-rootCA}
SSL_CRT_DIR=${SSL_CRT_DIR-./conf/ssl.crt}
SSL_CSR_DIR=${SSL_CSR_DIR-./conf/ssl.csr}
SSL_KEY_DIR=${SSL_KEY_DIR-./conf/ssl.key}

# Set up SSL directory.
if [ ! -d $SSL_CRT_DIR ]; then
	mkdir -p $SSL_CRT_DIR
fi

if [ ! -d $SSL_CSR_DIR ]; then
	mkdir -p $SSL_CSR_DIR
fi

if [ ! -d $SSL_KEY_DIR ]; then
	mkdir -p $SSL_KEY_DIR
fi

# Generate root certificate.
if [ ! -e ${CA_NAME}.key ]; then

	# Generate private key.
	openssl genrsa -des3 -out ${CA_NAME}.key 2048

	# Generate root certificate.
	openssl req -x509 -new -nodes -key ${CA_NAME}.key -sha256 -days 1024 -out ${CA_NAME}.pem

fi

# Generate self signed SSL certificate.
if [ ! -e ${SSL_CSR_DIR}/server.csr ]; then

	# Generate a server Certificate Signing Request.
	openssl req -new -sha256 -nodes -out ${SSL_CSR_DIR}/server.csr -newkey rsa:2048 -keyout ${SSL_KEY_DIR}/server.key -config ./conf/server.csr.cnf

	# Sign SSL certificate.
	openssl x509 -req -in ${SSL_CSR_DIR}/server.csr -CA ${CA_NAME}.pem -CAkey ${CA_NAME}.key -CAcreateserial -out ${SSL_CRT_DIR}/server.crt -days 365 -sha256 -extfile ./conf/v3.ext

fi
