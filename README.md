## Note
### Versions in use
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

## How to use
### (Optional) Domain name & SSL cert
In case of local deployment, find your local IP addr, set it as your `DOMAIN_NAME` in [.env](.env) and run this:
```bash
./gen-self-signed-cert.sh
```
Or just leave it as is, I had prepared self-signed cert for `127.0.0.1`.

In case of prod, update your public `DOMAIN_NAME` in [.env](.env), put your cert stuffs into [cert/](cert/).

### Deploy
```bash
docker-compose up -d && docker-compose logs -f
```

### Burn them all
```bash
docker-compose down -v --remove-orphans
sudo rm -rf wp-data/* && sudo rm -f wp-data/.htaccess && ll wp-data/
```
