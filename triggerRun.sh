#! /bin/bash

# for user input of url and variable name is URL
source ./prompt-url.sh



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
