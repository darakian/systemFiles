#!/bin/bash
for i in $(python-modernize -l | tail -51 | head -50 | awk '{print $2}' | awk -F '(' '{print $2}' | awk -F ')' '{print $1}')
do
    echo "Checking out master"
    git checkout master
    echo "Moving to fixer branch $i"
    git checkout -b "automatic-modernize-fixer=$i"
    if [ "$?" != 0 ]
    then
        echo "Skipping $i"
        continue
    fi
    python-modernize -f "$i" -j 8 -w -n --no-diffs .
    echo "Commiting fixes"
    git add -u
    git commit -m "Modernize fixes provided by the $i fixer"
    diffs=$(git diff master.. | wc -l)
    if [ $diffs == 0 ]
    then
        echo "$i has no diffs. Deleting branch"
        git checkout master
        git branch -D "automatic-modernize-fixer=$i"
    else
        git push --set-upstream origin "automatic-modernize-fixer=$i"
    fi
done