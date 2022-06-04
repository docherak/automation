# Downloads Manager
The following is a bash script I use to manage my Downloads folder.

Program waits for any changes in the Downloads folder and after it notices one, it waits for 10s before executing loop that checks for existence of .part files and waits until they disappear before moving all files to the specified directories, based on their extension.

Works with files that include spaces and special characters.

**Prerequisites:**

```
sudo apt-get install inotify-tools
```

**Usage:**

```
// make executable
chmod +x downloadsScanner.sh

// exec from folder
./downloadsScanner.sh
```
