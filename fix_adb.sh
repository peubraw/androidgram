#!/bin/bash

echo "=== DIAGNÓSTICO ADB ==="

# Tenta obter acesso root para configurar a porta
echo "[*] Configurando ADB via ROOT..."
su -c "setprop service.adb.tcp.port 5555 && stop adbd && start adbd"

# Aguarda o serviço reiniciar
sleep 3

# Verifica se a configuração foi aplicada
PORT=$(getprop service.adb.tcp.port)
echo "[*] Propriedade service.adb.tcp.port: $PORT"

if [ "$PORT" != "5555" ]; then
    echo "[!] AVISO: A porta não parece estar configurada como 5555. Tentando ler via root..."
    PORT_ROOT=$(su -c "getprop service.adb.tcp.port")
    echo "[*] Propriedade via root: $PORT_ROOT"
fi

# Obtém o IP local
IP=$(ifconfig | grep -Eo 'inet (addr:)?([0-9]*\.){3}[0-9]*' | grep -v '127.0.0.1' | awk '{print $2}' | sed 's/addr://')
echo "[*] IP Local detectado: $IP"

# Reinicia o servidor ADB do Termux
echo "[*] Reiniciando servidor ADB local..."
adb kill-server
adb start-server

# Tenta conectar no loopback
echo "[*] Tentando conectar em 127.0.0.1:5555..."
adb connect 127.0.0.1:5555

# Tenta conectar no IP local se encontrado
if [ ! -z "$IP" ]; then
    echo "[*] Tentando conectar em $IP:5555..."
    adb connect $IP:5555
fi

# Lista dispositivos
echo "=== LISTA DE DISPOSITIVOS ==="
adb devices
echo "============================="

if adb devices | grep -q "device$"; then
    echo "SUCESSO! Dispositivo conectado."
    echo "Agora você pode rodar o bot."
else
    echo "FALHA: Nenhum dispositivo conectado."
fi
