# (Local Cron) Automating youtube video to anchor fm audio

[Older codespaces workflow is still available on the main branch](https://github.com/MandarDevarshi/yt-anchor-action/tree/main)

**Table of Content**
- [(Local Cron) Automating youtube video to anchor fm audio](#local-cron-automating-youtube-video-to-anchor-fm-audio)
  - [Prerequisite](#prerequisite)
  - [Setting up automation](#setting-up-automation)
    - [(Once) Set up Github Credentials](#once-set-up-github-credentials)
    - [(Everytime) Creating a new podcast](#everytime-creating-a-new-podcast)
      - [On Github.com](#on-githubcom)
      - [On your local machine](#on-your-local-machine)
    - [Setting up the cron job](#setting-up-the-cron-job)
      - [Playlist](#playlist)
      - [Setup Workflow](#setup-workflow)
      - [Setup Cron](#setup-cron)
      - [Edit Cron Job Timing](#edit-cron-job-timing)
    - [See Your Actions](#see-your-actions)
    - [Rerun failed Actions](#rerun-failed-actions)
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

### (Once) Set up Github Credentials

> If you are not using any `GCM (Git Credential Manager)` which already has `Personal Access Token` to authenticate you with Github, do the following steps. Otherwise, skip.

1. Install [Homebrew](https://brew.sh/)
2. Install [Github CLI](https://github.com/cli/cli#installation)
3. Make `gh` your credential manager  
   ```
      gh auth setup-git
   ```
4. Run the following to setup credentials. For help [gh auth login](https://cli.github.com/manual/gh_auth_login)
   ```bash
      gh auth login
   ``` 
5. (For Mac) Please install `gnu-sed` and create an alias in bash profile.
   - Install `gnu-sed`
    ```
    brew install gnu-sed
    ```
### (Everytime) Creating a new podcast

#### On Github.com

1. On [Github](github.com) 
   1. Create `new branch from local-cron` and name it like `podcast_1`. 
2. Go to secrets and create `ANCHOR_EMAIL_1` and `ANCHOR_PASSWORD_1`. 
    > The `_x` naming format are important to match branch to podcast credentials.

#### On your local machine 

1. Open a terminal
2. If first time, on your local machine create a folder and navigate into the folder before proceeding, as this is where all subsequent podcast branches should be placed.
   1. `mkdir podcasts && cd podcasts/`
3. Clone the `podcast_x` branch to `podcasts/ folder in your local machine` and change into the `podcast_x` folder.
    ```bash
      git clone -b <podcast_x> <repository_url> <podcast_x>
    ```
    eg.
    replace `<podcast_x>` with your new podcast branch eg. podcast_2 <br/>
    replace `<repository_url>` with your repository url eg. https://github.com/username/repo.git
    
    ```bash
    git clone -b podcast_2 https://github.com/username/repo.git podcast_2
    ```
4. Change into the new `podcast_x` directory.

### Setting up the cron job

#### Playlist

1. To attach a Playlist URL to this branch ( this will be used in all subsequent runs )
    ```bash
      ./scripts/prompt-url.sh
    ```
#### Setup Workflow

1. To update the github action to match Anchor password and email. ( On Mac, make sure that gnu-sed is installed and aliased )
    ```bash
      ./scripts/update-workflow.sh
    ```
#### Setup Cron

1.  To set the job to run at a specific time.
    1.  To cron the job 
        ```bash
          ./scripts/cron-it.sh
        ``` 
    2. The job runs every Thursday at 12 pm your machine's local time, the machine needs to be powered on at this hour. To change the timings see next section.

#### Edit Cron Job Timing

1. At times, you would want to edit the cronjob, use `crontab -e` and edit it. [Cronguru](https://crontab.guru/) can help you in figuring out the format used in timing a job.

2. To check if the cron job is set, you can list it using
    ```bash
     crontab -l
    ```

### See Your Actions

1. On [Github](https://github.com) go to a `podcast branch` and under `Actions` tab you check status of your workflows.

### Rerun failed Actions

1. On your local machine using terminal, navigate into a branch, eg. podcast_1
2. Run the following command
  ```
  ./scripts/rerun-failed.sh
  ```
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
