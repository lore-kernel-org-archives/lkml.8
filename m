Return-Path: <SRS0=29cB=4T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72456C3F2D2
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 05:16:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 348E524677
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 05:16:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726436AbgCBFQM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 00:16:12 -0500
Received: from mail-il1-f200.google.com ([209.85.166.200]:47313 "EHLO
        mail-il1-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725781AbgCBFQL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 00:16:11 -0500
Received: by mail-il1-f200.google.com with SMTP id a4so8465834ili.14
        for <linux-kernel@vger.kernel.org>; Sun, 01 Mar 2020 21:16:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=b6lliFZi32kqJz9gKyg5UYzoGZc+Ouls9FFZfjbKEgs=;
        b=C9fa/RLhFeJBm3fev/EyWEDrYvr3nNnCGFeDvLVR5FPzgCT6QUt9fM1+PYINHTVzRG
         suhobOIYBHRkRL061ZlTTaIwwP8bTf3HEMhlDKJDpzmrRGB8KFumCP++QkjWU73vp7ri
         8PMZecx+WrUJdZcic/sXMubrBPe1gahKlAR8BnETkvRBdarTjo/oKaLAgY4E52YFoerD
         rg2CwLr2FVO32tDq7LI+mYGs5QMIyhcwtJ4FqnuCj5upwF5TV0d4wn0IlViHm+/HSwpR
         OuawHiAxCLZ0EesRgfXzMs6HN97cLZRUV1wR/3jSk2j5OGv+xYKUh256eZ8Y2LVxqnMS
         gpYA==
X-Gm-Message-State: APjAAAU7hxJi746NufVkXAcute2Q3WnyDAjTxylyH2DQ1ResGijYzu7Y
        /M16VQk+dMXrWk0+rJFzXan3Otr/7n22tAn91t5MvaAsztgg
X-Google-Smtp-Source: APXvYqy+2ucR4E2X7IdrMTCwq/prLec83Tty5f6RTpnFcxxJIVeXjkDYrnwbK/rI7K+LF613XMowy59VwFRdyhlpE5DV73f3sAe3
MIME-Version: 1.0
X-Received: by 2002:a5d:878c:: with SMTP id f12mr11846104ion.164.1583126169525;
 Sun, 01 Mar 2020 21:16:09 -0800 (PST)
Date:   Sun, 01 Mar 2020 21:16:09 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f827d5059fd848d9@google.com>
Subject: INFO: task hung in vt_resize
From:   syzbot <syzbot+7dd2cfed71fe7276d543@syzkaller.appspotmail.com>
To:     daniel.vetter@ffwll.ch, ghalat@redhat.com,
        gregkh@linuxfoundation.org, jslaby@suse.com,
        linux-kernel@vger.kernel.org, lukas@wunner.de, nico@fluxnic.net,
        okash.khawaja@gmail.com, sam@ravnborg.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    f8788d86 Linux 5.6-rc3
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=157758f9e00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=9833e26bab355358
dashboard link: https://syzkaller.appspot.com/bug?extid=7dd2cfed71fe7276d543
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+7dd2cfed71fe7276d543@syzkaller.appspotmail.com

INFO: task syz-executor.3:19080 blocked for more than 143 seconds.
      Not tainted 5.6.0-rc3-syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
syz-executor.3  D28376 19080   9706 0x00000004
Call Trace:
 context_switch kernel/sched/core.c:3380 [inline]
 __schedule+0x934/0x1f90 kernel/sched/core.c:4080
 schedule+0xdc/0x2b0 kernel/sched/core.c:4154
 schedule_timeout+0x717/0xc50 kernel/time/timer.c:1871
 __down_common kernel/locking/semaphore.c:220 [inline]
 __down+0x176/0x2c0 kernel/locking/semaphore.c:237
 down+0x64/0x90 kernel/locking/semaphore.c:61
 console_lock+0x29/0x80 kernel/printk/printk.c:2289
 vt_resize+0x48/0xf0 drivers/tty/vt/vt.c:1335
 tiocswinsz drivers/tty/tty_io.c:2281 [inline]
 tty_ioctl+0x78a/0x14f0 drivers/tty/tty_io.c:2580
 vfs_ioctl fs/ioctl.c:47 [inline]
 ksys_ioctl+0x123/0x180 fs/ioctl.c:763
 __do_sys_ioctl fs/ioctl.c:772 [inline]
 __se_sys_ioctl fs/ioctl.c:770 [inline]
 __x64_sys_ioctl+0x73/0xb0 fs/ioctl.c:770
 do_syscall_64+0xfa/0x790 arch/x86/entry/common.c:294
 entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x45c449
Code: ad b6 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 0f 83 7b b6 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007f274a6bbc78 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f274a6bc6d4 RCX: 000000000045c449
RDX: 0000000020000200 RSI: 0000000000005414 RDI: 0000000000000003
RBP: 000000000076bfc0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000ffffffff
R13: 000000000000058d R14: 00000000004c7e1b R15: 000000000076bfcc
INFO: task syz-executor.1:19126 blocked for more than 143 seconds.
      Not tainted 5.6.0-rc3-syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
syz-executor.1  D26248 19126   9695 0x00004004
Call Trace:
 context_switch kernel/sched/core.c:3380 [inline]
 __schedule+0x934/0x1f90 kernel/sched/core.c:4080
 schedule+0xdc/0x2b0 kernel/sched/core.c:4154
 schedule_timeout+0x717/0xc50 kernel/time/timer.c:1871
 __down_common kernel/locking/semaphore.c:220 [inline]
 __down+0x176/0x2c0 kernel/locking/semaphore.c:237
 down+0x64/0x90 kernel/locking/semaphore.c:61
 console_lock+0x29/0x80 kernel/printk/printk.c:2289
 vcs_open+0x67/0xd0 drivers/tty/vt/vc_screen.c:688
 chrdev_open+0x245/0x6b0 fs/char_dev.c:414
 do_dentry_open+0x4e6/0x1380 fs/open.c:797
 vfs_open+0xa0/0xd0 fs/open.c:914
 do_last fs/namei.c:3490 [inline]
 path_openat+0x12ee/0x3490 fs/namei.c:3607
 do_filp_open+0x192/0x260 fs/namei.c:3637
 do_sys_openat2+0x5eb/0x7e0 fs/open.c:1149
 do_sys_open+0xf2/0x180 fs/open.c:1165
 __do_sys_openat fs/open.c:1179 [inline]
 __se_sys_openat fs/open.c:1174 [inline]
 __x64_sys_openat+0x9d/0x100 fs/open.c:1174
 do_syscall_64+0xfa/0x790 arch/x86/entry/common.c:294
 entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x45c449
Code: ad b6 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 0f 83 7b b6 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007f108721cc78 EFLAGS: 00000246 ORIG_RAX: 0000000000000101
RAX: ffffffffffffffda RBX: 00007f108721d6d4 RCX: 000000000045c449
RDX: 0000000000000200 RSI: 00000000200001c0 RDI: ffffffffffffff9c
RBP: 000000000076bf20 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000ffffffff
R13: 00000000000007ff R14: 00000000004ca787 R15: 000000000076bf2c

Showing all locks held in the system:
4 locks held by kworker/u4:7/667:
1 lock held by khungtaskd/1132:
 #0: ffffffff89bac280 (rcu_read_lock){....}, at: debug_show_all_locks+0x5f/0x279 kernel/locking/lockdep.c:5333
1 lock held by rsyslogd/9561:
 #0: ffff888098823160 (&f->f_pos_lock){+.+.}, at: __fdget_pos+0xee/0x110 fs/file.c:821
2 locks held by getty/9651:
 #0: ffff8880a7141090 (&tty->ldisc_sem){++++}, at: ldsem_down_read+0x33/0x40 drivers/tty/tty_ldsem.c:340
 #1: ffffc900059232e0 (&ldata->atomic_read_lock){+.+.}, at: n_tty_read+0x220/0x1bf0 drivers/tty/n_tty.c:2156
2 locks held by getty/9652:
 #0: ffff88809f514090 (&tty->ldisc_sem){++++}, at: ldsem_down_read+0x33/0x40 drivers/tty/tty_ldsem.c:340
 #1: ffffc900059cb2e0 (&ldata->atomic_read_lock){+.+.}, at: n_tty_read+0x220/0x1bf0 drivers/tty/n_tty.c:2156
2 locks held by getty/9653:
 #0: ffff88809aae1090 (&tty->ldisc_sem){++++}, at: ldsem_down_read+0x33/0x40 drivers/tty/tty_ldsem.c:340
 #1: ffffc900059db2e0 (&ldata->atomic_read_lock){+.+.}, at: n_tty_read+0x220/0x1bf0 drivers/tty/n_tty.c:2156
2 locks held by getty/9654:
 #0: ffff88809fc70090 (&tty->ldisc_sem){++++}, at: ldsem_down_read+0x33/0x40 drivers/tty/tty_ldsem.c:340
 #1: ffffc9000592b2e0 (&ldata->atomic_read_lock){+.+.}, at: n_tty_read+0x220/0x1bf0 drivers/tty/n_tty.c:2156
2 locks held by getty/9655:
 #0: ffff88809f51a090 (&tty->ldisc_sem){++++}, at: ldsem_down_read+0x33/0x40 drivers/tty/tty_ldsem.c:340
 #1: ffffc900059bb2e0 (&ldata->atomic_read_lock){+.+.}, at: n_tty_read+0x220/0x1bf0 drivers/tty/n_tty.c:2156
2 locks held by getty/9656:
 #0: ffff888090d01090 (&tty->ldisc_sem){++++}, at: ldsem_down_read+0x33/0x40 drivers/tty/tty_ldsem.c:340
 #1: ffffc900059ab2e0 (&ldata->atomic_read_lock){+.+.}, at: n_tty_read+0x220/0x1bf0 drivers/tty/n_tty.c:2156
2 locks held by getty/9657:
 #0: ffff8880a79c2090 (&tty->ldisc_sem){++++}, at: ldsem_down_read+0x33/0x40 drivers/tty/tty_ldsem.c:340
 #1: ffffc900059032e0 (&ldata->atomic_read_lock){+.+.}, at: n_tty_read+0x220/0x1bf0 drivers/tty/n_tty.c:2156
1 lock held by syz-executor.3/19078:

=============================================

NMI backtrace for cpu 1
CPU: 1 PID: 1132 Comm: khungtaskd Not tainted 5.6.0-rc3-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x197/0x210 lib/dump_stack.c:118
 nmi_cpu_backtrace.cold+0x70/0xb2 lib/nmi_backtrace.c:101
 nmi_trigger_cpumask_backtrace+0x23b/0x28b lib/nmi_backtrace.c:62
 arch_trigger_cpumask_backtrace+0x14/0x20 arch/x86/kernel/apic/hw_nmi.c:38
 trigger_all_cpu_backtrace include/linux/nmi.h:146 [inline]
 check_hung_uninterruptible_tasks kernel/hung_task.c:205 [inline]
 watchdog+0xb11/0x10c0 kernel/hung_task.c:289
 kthread+0x361/0x430 kernel/kthread.c:255
 ret_from_fork+0x24/0x30 arch/x86/entry/entry_64.S:352
Sending NMI from CPU 1 to CPUs 0:
NMI backtrace for cpu 0
CPU: 0 PID: 19078 Comm: syz-executor.3 Not tainted 5.6.0-rc3-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:__sanitizer_cov_trace_pc+0x3b/0x50 kernel/kcov.c:192
Code: 97 8c 7e 81 e2 00 01 1f 00 48 8b 75 08 75 2b 8b 90 80 13 00 00 83 fa 02 75 20 48 8b 88 88 13 00 00 8b 80 84 13 00 00 48 8b 11 <48> 83 c2 01 48 39 d0 76 07 48 89 34 d1 48 89 11 5d c3 0f 1f 00 65
RSP: 0018:ffffc90007567680 EFLAGS: 00000246
RAX: 0000000000040000 RBX: 0000000000000000 RCX: ffffc900101b6000
RDX: 000000000003ffff RSI: ffffffff83c82685 RDI: ffff8880a3de1000
RBP: ffffc90007567680 R08: 0000000000001400 R09: 0000000000000040
R10: ffffed10147bc5d3 R11: ffff8880a3de2e9f R12: 0000000000001400
R13: 0000000000000040 R14: ffff8880000a0000 R15: 0000000000000000
FS:  00007f274a6dd700(0000) GS:ffff8880ae800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffffffff600400 CR3: 000000004081a000 CR4: 00000000001426f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 bitfill_aligned+0x25/0x210 drivers/video/fbdev/core/cfbfillrect.c:40
 cfb_fillrect+0x423/0x7c0 drivers/video/fbdev/core/cfbfillrect.c:327
 vga16fb_fillrect+0x6ce/0x19b0 drivers/video/fbdev/vga16fb.c:951
 bit_clear_margins+0x30b/0x530 drivers/video/fbdev/core/bitblit.c:232
 fbcon_clear_margins+0x1e9/0x250 drivers/video/fbdev/core/fbcon.c:1379
 fbcon_switch+0xd7f/0x17f0 drivers/video/fbdev/core/fbcon.c:2361
 redraw_screen+0x2b6/0x7d0 drivers/tty/vt/vt.c:1008
 vc_do_resize+0x10c9/0x1460 drivers/tty/vt/vt.c:1295
 vt_resize+0xaa/0xf0 drivers/tty/vt/vt.c:1336
 tiocswinsz drivers/tty/tty_io.c:2281 [inline]
 tty_ioctl+0x78a/0x14f0 drivers/tty/tty_io.c:2580
 vfs_ioctl fs/ioctl.c:47 [inline]
 ksys_ioctl+0x123/0x180 fs/ioctl.c:763
 __do_sys_ioctl fs/ioctl.c:772 [inline]
 __se_sys_ioctl fs/ioctl.c:770 [inline]
 __x64_sys_ioctl+0x73/0xb0 fs/ioctl.c:770
 do_syscall_64+0xfa/0x790 arch/x86/entry/common.c:294
 entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x45c449
Code: ad b6 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 0f 83 7b b6 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007f274a6dcc78 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f274a6dd6d4 RCX: 000000000045c449
RDX: 0000000020000200 RSI: 0000000000005414 RDI: 0000000000000003
RBP: 000000000076bf20 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000ffffffff
R13: 000000000000058d R14: 00000000004c7e1b R15: 000000000076bf2c


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
