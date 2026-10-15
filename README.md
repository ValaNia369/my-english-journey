# My English Journey — installation guide

A mobile-first English-only PWA. Includes sentence flip cards, vocabulary, patterns, idioms, songs, daily session imports, search, FSRS-4.5 review scheduling, JSON backup/restore, and optional Supabase sync.

## Try on your computer

1. Unzip the folder.
2. Open a terminal in the folder.
3. Run `python -m http.server 8000` (or `python3 -m http.server 8000`).
4. Visit `http://localhost:8000` in your browser.
5. On **Home**, import `sample-sol-export.json` to see the workflow.

Do not open `index.html` directly as a `file://` file: installation and service workers need an HTTP(S) origin.

## Install on your phone and computer

You need to host the folder at an HTTPS address to install it on your phone. One free method:

1. Create a GitHub repository with these app files at the top level.
2. Open repository **Settings → Pages**. Select **Deploy from a branch**, branch **main**, folder **/(root)**. Save.
3. Open the HTTPS Pages URL on your phone.
4. **Android / Chrome:** menu → **Add to Home screen** or **Install app**.
5. **iPhone / Safari:** Share → **Add to Home Screen**.
6. **Desktop Chrome / Edge:** use the install icon in the address bar (or browser menu → Install).

GitHub Pages is public hosting. The application source code is public, but your library is stored in the browser or the private Supabase table, not in the repository. Do not upload backups, login details or private learning data to the repository.

## Daily use

1. Add the text in `SOL_PROJECT_INSTRUCTIONS.md` to your Sol project's instructions.
2. Chat normally with Sol. Ask: `Sol, export this session.`
3. Copy its JSON output (or save it as `.json`).
4. In the app open **Home → Daily import**. Paste JSON or select its file, preview, then save.
5. Open **Sentences** to flip, **Vocabulary** to highlight words and attach small pictures/audio, and **Review** for FSRS spaced repetition.
6. Make a backup in **Settings → Create Backup** after important changes.

The daily export covers one accessible chat, not all chats from one date. Repeat for separate chats.

## Enable free optional sync (Supabase)

You only need to do this once. It is **not** a ChatGPT-account connection. You need a separate Supabase account.

1. Create a Supabase project on its free plan at https://supabase.com .
2. Open its **SQL Editor** and run `supabase-setup.sql`.
3. Copy the **Project URL** and **publishable key** (or legacy `anon` key) from your project's API settings. **Never use the service_role or secret key.**
4. In the app go to **Settings → Cloud sync**. Enter the project URL, key, email and password. Choose **Sign Up**, confirm your email if required, then **Sign In**.
5. On the second device, open the same hosted app, enter the same URL/key and **Sign In** with the same email/password, then use **Sync Now**.
6. Save changes normally. The app syncs shortly after saving while online, and retrieves newer cloud data on start. Press **Sync Now** to refresh manually.

**Sync limitation:** This MVP uses a single user state record and last-write-wins. Do not edit on both devices while offline or before changes finish syncing; this can overwrite newer work. Make a JSON backup regularly. Large media files can exceed browser storage and free cloud limits. The app limits each attached media file to 2 MB. Cloud sync is optional: the app works locally without it. When opening the app on a new device, sign in before importing new data to avoid conflicts.

## Backup

**Settings → Create Backup** downloads a JSON file containing your data, review history, and small embedded media. **Restore Backup** replaces local data with the chosen backup. Store the backup separately from the device (for example in your personal cloud drive). The app can remind you every 3, 7, 14, or 30 days *when you open it*. It does not autonomously save backups while closed.

## FSRS

Uses an offline implementation of FSRS-4.5 with its default parameters and target retention (85%, 90% or 95%). Review grades: Again, Hard, Good, Easy. This is not trained on your personal review history; scheduling uses default model parameters. The review interface schedules sentences, vocabulary, patterns and idioms. Song progress is tracked separately with statuses.

## Limitations

- This is a functioning MVP, not an App Store binary or hosted deployment.
- No paid API is needed, and it does not directly read your ChatGPT account.
- Browser localStorage has a device-specific size limit; keep attached media small, and save backups.
- Song audio is not uploaded automatically; you can attach a small audio file (max 2 MB) or store song title and notes instead. Full music files generally exceed this limit.
- Automated recognition of unknown words from arbitrary chat text is not offered: Sol must export the structured JSON.
- Audio playback depends on attached media or browser/device features; speech scoring is not included.
- This version does not support simultaneous conflict-free editing across multiple offline devices.
