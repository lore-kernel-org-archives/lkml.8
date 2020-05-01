Return-Path: <SRS0=nvtT=6P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D57B8C47253
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 08:40:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BA419206D9
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 08:40:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728506AbgEAIkU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 May 2020 04:40:20 -0400
Received: from mail-io1-f70.google.com ([209.85.166.70]:40403 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728401AbgEAIkQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 May 2020 04:40:16 -0400
Received: by mail-io1-f70.google.com with SMTP id p138so4147552iod.7
        for <linux-kernel@vger.kernel.org>; Fri, 01 May 2020 01:40:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=ydSTjQ8oRfzT3QnpNyOOedQWAlaWyLarqFG4Q5BYjhY=;
        b=RfaK7bYGk9R5+tppQBgYNwsocvSwFBll9IHr6+4hi1SS4idjGhZKIvdI6IZvd0+Kju
         It+/EKtpna1oSUyaOjPwTyJakBa9YOLZLEMH188mP9lZAHrybmK2y5csqPP3o/Q6u3qP
         D16JSFup/GOLqdq44nYX6Y1PXRrdpzyebMN67Vt9UScJ6aszVvhPpiz1RXZaMQv/Diaa
         RkprgAy865uDlSRgICf2GjnQscQCUgSdy1cQ7hqXcwDzD8lIIAVvhOdUBbFtRTjaKarY
         L9WC+5KnOUCT2atyxvtzJYkISEsNjHHjwZEIi/SAQkUrK4D8nTiGoNoLns1hGY+EZLtH
         4vxQ==
X-Gm-Message-State: AGi0PuY8eeQDsnFEmrBXT06BIGaTulXmq1oZxLfRtC16B/iiOW0dEKQh
        onaNkgjr09JXpBfXjjPQAiyOD9y/1dNSBwq24wJLBYl0QPng
X-Google-Smtp-Source: APiQypJx5z3SXa+vTDfaSZM29LJbgZqEPAlHgVTcJscnvyyqSckVjwWC+X+PYE+yexdHSqfgfRlDi5ClxFvm8SgJcyZdlzZLrA5B
MIME-Version: 1.0
X-Received: by 2002:a6b:1409:: with SMTP id 9mr2876481iou.65.1588322414073;
 Fri, 01 May 2020 01:40:14 -0700 (PDT)
Date:   Fri, 01 May 2020 01:40:14 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000479d8d05a49221b1@google.com>
Subject: kernel BUG at arch/x86/mm/physaddr.c:LINE! (5)
From:   syzbot <syzbot+0bfda3ade1ee9288a1be@syzkaller.appspotmail.com>
To:     daniel.vetter@ffwll.ch, gregkh@linuxfoundation.org,
        jslaby@suse.com, linux-kernel@vger.kernel.org, nico@fluxnic.net,
        sam@ravnborg.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    6a8b55ed Linux 5.7-rc3
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1447420fe00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1ac152749c11ca54
dashboard link: https://syzkaller.appspot.com/bug?extid=0bfda3ade1ee9288a1be
compiler:       clang version 10.0.0 (https://github.com/llvm/llvm-project/ c2443155a0fb245c8f17f2c1c72b6ea391e86e81)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12db1b80100000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15efcb80100000

The bug was bisected to:

commit 9a98e7a80f95378c9ee0c644705e3b5aa54745f1
Author: Nicolas Pitre <nico@fluxnic.net>
Date:   Sun Mar 29 02:25:11 2020 +0000

    vt: don't use kmalloc() for the unicode screen buffer

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=16bb967fe00000
final crash:    https://syzkaller.appspot.com/x/report.txt?x=15bb967fe00000
console output: https://syzkaller.appspot.com/x/log.txt?x=11bb967fe00000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+0bfda3ade1ee9288a1be@syzkaller.appspotmail.com
Fixes: 9a98e7a80f95 ("vt: don't use kmalloc() for the unicode screen buffer")

------------[ cut here ]------------
kernel BUG at arch/x86/mm/physaddr.c:28!
invalid opcode: 0000 [#1] PREEMPT SMP KASAN
CPU: 1 PID: 7061 Comm: syz-executor995 Not tainted 5.7.0-rc3-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:__phys_addr+0x10e/0x120 arch/x86/mm/physaddr.c:28
Code: 6b 89 80 e1 07 38 c1 0f 8c 75 ff ff ff 48 c7 c7 85 a3 6b 89 e8 f3 a8 7d 00 e9 64 ff ff ff e8 b9 c5 3f 00 0f 0b e8 b2 c5 3f 00 <0f> 0b e8 ab c5 3f 00 0f 0b 66 0f 1f 84 00 00 00 00 00 53 48 89 fb
RSP: 0018:ffffc900016579f8 EFLAGS: 00010093
RAX: ffffffff81339bbe RBX: 0000000000000001 RCX: ffff88808dd5a340
RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000000
RBP: 00000000ffffffea R08: ffffffff81339b2c R09: ffffed1015d27074
R10: ffffed1015d27074 R11: 0000000000000000 R12: ffffc900016c9000
R13: dffffc0000000000 R14: 00004080016c9000 R15: ffffffff83fad568
FS:  0000000001f5d880(0000) GS:ffff8880ae900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000000043e7d0 CR3: 0000000099a6c000 CR4: 00000000001406e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 virt_to_head_page include/linux/mm.h:833 [inline]
 virt_to_cache mm/slab.h:474 [inline]
 kfree+0x60/0x220 mm/slab.c:3749
 vc_do_resize+0x738/0x1ce0 drivers/tty/vt/vt.c:1233
 vt_ioctl+0x3178/0x3eb0 drivers/tty/vt/vt_ioctl.c:901
 tty_ioctl+0xee4/0x15c0 drivers/tty/tty_io.c:2656
 vfs_ioctl fs/ioctl.c:47 [inline]
 ksys_ioctl fs/ioctl.c:763 [inline]
 __do_sys_ioctl fs/ioctl.c:772 [inline]
 __se_sys_ioctl+0xf9/0x160 fs/ioctl.c:770
 do_syscall_64+0xf3/0x1b0 arch/x86/entry/common.c:295
 entry_SYSCALL_64_after_hwframe+0x49/0xb3
RIP: 0033:0x443f99
Code: 18 89 d0 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 0f 83 7b d8 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007ffcf0b9f6f8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00000000004002e0 RCX: 0000000000443f99
RDX: 0000000020000080 RSI: 000000000000560a RDI: 0000000000000004
RBP: 00000000006ce018 R08: 000000000000000d R09: 00000000004002e0
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000401ca0
R13: 0000000000401d30 R14: 0000000000000000 R15: 0000000000000000
Modules linked in:
---[ end trace 7662909635649ec0 ]---
RIP: 0010:__phys_addr+0x10e/0x120 arch/x86/mm/physaddr.c:28
Code: 6b 89 80 e1 07 38 c1 0f 8c 75 ff ff ff 48 c7 c7 85 a3 6b 89 e8 f3 a8 7d 00 e9 64 ff ff ff e8 b9 c5 3f 00 0f 0b e8 b2 c5 3f 00 <0f> 0b e8 ab c5 3f 00 0f 0b 66 0f 1f 84 00 00 00 00 00 53 48 89 fb
RSP: 0018:ffffc900016579f8 EFLAGS: 00010093
RAX: ffffffff81339bbe RBX: 0000000000000001 RCX: ffff88808dd5a340
RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000000
RBP: 00000000ffffffea R08: ffffffff81339b2c R09: ffffed1015d27074
R10: ffffed1015d27074 R11: 0000000000000000 R12: ffffc900016c9000
R13: dffffc0000000000 R14: 00004080016c9000 R15: ffffffff83fad568
FS:  0000000001f5d880(0000) GS:ffff8880ae900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000000043e7d0 CR3: 0000000099a6c000 CR4: 00000000001406e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
