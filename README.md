# open-pool-pirl
open-pool-pirl PT-BR

## Modificações com Base no Projeto Original Criado por:
https://github.com/sammy007
```
sammy007
https://github.com/sammy007

Donate 0xb85150eb365e7df0941f0cf08235f987ba91506a 
ETH/ETC/PIRL/ELLA/MUSIC

```

## Outras Opcões do Projeto

```
Ellaism
https://github.com/ellaism/community-pool

Wallermadev
https://github.com/wallermadev/pirl-pool
````


# Instalação
## Recomendo que tenha o Cliete pirl Geth pre instalado
Link: https://github.com/l217/pirl


Ambiente de Intalação Ubuntu 16.04 LTS

Instale os requisitos básicos necessários:
```sh
sudo apt-get install python-software-properties
curl -sL https://deb.nodesource.com/setup_8.x | sudo -E bash -
sudo add-apt-repository ppa:gophers/archive
sudo apt-get update

sudo apt-get install nodejs nginx redis-server git nano screen dpkg wget iptables iptables-persistent

```

Agora devemos clona o repositorio git para a pasta desejada ~ :
```sh
cd ~
https://github.com/l217/open-pool-pirl.git
```

Iremos para a pasta www e instalar requisitos básicos lá:
```
cd ~/community-pool/www/
npm install -g ember-cli
npm install -g bower
npm install
bower install --allow-root
```

agora você precisa editar o arquivo de configuração principal para o Ember js:
```sh
nano ~/open-pool-pirl/www/config/environment.js
```

Aqui você altera o domínio no APP Ex:
```js
    APP: {
      // API host and port
      ApiUrl: '//Seu-dominio/',

      // HTTP mining endpoint
      HttpHost: 'http://Seu-dominio',
      HttpPort: 9601,

      // Stratum mining endpoint
      StratumHost: 'Seu-dominio',
      StratumPort: 9202,

      // Fee and payout details
      PoolFee: '0.50%',
      PayoutThreshold: '1 PIRL',

      // For network hashrate (change for your favourite fork)
      BlockTime: 14.4
    }
  };
```

agora Daremos permições para os executáveis:
```sh
chmod +x ~/open-pool-pirl/poolrpc
chmod +x ~/open-pool-pirl/start.sh
chmod +x ~/open-pool-pirl/www/build.sh
```

after you have done this you want to compile your poolweb now:
```sh
cd ~/open-pool-pirl/www/
./build.sh
```

O caminho pode ser mostrado com esses comandos:
```sh
cd ~
pwd
```
a saída é a sua Psta

Agora estamos definindo o nginx para o pool. Abra uma nova configuração padrão com o nano ou editor preferido:
```sh
rm /etc/nginx/sites-available/default
nano /etc/nginx/sites-available/default
```

Agora, preencha essas configurações na configuração do nginx: 
```sh
server {
        listen 0.0.0.0:80;

        root <sua pasta path>/open-pool-pirl/www/dist;
        index index.html index.htm;

        server_name _;

        location /api {
                proxy_pass http://127.0.0.1:8080;
        }

        location / {
                try_files $uri $uri/ /index.html;
        }
}
```

Salve e reinicie o nginx:
```sh
service nginx restart
```


Agora crie um arquivo de senha e escreva uma senha,com a carteira do servidor usará que  ira efetuar os pagamentos:
```sh
nano ~/open-pool-pirl/.walletpass

```

Copie a saída e preencha-a em 3 arquivos:
```sh
nano ~/community-pool/start.sh
```

No final do arquivo de configuração em "payouts"> insira o Endereço para "endereço":
```sh
nano ~/open-pool-pirl/prlpayout.json
```


prlunlocker.json no final do arquivo de configuração em "unlocker" > insira o Endereço para "poolfeeaddress" fee padro esta 0.50% :
```sh
nano ~/open-pool-pirl/prlunlocker.json
```

## Caso o cliente go pirl esteja instalado
Agora estamos prontos para Executar o pool pela primeira vez:
```sh
~/open-pool-pirl/start.sh
```

Podemos olhar se todos os processos estão online, Com o comando:
```sh
screen -list
```
você deve ver todas as telas de todos os processos do pool na saída, então você pode continuar ... 


```sh
nano /etc/iptables/rules.v4
```
fill in there some basic rules:
```sh
*filter
:INPUT DROP [0:0]
:FORWARD DROP [0:0]
:OUTPUT ACCEPT [0:0]

# Accepts all established inbound connections
-A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT
# Allows all outbound traffic
# You could modify this to only allow certain traffic, you don't want to unless you know what you are doing!
-A OUTPUT -j ACCEPT
# Aceitar proxy Ember
-A INPUT -s 127.0.0.1/32 -j ACCEPT
# Aceita conexoes ao pool por todos
-A INPUT -p tcp --dport 80 -j ACCEPT
-A INPUT -p tcp --dport 9601 -j ACCEPT
-A INPUT -p tcp --dport 9202 -j ACCEPT
# Porta para conexoes via SSH 
# The --dport number is the same as in /etc/ssh/sshd_config you changed before
-A INPUT -p tcp -m state --state NEW --dport 22 -j ACCEPT
# Aceita teste de Ping
-A INPUT -p icmp -m icmp --icmp-type 8 -j ACCEPT
# log 
-A INPUT -m limit --limit 5/min -j LOG --log-prefix "iptables denied: " --log-level 7
# Reject all other inbound - default deny unless explicitly allowed policy:
-A INPUT -j REJECT
-A FORWARD -j REJECT

COMMIT

```
Salve-o, então você pode ativá-lo e escreva reformatado de volta ao arquivo:
```sh
 iptables-restore < /etc/iptables/rules.v4
 iptables-save > /etc/iptables/rules.v4
```
 

## Saldações:

Leandro

considerações
Equipes Minerpool.net / Pirl.io / Ellaism.com


P.S .:
Lembre-se de que ser um bom operador de pool é um trabalho de tempo integral com o apoio aos mineiros, apoiando a piscina, resolvendo problemas, mantendo a segurança e assim por diante.

Você deve obter uma chave shh e mudar ssh para permitir apenas o login com uma chave em vez da autenticação de senha. Além disso, você deve ler mais sobre segurança do servidor linux e backups do servidor linux, especialmente para um backup do banco de dados redis que você está usando agora.


