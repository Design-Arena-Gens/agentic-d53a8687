#!/bin/bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"
TEMP_DIR="$ROOT_DIR/.render-cache"
OUT_DIR="$ROOT_DIR/public/video"
IMAGE_DIR="$ROOT_DIR/public/images"
AUDIO_FILE="$ROOT_DIR/public/audio/upbeat.mp3"
FONT_FILE="/usr/share/fonts/truetype/dejavu/DejaVuSans-Bold.ttf"

if [ ! -f "$FONT_FILE" ]; then
  echo "Font file not found at $FONT_FILE" >&2
  exit 1
fi

if [ ! -f "$AUDIO_FILE" ]; then
  echo "Audio file not found at $AUDIO_FILE" >&2
  exit 1
fi

rm -rf "$TEMP_DIR"
mkdir -p "$TEMP_DIR"
mkdir -p "$OUT_DIR"

cat <<'EOF' > "$TEMP_DIR/text1.txt"
خیانت کردی به استایل؟
EOF

cat <<'EOF' > "$TEMP_DIR/text1b.txt"
Slide back in with Lunabell.
EOF

cat <<'EOF' > "$TEMP_DIR/text2.txt"
Luxury or nothing.
EOF

cat <<'EOF' > "$TEMP_DIR/text2b.txt"
Beach heat. Midnight edge.
EOF

cat <<'EOF' > "$TEMP_DIR/text3.txt"
Chrome pulse engaged.
EOF

cat <<'EOF' > "$TEMP_DIR/text3b.txt"
Reflections on repeat.
EOF

cat <<'EOF' > "$TEMP_DIR/text4.txt"
Crafted for chaos.
EOF

cat <<'EOF' > "$TEMP_DIR/text4b.txt"
Featherlight. Shockproof. Limitless.
EOF

cat <<'EOF' > "$TEMP_DIR/text5.txt"
Lunabell – چشمای تو، غرور تو.
EOF

cat <<'EOF' > "$TEMP_DIR/text5b.txt"
Tap to claim your crown.
EOF

COMMON_SCALE="scale=2300:-1"
FPS=30

ffmpeg -y -loop 1 -i "$IMAGE_DIR/urban-model.jpg" \
  -filter_complex "\
    [0:v]$COMMON_SCALE,zoompan=z='min(zoom+0.0014,1.22)':d=$(($FPS*3)):s=1920x1080:fps=$FPS,eq=saturation=1.35:contrast=1.08,format=rgba[base]; \
    [base]drawtext=fontfile='$FONT_FILE':textfile='$TEMP_DIR/text1.txt':fontcolor=0xFFFFFFFF:fontsize=110:x=(w-text_w)/2:y=0.65*h:shadowcolor=0x000000DD:shadowx=0:shadowy=12:enable='between(t,0.15,3.0)'[txt1]; \
    [txt1]drawtext=fontfile='$FONT_FILE':textfile='$TEMP_DIR/text1b.txt':fontcolor=0xFFFFFFFF:fontsize=46:x=(w-text_w)/2:y=0.82*h:shadowcolor=0x000000AA:shadowx=0:shadowy=8:enable='between(t,1.1,3.0)'[txt2]; \
    [txt2]drawbox=x=(iw/2)-(0.18*iw*(1.0-(t/3))):y=0.58*ih:w=0.36*iw:h=6:color=0xFFFFFFFF@0.7:t=fill:enable='between(t,0.2,0.45)' \
  " \
  -t 3 -r $FPS -c:v libx264 -pix_fmt yuv420p "$TEMP_DIR/shot1.mp4" >/dev/null 2>&1

ffmpeg -y -loop 1 -i "$IMAGE_DIR/beach-couple.jpg" \
  -filter_complex "\
    [0:v]$COMMON_SCALE,zoompan=z='1.06-0.0012*on':d=$(($FPS*3)):s=1920x1080:fps=$FPS,eq=saturation=1.45:contrast=1.05,format=rgba[base]; \
    [base]drawbox=x=0:y=0:w=iw:h=ih:color=0x101020@0.35:t=fill:enable='between(t,0.0,3.0)'[layer]; \
    [layer]drawtext=fontfile='$FONT_FILE':textfile='$TEMP_DIR/text2.txt':fontcolor=0xFFFFFFFF:fontsize=104:x=0.08*w:y=0.14*h:shadowcolor=0x000000AA:shadowx=0:shadowy=10:enable='between(t,0.1,3.0)'[txt1]; \
    [txt1]drawtext=fontfile='$FONT_FILE':textfile='$TEMP_DIR/text2b.txt':fontcolor=0xFFEBA2FF:fontsize=52:x=0.08*w:y=0.28*h:shadowcolor=0x00000099:shadowx=0:shadowy=6:enable='between(t,1.0,3.0)' \
  " \
  -t 3 -r $FPS -c:v libx264 -pix_fmt yuv420p "$TEMP_DIR/shot2.mp4" >/dev/null 2>&1

ffmpeg -y -loop 1 -i "$IMAGE_DIR/sunglasses-closeup.jpg" \
  -filter_complex "\
    [0:v]scale=2100:-1,zoompan=z='min(1.05+0.0015*on,1.2)':d=$(($FPS*3)):s=1920x1080:fps=$FPS,format=rgba[zoom]; \
    [zoom]rotate=0.05*sin(2*PI*t/1.5):fillcolor=0x05050AFF[rot]; \
    [rot]drawbox=x=0:y=0:w=iw:h=ih:color=0x060606@0.6:t=fill:enable='between(t,0.0,3.0)'[dark]; \
    [dark]drawtext=fontfile='$FONT_FILE':textfile='$TEMP_DIR/text3.txt':fontcolor=0xFFFFFFFF:fontsize=88:x=(w-text_w)/2:y=0.18*h:shadowcolor=0x000000CC:shadowx=0:shadowy=9:enable='between(t,0.2,3.0)'[txt1]; \
    [txt1]drawtext=fontfile='$FONT_FILE':textfile='$TEMP_DIR/text3b.txt':fontcolor=0x3FD7FFFF:fontsize=48:x=(w-text_w)/2:y=0.32*h:shadowcolor=0x000000AA:shadowx=0:shadowy=6:enable='between(t,0.9,3.0)'[txt2]; \
    [txt2]drawbox=x=(iw/2)-2:y=ih-160:w=4:h=120:color=0x3FD7FFFF:t=fill:enable='between(t,0.6,3.0)' \
  " \
  -t 3 -r $FPS -c:v libx264 -pix_fmt yuv420p "$TEMP_DIR/shot3.mp4" >/dev/null 2>&1

ffmpeg -y -loop 1 -i "$IMAGE_DIR/sunglasses-flatlay.jpg" \
  -filter_complex "\
    [0:v]scale=2300:-1,zoompan=z='min(zoom+0.001,1.16)':d=$(($FPS*3)):s=1920x1080:fps=$FPS,eq=saturation=1.6:contrast=1.1,format=rgba[base]; \
    [base]split=2[a][b]; \
    [a]gblur=sigma=20[glow]; \
    [b][glow]blend=all_mode='screen':all_opacity=0.35[glimmer]; \
    [glimmer]drawbox=x=0:y=0:w=iw:h=ih:color=0x111111@0.33:t=fill[dim]; \
    [dim]drawtext=fontfile='$FONT_FILE':textfile='$TEMP_DIR/text4.txt':fontcolor=0xFFFFFFFF:fontsize=92:x=0.08*w:y=0.68*h:shadowcolor=0x000000BB:shadowx=0:shadowy=10:enable='between(t,0.15,3.0)'[txt1]; \
    [txt1]drawtext=fontfile='$FONT_FILE':textfile='$TEMP_DIR/text4b.txt':fontcolor=0xFFC86BFF:fontsize=44:x=0.08*w:y=0.82*h:shadowcolor=0x00000088:shadowx=0:shadowy=5:enable='between(t,0.8,3.0)' \
  " \
  -t 3 -r $FPS -c:v libx264 -pix_fmt yuv420p "$TEMP_DIR/shot4.mp4" >/dev/null 2>&1

ffmpeg -y -loop 1 -i "$IMAGE_DIR/runway-squad.jpg" \
  -filter_complex "\
    [0:v]scale=2300:-1,zoompan=z='min(zoom+0.0008,1.1)':d=$(($FPS*43/10)):s=1920x1080:fps=$FPS,eq=saturation=1.3:contrast=1.05,format=rgba[base]; \
    [base]drawbox=x=0:y=0:w=iw:h=ih:color=0x050505@0.6:t=fill:enable='between(t,0.0,4.3)'[dim]; \
    [dim]drawbox=x=(iw/2)-(iw*0.32):y=(ih/2)-(ih*0.18):w=iw*0.64:h=ih*0.36:color=0x101010@0.65:t=fill:enable='between(t,0.4,4.3)'[panel]; \
    [panel]drawtext=fontfile='$FONT_FILE':textfile='$TEMP_DIR/text5.txt':fontcolor=0xFFFFFFFF:fontsize=108:x=(w-text_w)/2:y=(h-text_h)/2 - 40:shadowcolor=0x000000CC:shadowx=0:shadowy=10:enable='between(t,0.4,4.3)'[txt1]; \
    [txt1]drawtext=fontfile='$FONT_FILE':textfile='$TEMP_DIR/text5b.txt':fontcolor=0xFFD16AFF:fontsize=50:x=(w-text_w)/2:y=(h-text_h)/2 + 80:shadowcolor=0x000000AA:shadowx=0:shadowy=6:enable='between(t,1.3,4.3)' \
  " \
  -t 4.3 -r $FPS -c:v libx264 -pix_fmt yuv420p "$TEMP_DIR/shot5.mp4" >/dev/null 2>&1

ffmpeg -y \
  -i "$TEMP_DIR/shot1.mp4" \
  -i "$TEMP_DIR/shot2.mp4" \
  -i "$TEMP_DIR/shot3.mp4" \
  -i "$TEMP_DIR/shot4.mp4" \
  -i "$TEMP_DIR/shot5.mp4" \
  -filter_complex "\
    [0:v][1:v]xfade=transition=fadeblack:duration=0.32:offset=2.68[v01]; \
    [v01][2:v]xfade=transition=smoothleft:duration=0.32:offset=5.36[v02]; \
    [v02][3:v]xfade=transition=smoothright:duration=0.32:offset=8.04[v03]; \
    [v03][4:v]xfade=transition=fadewhite:duration=0.32:offset=10.72[video] \
  " \
  -map "[video]" \
  -c:v libx264 -pix_fmt yuv420p -r $FPS "$TEMP_DIR/video_no_audio.mp4" >/dev/null 2>&1

ffmpeg -y -i "$TEMP_DIR/video_no_audio.mp4" -i "$AUDIO_FILE" \
  -c:v copy -c:a aac -b:a 192k \
  -shortest "$OUT_DIR/lunabell-demo.mp4" >/dev/null 2>&1

echo "Video created at $OUT_DIR/lunabell-demo.mp4"
