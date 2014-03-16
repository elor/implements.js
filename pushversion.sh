#!/bin/bash
#
# update all version information, delete this file and

# get the current version from the branch name
branch_name="$(git symbolic-ref HEAD 2>/dev/null)" ||
branch_name="(unnamed branch)"     # detached HEAD
branch_name=${branch_name##refs/heads/}
version=${branch_name##release-}

# replace all %VERSION% and $VERSION$ placeholders
echo "pushing version $version"
IFS=$'\r\n'
for file in `git ls-files`; do
  sed -i -e "s/\\\$VERSION\\$/$version/g" -e "s/%VERSION%/$version/g" $file
  git add $file
done

# create alternative files automatically

mkdir alt
sed -e 's/var Implements = (function /define(function /' -e 's/})();/});/' \
  implements.js > alt/implements-require.js

git add alt

git rm pushversion.sh --cached

echo "committing changes"

git commit -m "pushed version $version"

rm pushversion.sh