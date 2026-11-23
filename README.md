# OnyxScale

Your **Tailscale** network inside your browser, and nowhere else.
For **Firefox**, **Chrome**, **Edge** and **Brave** on Windows, macOS and Linux.

Each browser profile becomes its own device on your tailnet. Your computer's
network, DNS and other apps are untouched: no VPN adapter, no system-wide
routing, no admin rights.

## Install

### 1. The helper (once per computer)

Download the helper for your computer from [Releases](../../releases/latest):

| System | File |
| --- | --- |
| Windows | `onyxscale-windows-amd64.exe` (ARM: `onyxscale-windows-arm64.exe`) |
| macOS | `onyxscale-macos-arm64` (Intel: `onyxscale-macos-amd64`) |
| Linux | `onyxscale-linux-amd64` (ARM: `onyxscale-linux-arm64`) |

**Windows:** double-click it. A small window says which browsers it set up.
If SmartScreen warns, choose **More info → Run anyway**. You can delete the
download afterwards; it keeps a copy in `%LOCALAPPDATA%\OnyxScale`.

**macOS / Linux:**

```sh
chmod +x onyxscale-* && ./onyxscale-*
```

There is no installer and nothing to uninstall from Settings. It registers
itself with your browsers for your user account only.

### 2. The browser extension

**Firefox:** open [Releases](../../releases/latest) in Firefox and click
`onyxscale-firefox.xpi`, then **Add**. It is signed by Mozilla and updates
itself. When you first open it, click **Allow** so it can route your tailnet's
addresses.

**Chrome, Edge, Brave:** download `onyxscale-chrome.zip` and unzip it
somewhere it can stay. Open `chrome://extensions` (or `edge://extensions`),
turn on **Developer mode**, click **Load unpacked** and pick the unzipped folder.

### 3. Sign in

Click the OnyxScale icon in the toolbar and choose **Sign in to Tailscale**, or
use an auth key from the admin console. The browser shows up in your tailnet
as its own device.

## What it does

* **Tailnet in the browser:** open your devices by name (MagicDNS), IP, split
  DNS domains and subnet routes, from this browser only.
* **Exit nodes for the browser only:** pick an exit node and just this
  browser's traffic uses it. If the exit node drops, browsing **pauses instead
  of leaking your real IP**.
* **Split tunnelling by site:** list sites that skip the exit node, or that are
  the only ones to use it.
* **Devices at a glance:** search, open, copy an IP or ping any device.
* **Auto-connect** when the browser starts, **Shields up**, auth-key sign-in.

## Uninstall

Remove the extension from your browser, then run the helper once more with
`uninstall`:

```sh
%LOCALAPPDATA%\OnyxScale\onyxscale.exe uninstall      # Windows
~/.local/share/onyxscale/onyxscale uninstall          # Linux
"~/Library/Application Support/OnyxScale/onyxscale" uninstall   # macOS
```

## Troubleshooting

**"A firewall or security program is blocking the OnyxScale helper"**: allow
the path shown in that message (on Windows,
`%LOCALAPPDATA%\OnyxScale\onyxscale.exe`) in your firewall or security
software, then click Retry.

## What's new

### 0.1.0

First release.

## License

Copyright 2026 NA Research. Licensed under the Apache License 2.0.
Includes code adapted from Tailchrome (MIT) and links Tailscale (BSD-3-Clause);
see [THIRD_PARTY_NOTICES.md](THIRD_PARTY_NOTICES.md).
