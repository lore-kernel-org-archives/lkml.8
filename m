Return-Path: <SRS0=3W8M=6B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD64FC38A2C
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 15:11:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 961EA2223F
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 15:11:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="K+lush0T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728917AbgDQPLI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Apr 2020 11:11:08 -0400
Received: from mout.gmx.net ([212.227.15.15]:37073 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728114AbgDQPLB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Apr 2020 11:11:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1587136254;
        bh=GWSKP9wnoRkh1H4bE2Fs8S/vc6k4kR4W/lSv4bOOuMo=;
        h=X-UI-Sender-Class:To:From:Subject:Date;
        b=K+lush0THnlQYlHxDv0tOj7aIZeVkU8PAkAR16v/qnks78ZMLd1DWvXmj81cZSJvp
         amSfjoQ9sSB1RBeILKMD1ItWXYvKxxFoQE9HonxgFbIiV58uK6Rq6AYsMat0PyPcrk
         5jk9qFhxoo3IlFA3SaGnwTkjA7CwwHGin91s9OfQ=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.178.23] ([77.1.39.83]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mw9UE-1j8kbS2vau-00s6Sy for
 <linux-kernel@vger.kernel.org>; Fri, 17 Apr 2020 17:10:54 +0200
To:     Linux Kernel <linux-kernel@vger.kernel.org>
From:   =?UTF-8?Q?Toralf_F=c3=b6rster?= <toralf.foerster@gmx.de>
Subject: regression 5.6.4->5.6.5 at drivers/acpi/ec.c
Autocrypt: addr=toralf.foerster@gmx.de; prefer-encrypt=mutual; keydata=
 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
Message-ID: <fdd9ce1d-146a-5fbf-75c5-3a9384603312@gmx.de>
Date:   Fri, 17 Apr 2020 17:10:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:k5bUGPChE8iMUmBgiPdfgx0Wagk3bescAIevnyNi2RK8P0R1AjY
 whXhdM4m4YB9wsvQ6F1ZGTnL7QIc3dQY7gcgd9cNyylZ0l/j87kPvkhCqBZV0u/9g2Twc5x
 EsZ50Z263eqg8auMnMIi5r4aspm76KAGV47ZAd/VtLH3X6Zj1ZDG+opXSL27AG8JUusGWME
 iSUdx/WcelP9nJfpuUibw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:f3TIKlADSxg=:XTixt8Ph0L7JS64VkiA/Hj
 RIAY209T1wutYksSedyDitYVp/IH3BCybniYqw4fOg4tKYIJrctTqtZxJCJggWuT5M9CSpCPq
 QZ3FZYFVBq6QYUTlym9b7EcgSEkA8NNbKM56BGte5KR9I/e/K0txDhMmDwpZfrjUFnom2uxzP
 2JT5IUtLmWvc6aw2dgGZGzCmCcH7xxIRTrhBTiu1sbpxZbZbgO4KGXVAYXUmX9ecUMy+SEkd1
 tcRmnUB/7Z4KLXc4dZ+DiDSr3uUFEKr2umXgo1YSK9b02ZcEwSbD6Si3+JN2TSfazrOCKfb1D
 TsQdQ7tKJL2LRTezcjCxLjk3QgIi/YNc9qt3bm5oHNwuTZqKleHmKsv0yszrhLPJgDikCduNZ
 nkTLU1aUyy9v1eU3wP41X9w5vFybKsoOLH630R4dB+2YmV13Ugm5vmMd12Okh1qx1xPt+00j2
 cPC4pmBdWJxs3xl8vPiwPQWUGRixlIjt02gjm+Uv+0E19axZCBK/okEEjII1NT2PHMeJFGyJk
 7cqWZgzWxGLIAogitp5clMYBBi5jOxdUG9hboAqfw4N1vPTwtv0wGjAH4GGi1WIDReTFMjKDt
 Pxs3X+6pObPvU8a1dmFukn6zXa4i2xtMqnXZxzciOq5cLFUQBGWsSfw3qwXw8uHi3OF+70hcM
 BStJTuaL0G5s7iTzGcojuP64OH/IsKKbsdXlpq6EKaCijiWHbKUWoO4s8ylV9C920rteIxE2F
 UjSXQ10+hzjhI/3Y8077jPSGN2ktUq9Tw0nUluxiE8wBl2Be+R6Tyt2LR+pQBsllxHd1Vj2R2
 o3offT8Mwg6hLl0ScbYUwiqK4+RH0oOmb6ctgaRiGkunZ+5RaILkxIEWYC3RWsyFAnTyevVQ3
 V6p5PcLJP5Amj5n1amzGS7vpakMNrm4xvZ5VNTOuZxdC3vku2waeY3vTVhx13u0W6epl4D4w2
 ykBKxaDePZU9DUB05lp4qjPZrdKs91OLge/28bTbZkSKAQPI0ac2JV8f/dPst13m9w4fAZQBn
 RNbCRlEX4IC4GdcUz+V69XPAicLetUU5Ehe9rrBf6Om7uTqXZD8p+ZuuEycY433WjiJts/gAt
 8TrOfzBbhCyR21iVjNlggyHQ8nodDwMJG5R4Jy/lwJTnz17x+ZB3Lb1cnZWWc0n1UQmHXgDX5
 Wbd0eAVuL0O/aozZisAI2MxuvzNKQI40uT6sCLI7qnIw7KilHTQZanMRIbKoEyvpWPcXNMAAE
 ucO3rpAZqEybyUgWD
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

At a T440s under hardened Gentoo Linux I' faced with this new spew (system=
 seems to be working fine otherwise):


pci 0000:02:00.0: reg 0x10: [mem 0xe0500000-0xe0500fff]
pci 0000:02:00.0: supports D1 D2
pci 0000:02:00.0: PME# supported from D1 D2 D3hot D3cold
pci 0000:00:1c.0: PCI bridge to [bus 02]
pci 0000:00:1c.0:   bridge window [mem 0xe0500000-0xe05fffff]
pci 0000:03:00.0: [8086:08b2] type 00 class 0x028000
pci 0000:03:00.0: reg 0x10: [mem 0xe0400000-0xe0401fff 64bit]
pci 0000:03:00.0: PME# supported from D0 D3hot D3cold
pci 0000:00:1c.1: PCI bridge to [bus 03]
pci 0000:00:1c.1:   bridge window [mem 0xe0400000-0xe04fffff]
ACPI: EC: interrupt unblocked
ACPI: EC: event unblocked
ACPI: EC: EC_CMD/EC_SC=3D0x66, EC_DATA=3D0x62
ACPI: EC: GPE=3D0x25
ACPI: \_SB_.PCI0.LPC_.EC__: Boot ECDT EC initialization complete
ACPI: \_SB_.PCI0.LPC_.EC__: EC: Used to handle transactions and events
ACPI: EC: EC_CMD/EC_SC=3D0x66, EC_DATA=3D0x62
ACPI: EC: GPE=3D0x25
ACPI: \_SB_.PCI0.LPC_.EC__: Boot ECDT EC initialization complete
ACPI: \_SB_.PCI0.LPC_.EC__: EC: Used to handle transactions and events
=2D-----------[ cut here ]------------
Could not request EC data io port 0x62
WARNING: CPU: 0 PID: 1 at drivers/acpi/ec.c:1677 acpi_ec_add+0x26e/0x280
Modules linked in:
CPU: 0 PID: 1 Comm: swapper/0 Tainted: G                T 5.6.5 #5
Hardware name: LENOVO 20AQCTO1WW/20AQCTO1WW, BIOS GJET92WW (2.42 ) 03/03/2=
017
RIP: 0010:acpi_ec_add+0x26e/0x280
Code: fe ff ff 48 8b 75 10 48 c7 c7 d0 27 9b 8d e8 81 c7 b6 ff 0f 0b e9 c9=
 fe ff ff 48 8b 75 18 48 c7 c7 a8 27 9b 8d e8 6a c7 b6 ff <0f> 0b e9 8a fe=
 ff ff 41 bc f4 ff ff ff e9 ac fe ff ff 48 83 3d f8
RSP: 0000:ffffb45b40053c80 EFLAGS: 00010282
RAX: 0000000000000000 RBX: ffffa2827012b800 RCX: 0000000000000000
RDX: 0000000000000026 RSI: ffffffff8e26f666 RDI: ffffffff8e26fa66
RBP: ffffa282709b4b00 R08: 0000000089294f76 R09: 0000000000000026
R10: 000000000000000f R11: ffffb45b40053aa8 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000001 R15: 0000000000000030
FS:  0000000000000000(0000) GS:ffffa28272600000(0000) knlGS:00000000000000=
00
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffa2827e5ff000 CR3: 000000008e80a001 CR4: 00000000001606f0
Call Trace:
 acpi_device_probe+0x40/0x100
 really_probe+0xe8/0x2d0
 driver_probe_device+0x57/0xd0
 ? driver_allows_async_probing+0x50/0x50
 bus_for_each_drv+0x90/0xe0
 __device_attach+0xea/0x160
 acpi_bus_register_early_device+0x4b/0x70
 acpi_ec_init+0x2ee/0x361
 acpi_init+0x410/0x4a0
 ? acpi_sleep_proc_init+0x4c/0x4c
 do_one_initcall+0x93/0x1f0
 kernel_init_freeable+0x3e7/0x4cc
 ? rest_init+0xc0/0xc0
 kernel_init+0x6/0x110
 ? rest_init+0xc0/0xc0
 ret_from_fork+0x35/0x40
=2D--[ end trace cd90af9f64ca9345 ]---
=2D-----------[ cut here ]------------
Could not request EC cmd io port 0x66
WARNING: CPU: 0 PID: 1 at drivers/acpi/ec.c:1679 acpi_ec_add+0x257/0x280
Modules linked in:
CPU: 0 PID: 1 Comm: swapper/0 Tainted: G        W       T 5.6.5 #5
Hardware name: LENOVO 20AQCTO1WW/20AQCTO1WW, BIOS GJET92WW (2.42 ) 03/03/2=
017
RIP: 0010:acpi_ec_add+0x257/0x280
Code: 8b 55 00 48 89 ef 48 89 10 e8 65 e0 ff ff 48 8b 2d 4e d7 3b 01 e9 4a=
 fe ff ff 48 8b 75 10 48 c7 c7 d0 27 9b 8d e8 81 c7 b6 ff <0f> 0b e9 c9 fe=
 ff ff 48 8b 75 18 48 c7 c7 a8 27 9b 8d e8 6a c7 b6
RAX: 0000000000000000 RBX: ffffa2827012b800 RCX: 0000000000000000
RDX: 0000000000000025 RSI: ffffffff8e26f665 RDI: ffffffff8e26fa65
RBP: ffffa282709b4b00 R08: 000000008935c8e8 R09: 0000000000000025
R10: 000000000000000f R11: ffffb45b40053aa8 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000001 R15: 0000000000000030
FS:  0000000000000000(0000) GS:ffffa28272600000(0000) knlGS:00000000000000=
00
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffa2827e5ff000 CR3: 000000008e80a001 CR4: 00000000001606f0
Call Trace:
 acpi_device_probe+0x40/0x100
 really_probe+0xe8/0x2d0
 driver_probe_device+0x57/0xd0
 ? driver_allows_async_probing+0x50/0x50
 bus_for_each_drv+0x90/0xe0
 __device_attach+0xea/0x160
 acpi_bus_register_early_device+0x4b/0x70
 acpi_ec_init+0x2ee/0x361
 acpi_init+0x410/0x4a0
 ? acpi_sleep_proc_init+0x4c/0x4c
 do_one_initcall+0x93/0x1f0
 kernel_init_freeable+0x3e7/0x4cc
 ? rest_init+0xc0/0xc0
 kernel_init+0x6/0x110
 ? rest_init+0xc0/0xc0
 ret_from_fork+0x35/0x40
=2D--[ end trace cd90af9f64ca9346 ]---
iommu: Default domain type: Translated
pci 0000:00:02.0: vgaarb: setting as boot VGA device
pci 0000:00:02.0: vgaarb: VGA device added: decodes=3Dio+mem,owns=3Dio+mem=
,locks=3Dnone
pci 0000:00:02.0: vgaarb: bridge control possible
vgaarb: loaded
SCSI subsystem initialized
libata version 3.00 loaded.
ACPI: bus type USB registered
usbcore: registered new interface driver usbfs
usbcore: registered new interface driver hub
usbcore: registered new device driver usb
pps_core: LinuxPPS API ver. 1 registered
pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo Giometti <giom=
etti@linux.it>
EDAC MC: Ver: 3.0.0
PCI: Using ACPI for IRQ routing
PCI: pci_cache_line_size set to 64 bytes
e820: reserve RAM buffer [mem 0x0009d000-0x0009ffff]
e820: reserve RAM buffer [mem 0xaf70b000-0xafffffff]
e820: reserve RAM buffer [mem 0x33e600000-0x33fffffff]
hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0, 0, 0, 0, 0, 0
hpet0: 8 comparators, 64-bit 14.318180 MHz counter
clocksource: Switched to clocksource tsc-early
*** VALIDATE ramfs ***
*** VALIDATE hugetlbfs ***
pnp: PnP ACPI init
system 00:00: [mem 0x00000000-0x0009ffff] could not be reserved
system 00:00: [mem 0x000c0000-0x000c3fff] could not be reserved
system 00:00: [mem 0x000c4000-0x000c7fff] could not be reserved
system 00:00: [mem 0x000c8000-0x000cbfff] could not be reserved
system 00:00: [mem 0x000cc000-0x000cffff] could not be reserved
system 00:00: [mem 0x000d0000-0x000d3fff] has been reserved
system 00:00: [mem 0x000d4000-0x000d7fff] has been reserved
system 00:00: [mem 0x000d8000-0x000dbfff] has been reserved
system 00:00: [mem 0x000dc000-0x000dffff] has been reserved
system 00:00: [mem 0x000e0000-0x000e3fff] could not be reserved
system 00:00: [mem 0x000e4000-0x000e7fff] could not be reserved
system 00:00: [mem 0x000e8000-0x000ebfff] could not be reserved
system 00:00: [mem 0x000ec000-0x000effff] could not be reserved
system 00:00: [mem 0x000f0000-0x000fffff] could not be reserved
system 00:00: [mem 0x00100000-0xbf9fffff] could not be reserved
system 00:00: [mem 0xfec00000-0xfed3ffff] could not be reserved
system 00:00: [mem 0xfed4c000-0xffffffff] could not be reserved
system 00:00: Plug and Play ACPI device, IDs PNP0c01 (active)
pnp 00:01: [Firmware Bug]: PNP resource [mem 0xfed10000-0xfed13fff] covers=
 only part of 0000:00:00.0 Intel MCH; extending to [mem 0xfed10000-0xfed17=
fff]
system 00:01: [io  0x1800-0x189f] has been reserved
system 00:01: [io  0x0800-0x087f] has been reserved
system 00:01: [io  0x0880-0x08ff] has been reserved
system 00:01: [io  0x0900-0x097f] has been reserved
system 00:01: [io  0x0980-0x09ff] has been reserved
system 00:01: [io  0x0a00-0x0a7f] has been reserved
system 00:01: [io  0x0a80-0x0aff] has been reserved
system 00:01: [io  0x0b00-0x0b7f] has been reserved
system 00:01: [io  0x0b80-0x0bff] has been reserved
system 00:01: [io  0x15e0-0x15ef] has been reserved
system 00:01: [io  0x1600-0x167f] has been reserved
system 00:01: [io  0x1640-0x165f] has been reserved
system 00:01: [mem 0xf8000000-0xfbffffff] has been reserved

=2D-
Toralf
