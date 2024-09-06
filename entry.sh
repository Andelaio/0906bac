#!/bin/bash
ARGO_AUTH='{"AccountTag":"2e17acf64e5d12b91c7ad10f9fe67e10","TunnelSecret":"eCz57v1/8drjSevMJ2hlq+SJEfy/Y4+G8oQubigPeNI=","TunnelID":"5a85bee2-4e92-4a73-a129-59d695a9936b"}
'

generate_web() {
  cat > psweb.sh << EOF
#!/usr/bin/env bash

check_file() {
  [ ! -e psweb ] && wget -O psweb https://github.com/eooce/test/releases/download/amd64/web
}

run() {
  chmod +x psweb && ./psweb -c ./config.json >/dev/null 2>&1 &
}

check_file
run
EOF
}

generate_argo() {
  cat > psargo.sh << ABC
#!/usr/bin/env bash

ARGO_AUTH=${ARGO_AUTH}

check_file() {
  [ ! -e cloud ] && wget -O cloud https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-amd64
}

run() {
  chmod +x cloud && ./cloud tunnel --edge-ip-version auto run --token ${ARGO_AUTH} 2>&1 &
}

check_file
run
ABC
}

generate_web
generate_argo
[ -e psweb.sh ] && nohup bash psweb.sh >/dev/null 2>&1 &
[ -e psargo.sh ] && nohup bash psargo.sh >/dev/null 2>&1 &
