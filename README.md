# rssp

A quick rss feed parser.

## Install

```
$ git clone https://github.com/teegre/rssp
$ cd rssp
# make install
```

## Uninstall

```
# make uninstall
```

## Usage

```
rssp version 0.3
quick rss feed parser.

usage: rssp [-t] <url|file>

options:
  -t display rss channel's title only.

```

## Example

### Get rss feed title:

```
$ rssp -t https://example.com/feeds/news/
Example dot com: Recent news updates
```

### Get rss feed entries

```
$ rssp https://example.com/feeds/news/
2024/07/01 Entry 1
https://example.com/news/entry1/
2024/04/15 Entry 2
https://example.com/news/entry2/
2024/04/07 Entry 3
https://example.com/news/entry3/
```
