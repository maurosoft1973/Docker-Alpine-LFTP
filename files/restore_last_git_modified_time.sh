#!/bin/sh -e

OS=${OS:-`uname`}

if [ "$OS" = 'Darwin' ]; then
    get_touch_time() {
        date -r ${unixtime} +'%Y%m%d%H%M.%S'
    }
else
    # default Linux
    get_touch_time() {
        date -d @${unixtime} +'%Y%m%d%H%M.%S'
    }
fi

# all git files
git ls-tree -r --name-only HEAD	> .git_ls-tree_r_name-only_HEAD

# modified git files
git diff --name-only > .git_diff_name-only

# minus https://stackoverflow.com/questions/1370996/minus-operation-on-two-files-using-linux-commands                                                                      
# only restore files not modified
comm -2 -3 .git_ls-tree_r_name-only_HEAD .git_diff_name-only | while read filename; do
  unixtime=$(git log -1 --format="%at" -- "${filename}")
  touchtime=$(get_touch_time)
  echo ${touchtime} "${filename}"
  touch -t ${touchtime} "${filename}"
done

rm .git_ls-tree_r_name-only_HEAD .git_diff_name-only