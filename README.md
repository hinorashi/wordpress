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

#### Deploy
```bash
docker-compose up -d && docker-compose logs -f
```

#### (To be optimized) Wordpress installation
Check this part in `compose.yml`, update your preferences (refer: https://developer.wordpress.org/cli/commands/core/install/):
```yml
services:
  wp-cli:
    command: >
      wp core install
      --path="/var/www/html"
      --url="http://${DOMAIN_NAME}"
      --title="Deathnote"
      --admin_user=hino
      --admin_password=password
      --admin_email=hino@hino.io
      --skip-email
```
Then run this:
```bash
docker-compose run --rm wp-cli
```
What you should see:
```properties
Creating wp_wp-cli_run ... done
Success: WordPress installed successfully.
```
Or you can access the installation page, e.g. `http://<home>/wp-admin/install.php`

#### Burn them all
```bash
docker-compose down -v --remove-orphans
sudo rm -rf wp-data/* && sudo rm -f wp-data/.htaccess && ll wp-data/
```

## Tricks
Play with wp-cli: https://developer.wordpress.org/cli/commands/

#### User
```bash
docker-compose run --rm wp-cli user list
docker-compose run --rm wp-cli user create yasuo yasuo@hino.io --role=administrator --user_pass=secret
```

#### Config and Option
```bash
docker-compose run --rm wp-cli config list
docker-compose run --rm wp-cli option get home
docker-compose run --rm wp-cli option get siteurl
docker-compose run --rm wp-cli option set home http://<home>
docker-compose run --rm wp-cli option set siteurl http://<site-url>
```
