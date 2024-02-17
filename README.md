# git-ego

Swap between different users for Git repositories.

> [!NOTE]
> This program only affects **local** Git configurations

## Installation

TODO: Write installation instructions here

## Usage

TODO: Write usage instructions here

If you have everything organized well enough, one can just use
[conditional inclusions][1] in their Git configuration.
If not, this tool comes in handy.
It sure did for my needs.

[1]: https://git-scm.com/docs/git-config#_conditional_includes

## Development

TODO: Write development instructions here

## Contributing

1. Fork it (<https://github.com/rocx/git-ego/fork>)
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

## Contributors

- [Box O'Rocks](https://github.com/rocx) - creator and maintainer

## Config

`git-ego` is configured with YAML.

Table names are the keys for the alter ego itself.

```yaml
john:
  user.name: John Doe
  user.email: jdoe1@example.com
  core.sshCommand: ssh -i ~/.ssh/id_jdoe -o 'IdentitiesOnly yes'

rocx:
  user.name: Box O'Rocks
  user.email: rocx@rocx.rocks
  core.sshCommand: ssh -i ~/.ssh/id_rocx -o 'IdentitiesOnly yes'
```

```
$ git config --local user.name
John Doe
$ git ego rocx
$ git config --local user.name
Box O'Rocks
```
