Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31DD2C4BA24
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 08:39:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 057C82468D
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 08:39:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728629AbgB0IjO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 03:39:14 -0500
Received: from mail-il1-f199.google.com ([209.85.166.199]:41198 "EHLO
        mail-il1-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728440AbgB0IjO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 03:39:14 -0500
Received: by mail-il1-f199.google.com with SMTP id k9so4379743ili.8
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2020 00:39:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=q0lYrwRVdnUGvEQaooBsjU/1Z2nf/gS3i3kKTs6syaQ=;
        b=VGlvLR5LW9riW1la57bxDIJ+kmm4TKR96JavvG+n27uSnlCAe/uY/DMgw7R1+Bka+i
         cQF1tIcMLv4BNxH9rEzeMu3bm/zlfMQfI3CZh9yhTfTkWvBgkRSLxLBDubnVdHNjIP+J
         8doQrhFv9Zw7che1xyeAUx1HO6v1tl4y1dQupfgPFF8M5KpQ0xZguetpnpd6fHCPJj3B
         3DA4eryccfDyO/9STlHRSkmlvRRDnYmtkYEekM7bN43eAiC0WiShRjsld+BOGMcVsYuF
         F+bk9G+048lYAkOsD97yulNN5GVR0pzcNHDHGuPJkP5F+iuP/dhJei7SaxSrrY9NdhiL
         y01g==
X-Gm-Message-State: APjAAAWRwwTl86rvJWkq1RxVCBmZLWaRVT4VYdUIfca5Dc1EGQBYSfK5
        tcdXhGg5m5aMdKbI7/8NLkUFrD4QZ8jAtVgcxX7hj1NtZNj+
X-Google-Smtp-Source: APXvYqxfop5M8wyTCk9XQt+rVgeUBvNS5e3KyaD3fne1TJWWtzkZnqJiR5uT/yFrLQdgyC1q/PAjNsVFf3UHIR/tpNoUXsXbYEUW
MIME-Version: 1.0
X-Received: by 2002:a92:8dc3:: with SMTP id w64mr3460034ill.68.1582792752123;
 Thu, 27 Feb 2020 00:39:12 -0800 (PST)
Date:   Thu, 27 Feb 2020 00:39:12 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000be57bf059f8aa7b9@google.com>
Subject: possible deadlock in tty_unthrottle
From:   syzbot <syzbot+26183d9746e62da329b8@syzkaller.appspotmail.com>
To:     gregkh@linuxfoundation.org, jslaby@suse.com,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    f8788d86 Linux 5.6-rc3
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1102d22de00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5d2e033af114153f
dashboard link: https://syzkaller.appspot.com/bug?extid=26183d9746e62da329b8
compiler:       clang version 10.0.0 (https://github.com/llvm/llvm-project/ c2443155a0fb245c8f17f2c1c72b6ea391e86e81)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+26183d9746e62da329b8@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
5.6.0-rc3-syzkaller #0 Not tainted
------------------------------------------------------
syz-executor.4/20336 is trying to acquire lock:
ffff8880a2e952a0 (&tty->termios_rwsem){++++}, at: tty_unthrottle+0x22/0x100 drivers/tty/tty_ioctl.c:136

but task is already holding lock:
ffffffff89462e70 (sel_lock){+.+.}, at: paste_selection+0x118/0x470 drivers/tty/vt/selection.c:374

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #2 (sel_lock){+.+.}:
       lock_acquire+0x154/0x250 kernel/locking/lockdep.c:4484
       __mutex_lock_common+0x16e/0x2f30 kernel/locking/mutex.c:956
       __mutex_lock kernel/locking/mutex.c:1103 [inline]
       mutex_lock_nested+0x1b/0x30 kernel/locking/mutex.c:1118
       set_selection_kernel+0x3b8/0x18a0 drivers/tty/vt/selection.c:217
       set_selection_user+0x63/0x80 drivers/tty/vt/selection.c:181
       tioclinux+0x103/0x530 drivers/tty/vt/vt.c:3050
       vt_ioctl+0x3f1/0x3a30 drivers/tty/vt/vt_ioctl.c:364
       tty_ioctl+0xee6/0x15c0 drivers/tty/tty_io.c:2660
       vfs_ioctl fs/ioctl.c:47 [inline]
       ksys_ioctl fs/ioctl.c:763 [inline]
       __do_sys_ioctl fs/ioctl.c:772 [inline]
       __se_sys_ioctl+0x113/0x190 fs/ioctl.c:770
       __x64_sys_ioctl+0x7b/0x90 fs/ioctl.c:770
       do_syscall_64+0xf7/0x1c0 arch/x86/entry/common.c:294
       entry_SYSCALL_64_after_hwframe+0x49/0xbe

-> #1 (console_lock){+.+.}:
       lock_acquire+0x154/0x250 kernel/locking/lockdep.c:4484
       console_lock+0x46/0x70 kernel/printk/printk.c:2289
       con_flush_chars+0x50/0x650 drivers/tty/vt/vt.c:3223
       n_tty_write+0xeae/0x1200 drivers/tty/n_tty.c:2350
       do_tty_write drivers/tty/tty_io.c:962 [inline]
       tty_write+0x5a1/0x950 drivers/tty/tty_io.c:1046
       __vfs_write+0xb8/0x740 fs/read_write.c:494
       vfs_write+0x270/0x580 fs/read_write.c:558
       ksys_write+0x117/0x220 fs/read_write.c:611
       __do_sys_write fs/read_write.c:623 [inline]
       __se_sys_write fs/read_write.c:620 [inline]
       __x64_sys_write+0x7b/0x90 fs/read_write.c:620
       do_syscall_64+0xf7/0x1c0 arch/x86/entry/common.c:294
       entry_SYSCALL_64_after_hwframe+0x49/0xbe

-> #0 (&tty->termios_rwsem){++++}:
       check_prev_add kernel/locking/lockdep.c:2475 [inline]
       check_prevs_add kernel/locking/lockdep.c:2580 [inline]
       validate_chain+0x1507/0x7be0 kernel/locking/lockdep.c:2970
       __lock_acquire+0xc5a/0x1bc0 kernel/locking/lockdep.c:3954
       lock_acquire+0x154/0x250 kernel/locking/lockdep.c:4484
       down_write+0x57/0x140 kernel/locking/rwsem.c:1534
       tty_unthrottle+0x22/0x100 drivers/tty/tty_ioctl.c:136
       mkiss_receive_buf+0x12aa/0x1340 drivers/net/hamradio/mkiss.c:902
       tty_ldisc_receive_buf+0x12f/0x170 drivers/tty/tty_buffer.c:465
       paste_selection+0x346/0x470 drivers/tty/vt/selection.c:389
       tioclinux+0x121/0x530 drivers/tty/vt/vt.c:3055
       vt_ioctl+0x3f1/0x3a30 drivers/tty/vt/vt_ioctl.c:364
       tty_ioctl+0xee6/0x15c0 drivers/tty/tty_io.c:2660
       vfs_ioctl fs/ioctl.c:47 [inline]
       ksys_ioctl fs/ioctl.c:763 [inline]
       __do_sys_ioctl fs/ioctl.c:772 [inline]
       __se_sys_ioctl+0x113/0x190 fs/ioctl.c:770
       __x64_sys_ioctl+0x7b/0x90 fs/ioctl.c:770
       do_syscall_64+0xf7/0x1c0 arch/x86/entry/common.c:294
       entry_SYSCALL_64_after_hwframe+0x49/0xbe

other info that might help us debug this:

Chain exists of:
  &tty->termios_rwsem --> console_lock --> sel_lock

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(sel_lock);
                               lock(console_lock);
                               lock(sel_lock);
  lock(&tty->termios_rwsem);

 *** DEADLOCK ***

3 locks held by syz-executor.4/20336:
 #0: ffff8880a2e95090 (&tty->ldisc_sem){++++}, at: tty_ldisc_ref_wait+0x25/0x70 drivers/tty/tty_ldisc.c:267
 #1: ffff888097ac10a8 (&buf->lock){+.+.}, at: tty_buffer_lock_exclusive+0x33/0x40 drivers/tty/tty_buffer.c:61
 #2: ffffffff89462e70 (sel_lock){+.+.}, at: paste_selection+0x118/0x470 drivers/tty/vt/selection.c:374

stack backtrace:
CPU: 1 PID: 20336 Comm: syz-executor.4 Not tainted 5.6.0-rc3-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x1fb/0x318 lib/dump_stack.c:118
 print_circular_bug+0xc3f/0xe70 kernel/locking/lockdep.c:1684
 check_noncircular+0x206/0x3a0 kernel/locking/lockdep.c:1808
 check_prev_add kernel/locking/lockdep.c:2475 [inline]
 check_prevs_add kernel/locking/lockdep.c:2580 [inline]
 validate_chain+0x1507/0x7be0 kernel/locking/lockdep.c:2970
 __lock_acquire+0xc5a/0x1bc0 kernel/locking/lockdep.c:3954
 lock_acquire+0x154/0x250 kernel/locking/lockdep.c:4484
 down_write+0x57/0x140 kernel/locking/rwsem.c:1534
 tty_unthrottle+0x22/0x100 drivers/tty/tty_ioctl.c:136
 mkiss_receive_buf+0x12aa/0x1340 drivers/net/hamradio/mkiss.c:902
 tty_ldisc_receive_buf+0x12f/0x170 drivers/tty/tty_buffer.c:465
 paste_selection+0x346/0x470 drivers/tty/vt/selection.c:389
 tioclinux+0x121/0x530 drivers/tty/vt/vt.c:3055
 vt_ioctl+0x3f1/0x3a30 drivers/tty/vt/vt_ioctl.c:364
 tty_ioctl+0xee6/0x15c0 drivers/tty/tty_io.c:2660
 vfs_ioctl fs/ioctl.c:47 [inline]
 ksys_ioctl fs/ioctl.c:763 [inline]
 __do_sys_ioctl fs/ioctl.c:772 [inline]
 __se_sys_ioctl+0x113/0x190 fs/ioctl.c:770
 __x64_sys_ioctl+0x7b/0x90 fs/ioctl.c:770
 do_syscall_64+0xf7/0x1c0 arch/x86/entry/common.c:294
 entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x45c449
Code: ad b6 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 0f 83 7b b6 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007f0ac45bac78 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f0ac45bb6d4 RCX: 000000000045c449
RDX: 0000000020000140 RSI: 000000000000541c RDI: 0000000000000003
RBP: 000000000076bf20 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000ffffffff
R13: 0000000000000571 R14: 00000000004c7c29 R15: 000000000076bf2c


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
