# Dart GitHub Cloner

Just to experiment with how I can download repo content from a private repository from GitHub using Dart.

## Getting Started

Create `.env` file in the root directory and add the following content:

```env
GITHUB_PAT=github_pat_xxxxxxxx
```

_I created my token using the GitHub's new **Fine-grained personal access tokens**, but I think you can also use the traditional token. For public repository, I'm not sure whether you need the token or not_

## Known issue

- Download as `tar.gz` tarball file can have unexpected results. Some files are not located correctly inside their original directory.

## References

- https://docs.github.com/en/rest/repos/contents?apiVersion=2022-11-28#download-a-repository-archive-tar
- https://docs.github.com/en/rest/repos/contents?apiVersion=2022-11-28#download-a-repository-archive-zip
