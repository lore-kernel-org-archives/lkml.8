Return-Path: <SRS0=9JlO=3L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97E5EC2D0DB
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 09:55:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 658132465A
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 09:55:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730902AbgAVJzM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jan 2020 04:55:12 -0500
Received: from mail-io1-f69.google.com ([209.85.166.69]:56526 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729587AbgAVJzK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 04:55:10 -0500
Received: by mail-io1-f69.google.com with SMTP id d13so3646891ioo.23
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jan 2020 01:55:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=X4SvEv/FJrnJ0xP6nb/n/lo7JoPMBrdpq364rqluGuA=;
        b=T/9yU0CKAQJMq3aLJCPVJcVdj3pBtkKQwi/M0HI+cfANzN2qiutjhz7TcNoI1w+Pbt
         U/6QDdPlwpi1mB4+2UB2yTgt5jZ4EQcTzqIQ2KwNAeoA16Sf6S2h+C1DieJHbY4rHgA3
         jNFr8EkDdTyFbxXlILr/NyipHb5aVQ5BRLHKrNZgm23HehBeWu8FRYYwzDrp7HbxGkPo
         +VND3q5Lh5vnQ0b2CEGWg3iekKPx8fN8KUh4TTXXfCvu3FBv1oiqNlqx3mSWwwtn0Mko
         914q+HB6FHzUaklpAg2aM6Lw2JHgybQ7mNhBQBYPXltx67bYjb7GP5Mr+XFLFkd/ypCk
         pdAg==
X-Gm-Message-State: APjAAAXNyMp4QwAFRK07kQ0Pv75GAjgZKEjnc/yAKJ7HVUcuXZjQCzY5
        ebC9lCYRSarZDoRITK+tYq/i+Xadg1GEOxKQPI2Q4h96T+gs
X-Google-Smtp-Source: APXvYqzTffGaFxw9XM3sGLEJUaL2gWAkKYyLe6mk4TPpg0pfOdT20Yz3b1k0eB1+vj4udJ/m7/qQ8uJT5WjzpHOfSQD3RE/n9CGn
MIME-Version: 1.0
X-Received: by 2002:a5e:d515:: with SMTP id e21mr1874110iom.100.1579686909329;
 Wed, 22 Jan 2020 01:55:09 -0800 (PST)
Date:   Wed, 22 Jan 2020 01:55:09 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000001644d1059cb7851c@google.com>
Subject: INFO: task hung in console_callback
From:   syzbot <syzbot+2cc8ec111ca094cf3fb7@syzkaller.appspotmail.com>
To:     daniel.vetter@ffwll.ch, ghalat@redhat.com,
        gregkh@linuxfoundation.org, jslaby@suse.com,
        linux-kernel@vger.kernel.org, nico@fluxnic.net, sam@ravnborg.org,
        syzkaller-bugs@googlegroups.com, textshell@uchuujin.de
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    ab7541c3 Merge tag 'fuse-fixes-5.5-rc7' of git://git.kerne..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1051c8bee00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d9290aeb7e6cf1c4
dashboard link: https://syzkaller.appspot.com/bug?extid=2cc8ec111ca094cf3fb7
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+2cc8ec111ca094cf3fb7@syzkaller.appspotmail.com

INFO: task kworker/1:47:2805 blocked for more than 143 seconds.
      Not tainted 5.5.0-rc6-syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
kworker/1:47    D26936  2805      2 0x80004000
Workqueue: events console_callback
Call Trace:
 context_switch kernel/sched/core.c:3385 [inline]
 __schedule+0x934/0x1f90 kernel/sched/core.c:4081
 schedule+0xdc/0x2b0 kernel/sched/core.c:4155
 schedule_timeout+0x717/0xc50 kernel/time/timer.c:1871
 __down_common kernel/locking/semaphore.c:220 [inline]
 __down+0x176/0x2c0 kernel/locking/semaphore.c:237
 down+0x64/0x90 kernel/locking/semaphore.c:61
 console_lock+0x29/0x80 kernel/printk/printk.c:2289
 console_callback+0x70/0x400 drivers/tty/vt/vt.c:2818
 process_one_work+0x9af/0x1740 kernel/workqueue.c:2264
 worker_thread+0x98/0xe40 kernel/workqueue.c:2410
 kthread+0x361/0x430 kernel/kthread.c:255
 ret_from_fork+0x24/0x30 arch/x86/entry/entry_64.S:352
INFO: task syz-executor.2:24995 blocked for more than 143 seconds.
      Not tainted 5.5.0-rc6-syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
syz-executor.2  D28312 24995  10662 0x00000004
Call Trace:
 context_switch kernel/sched/core.c:3385 [inline]
 __schedule+0x934/0x1f90 kernel/sched/core.c:4081
 schedule+0xdc/0x2b0 kernel/sched/core.c:4155
 schedule_preempt_disabled+0x13/0x20 kernel/sched/core.c:4214
 __mutex_lock_common kernel/locking/mutex.c:1033 [inline]
 __mutex_lock+0x7ab/0x13c0 kernel/locking/mutex.c:1103
 mutex_lock_nested+0x16/0x20 kernel/locking/mutex.c:1118
 lock_fb_info include/linux/fb.h:637 [inline]
 fb_open+0xd7/0x450 drivers/video/fbdev/core/fbmem.c:1406
 chrdev_open+0x245/0x6b0 fs/char_dev.c:414
 do_dentry_open+0x4e6/0x1380 fs/open.c:797
 vfs_open+0xa0/0xd0 fs/open.c:914
 do_last fs/namei.c:3356 [inline]
 path_openat+0x118b/0x3180 fs/namei.c:3473
 do_filp_open+0x1a1/0x280 fs/namei.c:3503
 do_sys_open+0x3fe/0x5d0 fs/open.c:1097
 __do_sys_openat fs/open.c:1124 [inline]
 __se_sys_openat fs/open.c:1118 [inline]
 __x64_sys_openat+0x9d/0x100 fs/open.c:1118
 do_syscall_64+0xfa/0x790 arch/x86/entry/common.c:294
 entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x45aff9
Code: ad b6 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 0f 83 7b b6 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007efd35bd9c78 EFLAGS: 00000246 ORIG_RAX: 0000000000000101
RAX: ffffffffffffffda RBX: 00007efd35bda6d4 RCX: 000000000045aff9
RDX: 0000000000000000 RSI: 0000000020000180 RDI: ffffffffffffff9c
RBP: 000000000075bfc8 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000ffffffff
R13: 000000000000076e R14: 00000000004c8974 R15: 000000000075bfd4

Showing all locks held in the system:
2 locks held by kworker/u4:6/660:
1 lock held by khungtaskd/1117:
 #0: ffffffff899a3f00 (rcu_read_lock){....}, at: debug_show_all_locks+0x5f/0x279 kernel/locking/lockdep.c:5334
2 locks held by kworker/1:47/2805:
 #0: ffff8880aa426d28 ((wq_completion)events){+.+.}, at: __write_once_size include/linux/compiler.h:226 [inline]
 #0: ffff8880aa426d28 ((wq_completion)events){+.+.}, at: arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
 #0: ffff8880aa426d28 ((wq_completion)events){+.+.}, at: atomic64_set include/asm-generic/atomic-instrumented.h:855 [inline]
 #0: ffff8880aa426d28 ((wq_completion)events){+.+.}, at: atomic_long_set include/asm-generic/atomic-long.h:40 [inline]
 #0: ffff8880aa426d28 ((wq_completion)events){+.+.}, at: set_work_data kernel/workqueue.c:615 [inline]
 #0: ffff8880aa426d28 ((wq_completion)events){+.+.}, at: set_work_pool_and_clear_pending kernel/workqueue.c:642 [inline]
 #0: ffff8880aa426d28 ((wq_completion)events){+.+.}, at: process_one_work+0x88b/0x1740 kernel/workqueue.c:2235
 #1: ffffc90008a37dc0 (console_work){+.+.}, at: process_one_work+0x8c1/0x1740 kernel/workqueue.c:2239
1 lock held by rsyslogd/10490:
 #0: ffff8880956ca3e0 (&f->f_pos_lock){+.+.}, at: __fdget_pos+0xee/0x110 fs/file.c:801
2 locks held by getty/10612:
 #0: ffff888097aca090 (&tty->ldisc_sem){++++}, at: ldsem_down_read+0x33/0x40 drivers/tty/tty_ldsem.c:340
 #1: ffffc9000177b2e0 (&ldata->atomic_read_lock){+.+.}, at: n_tty_read+0x220/0x1bf0 drivers/tty/n_tty.c:2156
2 locks held by getty/10613:
 #0: ffff88809642c090 (&tty->ldisc_sem){++++}, at: ldsem_down_read+0x33/0x40 drivers/tty/tty_ldsem.c:340
 #1: ffffc9000176b2e0 (&ldata->atomic_read_lock){+.+.}, at: n_tty_read+0x220/0x1bf0 drivers/tty/n_tty.c:2156
2 locks held by getty/10614:
 #0: ffff8880968a7090 (&tty->ldisc_sem){++++}, at: ldsem_down_read+0x33/0x40 drivers/tty/tty_ldsem.c:340
 #1: ffffc9000178b2e0 (&ldata->atomic_read_lock){+.+.}, at: n_tty_read+0x220/0x1bf0 drivers/tty/n_tty.c:2156
2 locks held by getty/10615:
 #0: ffff8880978b1090 (&tty->ldisc_sem){++++}, at: ldsem_down_read+0x33/0x40 drivers/tty/tty_ldsem.c:340
 #1: ffffc900017932e0 (&ldata->atomic_read_lock){+.+.}, at: n_tty_read+0x220/0x1bf0 drivers/tty/n_tty.c:2156
2 locks held by getty/10616:
 #0: ffff8880968a8090 (&tty->ldisc_sem){++++}, at: ldsem_down_read+0x33/0x40 drivers/tty/tty_ldsem.c:340
 #1: ffffc9000178f2e0 (&ldata->atomic_read_lock){+.+.}, at: n_tty_read+0x220/0x1bf0 drivers/tty/n_tty.c:2156
2 locks held by getty/10617:
 #0: ffff888097a2f090 (&tty->ldisc_sem){++++}, at: ldsem_down_read+0x33/0x40 drivers/tty/tty_ldsem.c:340
 #1: ffffc9000170b2e0 (&ldata->atomic_read_lock){+.+.}, at: n_tty_read+0x220/0x1bf0 drivers/tty/n_tty.c:2156
2 locks held by getty/10618:
 #0: ffff888095c8a090 (&tty->ldisc_sem){++++}, at: ldsem_down_read+0x33/0x40 drivers/tty/tty_ldsem.c:340
 #1: ffffc900016eb2e0 (&ldata->atomic_read_lock){+.+.}, at: n_tty_read+0x220/0x1bf0 drivers/tty/n_tty.c:2156
2 locks held by syz-executor.2/24987:
1 lock held by syz-executor.2/24995:
 #0: ffff8880a382f070 (&fb_info->lock){+.+.}, at: lock_fb_info include/linux/fb.h:637 [inline]
 #0: ffff8880a382f070 (&fb_info->lock){+.+.}, at: fb_open+0xd7/0x450 drivers/video/fbdev/core/fbmem.c:1406

=============================================

NMI backtrace for cpu 1
CPU: 1 PID: 1117 Comm: khungtaskd Not tainted 5.5.0-rc6-syzkaller #0
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
CPU: 0 PID: 4332 Comm: udevd Not tainted 5.5.0-rc6-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:check_memory_region+0x1f/0x1a0 mm/kasan/generic.c:191
Code: 00 66 2e 0f 1f 84 00 00 00 00 00 48 85 f6 0f 84 34 01 00 00 48 b8 ff ff ff ff ff 7f ff ff 55 0f b6 d2 48 39 c7 48 89 e5 41 55 <41> 54 53 0f 86 07 01 00 00 4c 8d 5c 37 ff 49 89 f8 48 b8 00 00 00
RSP: 0018:ffffc90001c1f8a0 EFLAGS: 00000012
RAX: ffff7fffffffffff RBX: 00000000000004c6 RCX: ffffffff815a7ee0
RDX: 0000000000000000 RSI: 0000000000000008 RDI: ffffffff8b2f3d78
RBP: ffffc90001c1f8a8 R08: 1ffffffff165e7af R09: fffffbfff165e7b0
R10: ffff8880a64fac18 R11: ffff8880a64fa380 R12: 00000000cb98681d
R13: ffffffff8a7b7ef0 R14: 0000000000000000 R15: 0000000000000001
FS:  00007f8ef8b667a0(0000) GS:ffff8880ae800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffffffff600400 CR3: 00000000a6476000 CR4: 00000000001406f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 __kasan_check_read+0x11/0x20 mm/kasan/common.c:95
 test_bit include/asm-generic/bitops/instrumented-non-atomic.h:110 [inline]
 hlock_class kernel/locking/lockdep.c:163 [inline]
 __lock_acquire+0x8a0/0x4a00 kernel/locking/lockdep.c:3952
 lock_acquire+0x190/0x410 kernel/locking/lockdep.c:4485
 __mutex_lock_common kernel/locking/mutex.c:956 [inline]
 __mutex_lock+0x156/0x13c0 kernel/locking/mutex.c:1103
 mutex_lock_nested+0x16/0x20 kernel/locking/mutex.c:1118
 ep_scan_ready_list+0x7d4/0x9e0 fs/eventpoll.c:680
 ep_send_events fs/eventpoll.c:1772 [inline]
 ep_poll+0x1f9/0xe60 fs/eventpoll.c:1909
 do_epoll_wait+0x210/0x260 fs/eventpoll.c:2273
 __do_sys_epoll_wait fs/eventpoll.c:2283 [inline]
 __se_sys_epoll_wait fs/eventpoll.c:2280 [inline]
 __x64_sys_epoll_wait+0x97/0xf0 fs/eventpoll.c:2280
 do_syscall_64+0xfa/0x790 arch/x86/entry/common.c:294
 entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x7f8ef827a943
Code: 00 31 d2 48 29 c2 64 89 11 48 83 c8 ff eb ea 90 90 90 90 90 90 90 90 83 3d b5 dc 2a 00 00 75 13 49 89 ca b8 e8 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 34 c3 48 83 ec 08 e8 3b c4 00 00 48 89 04 24
RSP: 002b:00007fff13826b08 EFLAGS: 00000246 ORIG_RAX: 00000000000000e8
RAX: ffffffffffffffda RBX: 0000000000000bb8 RCX: 00007f8ef827a943
RDX: 0000000000000008 RSI: 00007fff13826c00 RDI: 000000000000000a
RBP: 0000000000000001 R08: 0000000000000000 R09: 0000000000000001
R10: 0000000000000bb8 R11: 0000000000000246 R12: 0000000000000003
R13: 0000000000000000 R14: 0000000000b136b0 R15: 0000000000ade030


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
