Return-Path: <SRS0=kRID=5C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1530C10F29
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 09:34:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A057320714
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 09:34:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726066AbgCQJeR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Mar 2020 05:34:17 -0400
Received: from mail-io1-f71.google.com ([209.85.166.71]:47804 "EHLO
        mail-io1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725730AbgCQJeR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 05:34:17 -0400
Received: by mail-io1-f71.google.com with SMTP id w21so13660061iod.14
        for <linux-kernel@vger.kernel.org>; Tue, 17 Mar 2020 02:34:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=8hA1xiNFfEeNh4tjPf0Sj4oPNobnSXcjqFM/N93g+x4=;
        b=WL46Etq6AQv81hEl6tYQcRWCB/hoieROR9+Nc2n2XqS14etejsHk+1DKCnjcPSdwMg
         KpSvOuXLerNiGkh/RHaO/QSBc78ci5GEStCLINOPQZybGmo27fnfodGY2X/W7uNe93bQ
         Ch9FZEKgSuzIjbs7jeBTHWFhikzozH3dIXZbTfKtq0OlKdNgycXxXOLhtsBOMo0Uwrvd
         ARYabWGwOqVOMxzcdIhmwGSjmLdFKD/U1Uze86RY95idv56Xg/2H2GnZ9PjpSUpDupYf
         T03qmKejT7KbtaBnonwIDm4415N9f3z8xHsVS2Fhtnv6OxVirJYjMIWnBIHev7pnJcGY
         EhWw==
X-Gm-Message-State: ANhLgQ2haTjo+isJvrtWGk2158JFThTudOMF87lAhsr2LW5orPoHALOZ
        AGU+pttxyqo8m7H/oNYvVrlzt/NU/wwGylu/l42/Kln3bUMt
X-Google-Smtp-Source: ADFU+vvwgyMWDfCh3AiPKjRyG8ZlkZ8tqhlrYN4CYwCevf2XHU/VCKMvku+jVjT9gOIGJynjjnn9dHGSHsL+rLQAZcQgm2nA5lW4
MIME-Version: 1.0
X-Received: by 2002:a02:3506:: with SMTP id k6mr4450475jaa.104.1584437655618;
 Tue, 17 Mar 2020 02:34:15 -0700 (PDT)
Date:   Tue, 17 Mar 2020 02:34:15 -0700
In-Reply-To: <000000000000a4293f0598ef165e@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a1c96505a109a31b@google.com>
Subject: Re: KASAN: vmalloc-out-of-bounds Write in bitfill_aligned
From:   syzbot <syzbot+e5fd3e65515b48c02a30@syzkaller.appspotmail.com>
To:     b.zolnierkie@samsung.com, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has found a reproducer for the following crash on:

HEAD commit:    fb33c651 Linux 5.6-rc6
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=17dacd55e00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=9f894bd92023de02
dashboard link: https://syzkaller.appspot.com/bug?extid=e5fd3e65515b48c02a30
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11b8ca75e00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=114800e5e00000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+e5fd3e65515b48c02a30@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: vmalloc-out-of-bounds in bitfill_aligned drivers/video/fbdev/core/sysfillrect.c:54 [inline]
BUG: KASAN: vmalloc-out-of-bounds in bitfill_aligned+0x34b/0x410 drivers/video/fbdev/core/sysfillrect.c:25
Write of size 8 at addr ffffc90009621000 by task syz-executor767/9337

CPU: 3 PID: 9337 Comm: syz-executor767 Not tainted 5.6.0-rc6-syzkaller #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.12.0-59-gc9ba5276e321-prebuilt.qemu.org 04/01/2014
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x188/0x20d lib/dump_stack.c:118
 print_address_description.constprop.0.cold+0x5/0x315 mm/kasan/report.c:374
 __kasan_report.cold+0x1a/0x32 mm/kasan/report.c:506
 kasan_report+0xe/0x20 mm/kasan/common.c:641
 bitfill_aligned drivers/video/fbdev/core/sysfillrect.c:54 [inline]
 bitfill_aligned+0x34b/0x410 drivers/video/fbdev/core/sysfillrect.c:25
 sys_fillrect+0x415/0x7a0 drivers/video/fbdev/core/sysfillrect.c:291
 drm_fb_helper_sys_fillrect+0x1c/0x190 drivers/gpu/drm/drm_fb_helper.c:719
 bit_clear_margins+0x2d5/0x4a0 drivers/video/fbdev/core/bitblit.c:232
 fbcon_clear_margins+0x1de/0x240 drivers/video/fbdev/core/fbcon.c:1379
 fbcon_switch+0xd1b/0x1740 drivers/video/fbdev/core/fbcon.c:2361
 redraw_screen+0x2a8/0x770 drivers/tty/vt/vt.c:1008
 fbcon_modechanged+0x5bd/0x780 drivers/video/fbdev/core/fbcon.c:2998
 fbcon_update_vcs+0x3a/0x50 drivers/video/fbdev/core/fbcon.c:3045
 fb_set_var+0xad0/0xd40 drivers/video/fbdev/core/fbmem.c:1056
 do_fb_ioctl+0x390/0x7d0 drivers/video/fbdev/core/fbmem.c:1109
 fb_ioctl+0xdd/0x130 drivers/video/fbdev/core/fbmem.c:1185
 vfs_ioctl fs/ioctl.c:47 [inline]
 ksys_ioctl+0x11a/0x180 fs/ioctl.c:763
 __do_sys_ioctl fs/ioctl.c:772 [inline]
 __se_sys_ioctl fs/ioctl.c:770 [inline]
 __x64_sys_ioctl+0x6f/0xb0 fs/ioctl.c:770
 do_syscall_64+0xf6/0x7d0 arch/x86/entry/common.c:294
 entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x433d29
Code: c4 18 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 0f 83 eb da fc ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007fff33d61508 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00000000004002e0 RCX: 0000000000433d29
RDX: 00000000200001c0 RSI: 0000000000004601 RDI: 0000000000000003
RBP: 00000000006b2018 R08: 0000000000000000 R09: 00000000004002e0
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000401bc0
R13: 0000000000401c50 R14: 0000000000000000 R15: 0000000000000000


Memory state around the buggy address:
 ffffc90009620f00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ffffc90009620f80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>ffffc90009621000: f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9
                   ^
 ffffc90009621080: f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9
 ffffc90009621100: f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9
==================================================================

