Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A86E6C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 08:54:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7900320723
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 08:54:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388337AbgE0IyS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 04:54:18 -0400
Received: from mail-io1-f70.google.com ([209.85.166.70]:46681 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388169AbgE0IyS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 04:54:18 -0400
Received: by mail-io1-f70.google.com with SMTP id a11so16551113ioq.13
        for <linux-kernel@vger.kernel.org>; Wed, 27 May 2020 01:54:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=ZHI11N//sJVG+YwAmx5GjEx0JsAlT/tR96kXBprpZ4I=;
        b=hx0oTn65AU9cJI3+6WygYqmOcfjVzp+rIXsinNfpzwrUmGVIgZUzwxNn13RkiEIvEW
         LLZacMsC+C+lgIrEICTJyJPrz4fUQVyvaZxwlU7sFdTr2Q3mYOPqITI1Bmj6m8vQNVvN
         opYYZOEonlCFuO0Fo5bexHiuFtMxJdDaupB6AQ0BbL5imfrDyNcxVgDg+dx71NBODS4q
         j+P7Q3HAXVTh6lJPXYVHU455gvXRoPV9zLOeh6zubLID0d+1JwIOLtCouSsaIPG7vVTU
         Cv4i2oKdi2UUa0Xv+YGvE/7/Djr4N822TMMibCYK42WPNlG4MngkmUQt7meLpd/cQPt+
         wqfg==
X-Gm-Message-State: AOAM533B1s5fuFJeuvex6XOi2X35rIe6j+fYIOphn4d3iyp0sYsyTtN+
        Vp3bcFSArTcyryZI4hbwcsNJ0zyjhbHNk6u/mTDWtMJ+E7rw
X-Google-Smtp-Source: ABdhPJxkjDq3z5l9yAW41Kdctcg+iQ2G+i1GAK9TFtWH+NrEpIwhDhfzR7u+epipnIJAcReVJgh71U3Bes+ndI3L//cGDcltqmxO
MIME-Version: 1.0
X-Received: by 2002:a05:6602:2dd4:: with SMTP id l20mr20302859iow.13.1590569657245;
 Wed, 27 May 2020 01:54:17 -0700 (PDT)
Date:   Wed, 27 May 2020 01:54:17 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000006925ea05a69d5bfb@google.com>
Subject: WARNING in binder_transaction_buffer_release (2)
From:   syzbot <syzbot+e113a0b970b7b3f394ba@syzkaller.appspotmail.com>
To:     arve@android.com, christian@brauner.io, devel@driverdev.osuosl.org,
        gregkh@linuxfoundation.org, joel@joelfernandes.org,
        linux-kernel@vger.kernel.org, maco@android.com,
        syzkaller-bugs@googlegroups.com, tkjos@android.com,
        tkjos@google.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    44456565 Merge tag 'io_uring-5.7-2020-05-22' of git://git...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=12990cba100000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b3368ce0cc5f5ace
dashboard link: https://syzkaller.appspot.com/bug?extid=e113a0b970b7b3f394ba
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=165b01e2100000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14706016100000

The bug was bisected to:

commit 44d8047f1d87adc2fd7eccc88533794f6d88c15e
Author: Todd Kjos <tkjos@android.com>
Date:   Tue Aug 28 20:46:25 2018 +0000

    binder: use standard functions to allocate fds

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=134e254a100000
final crash:    https://syzkaller.appspot.com/x/report.txt?x=10ce254a100000
console output: https://syzkaller.appspot.com/x/log.txt?x=174e254a100000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+e113a0b970b7b3f394ba@syzkaller.appspotmail.com
Fixes: 44d8047f1d87 ("binder: use standard functions to allocate fds")

------------[ cut here ]------------
WARNING: CPU: 1 PID: 7071 at drivers/android/binder.c:2348 binder_transaction_buffer_release+0x601/0x8a0 drivers/android/binder.c:2348
Kernel panic - not syncing: panic_on_warn set ...
CPU: 1 PID: 7071 Comm: syz-executor142 Not tainted 5.7.0-rc6-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x188/0x20d lib/dump_stack.c:118
 panic+0x2e3/0x75c kernel/panic.c:221
 __warn.cold+0x2f/0x35 kernel/panic.c:582
 report_bug+0x27b/0x2f0 lib/bug.c:195
 fixup_bug arch/x86/kernel/traps.c:175 [inline]
 fixup_bug arch/x86/kernel/traps.c:170 [inline]
 do_error_trap+0x12b/0x220 arch/x86/kernel/traps.c:267
 do_invalid_op+0x32/0x40 arch/x86/kernel/traps.c:286
 invalid_op+0x23/0x30 arch/x86/entry/entry_64.S:1027
RIP: 0010:binder_transaction_buffer_release+0x601/0x8a0 drivers/android/binder.c:2348
Code: bb fd 31 ff 41 89 c5 89 c6 e8 bb ff 81 fb 45 85 ed 0f 85 f9 4b 01 00 48 8d 45 40 48 89 44 24 28 e9 fa fa ff ff e8 2f fe 81 fb <0f> 0b e9 87 fc ff ff e8 23 fe 81 fb 4c 8b 44 24 20 48 89 d8 45 31
RSP: 0018:ffffc900018e7620 EFLAGS: 00010293
RAX: ffff8880a12da5c0 RBX: 0000000000000058 RCX: 1ffff1101425b55b
RDX: 0000000000000000 RSI: ffffffff85f136f1 RDI: ffff88809db1c048
RBP: ffff88809290a080 R08: ffff8880a12da5c0 R09: fffff5200031cee7
R10: ffffc900018e7737 R11: fffff5200031cee6 R12: ffff88809187a040
R13: 0000000000000060 R14: ffff88809db1c000 R15: 0000000000000060
 binder_transaction+0x146d/0x6500 drivers/android/binder.c:3486
 binder_thread_write+0x818/0x2560 drivers/android/binder.c:3796
 binder_ioctl_write_read drivers/android/binder.c:4847 [inline]
 binder_ioctl+0x1008/0x1862 drivers/android/binder.c:5024
 vfs_ioctl fs/ioctl.c:47 [inline]
 ksys_ioctl+0x11a/0x180 fs/ioctl.c:771
 __do_sys_ioctl fs/ioctl.c:780 [inline]
 __se_sys_ioctl fs/ioctl.c:778 [inline]
 __x64_sys_ioctl+0x6f/0xb0 fs/ioctl.c:778
 do_syscall_64+0xf6/0x7d0 arch/x86/entry/common.c:295
 entry_SYSCALL_64_after_hwframe+0x49/0xb3
RIP: 0033:0x44b749
Code: e8 5c d9 02 00 48 83 c4 18 c3 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 0f 83 bb d0 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007f65c624dce8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00000000006ddc48 RCX: 000000000044b749
RDX: 0000000020000540 RSI: 00000000c0306201 RDI: 0000000000000003
RBP: 00000000006ddc40 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000006ddc4c
R13: 00007ffd9783511f R14: 00007f65c624e9c0 R15: 00000000006ddc4c
Kernel Offset: disabled
Rebooting in 86400 seconds..


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
