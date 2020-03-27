Return-Path: <SRS0=s8dx=5M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 805E5C2D0F1
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 13:30:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 518B3206F2
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 13:30:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727685AbgC0NaR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Mar 2020 09:30:17 -0400
Received: from mail-il1-f200.google.com ([209.85.166.200]:52699 "EHLO
        mail-il1-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727575AbgC0NaQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Mar 2020 09:30:16 -0400
Received: by mail-il1-f200.google.com with SMTP id d2so8823954ilf.19
        for <linux-kernel@vger.kernel.org>; Fri, 27 Mar 2020 06:30:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=BNFXoiYssRBqTTsgLrZShw+/qIh/hPgY1hNBCz0KNwU=;
        b=im7i56Teyam8EIww4swMd8siKmgBoCpMjct37BRjiRcq5waIfW0X55xMieqoXCBPFz
         RjXcG1EYtEc7Or4tR1WVRzvwaC4xFJCh/fbmvXjJRWPmoEPsJhPUbDpgE4OX9lUTNfip
         AjcgbOxB5u9Wm58aNiISQCupGCOkhvQksWfz/lq2PnZZSXNaZI84Ttjg3edJvHXGOXg/
         kCFf0K+T6tq7B+Lp9vm3g8LYsR89wAKpU39xfisBrxaF8pqPLP/AOKx1ewHl7b5VQZZ4
         4c0uAnZ0h38ww900a+IOcmKtBdtsLkJb4PLsiMjOpT4FP+KNVIsoPH+hhZAwBluf5Yby
         O4uw==
X-Gm-Message-State: ANhLgQ29fDRDUiRQNRT6tU1ep1PW77OSoX3eTejskYBv53vRYMJXS4jg
        63RkVSGo/aruNs7QkUXGslVfpHDllzExOtld2t5P6GW/TmXS
X-Google-Smtp-Source: ADFU+vsvEmt0H8n/9nGrp9JLN5HsPCng/cD/1aH04O1n9JDJLXRWbxUmpsAwCO78Hak+nYkkKpllSLFXzDdbIEMgpc72x+EzWjAM
MIME-Version: 1.0
X-Received: by 2002:a92:da81:: with SMTP id u1mr13446221iln.116.1585315815220;
 Fri, 27 Mar 2020 06:30:15 -0700 (PDT)
Date:   Fri, 27 Mar 2020 06:30:15 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000005ec9405a1d61aa0@google.com>
Subject: general protection fault in fbcon_switch
From:   syzbot <syzbot+732528bae351682f1f27@syzkaller.appspotmail.com>
To:     andreyknvl@google.com, b.zolnierkie@samsung.com,
        daniel.vetter@ffwll.ch, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, maarten.lankhorst@linux.intel.com,
        sam@ravnborg.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    e17994d1 usb: core: kcov: collect coverage from usb comple..
git tree:       https://github.com/google/kasan.git usb-fuzzer
console output: https://syzkaller.appspot.com/x/log.txt?x=1328834be00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5d64370c438bc60
dashboard link: https://syzkaller.appspot.com/bug?extid=732528bae351682f1f27
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+732528bae351682f1f27@syzkaller.appspotmail.com

general protection fault, probably for non-canonical address 0xdffffc000000006c: 0000 [#1] SMP KASAN
KASAN: null-ptr-deref in range [0x0000000000000360-0x0000000000000367]
CPU: 0 PID: 5 Comm: kworker/0:0 Not tainted 5.6.0-rc5-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Workqueue: usb_hub_wq hub_event
RIP: 0010:fbcon_switch+0x28f/0x1740 drivers/video/fbdev/core/fbcon.c:2260
Code: 0f 85 96 14 00 00 48 8d 04 db 48 8b 1c c5 00 91 ff 89 48 b8 00 00 00 00 00 fc ff df 48 8d bb 60 03 00 00 48 89 fa 48 c1 ea 03 <0f> b6 04 02 84 c0 74 08 3c 03 0f 8e de 11 00 00 44 8b b3 60 03 00
RSP: 0018:ffff8881da1dead8 EFLAGS: 00010206
RAX: dffffc0000000000 RBX: 0000000000000000 RCX: ffffc9000d9eb000
RDX: 000000000000006c RSI: ffffffff81fe5b44 RDI: 0000000000000360
RBP: ffff8881ab4f0000 R08: ffff8881da196200 R09: fffffbfff0fcc10e
R10: fffffbfff0fcc10d R11: ffffffff87e6086f R12: ffff8881d6616000
R13: ffff8881c6a4a000 R14: 00000000000000a3 R15: ffffffff85ff8520
FS:  0000000000000000(0000) GS:ffff8881db200000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f676c8e2740 CR3: 00000001cfd06000 CR4: 00000000001406f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 redraw_screen+0x2a8/0x770 drivers/tty/vt/vt.c:1008
 vc_do_resize+0xfe7/0x1360 drivers/tty/vt/vt.c:1295
 fbcon_init+0x1221/0x1ab0 drivers/video/fbdev/core/fbcon.c:1219
 visual_init+0x305/0x5c0 drivers/tty/vt/vt.c:1062
 do_bind_con_driver+0x536/0x890 drivers/tty/vt/vt.c:3542
 do_take_over_console+0x453/0x5b0 drivers/tty/vt/vt.c:4122
 do_fbcon_takeover+0x10b/0x210 drivers/video/fbdev/core/fbcon.c:588
 fbcon_fb_registered+0x26b/0x340 drivers/video/fbdev/core/fbcon.c:3259
 do_register_framebuffer drivers/video/fbdev/core/fbmem.c:1664 [inline]
 register_framebuffer+0x56e/0x980 drivers/video/fbdev/core/fbmem.c:1832
 dlfb_usb_probe.cold+0x1743/0x1ba3 drivers/video/fbdev/udlfb.c:1735
 usb_probe_interface+0x310/0x800 drivers/usb/core/driver.c:374
 really_probe+0x290/0xac0 drivers/base/dd.c:551
 driver_probe_device+0x223/0x350 drivers/base/dd.c:724
 __device_attach_driver+0x1d1/0x290 drivers/base/dd.c:831
 bus_for_each_drv+0x162/0x1e0 drivers/base/bus.c:431
 __device_attach+0x217/0x390 drivers/base/dd.c:897
 bus_probe_device+0x1e4/0x290 drivers/base/bus.c:491
 device_add+0x1459/0x1bf0 drivers/base/core.c:2500
 usb_set_configuration+0xe47/0x17d0 drivers/usb/core/message.c:2023
 usb_generic_driver_probe+0x9d/0xe0 drivers/usb/core/generic.c:241
 usb_probe_device+0xd9/0x230 drivers/usb/core/driver.c:272
 really_probe+0x290/0xac0 drivers/base/dd.c:551
 driver_probe_device+0x223/0x350 drivers/base/dd.c:724
 __device_attach_driver+0x1d1/0x290 drivers/base/dd.c:831
 bus_for_each_drv+0x162/0x1e0 drivers/base/bus.c:431
 __device_attach+0x217/0x390 drivers/base/dd.c:897
 bus_probe_device+0x1e4/0x290 drivers/base/bus.c:491
 device_add+0x1459/0x1bf0 drivers/base/core.c:2500
 usb_new_device.cold+0x540/0xcd0 drivers/usb/core/hub.c:2548
 hub_port_connect drivers/usb/core/hub.c:5195 [inline]
 hub_port_connect_change drivers/usb/core/hub.c:5335 [inline]
 port_event drivers/usb/core/hub.c:5481 [inline]
 hub_event+0x21cb/0x4300 drivers/usb/core/hub.c:5563
 process_one_work+0x94b/0x1620 kernel/workqueue.c:2264
 process_scheduled_works kernel/workqueue.c:2326 [inline]
 worker_thread+0x7ab/0xe20 kernel/workqueue.c:2412
 kthread+0x318/0x420 kernel/kthread.c:255
 ret_from_fork+0x24/0x30 arch/x86/entry/entry_64.S:352
Modules linked in:
---[ end trace bae4913bb3cd6c7d ]---
RIP: 0010:fbcon_switch+0x28f/0x1740 drivers/video/fbdev/core/fbcon.c:2260
Code: 0f 85 96 14 00 00 48 8d 04 db 48 8b 1c c5 00 91 ff 89 48 b8 00 00 00 00 00 fc ff df 48 8d bb 60 03 00 00 48 89 fa 48 c1 ea 03 <0f> b6 04 02 84 c0 74 08 3c 03 0f 8e de 11 00 00 44 8b b3 60 03 00
RSP: 0018:ffff8881da1dead8 EFLAGS: 00010206
RAX: dffffc0000000000 RBX: 0000000000000000 RCX: ffffc9000d9eb000
RDX: 000000000000006c RSI: ffffffff81fe5b44 RDI: 0000000000000360
RBP: ffff8881ab4f0000 R08: ffff8881da196200 R09: fffffbfff0fcc10e
R10: fffffbfff0fcc10d R11: ffffffff87e6086f R12: ffff8881d6616000
R13: ffff8881c6a4a000 R14: 00000000000000a3 R15: ffffffff85ff8520
FS:  0000000000000000(0000) GS:ffff8881db200000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f676c8e2740 CR3: 0000000007021000 CR4: 00000000001406f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
