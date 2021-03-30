## Note
### Versions in use
| Component | Version  | 
| ---       | ---      |
| wordpress | 5.7      |
| wp-cli    | 2.4      |
| php       | 7.4      |
| apache    | 2.4      |
| mariadb   | 10.5     |

## How to use
### Deploy
```bash
docker-compose up -d && docker-compose logs -f
```
### Burn them all
```bash
docker-compose down -v --remove-orphans
sudo rm -rf wp-data/* && sudo rm -f wp-data/.htaccess && ll wp-data/
```
