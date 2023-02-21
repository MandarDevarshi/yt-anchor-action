#! /bin/bash

# for user input of url and variable name is URL
# For manual run: uncomment and comment out the lines
# which are reading the playlist from CODESPACE secret
# source ./prompt-url.sh

# The URL is read from repository variable and passed from scheduled workflow
URL=$1
echo "Processing: " $URL

# The branch on which this is being run
# branch=$(git branch --show-current)
# echo $branch
# # Sync with the latest convertedVideos file
# git checkout origin/$branch -- convertedVideos.json

# To download and generate episodes to be uploaded
node generateEpisodeList.mjs $URL

TOTAL_EPISODES=$(ls | grep episode | wc -l)

echo
echo "=======           Commit Changes to Processed Videos                        ======\n"
echo " Note: To reset in case of failure use emptyProcessedFile script and commit manually"
echo '===================================================================================='
git add -f convertedVideos.json
git commit -m "workflow-run: Videos processed"
git push

echo 
echo '==================================================='
echo "=       Triggering push for Github action         ="
echo '==================================================='
echo 
echo Total episode to convert and upload: ${TOTAL_EPISODES}

for i in $(ls | grep episode); do
    # Rename to episode.json
    mv $i episode.json
    # Stage file for commit
    git add -f episode.json
    # Commit
    git commit -m 'workflow-run: Uploading Episode to AnchorFM'
    # Push to trigger
    git push
done
