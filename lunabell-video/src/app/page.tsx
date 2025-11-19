'use client';

import { useEffect, useRef, useState } from "react";

const shots = [
  {
    time: "0 — 3s",
    title: "Urban redemption",
    description: "Quick zoom-in as the question hits: «خیانت کردی به استایل؟»",
  },
  {
    time: "3 — 6s",
    title: "Beach flex",
    description: "Vibrant overlay flashes “Luxury or nothing.” in bold amber tones.",
  },
  {
    time: "6 — 9s",
    title: "Chrome pulse",
    description: "Rotating macro of mirrored lenses with neon reflections.",
  },
  {
    time: "9 — 12s",
    title: "Product armour",
    description: "Soft-glow blend shows texture, specs, and the “Crafted for chaos.” badge.",
  },
  {
    time: "12 — 15s",
    title: "Crown moment",
    description: "Slogan lock-up: «Lunabell – چشمای تو، غرور تو.»",
  },
];

const features = [
  "Upbeat 15s cut engineered for TikTok/Reels virality.",
  "Persian meme-ready overlays built straight into the edit.",
  "Lifestyle + product montage with whip transitions and glint effects.",
  "Mastered audio beat-matched to every transition.",
  "Delivered as 1080p MP4 and embedded for instant review.",
];

export default function Home() {
  const videoRef = useRef<HTMLVideoElement | null>(null);
  const [isMuted, setIsMuted] = useState(true);
  const [isPlaying, setIsPlaying] = useState(false);

  useEffect(() => {
    const video = videoRef.current;
    if (!video) return;

    const playPromise = video.play();
    if (playPromise !== undefined) {
      playPromise.then(() => setIsPlaying(true)).catch(() => {
        // Browser blocked autoplay with sound; keep muted prompt visible.
      });
    }

    const handlePlay = () => setIsPlaying(true);
    const handlePause = () => setIsPlaying(false);

    video.addEventListener("play", handlePlay);
    video.addEventListener("pause", handlePause);

    return () => {
      video.removeEventListener("play", handlePlay);
      video.removeEventListener("pause", handlePause);
    };
  }, []);

  const toggleMute = () => {
    const video = videoRef.current;
    if (!video) return;
    video.muted = !video.muted;
    setIsMuted(video.muted);
    if (video.paused) {
      void video.play();
    }
  };

  return (
    <div className="min-h-screen bg-gradient-to-br from-zinc-950 via-slate-900 to-purple-900 text-white">
      <div className="mx-auto flex min-h-screen max-w-6xl flex-col gap-12 px-6 py-12 md:gap-16 md:px-10 md:py-16">
        <header className="flex flex-col gap-6 md:flex-row md:items-end md:justify-between">
          <div>
            <p className="text-sm uppercase tracking-[0.4em] text-zinc-400">
              Viral Launch Preview
            </p>
            <h1 className="mt-3 text-4xl font-semibold sm:text-5xl">
              Lunabell — Viral Demo Drop
            </h1>
            <p className="mt-4 max-w-xl text-lg text-zinc-200">
              Fast-cuts, chrome reflections, and punchline overlays crafted to
              dominate the algorithm. Tap in and feel the hype.
            </p>
          </div>
          <div className="flex flex-wrap gap-2 text-sm">
            <span className="rounded-full border border-white/20 px-4 py-1 text-white/80">
              1080p .mp4
            </span>
            <span className="rounded-full border border-white/20 px-4 py-1 text-white/80">
              15s runtime
            </span>
            <span className="rounded-full border border-white/20 px-4 py-1 text-white/80">
              Music-driven
            </span>
          </div>
        </header>

        <section className="relative overflow-hidden rounded-3xl border border-white/10 bg-black/40 shadow-[0_25px_70px_-20px_rgba(59,36,88,0.75)]">
          <div className="absolute inset-0 -z-10 bg-[radial-gradient(circle_at_top,_rgba(255,255,255,0.22),_rgba(8,6,20,0))]" />
          <video
            ref={videoRef}
            className="aspect-video w-full object-cover"
            src="/video/lunabell-demo.mp4"
            poster="/images/sunglasses-flatlay.jpg"
            playsInline
            loop
            muted={isMuted}
            preload="auto"
          />
          <div className="pointer-events-none absolute inset-0 bg-gradient-to-t from-black/40 via-transparent to-black/30" />

          <div className="absolute bottom-6 left-6 right-6 flex flex-col gap-4 md:flex-row md:items-center md:justify-between">
            <div className="pointer-events-auto flex flex-wrap gap-3">
              <button
                onClick={toggleMute}
                className="flex items-center gap-2 rounded-full border border-white/30 bg-white/10 px-5 py-2 text-sm font-medium text-white backdrop-blur transition hover:bg-white/20"
              >
                <span
                  className="inline-block h-2 w-2 rounded-full"
                  style={{
                    background: isMuted ? "#f97316" : "#22c55e",
                    boxShadow: isMuted
                      ? "0 0 12px rgba(249, 115, 22, 0.7)"
                      : "0 0 12px rgba(34, 197, 94, 0.6)",
                  }}
                />
                {isMuted ? "Unmute for full impact" : "Sound on — ride the beat"}
              </button>
              <a
                href="/video/lunabell-demo.mp4"
                download
                className="pointer-events-auto rounded-full border border-white/30 bg-white/10 px-5 py-2 text-sm font-medium text-white backdrop-blur transition hover:bg-white/20"
              >
                Download master
              </a>
            </div>
            <div className="pointer-events-auto">
              <span className="rounded-full bg-white/10 px-4 py-2 text-xs uppercase tracking-[0.3em] text-white/70">
                {isPlaying ? "Streaming preview" : "Paused"}
              </span>
            </div>
          </div>
        </section>

        <section className="grid gap-8 md:grid-cols-[1.3fr_1fr] md:gap-12">
          <div className="space-y-6 rounded-3xl border border-white/10 bg-white/5 p-8 backdrop-blur">
            <h2 className="text-xl font-semibold uppercase tracking-[0.3em] text-zinc-200">
              Beat-by-beat breakdown
            </h2>
            <div className="space-y-5">
              {shots.map((shot) => (
                <article
                  key={shot.time}
                  className="group rounded-2xl border border-white/5 bg-black/20 px-6 py-4 transition hover:border-purple-500/60 hover:bg-black/30"
                >
                  <p className="text-xs font-semibold uppercase tracking-[0.4em] text-purple-300">
                    {shot.time}
                  </p>
                  <h3 className="mt-2 text-lg font-medium text-white">
                    {shot.title}
                  </h3>
                  <p className="mt-1 text-sm text-zinc-300">{shot.description}</p>
                </article>
              ))}
            </div>
          </div>
          <aside className="space-y-6 rounded-3xl border border-purple-500/10 bg-gradient-to-br from-purple-900/50 via-slate-900/40 to-zinc-900/60 p-8 backdrop-blur">
            <h2 className="text-xl font-semibold uppercase tracking-[0.3em] text-purple-200">
              Why it bangs
            </h2>
            <ul className="space-y-4 text-sm text-zinc-200">
              {features.map((feature) => (
                <li
                  key={feature}
                  className="flex items-start gap-3 leading-relaxed"
                >
                  <span className="mt-1 inline-block h-2 w-2 flex-shrink-0 rounded-full bg-gradient-to-br from-purple-400 to-amber-400 shadow-[0_0_12px_rgba(192,132,252,0.7)]" />
                  {feature}
                </li>
              ))}
            </ul>
            <div className="rounded-2xl border border-white/10 bg-black/30 p-4 text-xs text-zinc-300">
              <p className="font-semibold text-white/80">Usage notes</p>
              <p className="mt-2">
                Optimized for autoplay with subtitles baked in. Ideal for launch
                teasers, paid ads, and hype reels across TikTok, Instagram, and
                YouTube Shorts.
              </p>
            </div>
          </aside>
        </section>

        <footer className="pb-4 text-xs uppercase tracking-[0.4em] text-zinc-500">
          Lunabell — چشمای تو، غرور تو.
        </footer>
      </div>
    </div>
  );
}

