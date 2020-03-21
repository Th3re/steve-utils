# steve-utils
Repository containing automation and debugging scripts

## Run

```bash
$ ./steve.sh --help
Steve Utils CLI
Set of Steve automation and debugging commands

Run one of the following commands:
  rabbit-consumer

All commands are configurable via environment variables.

```

Example

```bash
./steve.sh rabbit-consumer env/location-write-api.sh
Running rabbit topic consumer with env: env/location-write-api.sh
 [*] Waiting for logs. To exit press CTRL+C

```
