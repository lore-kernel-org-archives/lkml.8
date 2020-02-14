Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3CA9C2BA83
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 17:37:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD02A2168B
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 17:37:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390710AbgBNRhS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 12:37:18 -0500
Received: from mail-il1-f199.google.com ([209.85.166.199]:42111 "EHLO
        mail-il1-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390612AbgBNRhQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 12:37:16 -0500
Received: by mail-il1-f199.google.com with SMTP id s13so8190715ili.9
        for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2020 09:37:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=gOMw5WSI6uBq6uEWNfGFgc8NIaIHo411fneSXFMRfCA=;
        b=ESJxiEVxItUcLvf/tEIiE73X4ec+W6sFSJHsnwMbmMzTkVJbxu+F3jbilBi0JWIUJD
         4zyrGRxcJI0JQgyVttC98QzhBYbGOSKbB6hI/VcK+aZCgIK8EVJ/6gHXPfWhGP7vqOal
         tPylwyDLSE1mnJA+BMYehFmQyzyNeOO0I7S7C2GZ+qhMWy3aYrNVSWaek3bo6dY9qBYj
         Wu9aAGQSyLWaSgeG/YK/Ol0kdQWLZ7Cb7igmTpK4lJiUpmDjq8eMaZFa1+njVfmXq95+
         /E+okavtpPtAInBVIIsEw6PdzQ1TsJMbIGk9HBF/hcla7tizxbTMfkE/0fLkxDFPMh5I
         zVPg==
X-Gm-Message-State: APjAAAV2wlYElXgAO9bHe93xRJgnTmbr45Cj9EfgxRGKc+3hAogdys0o
        Vo2GWLjea4ijm4BQStsQAZ3/Yx6W7TGAky3jyqohLrL2KQSP
X-Google-Smtp-Source: APXvYqxdtEw8JEouC9e0fzkSg3MRf5uz8Al1+TDJohN2sIm1QXVfxpay0ZlVjrIWZiGMKQnz4If3aaFmNxVudvrO2CeYflvs50Ix
MIME-Version: 1.0
X-Received: by 2002:a92:409d:: with SMTP id d29mr3927439ill.66.1581701834425;
 Fri, 14 Feb 2020 09:37:14 -0800 (PST)
Date:   Fri, 14 Feb 2020 09:37:14 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000fb4c32059e8ca78c@google.com>
Subject: possible deadlock in n_tty_receive_buf_common
From:   syzbot <syzbot+41a045bca47dde704c4c@syzkaller.appspotmail.com>
To:     gregkh@linuxfoundation.org, jslaby@suse.com,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    9f01828e Add linux-next specific files for 20200214
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=119f6c29e00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ffb2752ee30931a0
dashboard link: https://syzkaller.appspot.com/bug?extid=41a045bca47dde704c4c
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1172fc09e00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15a3a431e00000

Bisection is inconclusive: the bug happens on the oldest tested release.

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=106596b5e00000
final crash:    https://syzkaller.appspot.com/x/report.txt?x=126596b5e00000
console output: https://syzkaller.appspot.com/x/log.txt?x=146596b5e00000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+41a045bca47dde704c4c@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
5.6.0-rc1-next-20200214-syzkaller #0 Not tainted
------------------------------------------------------
syz-executor167/9787 is trying to acquire lock:
ffff88809a1872a0 (&tty->termios_rwsem){++++}, at: n_tty_receive_buf_common+0x8a/0x2b70 drivers/tty/n_tty.c:1705

but task is already holding lock:
ffffffff8a1414c0 (sel_lock){+.+.}, at: paste_selection+0x15a/0x4d0 drivers/tty/vt/selection.c:374

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #2 (sel_lock){+.+.}:
       __mutex_lock_common kernel/locking/mutex.c:956 [inline]
       __mutex_lock+0x156/0x13c0 kernel/locking/mutex.c:1103
       mutex_lock_nested+0x16/0x20 kernel/locking/mutex.c:1118
       set_selection_kernel+0x39d/0x13d0 drivers/tty/vt/selection.c:217
       set_selection_user+0x95/0xd9 drivers/tty/vt/selection.c:181
       tioclinux+0x11c/0x480 drivers/tty/vt/vt.c:3050
       vt_ioctl+0x1a41/0x26c0 drivers/tty/vt/vt_ioctl.c:364
       tty_ioctl+0xa37/0x14f0 drivers/tty/tty_io.c:2660
       vfs_ioctl fs/ioctl.c:47 [inline]
       ksys_ioctl+0x123/0x180 fs/ioctl.c:763
       __do_sys_ioctl fs/ioctl.c:772 [inline]
       __se_sys_ioctl fs/ioctl.c:770 [inline]
       __x64_sys_ioctl+0x73/0xb0 fs/ioctl.c:770
       do_syscall_64+0xfa/0x790 arch/x86/entry/common.c:294
       entry_SYSCALL_64_after_hwframe+0x49/0xbe

-> #1 (console_lock){+.+.}:
       console_lock+0x47/0x80 kernel/printk/printk.c:2286
       con_flush_chars drivers/tty/vt/vt.c:3223 [inline]
       con_flush_chars+0x3d/0xa0 drivers/tty/vt/vt.c:3215
       n_tty_write+0xc85/0x1080 drivers/tty/n_tty.c:2350
       do_tty_write drivers/tty/tty_io.c:962 [inline]
       tty_write+0x496/0x7f0 drivers/tty/tty_io.c:1046
       __vfs_write+0x8a/0x110 fs/read_write.c:494
       vfs_write+0x268/0x5d0 fs/read_write.c:558
       ksys_write+0x14f/0x290 fs/read_write.c:611
       __do_sys_write fs/read_write.c:623 [inline]
       __se_sys_write fs/read_write.c:620 [inline]
       __x64_sys_write+0x73/0xb0 fs/read_write.c:620
       do_syscall_64+0xfa/0x790 arch/x86/entry/common.c:294
       entry_SYSCALL_64_after_hwframe+0x49/0xbe

-> #0 (&tty->termios_rwsem){++++}:
       check_prev_add kernel/locking/lockdep.c:2481 [inline]
       check_prevs_add kernel/locking/lockdep.c:2586 [inline]
       validate_chain kernel/locking/lockdep.c:3203 [inline]
       __lock_acquire+0x29cd/0x6320 kernel/locking/lockdep.c:4190
       lock_acquire+0x190/0x410 kernel/locking/lockdep.c:4720
       down_read+0x95/0x440 kernel/locking/rwsem.c:1492
       n_tty_receive_buf_common+0x8a/0x2b70 drivers/tty/n_tty.c:1705
       n_tty_receive_buf2+0x34/0x40 drivers/tty/n_tty.c:1777
       tty_ldisc_receive_buf+0xad/0x1c0 drivers/tty/tty_buffer.c:461
       paste_selection+0x1ff/0x4d0 drivers/tty/vt/selection.c:389
       tioclinux+0x133/0x480 drivers/tty/vt/vt.c:3055
       vt_ioctl+0x1a41/0x26c0 drivers/tty/vt/vt_ioctl.c:364
       tty_ioctl+0xa37/0x14f0 drivers/tty/tty_io.c:2660
       vfs_ioctl fs/ioctl.c:47 [inline]
       ksys_ioctl+0x123/0x180 fs/ioctl.c:763
       __do_sys_ioctl fs/ioctl.c:772 [inline]
       __se_sys_ioctl fs/ioctl.c:770 [inline]
       __x64_sys_ioctl+0x73/0xb0 fs/ioctl.c:770
       do_syscall_64+0xfa/0x790 arch/x86/entry/common.c:294
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

3 locks held by syz-executor167/9787:
 #0: ffff88809a187090 (&tty->ldisc_sem){++++}, at: ldsem_down_read+0x33/0x40 drivers/tty/tty_ldsem.c:340
 #1: ffff8880aa5be0a8 (&buf->lock){+.+.}, at: tty_buffer_lock_exclusive+0x30/0x40 drivers/tty/tty_buffer.c:61
 #2: ffffffff8a1414c0 (sel_lock){+.+.}, at: paste_selection+0x15a/0x4d0 drivers/tty/vt/selection.c:374

stack backtrace:
CPU: 1 PID: 9787 Comm: syz-executor167 Not tainted 5.6.0-rc1-next-20200214-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x197/0x210 lib/dump_stack.c:118
 print_circular_bug.isra.0.cold+0x163/0x172 kernel/locking/lockdep.c:1688
 check_noncircular+0x32e/0x3e0 kernel/locking/lockdep.c:1812
 check_prev_add kernel/locking/lockdep.c:2481 [inline]
 check_prevs_add kernel/locking/lockdep.c:2586 [inline]
 validate_chain kernel/locking/lockdep.c:3203 [inline]
 __lock_acquire+0x29cd/0x6320 kernel/locking/lockdep.c:4190
 lock_acquire+0x190/0x410 kernel/locking/lockdep.c:4720
 down_read+0x95/0x440 kernel/locking/rwsem.c:1492
 n_tty_receive_buf_common+0x8a/0x2b70 drivers/tty/n_tty.c:1705
 n_tty_receive_buf2+0x34/0x40 drivers/tty/n_tty.c:1777
 tty_ldisc_receive_buf+0xad/0x1c0 drivers/tty/tty_buffer.c:461
 paste_selection+0x1ff/0x4d0 drivers/tty/vt/selection.c:389
 tioclinux+0x133/0x480 drivers/tty/vt/vt.c:3055
 vt_ioctl+0x1a41/0x26c0 drivers/tty/vt/vt_ioctl.c:364
 tty_ioctl+0xa37/0x14f0 drivers/tty/tty_io.c:2660
 vfs_ioctl fs/ioctl.c:47 [inline]
 ksys_ioctl+0x123/0x180 fs/ioctl.c:763
 __do_sys_ioctl fs/ioctl.c:772 [inline]
 __se_sys_ioctl fs/ioctl.c:770 [inline]
 __x64_sys_ioctl+0x73/0xb0 fs/ioctl.c:770
 do_syscall_64+0xfa/0x790 arch/x86/entry/common.c:294
 entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x440219
Code: 18 89 d0 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 0f 83 5b 14 fc ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007ffe5133a1c8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00000000004002c8 RCX: 0000000000440219
RDX: 0000000020000040 RSI: 000000000000541c RDI: 0000000000000004
RBP: 00000000006ca018 R08: 000000000000000d R09: 00000000004002c8
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000401b00
R13: 0000000000401b90 R14: 0000000000000000 R15: 000000000


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
