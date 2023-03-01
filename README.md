# Automating youtube video to anchor fm audio

**Table of Content**
- [Automating youtube video to anchor fm audio](#automating-youtube-video-to-anchor-fm-audio)
  - [Prerequisite](#prerequisite)
  - [Setting up automation](#setting-up-automation)
    - [Set up Github Credentials](#set-up-github-credentials)
      - [On your machine](#on-your-machine)
    - [Creating a new podcast](#creating-a-new-podcast)
    - [Setting up the cron job](#setting-up-the-cron-job)
      - [Playlist](#playlist)
      - [Setup Workflow](#setup-workflow)
      - [Setup Cron](#setup-cron)
      - [Edit Cron Job Timing](#edit-cron-job-timing)
    - [See Your Actions](#see-your-actions)
  - [Manual Method](#manual-method)
  - [How is the converted videos data stored ?](#how-is-the-converted-videos-data-stored-)
  - [Concern regarding automation of playlists](#concern-regarding-automation-of-playlists)

## Prerequisite 

> For the script to run successfully it is necessary for there to be **at least one episode manually published** on Anchor.fm. The steps to publish on a brand new Anchor.fm account are different and will break the automation.

1. Make sure you have `node`, `npm` and `git` installed on your machine.

   ```bash
    node --version && npm --version && git --version
   ```
## Setting up automation

### Set up Github Credentials

> If you are not using any `GCM (Git Credential Manager)` which already has `Personal Access Token` to authenticate you with Github, do the following steps. Otherwise, skip.

1. Install [Homebrew](https://brew.sh/)
2. Install [Github CLI](https://github.com/cli/cli#installation)
3. Get a Fine-Grained PAT for the repository. [Personal access token how to](https://docs.github.com/en/authentication/keeping-your-account-and-data-secure/creating-a-personal-access-token#creating-a-fine-grained-personal-access-token) with following permissions  
![Screenshot 2023-03-01 at 17-49-37 Fine-grained Personal Access Tokens](https://user-images.githubusercontent.com/34445750/222138260-a80aecff-9325-46b4-8020-6978826a0c50.png)

#### On your machine 

1. Make `gh` your credential manager  `gh auth setup-git`
2. `git auth login` will help you set things up. For help [gh auth login][https://cli.github.com/manual/gh_auth_login] 
3. List your token `gh auth token` to see if it is set up correctly.

### Creating a new podcast

1. On [Github](github.com) 
   1. Fork the Repository or sync fork. Make sure you get the branch `local-cron`.
   2. Create `new branch from local-cron` and name it like `podcast_1`. 
2. Go to secrets and create `ANCHOR_EMAIL_1` and `ANCHOR_PASSWORD_1`. 
    > The `_x` naming format are important to match branch to podcast credentials.
3. If first time, on your local machine create a folder and navigate into the folder before proceeding, as this is where all subsequent podcast branches should be placed.
   1. `mkdir podcasts && cd podcasts/`
4. Clone the `podcast_x` repository to a folder in your local machine and navigate into the folder.
    ```bash
      git clone -b <podcast_x> <repository_url> <podcast_x>
    ```
5. Change into the new `podcast_x` directory.


### Setting up the cron job

#### Playlist

1. To setup up a Playlist URL for this branch ( this will be used in all subsequent runs )
    ```bash
      ./scripts/prompt-url.sh
    ```
#### Setup Workflow

1. To update the github action to match Anchor password and email
    ```bash
      ./scripts/update-workflow.sh
    ```
#### Setup Cron

1.  To set the job to run at a specific time and edit that time if needed.
    1.  To cron the job 
        ```bash
          ./scripts/cron-it.sh
        ``` 
    2.  At times, you would want to edit the cronjob, use `crontab -e` and edit it. [Cronguru](https://crontab.guru/) can help you in figuring out the format used in timing a job.

#### Edit Cron Job Timing

1.  To check if the cron job is set, you can list it using
       ```bash
        crontab -l
       ```
2. The action runs every Thursday at 12 pm your machine's local time, the machine needs to be powered on at this hour.

### See Your Actions

1. On Github go to a `podcast branch` and under `Actions` tab of a branch, you can see if the action was executed.

## Manual Method

The manual method is still available from `main` branch and using a `codespace`, same as before. If it is ever needed.

## How is the converted videos data stored ?

For first run the `convertedVideos.json` file should have the following keys. 

```json
{
    "name": "Upload processed data",
    "videoQuantity": 0,
    "lastUpdated": "",
    "videos": []
}
```

- The video information is stored in the key `videos` as array of _video IDs_

## Concern regarding automation of playlists

> **NOTE:** Automation depends on this [npm package](https://www.npmjs.com/package/@fabricio-191/youtube) to fetch playlist related information without use of an API key.

> **Warning:** There might be concerns regarding violation of Github TOS when it comes to uploading of a playlist. [Read more here](https://github.com/Schrodinger-Hat/youtube-to-anchorfm#how-to-upload-a-youtube-playlist-to-anchorfm-using-this-script)

> **Manual Effort:** At times some fields don't get populated on AnchorFM (eg. title being untitled), this is dependent on Github Action and will need manual intervention.

> **Limitation:** Github allows for 2000 min of action usage per month. Once you run out of these get an account or wait for next month.

<!-- ### Processing a playlist

> Using an example [playlist](https://www.youtube.com/watch?v=ABbDB6xri8o&list=PLrAXtmErZgOcl7mvyfkQTHFnOGZxWtN55)

- To process all of them do as recommened [here](https://github.com/Schrodinger-Hat/youtube-to-anchorfm#how-to-upload-a-youtube-playlist-to-anchorfm-using-this-script) 

https://github.com/cli/cli/blob/trunk/docs/install_linux.md

Homebrew seems to be having some problem with their installation script, more like their repositories are having issues.
Or may be it is Github's issue nonetheless curl timesout

Push Issue
https://github.com/community/community/discussions/37103
-->
