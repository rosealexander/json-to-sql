## json_sql
Copies JSON data into a SQL table and vice-versa.

### usage
- gem install json_to_sql

```text
usage: json_to_sql [options]
    -e, --except  Keys to exclude
    -f, --file    JSON file path
    -t, --table   Database table name
    -u, --uri     SQL connection URI
    -j, --json    Create JSON file from a SQL table
    -h, --help    Displays this message
```
- Keys from JSON source must match SQL table column names. Use `--except` to exclude keys.

[![MIT License][license-shield]][license-url]

[license-shield]: https://img.shields.io/github/license/rosealexander/json-to-sql.svg?style=for-the-badge
[license-url]: https://github.com/rosealexander/json-to-sql/blob/master/LICENSE
