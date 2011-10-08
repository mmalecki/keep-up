# keep-up
Copyright (C) 2011 by Maciej Małecki  
MIT License (see LICENSE file)

keep-up is a tiny command line tool for keeping your git repos updated,
written to get familiar with Lua.

When given a directory, it'll iterate over it, looking for git repos and
updating them if no `upstream` branch exists.

## Usage

    keep-up <directory>

