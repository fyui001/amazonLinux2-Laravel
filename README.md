# 使い方

ローカルの開発機等で使う場合は以下のコマンドを実行
```
docker-compose up
```
  ```DONE  Compiled successfully```ってでたら起動成功なので以下のコマンドでバックグランドで実行する

  ```
  docker-compose up -d
  ```
開発はこれでコーディングしていけば万事オーケー


# ECSへのデプロイ方法
ecs-cliの設定等は出来てるものとしてすすめる

### プロジェクトルートディレクトリからデプロイ用のイメージをビルドする
```
docker build -f docker/web/deploy/Dockerfile ./
```
成功したらECR等にpushする

### クラスタに設定ファイルをデプロイ
`ecs-cli compose service up` でクラスターにデプロイする。デフォルトは現在ディレクトリで
`docker-compose.yml`と`ecs-params.yml`を検索します。`--file`オプションを使用して別構成ファイルを指定することや、`--ecs-params`オプションで別のECS Paramsファイルを指定することもできます。

```
ecs-cli compose --project-name タスク名 service up --create-log-groups ロググループ名 --cluster-config クラスター名
```
