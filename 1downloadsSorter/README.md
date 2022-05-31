# Downloads Manager
The following is a bash script I use to manage my Downloads folder.

It scans for any changes in the Downloads folder (excl. subfolders) and sorts the files by scanning their extensions, moving them to the specified folders accordingly.

Works with files that include spaces and special characters.

Tested with [zsh](https://www.zsh.org/).

**Prerequisites:**

```
sudo apt-get install inotify-tools
```

**Usage:**

```
// make executable
chmod a+x downloadsScanner.sh

// exec
./downloadsScanner.sh
```

**How I launch this on reboot:**

```
crontab -e

// add the following line:
@reboot [path to shell script] & disown
```
