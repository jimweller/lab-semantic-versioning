#!/bin/zsh

source ~/.zshrc

export MY_TYP="Fix"
export MY_PRE="jim-weller"
export MY_BRANCH="${MY_TYP:l}/$MY_PRE-`date +%s`"
export MY_TITLE="$MY_TYP: $MY_PRE title $MY_BRANCH"
export MY_BODY="$MY_TYP: $MY_PRE body $MY_BRANCH  (`fortune`)"
export MY_CMSG="$MY_TYP: $MY_PRE commit message $MY_BRANCH  (`fortune`)"

gcb "$MY_BRANCH"
head -n 7 README.md >> .tmp
echo "- `date`" >> .tmp
mv .tmp README.md
gav .
gst
gcmsg "$MY_CMSG"

git fetch origin main
git rebase origin/main
git checkout $MY_BRANCH

ggpush

gh pr create --title "$MY_TITLE" --body="$MY_BODY" 
gh pr merge "$MY_BRANCH" -s -d


