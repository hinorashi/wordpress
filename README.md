## Note
#### Versions in use
| Component | Version  |
| ---       | ---      |
| docker    | 20.10    |
| compose   | 1.28     |
| bash      | 4.4      |
| wordpress | 5.7      |
| wp-cli    | 2.4      |
| php       | 7.4      |
| apache    | 2.4      |
| mariadb   | 10.5     |
| mysql     | 8.0      |

## How to use
#### (Optional) Domain name & SSL cert
In case of local deployment, find your local IP addr, set it as your `DOMAIN_NAME` in [.env](.env) and run this:
```bash
./gen-self-signed-cert.sh
```
Or just leave it as is, I had prepared self-signed cert for `127.0.0.1`.

In case of prod, update your public `DOMAIN_NAME` in [.env](.env), put your cert stuffs into [cert/](cert/).

#### (Optional) Automate wordpress installation
This project automates the standard wordpress installation process by default, see [.env](.env):
```properties
COMPOSE_PROFILES=mariadb,auto-config
```
Check this part in [.env](.env) as well, update your preferences:
```properties
# wordpress config
WP_TITLE=Deathnote
WP_ADMIN_USER=hino
WP_ADMIN_PASSWORD=password
WP_ADMIN_EMAIL=hino@hino.io
```

In case you want to run the installation process manually, update your [.env](.env):
```diff
-COMPOSE_PROFILES=mariadb,auto-config
+COMPOSE_PROFILES=mariadb
```
Then you can access the home page and be redirected to the installation page, i.e. `http://<home>/wp-admin/install.php`

#### Deploy
```bash
docker-compose up -d && docker-compose logs -f
```

#### Burn them all
```bash
docker-compose down -v --remove-orphans && sudo rm -rf wp-data/
```

## Tricks
#### wp-cli
Play with wp-cli: https://developer.wordpress.org/cli/commands/

User:
```bash
docker-compose run --rm wp-cli user list
docker-compose run --rm wp-cli user create yasuo yasuo@hino.io --role=administrator --user_pass=secret
```
Config and Option:
```bash
docker-compose run --rm wp-cli config list
docker-compose run --rm wp-cli option get home
docker-compose run --rm wp-cli option get siteurl
docker-compose run --rm wp-cli option set home http://<home>
docker-compose run --rm wp-cli option set siteurl http://<site-url>
```

#### mariadb (or even mysql)
Show tables:
```bash
docker exec -it mariadb mysql -proot -Dwordpress -e 'show tables;'
```
Dump data:
```bash
docker exec -it mariadb mysqldump -hmariadb -uroot -proot -B wordpress --single-transaction --no-create-db > dump.sql
docker exec -it mariadb sh -c 'mysqldump -hmariadb -uroot -p"$MYSQL_ROOT_PASSWORD" -B wordpress --single-transaction --no-create-db' > dump.sql
```
Restore data:
```bash
cat dump.sql | docker exec -i mariadb mysql -uroot -Dwordpress -proot
```
