Return-Path: <SRS0=Xzqw=5F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8389C4332B
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 20:43:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16A7420724
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 20:43:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=tuta.io header.i=@tuta.io header.b="g9mjLizH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727261AbgCTUnF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Mar 2020 16:43:05 -0400
Received: from w1.tutanota.de ([81.3.6.162]:44468 "EHLO w1.tutanota.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726855AbgCTUnF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Mar 2020 16:43:05 -0400
Received: from w3.tutanota.de (unknown [192.168.1.164])
        by w1.tutanota.de (Postfix) with ESMTP id 9C521FBF53C
        for <linux-kernel@vger.kernel.org>; Fri, 20 Mar 2020 20:43:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1584736981;
        s=s1; d=tuta.io;
        h=From:From:To:To:Subject:Subject:Content-Description:Content-ID:Content-Type:Content-Type:Content-Transfer-Encoding:Content-Transfer-Encoding:Cc:Date:Date:In-Reply-To:MIME-Version:MIME-Version:Message-ID:Message-ID:Reply-To:References:Sender;
        bh=/Ex8eIlhG4wONznFScMTVgv1C+Wn2zkeSK27MtqjOGo=;
        b=g9mjLizHjN3fcPuu9UQlAF72P/D9igm9XhXQq7YVrgULKUEy1w10JQMmjh7c6mKy
        vezYgfEU/i1oG3xNhDgO1sARpZ5U718Msqg1UQuh/oQzlc8YM5pm2llPGycnGNiSstj
        NFHJrQzytQY7QfyMHIC+vDEdTZOa4a6Hef4t3hyejO5kUy9fqloKzx6Xrr1LfPpI/JY
        mLCjyqJoqybAD3yPaTLFz1RPNZFO2934ytkdm7SOq/oB1YdoK20UIrHVUdbhnmMskdk
        Ma05owOmbYIEsb6HPpsQ73j67e0NljeE5ixxYWtvAw5UyPVenrpWC2JEb6LrDKo6/ae
        GfehPmSlng==
Date:   Fri, 20 Mar 2020 21:43:01 +0100 (CET)
From:   stratus@tuta.io
To:     Linux Kernel <linux-kernel@vger.kernel.org>
Message-ID: <M2tfonU--3-2@tuta.io>
Subject: Error messages from searching
 /sys/devices/pci0000:00/0000:00:01.0/0000:01:00.0/resource0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

/sys/devices/pci0000:00/0000:00:01.0/0000:01:00.0$ sudo ag -u something res=
ource0=C2=A0 (or resource1 / 1_wc / 3)
This results in ag hanging, plus a huge amount of error messages are writte=
n to syslog. Once it locked up the desktop and I had to press and hold the =
power button.
If a log file limit is not set this can quickly fill the entire partition a=
nd then the system will not reboot after it is shut down, unless something =
is deleted.
I found this by accident when using sudo ag -u from / to search the entire =
file system. It occurred with the regular distro packages, and still happen=
s when I installed the relevant -git versions from the AUR.


/sys/devices/pci0000:00/0000:00:01.0/0000:01:00.0$ ls -l
etc...etc:
-r--r--r-- 1 root root=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 4096 Mar 20 01:03 reso=
urce
-rw------- 1 root root=C2=A0 16777216 Mar 20 01:05 resource0
-rw------- 1 root root 268435456 Mar 20 01:05 resource1
-rw------- 1 root root 268435456 Mar 20 01:05 resource1_wc
-rw------- 1 root root=C2=A0 33554432 Mar 20 01:04 resource3
-rw------- 1 root root=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 128 Mar 20 01:04=
 resource5
-r--r--r-- 1 root root=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 4096 Mar 20 01:03 revi=
sion
etc...


Mar 20 01:09:08 xyz kernel: [=C2=A0 375.563053] nouveau 0000:01:00.0: fb: t=
rapped read at 0101059e74 on channel -1 [1fed0000 unknown] engine 06 [BAR] =
client 08 [PFIFO_READ] subclient
01 [IN] reason 00000002 [PAGE_NOT_PRESENT]
Mar 20 01:09:08 xyz kernel: [=C2=A0 375.563148] nouveau 0000:01:00.0: fb: t=
rapped read at 0101059e74 on channel -1 [1fed0000 unknown] engine 06 [BAR] =
client 08 [PFIFO_READ] subclient
01 [IN] reason 00000002 [PAGE_NOT_PRESENT]
Mar 20 01:09:08 xyz kernel: [=C2=A0 375.563300] nouveau 0000:01:00.0: fb: t=
rapped read at 0101059e84 on channel -1 [1fed0000 unknown] engine 06 [BAR] =
client 08 [PFIFO_READ] subclient
01 [IN] reason 00000002 [PAGE_NOT_PRESENT]
Mar 20 01:09:08 xyz kernel: [=C2=A0 375.563428] nouveau 0000:01:00.0: fb: t=
rapped read at 0101059e8c on channel -1 [1fed0000 unknown] engine 06 [BAR] =
client 08 [PFIFO_READ] subclient
01 [IN] reason 00000002 [PAGE_NOT_PRESENT]
Mar 20 01:09:08 xyz kernel: [=C2=A0 375.563529] nouveau 0000:01:00.0: fb: t=
rapped read at 0101059e94 on channel -1 [1fed0000 unknown] engine 06 [BAR] =
client 08 [PFIFO_READ] subclient
01 [IN] reason 00000002 [PAGE_NOT_PRESENT]
Mar 20 01:09:08 xyz kernel: [=C2=A0 375.563665] nouveau 0000:01:00.0: fb: t=
rapped read at 0101059e9c on channel -1 [1fed0000 unknown] engine 06 [BAR] =
client 08 [PFIFO_READ] subclient
01 [IN] reason 00000002 [PAGE_NOT_PRESENT]
Mar 20 01:09:08 xyz kernel: [=C2=A0 375.563800] nouveau 0000:01:00.0: fb: t=
rapped read at 0101059ea4 on channel -1 [1fed0000 unknown] engine 06 [BAR] =
client 08 [PFIFO_READ] subclient
01 [IN] reason 00000002 [PAGE_NOT_PRESENT]


$ inxi -zv7
System:=C2=A0=C2=A0=C2=A0 Host: xyz Kernel: 5.6.0-rc6-1-git-00009-gac309e77=
44be x86_64 bits: 64 compiler: gcc v: 9.2.1
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Desktop: Xfce =
4.14.2 tk: Gtk 3.24.13 info: xfce4-panel wm: xfwm4 dm: startx Distro: Artix=
 Linux
Machine:=C2=A0=C2=A0 Type: Portable System: Dell product: Precision M4400 v=
: N/A serial: <filter> Chassis: type: 8
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 serial: <filte=
r>
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Mobo: Dell mod=
el: 0NY980 serial: <filter> BIOS: Dell v: A29 date: 06/04/2013
Battery:=C2=A0=C2=A0 ID-1: BAT0 charge: 69.7 Wh condition: 69.7/73.3 Wh (95=
%) volts: 12.4/11.1 model: Sanyo DELL U726H8A
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 type: Li-ion s=
erial: <filter> status: Full
Memory:=C2=A0=C2=A0=C2=A0 RAM: total: 7.77 GiB used: 343.3 MiB (4.3%)
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 RAM Report: mi=
ssing: Required program dmidecode not available
CPU:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Topology: Dual Core model: Intel C=
ore2 Duo T9900 bits: 64 type: MCP arch: Penryn rev: A
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 L2 cache: 6144=
 KiB bogomips: 12241
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Speed: 798 MHz=
 min/max: 800/3068 MHz boost: enabled Core speeds (MHz): 1: 847 2: 1103
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Flags: acpi ap=
erfmperf apic arch_perfmon bts clflush cmov constant_tsc cpuid cx16 cx8 de =
ds_cpl
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dtes64 dtherm =
dts est fpu fxsr ht ida lahf_lm lm mca mce mmx monitor msr mtrr nopl nx pae=
 pat pbe
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pdcm pebs pge =
pni pse pse36 pti rep_good sep smx sse sse2 sse4_1 ssse3 syscall tm tm2 tsc=
 vme xsave
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 xtpr
Graphics:=C2=A0 Device-1: NVIDIA G96GLM [Quadro FX 770M] vendor: Dell drive=
r: nouveau v: kernel bus ID: 01:00.0
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 chip ID: 10de:=
065c
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Display: tty s=
erver: X.Org 1.20.7 driver: nouveau,vesa unloaded: fbdev,modesetting altern=
ate: nv
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 resolution: 14=
40x900~60Hz
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 OpenGL: render=
er: NV96 v: 3.3 Mesa 20.1.0-devel (git-f778c48869) direct render: Yes
Audio:=C2=A0=C2=A0=C2=A0=C2=A0 Device-1: Intel 82801I HD Audio vendor: Dell=
 driver: snd_hda_intel v: kernel bus ID: 00:1b.0
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 chip ID: 8086:=
293e
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Sound Server: =
ALSA v: k5.6.0-rc6-1-git-00009-gac309e7744be
Network:=C2=A0=C2=A0 Device-1: Intel 82567LM Gigabit Network vendor: Dell d=
river: e1000e v: 3.2.6-k port: efe0
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bus ID: 00:19.=
0 chip ID: 8086:10f5
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 IF: enp0s25 st=
ate: down mac: <filter>
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Device-2: Rali=
nk RT2760 Wireless 802.11n 1T/2R vendor: Belkin driver: rt2800pci v: 2.3.0 =
port: df00
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bus ID: 04:00.=
0 chip ID: 1814:0701
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 IF: wlp4s0 sta=
te: down mac: <filter>
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 WAN IP: No WAN=
 IP data found. Connected to the web? SSL issues?
Drives:=C2=A0=C2=A0=C2=A0 Local Storage: total: 111.79 GiB used: 36.29 GiB =
(32.5%)
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ID-1: /dev/sda=
 model: SSD2S120SF1200SA2 size: 111.79 GiB speed: 3.0 Gb/s serial: <filter>=
 rev: BBF0
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 scheme: GPT
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Optical-1: /de=
v/sr0 vendor: MATSHITA model: DVD+-RW UJ862A rev: 1.02 dev-links: cdrom
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Features: spee=
d: 24 multisession: yes audio: yes dvd: yes rw: cd-r,cd-rw,dvd-r,dvd-ram
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 state: running
RAID:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Message: No RAID data was found.
Partition: ID-1: / size: 45.00 GiB used: 36.20 GiB (80.4%) fs: btrfs dev: /=
dev/sda4 label: root1
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 uuid: 7002a85b=
-74aa-4374-b55a-61067abb4e94
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ID-2: /boot si=
ze: 1024.0 MiB used: 89.9 MiB (8.8%) fs: btrfs dev: /dev/sda2 label: N/A
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 uuid: 75c0faca=
-5886-4abb-aa12-ee239202ffa4
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ID-3: swap-1 s=
ize: 16.00 GiB used: 0 KiB (0.0%) fs: swap dev: /dev/sda3 label: swap
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 uuid: 402f9ace=
-25f8-4dc7-a7ab-c1ce4cbd34a8
Unmounted: ID-1: /dev/sda1 size: 1024 KiB fs: <root required> label: N/A uu=
id: N/A
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ID-2: /dev/sda=
5 size: 35.00 GiB fs: btrfs label: devuan uuid: bd06cd95-6c1f-4551-93ba-c3e=
0403bf6f6
USB:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Hub: 1-0:1 info: Full speed (or ro=
ot) Hub ports: 6 rev: 2.0 speed: 480 Mb/s chip ID: 1d6b:0002
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Hub: 2-0:1 inf=
o: Full speed (or root) Hub ports: 6 rev: 2.0 speed: 480 Mb/s chip ID: 1d6b=
:0002
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Hub: 3-0:1 inf=
o: Full speed (or root) Hub ports: 2 rev: 1.1 speed: 12 Mb/s chip ID: 1d6b:=
0001
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Hub: 4-0:1 inf=
o: Full speed (or root) Hub ports: 2 rev: 1.1 speed: 12 Mb/s chip ID: 1d6b:=
0001
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Hub: 5-0:1 inf=
o: Full speed (or root) Hub ports: 2 rev: 1.1 speed: 12 Mb/s chip ID: 1d6b:=
0001
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Device-1: 5-1:=
2 info: Broadcom BCM5880 Secure Applications Processor with fingerprint tou=
ch sensor
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 type: Smart Ca=
rd driver: N/A interfaces: 2 rev: 1.1 speed: 12 Mb/s chip ID: 0a5c:5802
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 serial: <filte=
r>
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Hub: 6-0:1 inf=
o: Full speed (or root) Hub ports: 2 rev: 1.1 speed: 12 Mb/s chip ID: 1d6b:=
0001
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Hub: 7-0:1 inf=
o: Full speed (or root) Hub ports: 2 rev: 1.1 speed: 12 Mb/s chip ID: 1d6b:=
0001
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Hub: 8-0:1 inf=
o: Full speed (or root) Hub ports: 2 rev: 1.1 speed: 12 Mb/s chip ID: 1d6b:=
0001
Sensors:=C2=A0=C2=A0 System Temperatures: cpu: 39.0 C mobo: N/A sodimm: 39.=
0 C gpu: nouveau temp: 53 C
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Fan Speeds (RP=
M): cpu: 0
Info:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Processes: 179 Uptime: 20m Init: N/A v:=
 N/A rc: OpenRC v: 0.42.1 runlevel: default Compilers:
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 gcc: 9.3.0 alt=
: 8 clang: 9.0.1 Shell: bash v: 5.0.16 running in: xfce4-terminal inxi: 3.0=
.26



$ uname -r
5.6.0-rc6-1-git-00009-gac309e7744be
$ pacman -Qi linux-git
Name=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 : li=
nux-git
Version=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 : 5.6rc6.r9.gac309e=
7744be-1
Description=C2=A0=C2=A0=C2=A0=C2=A0 : The Linux git kernel and modules
Architecture=C2=A0=C2=A0=C2=A0 : x86_64
URL=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 : https://www.kernel.org
Licenses=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 : GPL2
Groups=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 : None
Provides=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 : None
Depends On=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 : coreutils=C2=A0 kmod=C2=A0 initr=
amfs
Optional Deps=C2=A0=C2=A0 : crda: to set the correct wireless channels of y=
our country
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 linux-firmware: firmware images needed for some=
 devices [installed]
Required By=C2=A0=C2=A0=C2=A0=C2=A0 : None
Optional For=C2=A0=C2=A0=C2=A0 : None
Conflicts With=C2=A0 : None
Replaces=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 : None
Installed Size=C2=A0 : 74.61 MiB
Packager=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 : Unknown Packager
Build Date=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 : Tue 17 Mar 2020 21:27:04 GMT
Install Date=C2=A0=C2=A0=C2=A0 : Wed 18 Mar 2020 20:26:50 GMT
Install Reason=C2=A0 : Explicitly installed
Install Script=C2=A0 : No
Validated By=C2=A0=C2=A0=C2=A0 : None

$ pacman -Qi mesa-git
Name=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 : me=
sa-git
Version=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 : 20.1.0_devel.1213=
94.f778c48869f-1
Description=C2=A0=C2=A0=C2=A0=C2=A0 : an open-source implementation of the =
OpenGL specification, git version
Architecture=C2=A0=C2=A0=C2=A0 : x86_64
URL=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 : https://www.mesa3d.org
Licenses=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 : custom
Groups=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 : None
Provides=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 : mesa=3D20.1.0_devel.12=
1394.f778c48869f-1=C2=A0 vulkan-intel=3D20.1.0_devel.121394.f778c48869f-1=
=C2=A0 vulkan-radeon=3D20.1.0_devel.121394.f778c48869f-1
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 vulkan-mesa-layer=3D20.1.0_devel.121394.f778c48=
869f-1=C2=A0 libva-mesa-driver=3D20.1.0_devel.121394.f778c48869f-1=C2=A0 me=
sa-vdpau=3D20.1.0_devel.121394.f778c48869f-1
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 vulkan-driver=C2=A0 opengl-driver=C2=A0 opencl-=
driver
Depends On=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 : libdrm=C2=A0 libxxf86vm=C2=A0 li=
bxdamage=C2=A0 libxshmfence=C2=A0 libelf=C2=A0 libomxil-bellagio=C2=A0 libu=
nwind=C2=A0 libglvnd=C2=A0 wayland=C2=A0 lm_sensors=C2=A0 libclc=C2=A0 glsl=
ang=C2=A0 vulkan-icd-loader=C2=A0 zstd
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 llvm-libs=3D9.0.1
Optional Deps=C2=A0=C2=A0 : opengl-man-pages: for the OpenGL API man pages
Required By=C2=A0=C2=A0=C2=A0=C2=A0 : gst-plugins-base-libs=C2=A0 gtk3=C2=
=A0 lib32-mesa=C2=A0 libglvnd=C2=A0 qt5-base=C2=A0 xf86-video-nouveau-git=
=C2=A0 xorg-server-devel
Optional For=C2=A0=C2=A0=C2=A0 : vulkan-icd-loader
Conflicts With=C2=A0 : mesa=C2=A0 opencl-mesa=C2=A0 vulkan-intel=C2=A0 vulk=
an-radeon=C2=A0 vulkan-mesa-layer=C2=A0 libva-mesa-driver=C2=A0 mesa-vdpau
Replaces=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 : None
Installed Size=C2=A0 : 148.97 MiB
Packager=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 : Unknown Packager
Build Date=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 : Thu 19 Mar 2020 19:11:52 GMT
Install Date=C2=A0=C2=A0=C2=A0 : Thu 19 Mar 2020 20:09:30 GMT
Install Reason=C2=A0 : Explicitly installed
Install Script=C2=A0 : No
Validated By=C2=A0=C2=A0=C2=A0 : None

$ pacman -Qi libdrm-git
Name=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 : li=
bdrm-git
Version=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 : 2.4.100.r70.g665c=
0f7f-1
Description=C2=A0=C2=A0=C2=A0=C2=A0 : Userspace interface to kernel DRM ser=
vices, master git version
Architecture=C2=A0=C2=A0=C2=A0 : x86_64
URL=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 : http://dri.freedesktop.org/
Licenses=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 : custom
Groups=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 : None
Provides=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 : libdrm
Depends On=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 : libpciaccess
Optional Deps=C2=A0=C2=A0 : None
Required By=C2=A0=C2=A0=C2=A0=C2=A0 : ffmpeg=C2=A0 intel-media-sdk=C2=A0 li=
b32-libdrm=C2=A0 libva=C2=A0 mesa-git=C2=A0 xorg-server
Optional For=C2=A0=C2=A0=C2=A0 : None
Conflicts With=C2=A0 : libdrm
Replaces=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 : None
Installed Size=C2=A0 : 959.10 KiB
Packager=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 : Unknown Packager
Build Date=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 : Thu 19 Mar 2020 01:23:59 GMT
Install Date=C2=A0=C2=A0=C2=A0 : Thu 19 Mar 2020 02:14:40 GMT
Install Reason=C2=A0 : Explicitly installed
Install Script=C2=A0 : No
Validated By=C2=A0=C2=A0=C2=A0 : None

$ pacman -Qi xf86-video-nouveau-git
Name=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 : xf=
86-video-nouveau-git
Version=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 : 1.0.16+4+g5444cab=
-1
Description=C2=A0=C2=A0=C2=A0=C2=A0 : Open Source 3D acceleration driver fo=
r nVidia cards
Architecture=C2=A0=C2=A0=C2=A0 : x86_64
URL=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 : http://nouveau.freedesktop.org/
Licenses=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 : GPL
Groups=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 : xorg-drivers
Provides=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 : None
Depends On=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 : systemd-libs=C2=A0 mesa
Optional Deps=C2=A0=C2=A0 : None
Required By=C2=A0=C2=A0=C2=A0=C2=A0 : None
Optional For=C2=A0=C2=A0=C2=A0 : None
Conflicts With=C2=A0 : xf86-video-nouveau
Replaces=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 : None
Installed Size=C2=A0 : 262.84 KiB
Packager=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 : Unknown Packager
Build Date=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 : Thu 19 Mar 2020 20:12:55 GMT
Install Date=C2=A0=C2=A0=C2=A0 : Thu 19 Mar 2020 20:41:19 GMT
Install Reason=C2=A0 : Explicitly installed
Install Script=C2=A0 : No
Validated By=C2=A0=C2=A0=C2=A0 : None

$ pacman -Qi silver-searcher-git
Name=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 : si=
lver-searcher-git
Version=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 : 2.2.0.24.gb93c271=
.r2021.b93c271-1
Description=C2=A0=C2=A0=C2=A0=C2=A0 : The Silver Searcher: An attempt to ma=
ke something better than ack, which itself is better than grep.
Architecture=C2=A0=C2=A0=C2=A0 : x86_64
URL=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 : https://github.com/ggreer/the_silver_searcher
Licenses=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 : Apache
Groups=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 : None
Provides=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 : the_silver_searcher=3D=
2.2.0.24.gb93c271.r2021.b93c271
Depends On=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 : None
Optional Deps=C2=A0=C2=A0 : None
Required By=C2=A0=C2=A0=C2=A0=C2=A0 : None
Optional For=C2=A0=C2=A0=C2=A0 : None
Conflicts With=C2=A0 : the_silver_searcher
Replaces=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 : None
Installed Size=C2=A0 : 98.82 KiB
Packager=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 : Unknown Packager
Build Date=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 : Thu 19 Mar 2020 20:44:33 GMT
Install Date=C2=A0=C2=A0=C2=A0 : Thu 19 Mar 2020 20:45:18 GMT
Install Reason=C2=A0 : Explicitly installed
Install Script=C2=A0 : No
Validated By=C2=A0=C2=A0=C2=A0 : None
