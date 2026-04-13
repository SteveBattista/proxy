#!/usr/bin/env sh
set -eu

site_name="${SITE_NAME:-example.local}"
site_type="${SITE_TYPE:-generic}"
out_file="/usr/share/nginx/html/index.html"

escape_sed_replacement() {
  printf '%s' "$1" | sed 's/[&|\\]/\\&/g'
}

write_template() {
  escaped_site_name="$(escape_sed_replacement "$site_name")"
  sed "s|__SITE_NAME__|$escaped_site_name|g" > "$out_file"
}

case "$site_type" in
  shopping)
    write_template <<'EOF'
<!doctype html>
<html>
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>__SITE_NAME__</title>
  <style>
    :root { --bg:#fff8f1; --accent:#d9480f; --card:#ffffff; --text:#2b2b2b; }
    body { font-family: "Trebuchet MS", sans-serif; background: radial-gradient(circle at top,#ffe8cc,var(--bg)); color: var(--text); margin: 0; }
    .wrap { max-width: 960px; margin: 32px auto; padding: 0 16px; }
    .grid { display:grid; grid-template-columns: repeat(auto-fit,minmax(180px,1fr)); gap:16px; }
    .card { background:var(--card); border-radius:12px; padding:14px; box-shadow:0 8px 18px rgba(0,0,0,.08); }
    .price { color:var(--accent); font-weight:700; }
  </style>
</head>
<body>
  <div class="wrap">
    <h1>__SITE_NAME__</h1>
    <p>Spring Sale picks and trending products.</p>
    <div class="grid">
      <div class="card"><h3>Wireless Headphones</h3><p class="price">$79</p></div>
      <div class="card"><h3>Fitness Watch</h3><p class="price">$119</p></div>
      <div class="card"><h3>Smart Lamp</h3><p class="price">$39</p></div>
      <div class="card"><h3>Travel Backpack</h3><p class="price">$54</p></div>
    </div>
    <p>Trusted certs loaded from ./certs</p>
  </div>
</body>
</html>
EOF
    ;;
  social)
    write_template <<'EOF'
<!doctype html>
<html>
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>__SITE_NAME__</title>
  <style>
    :root { --bg:#eef6ff; --accent:#0b7285; --card:#ffffff; --text:#1f2a37; }
    body { font-family: "Verdana", sans-serif; background: linear-gradient(180deg,#dbeafe,var(--bg)); color:var(--text); margin:0; }
    .wrap { max-width: 820px; margin: 24px auto; padding: 0 14px; }
    .post { background:var(--card); border-left:4px solid var(--accent); padding:14px; border-radius:8px; margin-bottom:12px; }
    .meta { color:#4b5563; font-size:.9rem; }
  </style>
</head>
<body>
  <div class="wrap">
    <h1>__SITE_NAME__</h1>
    <div class="post"><strong>@sam</strong><p>Launching our new community meetup this weekend.</p><div class="meta">14 likes • 3 comments</div></div>
    <div class="post"><strong>@dina</strong><p>Photo walk recap: downtown murals and coffee spots.</p><div class="meta">29 likes • 8 comments</div></div>
    <div class="post"><strong>@leo</strong><p>Who is joining the live coding stream tonight?</p><div class="meta">9 likes • 2 comments</div></div>
    <p>Trusted certs loaded from ./certs</p>
  </div>
</body>
</html>
EOF
    ;;
  news)
    write_template <<'EOF'
<!doctype html>
<html>
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>__SITE_NAME__</title>
  <style>
    :root { --bg:#f8f9fa; --accent:#1d3557; --text:#212529; --card:#ffffff; }
    body { font-family: Georgia, serif; background: var(--bg); color: var(--text); margin: 0; }
    .wrap { max-width: 900px; margin: 28px auto; padding: 0 16px; }
    .headline { font-size: 2rem; color: var(--accent); margin: 10px 0; }
    .story { background: var(--card); padding: 12px 14px; border-radius: 8px; margin: 10px 0; border: 1px solid #dee2e6; }
  </style>
</head>
<body>
  <div class="wrap">
    <h1>__SITE_NAME__</h1>
    <div class="headline">City Council Approves Transit Expansion Plan</div>
    <div class="story"><strong>World:</strong> Leaders meet for climate policy summit.</div>
    <div class="story"><strong>Tech:</strong> Open-source tools gain momentum in enterprise.</div>
    <div class="story"><strong>Sports:</strong> Local club advances after dramatic finish.</div>
    <p>Trusted certs loaded from ./certs</p>
  </div>
</body>
</html>
EOF
    ;;
  email)
    write_template <<'EOF'
<!doctype html>
<html>
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>__SITE_NAME__</title>
  <style>
    :root { --bg:#f3f7ff; --panel:#ffffff; --accent:#364fc7; --text:#20262e; }
    body { font-family: "Tahoma", sans-serif; background: var(--bg); color: var(--text); margin: 0; }
    .app { display:grid; grid-template-columns: 220px 1fr; min-height: 100vh; }
    .sidebar { background:#e9edff; padding:16px; }
    .mail { padding:16px; }
    .item { background:var(--panel); border-radius:8px; padding:10px 12px; margin-bottom:10px; border-left:4px solid var(--accent); }
  </style>
</head>
<body>
  <div class="app">
    <aside class="sidebar"><h2>__SITE_NAME__</h2><p>Inbox</p><p>Sent</p><p>Drafts</p></aside>
    <main class="mail">
      <div class="item"><strong>Welcome</strong><p>Your account is ready to use.</p></div>
      <div class="item"><strong>Team Update</strong><p>Project milestone reached this morning.</p></div>
      <div class="item"><strong>Invoice</strong><p>Your monthly statement is available.</p></div>
      <p>Trusted certs loaded from ./certs</p>
    </main>
  </div>
</body>
</html>
EOF
    ;;
  forum)
    write_template <<'EOF'
<!doctype html>
<html>
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>__SITE_NAME__</title>
  <style>
    :root { --bg:#f5f3ff; --card:#ffffff; --accent:#5f3dc4; --muted:#6b7280; --text:#1f1f2e; }
    body { margin:0; font-family:"Segoe UI", sans-serif; background:linear-gradient(180deg,#ede9fe,var(--bg)); color:var(--text); }
    .wrap { max-width: 900px; margin: 28px auto; padding: 0 14px; }
    .thread { background:var(--card); border-radius:10px; padding:12px 14px; margin-bottom:12px; box-shadow:0 6px 14px rgba(0,0,0,.06); }
    .tag { display:inline-block; font-size:.75rem; background:#e5dbff; color:var(--accent); border-radius:999px; padding:2px 8px; margin-right:8px; }
    .meta { color:var(--muted); font-size:.9rem; }
  </style>
</head>
<body>
  <div class="wrap">
    <h1>__SITE_NAME__</h1>
    <div class="thread"><span class="tag">Announcements</span><strong>Welcome to the community forum</strong><p class="meta">Posted by admin • 12 replies</p></div>
    <div class="thread"><span class="tag">Support</span><strong>How do I configure SSL certificates?</strong><p class="meta">Posted by alex • 6 replies</p></div>
    <div class="thread"><span class="tag">General</span><strong>Show us your latest project setup</strong><p class="meta">Posted by maya • 21 replies</p></div>
    <p>Trusted certs loaded from ./certs</p>
  </div>
</body>
</html>
EOF
    ;;
  *)
    write_template <<'EOF'
<!doctype html>
<html>
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>__SITE_NAME__</title>
  <style>
    body { font-family: Arial, sans-serif; margin: 30px; background: #f8f9fa; }
    .card { max-width: 680px; background: #fff; padding: 18px; border-radius: 10px; box-shadow: 0 8px 18px rgba(0,0,0,.08); }
  </style>
</head>
<body>
  <div class="card">
    <h1>__SITE_NAME__</h1>
    <p>Generic placeholder page.</p>
    <p>Trusted certs loaded from ./certs</p>
  </div>
</body>
</html>
EOF
    ;;
esac
