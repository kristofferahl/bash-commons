# bash-commons
Reusable Bash functions for common tasks such as logging

---

## Modules

### log.sh
A collection of logging helpers that write logs to stdout.

Features:
- Pre-defined log levels (TRACE, DEBUG, INFO, WARN, ERROR)
- Log level filtering
- Colored log output (with option to disable)
- Custom log formats
- Custom log levels (add your own)

See examples/log for more info.

---

## Installation

At this point, simply curl it...
```bash
curl --silent https://raw.githubusercontent.com/kristofferahl/bash-commons/master/modules/bash-commons/src/module-name.sh
```

## Usage
```bash
source path/to/module.sh
```

---

## Development

### Executable examples

```bash
./run example
```

### Running tests (locally)
```bash
./run test
```

### Running tests (in docker)
```bash
./run test-docker
```
