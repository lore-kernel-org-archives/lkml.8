Return-Path: <SRS0=1cir=3Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18A77C35242
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jan 2020 06:32:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9460214AF
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jan 2020 06:32:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727326AbgA0GcK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jan 2020 01:32:10 -0500
Received: from mail-il1-f197.google.com ([209.85.166.197]:33532 "EHLO
        mail-il1-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725775AbgA0GcJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jan 2020 01:32:09 -0500
Received: by mail-il1-f197.google.com with SMTP id s9so6955748ilk.0
        for <linux-kernel@vger.kernel.org>; Sun, 26 Jan 2020 22:32:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=X1soBIF9LjBQVdj87gimeaKqO+fHd2lr8ET6cJ/1R7k=;
        b=FXVanmwLqkUSRhyYlap6wmS3HG46CY0bi5TPjAMdn/KKqUuBcDGwM+z1ADKyC2ENGa
         uFBecQLjbEK5reDS3VGoUg0zfB6JsXehfuFCyT9uzmcvK0wAnXqWmbVyiPd+QrK4lS7G
         nki8taqjeOsvy4bxmDsgxgCTAFX59Rqv8uyrKZM1BLzTumPZm9jIZicgAd2usS+/j0sz
         hKkwgQAfCsYQfP9ulYjBLFtUe6n/qH5+BZsnfRiTa9eEelQIG5ehGYMMjLTgXmXdLyXM
         sIVLlrgggcp9bXRdkz/8+gCYDQ+ybONfmCx8d1ZGZWUwSpOLA7aFbIlAJu9VJSgRXgSG
         gcjw==
X-Gm-Message-State: APjAAAUSFMrtOyQ4xY3mpuRvfeE3yqWuhOOFBpbNQ21pXxful2K5v6ws
        axp3ntqK3H7l2aTtX2sMRZfvYFHR36BHidW9/CHu5svTGcN6
X-Google-Smtp-Source: APXvYqxdX9PBN12nMfRhz2E74/o1/LkyilQcKDR+hTfsCJMPiXmFUQIKvFxkcGpKj+vJnG2hOomOFK9WqUlYSvNGlVxNnX/isBNu
MIME-Version: 1.0
X-Received: by 2002:a6b:731a:: with SMTP id e26mr11085004ioh.254.1580106728596;
 Sun, 26 Jan 2020 22:32:08 -0800 (PST)
Date:   Sun, 26 Jan 2020 22:32:08 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000043ed6f059d1944bf@google.com>
Subject: INFO: task hung in do_read_cache_page (3)
From:   syzbot <syzbot+518c54e255b5031adde4@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    2821e26f Merge tag 'for-linus' of git://git.armlinux.org.u..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=150b15c9e00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f1c1f9c2d5c6ce1b
dashboard link: https://syzkaller.appspot.com/bug?extid=518c54e255b5031adde4
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+518c54e255b5031adde4@syzkaller.appspotmail.com

INFO: task syz-executor.3:10862 blocked for more than 143 seconds.
      Not tainted 5.5.0-rc7-syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
syz-executor.3  D24888 10862  10588 0x00004004
Call Trace:
 context_switch kernel/sched/core.c:3385 [inline]
 __schedule+0x934/0x1f90 kernel/sched/core.c:4081
 schedule+0xdc/0x2b0 kernel/sched/core.c:4155
 io_schedule+0x1c/0x70 kernel/sched/core.c:5799
 wait_on_page_bit_common+0x3b6/0xf20 mm/filemap.c:1175
 wait_on_page_bit mm/filemap.c:1224 [inline]
 wait_on_page_locked include/linux/pagemap.h:527 [inline]
 wait_on_page_read mm/filemap.c:2747 [inline]
 do_read_cache_page+0x1019/0x1700 mm/filemap.c:2790
 read_cache_page+0x5e/0x70 mm/filemap.c:2874
 read_mapping_page include/linux/pagemap.h:396 [inline]
 read_dev_sector+0x71/0x400 block/partition-generic.c:592
 read_part_sector block/partitions/check.h:38 [inline]
 adfspart_check_ICS+0x12d/0xf50 block/partitions/acorn.c:361
 check_partition+0x3bc/0x6ce block/partitions/check.c:167
 blk_add_partitions+0xf8/0x6e2 block/partition-generic.c:525
 bdev_disk_changed+0x13c/0x2c0 fs/block_dev.c:1531
 __blkdev_get+0x140c/0x1650 fs/block_dev.c:1669
 blkdev_get+0x47/0x2c0 fs/block_dev.c:1736
 blkdev_open+0x205/0x290 fs/block_dev.c:1875
 do_dentry_open+0x4e6/0x1380 fs/open.c:797
 vfs_open+0xa0/0xd0 fs/open.c:914
 do_last fs/namei.c:3356 [inline]
 path_openat+0x118b/0x3180 fs/namei.c:3473
 do_filp_open+0x1a1/0x280 fs/namei.c:3503
 do_sys_open+0x3fe/0x5d0 fs/open.c:1097
 __do_sys_open fs/open.c:1115 [inline]
 __se_sys_open fs/open.c:1110 [inline]
 __x64_sys_open+0x7e/0xc0 fs/open.c:1110
 do_syscall_64+0xfa/0x790 arch/x86/entry/common.c:294
 entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x4150e1
Code: cc cc cc cc cc cc cc cc cc 48 83 ec 38 48 89 6c 24 30 48 8d 6c 24 30 64 48 8b 04 25 f8 ff ff ff 48 8b 40 30 48 8b 80 d0 00 00 <00> 48 89 44 24 28 84 00 48 8b 4c 24 58 48 89 ca 48 c1 e9 03 48 c1
RSP: 002b:00007f113d2747a0 EFLAGS: 00000293 ORIG_RAX: 0000000000000002
RAX: ffffffffffffffda RBX: 6666666666666667 RCX: 00000000004150e1
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 00007f113d274850
RBP: 000000000075bf20 R08: 00007f113d2747b0 R09: 000000000075bf20
R10: 0000000000000000 R11: 0000000000000293 R12: 00000000ffffffff
R13: 0000000000000bbe R14: 00000000004cca19 R15: 000000000075bf2c
INFO: task syz-executor.3:10867 blocked for more than 143 seconds.
      Not tainted 5.5.0-rc7-syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
syz-executor.3  D27768 10867  10588 0x00004004
Call Trace:
 context_switch kernel/sched/core.c:3385 [inline]
 __schedule+0x934/0x1f90 kernel/sched/core.c:4081
 schedule+0xdc/0x2b0 kernel/sched/core.c:4155
 schedule_preempt_disabled+0x13/0x20 kernel/sched/core.c:4214
 __mutex_lock_common kernel/locking/mutex.c:1033 [inline]
 __mutex_lock+0x7ab/0x13c0 kernel/locking/mutex.c:1103
 mutex_lock_nested+0x16/0x20 kernel/locking/mutex.c:1118
 blkdev_put+0x34/0x560 fs/block_dev.c:1916
 blkdev_close+0x8b/0xb0 fs/block_dev.c:1965
 __fput+0x2ff/0x890 fs/file_table.c:280
 ____fput+0x16/0x20 fs/file_table.c:313
 task_work_run+0x145/0x1c0 kernel/task_work.c:113
 tracehook_notify_resume include/linux/tracehook.h:188 [inline]
 exit_to_usermode_loop+0x316/0x380 arch/x86/entry/common.c:164
 prepare_exit_to_usermode arch/x86/entry/common.c:195 [inline]
 syscall_return_slowpath arch/x86/entry/common.c:278 [inline]
 do_syscall_64+0x676/0x790 arch/x86/entry/common.c:304
 entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x45b349
Code: 80 00 00 0f 83 b2 00 00 00 48 3d f8 03 00 00 77 7a 48 83 c0 07 48 c1 e8 03 48 3d 81 00 00 00 0f 83 df 00 00 00 48 8d 15 d5 91 <9f> 00 0f b6 04 10 48 83 f8 43 0f 83 c0 00 00 00 48 8d 0d 00 93 9f
RSP: 002b:00007f113d253c78 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: 0000000000000000 RBX: 00007f113d2546d4 RCX: 000000000045b349
RDX: 0000000000000000 RSI: 000000000000ab03 RDI: 0000000000000003
RBP: 000000000075bfc8 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000ffffffff
R13: 00000000000003fd R14: 00000000004c549d R15: 000000000075bfd4
INFO: task syz-executor.3:10896 blocked for more than 143 seconds.
      Not tainted 5.5.0-rc7-syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
syz-executor.3  D28592 10896  10588 0x00000004
Call Trace:
 context_switch kernel/sched/core.c:3385 [inline]
 __schedule+0x934/0x1f90 kernel/sched/core.c:4081
 schedule+0xdc/0x2b0 kernel/sched/core.c:4155
 schedule_preempt_disabled+0x13/0x20 kernel/sched/core.c:4214
 __mutex_lock_common kernel/locking/mutex.c:1033 [inline]
 __mutex_lock+0x7ab/0x13c0 kernel/locking/mutex.c:1103
 mutex_lock_nested+0x16/0x20 kernel/locking/mutex.c:1118
 __blkdev_get+0x19b/0x1650 fs/block_dev.c:1588
 blkdev_get+0x47/0x2c0 fs/block_dev.c:1736
 blkdev_open+0x205/0x290 fs/block_dev.c:1875
 do_dentry_open+0x4e6/0x1380 fs/open.c:797
 vfs_open+0xa0/0xd0 fs/open.c:914
 do_last fs/namei.c:3356 [inline]
 path_openat+0x118b/0x3180 fs/namei.c:3473
 do_filp_open+0x1a1/0x280 fs/namei.c:3503
 do_sys_open+0x3fe/0x5d0 fs/open.c:1097
 __do_sys_open fs/open.c:1115 [inline]
 __se_sys_open fs/open.c:1110 [inline]
 __x64_sys_open+0x7e/0xc0 fs/open.c:1110
 do_syscall_64+0xfa/0x790 arch/x86/entry/common.c:294
 entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x4150e1
Code: cc cc cc cc cc cc cc cc cc 48 83 ec 38 48 89 6c 24 30 48 8d 6c 24 30 64 48 8b 04 25 f8 ff ff ff 48 8b 40 30 48 8b 80 d0 00 00 <00> 48 89 44 24 28 84 00 48 8b 4c 24 58 48 89 ca 48 c1 e9 03 48 c1
RSP: 002b:00007f113d2327a0 EFLAGS: 00000293 ORIG_RAX: 0000000000000002
RAX: ffffffffffffffda RBX: 6666666666666667 RCX: 00000000004150e1
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 00007f113d232850
RBP: 000000000075c070 R08: 000000000000000f R09: 0000000000000000
R10: 00007f113d2339d0 R11: 0000000000000293 R12: 00000000ffffffff
R13: 0000000000000bbe R14: 00000000004cca19 R15: 000000000075c07c

Showing all locks held in the system:
1 lock held by khungtaskd/1027:
 #0: ffffffff899a3dc0 (rcu_read_lock){....}, at: debug_show_all_locks+0x5f/0x279 kernel/locking/lockdep.c:5333
1 lock held by rsyslogd/10415:
 #0: ffff8880a8f916a0 (&f->f_pos_lock){+.+.}, at: __fdget_pos+0xee/0x110 fs/file.c:801
2 locks held by getty/10537:
 #0: ffff888084fdc090 (&tty->ldisc_sem){++++}, at: ldsem_down_read+0x33/0x40 drivers/tty/tty_ldsem.c:340
 #1: ffffc90001a1b2e0 (&ldata->atomic_read_lock){+.+.}, at: n_tty_read+0x220/0x1bf0 drivers/tty/n_tty.c:2156
2 locks held by getty/10538:
 #0: ffff8880a06c2090 (&tty->ldisc_sem){++++}, at: ldsem_down_read+0x33/0x40 drivers/tty/tty_ldsem.c:340
 #1: ffffc900019fb2e0 (&ldata->atomic_read_lock){+.+.}, at: n_tty_read+0x220/0x1bf0 drivers/tty/n_tty.c:2156
2 locks held by getty/10539:
 #0: ffff8880968b9090 (&tty->ldisc_sem){++++}, at: ldsem_down_read+0x33/0x40 drivers/tty/tty_ldsem.c:340
 #1: ffffc90001a6b2e0 (&ldata->atomic_read_lock){+.+.}, at: n_tty_read+0x220/0x1bf0 drivers/tty/n_tty.c:2156
2 locks held by getty/10540:
 #0: ffff88809ffa6090 (&tty->ldisc_sem){++++}, at: ldsem_down_read+0x33/0x40 drivers/tty/tty_ldsem.c:340
 #1: ffffc900019eb2e0 (&ldata->atomic_read_lock){+.+.}, at: n_tty_read+0x220/0x1bf0 drivers/tty/n_tty.c:2156
2 locks held by getty/10541:
 #0: ffff8880a41aa090 (&tty->ldisc_sem){++++}, at: ldsem_down_read+0x33/0x40 drivers/tty/tty_ldsem.c:340
 #1: ffffc90001a4b2e0 (&ldata->atomic_read_lock){+.+.}, at: n_tty_read+0x220/0x1bf0 drivers/tty/n_tty.c:2156
2 locks held by getty/10542:
 #0: ffff8880945f8090 (&tty->ldisc_sem){++++}, at: ldsem_down_read+0x33/0x40 drivers/tty/tty_ldsem.c:340
 #1: ffffc90001a5b2e0 (&ldata->atomic_read_lock){+.+.}, at: n_tty_read+0x220/0x1bf0 drivers/tty/n_tty.c:2156
2 locks held by getty/10543:
 #0: ffff888096f83090 (&tty->ldisc_sem){++++}, at: ldsem_down_read+0x33/0x40 drivers/tty/tty_ldsem.c:340
 #1: ffffc900019ab2e0 (&ldata->atomic_read_lock){+.+.}, at: n_tty_read+0x220/0x1bf0 drivers/tty/n_tty.c:2156
1 lock held by syz-executor.3/10862:
 #0: ffff8880904db738 (&bdev->bd_mutex){+.+.}, at: __blkdev_get+0x19b/0x1650 fs/block_dev.c:1588
1 lock held by syz-executor.3/10867:
 #0: ffff8880904db738 (&bdev->bd_mutex){+.+.}, at: blkdev_put+0x34/0x560 fs/block_dev.c:1916
1 lock held by syz-executor.3/10896:
 #0: ffff8880904db738 (&bdev->bd_mutex){+.+.}, at: __blkdev_get+0x19b/0x1650 fs/block_dev.c:1588

=============================================

NMI backtrace for cpu 0
CPU: 0 PID: 1027 Comm: khungtaskd Not tainted 5.5.0-rc7-syzkaller #0
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
Sending NMI from CPU 0 to CPUs 1:
NMI backtrace for cpu 1 skipped: idling at native_safe_halt+0xe/0x10 arch/x86/include/asm/irqflags.h:60


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
