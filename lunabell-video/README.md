## Lunabell Viral Demo

High-energy marketing reel for the Lunabell sunglasses launch. The project contains:

- A rendered 1080p/30fps MP4 (`public/video/lunabell-demo.mp4`) with upbeat audio, cinematic zooms, neon overlays, and the required Persian slogans.
- A polished Next.js 14 site that embeds the video with mute toggling, download CTA, and shot-by-shot breakdown.
- An automated FFmpeg pipeline (`scripts/render_video.sh`) to rebuild the video from the source stills and soundtrack whenever creative tweaks are needed.

### Prerequisites

- Node.js 18+
- FFmpeg (installed automatically on Debian-based environments via `sudo apt-get install ffmpeg`).  
  The render script assumes the `ffmpeg` binary is available on the `$PATH`.

### Installation

```bash
npm install
```

### Regenerate the video asset

If you adjust the still images, copy tweaks, or soundtrack, re-render the master file with:

```bash
npm run render:video
```

The command rebuilds intermediate shots, stitches transitions, then muxes in the audio to produce `public/video/lunabell-demo.mp4`.

### Local development

```bash
npm run dev
```

Visit [http://localhost:3000](http://localhost:3000) to preview the site and video.

### Production build

```bash
npm run build
npm run start
```

### Asset credits

- Photography sourced from Unsplash (urban fashion, beach energy, macro sunglasses, flatlays, squad runway).
- Temporary music cue provided by Samplelib (`sample-15s.mp3`). Replace with licensed track before publishing if required.

### Deployment

The project is optimized for Vercel. Use:

```bash
vercel deploy --prod --yes --token $VERCEL_TOKEN --name agentic-d53a8687
```

After deployment propagates, verify the live build:

```bash
curl https://agentic-d53a8687.vercel.app
```

###
