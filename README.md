# docker

ローカル用のDocker

# 事前準備

 * dockerが使える状況にする。  
Docker for Mac or Docker for Windows をダウンロードインストール
https://docs.docker.com/mac/  
 * docker-compose.ymlのvolumesを絶対パスにする。

# mysql

```
docker-compose up -d db
```

# memcached

```
docker-compose up -d memcached
```
