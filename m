Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCF78C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 04:56:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BE73820DD4
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 04:56:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728291AbgFSE4R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 00:56:17 -0400
Received: from mail-io1-f70.google.com ([209.85.166.70]:54977 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725788AbgFSE4Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 00:56:16 -0400
Received: by mail-io1-f70.google.com with SMTP id t23so5855341iog.21
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jun 2020 21:56:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=kVV7AQIUbbYdGbVlGXkgoxxP+MlYua7sKpJCqtMOVU4=;
        b=Fd1254y3ug3IxkQCyjGp6iXud4hewUKyyVB673DTKKTWlbd5FureOmeftFrkk6+o1f
         zGovpSQ//qsqqLWmHZcew7KfAmtf2/HOi9z7fkzmVQByaQJ3NR+O2z5MHGHpI6nrqVmi
         +I0TIyylB4s5cjhl5JnV5PtpqTYmkSwYuf5r7J4JgE8QxVpotJhef2yOBWpvKvw2KtZD
         Q0HfSEsSR/SrpzZgatza4Qjb/BUoyQc77pJlLIdhtse82EvfAo5AlPNsEB6W2EitG5mN
         rK4Sq3BcF2EBR3IUen1ef10NqEqU6ko/pyBWreFSJLoFwwsoYq5Zb5fHrz4/mlg7FVIv
         uneQ==
X-Gm-Message-State: AOAM5304dMUtNAmOwTFjwaiSdf9fBqV7k+K/N0u9pOkUAr+VASWW1Y/8
        U9PZur+cybrQpWD6jMaFq1E6X38IpnYIFthgzKWiW4r5Kone
X-Google-Smtp-Source: ABdhPJwdNZQyzkPUlSgTaQiywiDsztu4+RdFjl3U3aswkL4CZhfKr0IA6BTtV1XwM3rxXzkhoJ+yY9MmVKDBru/N5YVV3R1a/wEA
MIME-Version: 1.0
X-Received: by 2002:a02:ab94:: with SMTP id t20mr2096716jan.13.1592542575012;
 Thu, 18 Jun 2020 21:56:15 -0700 (PDT)
Date:   Thu, 18 Jun 2020 21:56:15 -0700
In-Reply-To: <0000000000001d3ff605995c23d6@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000792f4f05a868b670@google.com>
Subject: Re: BUG: unable to handle kernel paging request in sys_imageblit
From:   syzbot <syzbot+33f89a9a6b6acd893b11@syzkaller.appspotmail.com>
To:     b.zolnierkie@samsung.com, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has found a reproducer for the following crash on:

HEAD commit:    435faf5c Merge tag 'riscv-for-linus-5.8-mw0' of git://git...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1768c725100000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3dbb617b9c2a5bdf
dashboard link: https://syzkaller.appspot.com/bug?extid=33f89a9a6b6acd893b11
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
userspace arch: i386
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11f3f485100000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+33f89a9a6b6acd893b11@syzkaller.appspotmail.com

BUG: unable to handle page fault for address: fffff520013df608
#PF: supervisor read access in kernel mode
#PF: error_code(0x0000) - not-present page
PGD 7ffcd067 P4D 7ffcd067 PUD 2c920067 PMD 29858067 PTE 0
Oops: 0000 [#1] PREEMPT SMP KASAN
CPU: 2 PID: 8457 Comm: syz-executor.0 Not tainted 5.7.0-syzkaller #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.12.0-59-gc9ba5276e321-prebuilt.qemu.org 04/01/2014
RIP: 0010:fast_imageblit drivers/video/fbdev/core/sysimgblt.c:229 [inline]
RIP: 0010:sys_imageblit+0x616/0x1240 drivers/video/fbdev/core/sysimgblt.c:275
Code: 0f b6 14 28 48 89 f8 83 e0 07 83 c0 03 38 d0 7c 08 84 d2 0f 85 5c 0b 00 00 8b 44 24 20 4d 8d 77 04 4c 89 fa 48 c1 ea 03 23 07 <42> 0f b6 0c 2a 4c 89 fa 83 e2 07 33 44 24 14 83 c2 03 38 ca 7c 08
RSP: 0018:ffffc90001867578 EFLAGS: 00010246
RAX: 0000000000000000 RBX: ffff888023ac8402 RCX: ffffffff88786a40
RDX: 1ffff920013df608 RSI: ffffffff83c3bbbc RDI: ffffffff88786a40
RBP: 0000000000000fef R08: ffff888029cf8040 R09: 0000000000000001
R10: ffffffff8a8b743f R11: fffffbfff1516e87 R12: 0000000000000007
R13: dffffc0000000000 R14: ffffc90009efb044 R15: ffffc90009efb040
FS:  0000000000000000(0000) GS:ffff88802d000000(0063) knlGS:00000000f7f0fb40
CS:  0010 DS: 002b ES: 002b CR0: 0000000080050033
CR2: fffff520013df608 CR3: 000000001b812000 CR4: 0000000000340ee0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 drm_fb_helper_sys_imageblit+0x1c/0x180 drivers/gpu/drm/drm_fb_helper.c:747
 bit_putcs_unaligned drivers/video/fbdev/core/bitblit.c:139 [inline]
 bit_putcs+0x8d0/0xd60 drivers/video/fbdev/core/bitblit.c:188
 fbcon_putcs+0x345/0x3f0 drivers/video/fbdev/core/fbcon.c:1362
 do_update_region+0x398/0x630 drivers/tty/vt/vt.c:683
 invert_screen+0x2a7/0x600 drivers/tty/vt/vt.c:800
 highlight drivers/tty/vt/selection.c:57 [inline]
 clear_selection drivers/tty/vt/selection.c:84 [inline]
 clear_selection+0x55/0x70 drivers/tty/vt/selection.c:80
 vc_do_resize+0xff3/0x1370 drivers/tty/vt/vt.c:1230
 fbcon_do_set_font+0x4a0/0x950 drivers/video/fbdev/core/fbcon.c:2608
 fbcon_set_font+0x732/0x870 drivers/video/fbdev/core/fbcon.c:2705
 con_font_set drivers/tty/vt/vt.c:4571 [inline]
 con_font_op+0xd65/0x1160 drivers/tty/vt/vt.c:4636
 compat_kdfontop_ioctl drivers/tty/vt/vt_ioctl.c:1151 [inline]
 vt_compat_ioctl+0x23a/0x6c0 drivers/tty/vt/vt_ioctl.c:1213
 tty_compat_ioctl+0x19c/0x410 drivers/tty/tty_io.c:2847
 __do_compat_sys_ioctl fs/ioctl.c:865 [inline]
 __se_compat_sys_ioctl fs/ioctl.c:816 [inline]
 __ia32_compat_sys_ioctl+0x23d/0x2b0 fs/ioctl.c:816
 do_syscall_32_irqs_on arch/x86/entry/common.c:337 [inline]
 do_fast_syscall_32+0x270/0xe90 arch/x86/entry/common.c:396
 entry_SYSENTER_compat+0x70/0x7f arch/x86/entry/entry_64_compat.S:139
Modules linked in:
CR2: fffff520013df608
---[ end trace fbceb2e52f6d552c ]---
RIP: 0010:fast_imageblit drivers/video/fbdev/core/sysimgblt.c:229 [inline]
RIP: 0010:sys_imageblit+0x616/0x1240 drivers/video/fbdev/core/sysimgblt.c:275
Code: 0f b6 14 28 48 89 f8 83 e0 07 83 c0 03 38 d0 7c 08 84 d2 0f 85 5c 0b 00 00 8b 44 24 20 4d 8d 77 04 4c 89 fa 48 c1 ea 03 23 07 <42> 0f b6 0c 2a 4c 89 fa 83 e2 07 33 44 24 14 83 c2 03 38 ca 7c 08
RSP: 0018:ffffc90001867578 EFLAGS: 00010246
RAX: 0000000000000000 RBX: ffff888023ac8402 RCX: ffffffff88786a40
RDX: 1ffff920013df608 RSI: ffffffff83c3bbbc RDI: ffffffff88786a40
RBP: 0000000000000fef R08: ffff888029cf8040 R09: 0000000000000001
R10: ffffffff8a8b743f R11: fffffbfff1516e87 R12: 0000000000000007
R13: dffffc0000000000 R14: ffffc90009efb044 R15: ffffc90009efb040
FS:  0000000000000000(0000) GS:ffff88802d000000(0063) knlGS:00000000f7f0fb40
CS:  0010 DS: 002b ES: 002b CR0: 0000000080050033
CR2: fffff520013df608 CR3: 000000001b812000 CR4: 0000000000340ee0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400

