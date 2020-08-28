Return-Path: <SRS0=aBbL=CG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,FROM_LOCAL_DIGITS,
	FROM_LOCAL_HEX,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23C42C433E6
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 22:28:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EAC252086A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 22:28:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726821AbgH1W21 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Aug 2020 18:28:27 -0400
Received: from mail-il1-f197.google.com ([209.85.166.197]:41566 "EHLO
        mail-il1-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726536AbgH1W2X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Aug 2020 18:28:23 -0400
Received: by mail-il1-f197.google.com with SMTP id e23so408554ill.8
        for <linux-kernel@vger.kernel.org>; Fri, 28 Aug 2020 15:28:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=Bid+fUDwJlNwtkNRc3wBiI4KYawq96rWfkYCEVzQDbI=;
        b=eBlvGLlvPY3SUtdsEIbciN26ZiS8i1hYWFxvH1Xh3TU+v3zgIsD1b7ehSeIqw6Biki
         shn2qjAlwrT+f9dor0fqJnm6EO7WMl0VP/8BVPaBUspFlJc6mnRNXBwQmpZLm+5l8nla
         GeK9BqwCx2nMG5KLRfPNPAauXgGYNu/EDD0HaK39ci+VAqe7Hn7IuWcVk+vj4RcgHesz
         A5J6W0CheVMNqnpYuCjXSGSoPnYO+Pn866Z2dcYfcQJ1dTuljK29t74r2hEuxoB9UDoS
         I2dmaRlTioLWj7kQ+is3QgW9v37U7RhX56NefCx94xJBhBnR5e8Z3AkF8Tfp75rIwVSP
         UFbg==
X-Gm-Message-State: AOAM531jkUawZmwVWencq++3ZiRl2zETPG3IkiGdGb2OO3v/50wue3l0
        o1Aj276XNB4OQUbv9X6USPd5kOOmDEUCJTXV5p4RcVG/BSKQ
X-Google-Smtp-Source: ABdhPJx9rjsOOx66GnFXvMVaw+WQ/rCsmLTMa807u1/xzxxwHEwxKTvJPmcLg6w23Cxj6r5+LCNuC0zHo1/Q+NmA8S5snrS3n6xj
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:e13:: with SMTP id a19mr842936ilk.172.1598653701766;
 Fri, 28 Aug 2020 15:28:21 -0700 (PDT)
Date:   Fri, 28 Aug 2020 15:28:21 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000034d0605adf792a0@google.com>
Subject: INFO: task can't die in wait_on_page_bit_common
From:   syzbot <syzbot+17675037466844188253@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, axboe@kernel.dk, josef@toxicpanda.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        mchristi@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    d8be0e12 Add linux-next specific files for 20200824
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=12fa85ee900000
kernel config:  https://syzkaller.appspot.com/x/.config?x=9ef0a5f95935d447
dashboard link: https://syzkaller.appspot.com/bug?extid=17675037466844188253
compiler:       gcc (GCC) 10.1.0-syz 20200507
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16f90519900000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=153d3f5e900000

The issue was bisected to:

commit 2da22da573481cc4837e246d0eee4d518b3f715e
Author: Mike Christie <mchristi@redhat.com>
Date:   Tue Aug 13 16:39:52 2019 +0000

    nbd: fix zero cmd timeout handling v2

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=15af02de900000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=17af02de900000
console output: https://syzkaller.appspot.com/x/log.txt?x=13af02de900000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+17675037466844188253@syzkaller.appspotmail.com
Fixes: 2da22da57348 ("nbd: fix zero cmd timeout handling v2")

INFO: task syz-executor066:6866 can't die for more than 143 seconds.
task:syz-executor066 state:D stack:28568 pid: 6866 ppid:  6855 flags:0x00000004
Call Trace:
 context_switch kernel/sched/core.c:3778 [inline]
 __schedule+0x8e5/0x21e0 kernel/sched/core.c:4527
 schedule+0xd0/0x2a0 kernel/sched/core.c:4602
 io_schedule+0xb5/0x120 kernel/sched/core.c:6296
 wait_on_page_bit_common+0x52c/0xca0 mm/filemap.c:1193
 wait_on_page_bit mm/filemap.c:1218 [inline]
 wait_on_page_locked include/linux/pagemap.h:611 [inline]
 do_read_cache_page+0x257/0x1390 mm/filemap.c:2917
 read_mapping_page include/linux/pagemap.h:437 [inline]
 read_part_sector+0xf6/0x5af block/partitions/core.c:770
 adfspart_check_ICS+0x9d/0xc90 block/partitions/acorn.c:360
 check_partition block/partitions/core.c:140 [inline]
 blk_add_partitions+0x445/0xe00 block/partitions/core.c:698
 bdev_disk_changed+0x1ea/0x370 fs/block_dev.c:1416
 __blkdev_get+0xee4/0x1aa0 fs/block_dev.c:1559
 blkdev_get fs/block_dev.c:1639 [inline]
 blkdev_open+0x227/0x300 fs/block_dev.c:1753
 do_dentry_open+0x4b9/0x11b0 fs/open.c:817
 do_open fs/namei.c:3251 [inline]
 path_openat+0x1b9a/0x2730 fs/namei.c:3368
 do_filp_open+0x17e/0x3c0 fs/namei.c:3395
 do_sys_openat2+0x16d/0x420 fs/open.c:1168
 do_sys_open fs/open.c:1184 [inline]
 __do_sys_open fs/open.c:1192 [inline]
 __se_sys_open fs/open.c:1188 [inline]
 __x64_sys_open+0x119/0x1c0 fs/open.c:1188
 do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x405811
Code: Bad RIP value.
RSP: 002b:00007f3442d94980 EFLAGS: 00000293 ORIG_RAX: 0000000000000002
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 0000000000405811
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 00007f3442d94990
RBP: 6666666666666667 R08: 000000000000000f R09: 00007f3442d95700
R10: 00007f3442d959d0 R11: 0000000000000293 R12: 00000000006dbc4c
R13: 00007fffc941905f R14: 00007f3442d959c0 R15: 20c49ba5e353f7cf
INFO: task syz-executor066:6866 blocked for more than 143 seconds.
      Not tainted 5.9.0-rc2-next-20200824-syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor066 state:D stack:28568 pid: 6866 ppid:  6855 flags:0x00000004
Call Trace:
 context_switch kernel/sched/core.c:3778 [inline]
 __schedule+0x8e5/0x21e0 kernel/sched/core.c:4527
 schedule+0xd0/0x2a0 kernel/sched/core.c:4602
 io_schedule+0xb5/0x120 kernel/sched/core.c:6296
 wait_on_page_bit_common+0x52c/0xca0 mm/filemap.c:1193
 wait_on_page_bit mm/filemap.c:1218 [inline]
 wait_on_page_locked include/linux/pagemap.h:611 [inline]
 do_read_cache_page+0x257/0x1390 mm/filemap.c:2917
 read_mapping_page include/linux/pagemap.h:437 [inline]
 read_part_sector+0xf6/0x5af block/partitions/core.c:770
 adfspart_check_ICS+0x9d/0xc90 block/partitions/acorn.c:360
 check_partition block/partitions/core.c:140 [inline]
 blk_add_partitions+0x445/0xe00 block/partitions/core.c:698
 bdev_disk_changed+0x1ea/0x370 fs/block_dev.c:1416
 __blkdev_get+0xee4/0x1aa0 fs/block_dev.c:1559
 blkdev_get fs/block_dev.c:1639 [inline]
 blkdev_open+0x227/0x300 fs/block_dev.c:1753
 do_dentry_open+0x4b9/0x11b0 fs/open.c:817
 do_open fs/namei.c:3251 [inline]
 path_openat+0x1b9a/0x2730 fs/namei.c:3368
 do_filp_open+0x17e/0x3c0 fs/namei.c:3395
 do_sys_openat2+0x16d/0x420 fs/open.c:1168
 do_sys_open fs/open.c:1184 [inline]
 __do_sys_open fs/open.c:1192 [inline]
 __se_sys_open fs/open.c:1188 [inline]
 __x64_sys_open+0x119/0x1c0 fs/open.c:1188
 do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x405811
Code: Bad RIP value.
RSP: 002b:00007f3442d94980 EFLAGS: 00000293 ORIG_RAX: 0000000000000002
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 0000000000405811
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 00007f3442d94990
RBP: 6666666666666667 R08: 000000000000000f R09: 00007f3442d95700
R10: 00007f3442d959d0 R11: 0000000000000293 R12: 00000000006dbc4c
R13: 00007fffc941905f R14: 00007f3442d959c0 R15: 20c49ba5e353f7cf
INFO: task syz-executor066:6867 can't die for more than 143 seconds.
task:syz-executor066 state:D stack:28744 pid: 6867 ppid:  6855 flags:0x00000004
Call Trace:
 context_switch kernel/sched/core.c:3778 [inline]
 __schedule+0x8e5/0x21e0 kernel/sched/core.c:4527
 schedule+0xd0/0x2a0 kernel/sched/core.c:4602
 schedule_preempt_disabled+0xf/0x20 kernel/sched/core.c:4661
 __mutex_lock_common kernel/locking/mutex.c:1033 [inline]
 __mutex_lock+0x3e2/0x10e0 kernel/locking/mutex.c:1103
 __blkdev_get+0x4b8/0x1aa0 fs/block_dev.c:1492
 blkdev_get fs/block_dev.c:1639 [inline]
 blkdev_open+0x227/0x300 fs/block_dev.c:1753
 do_dentry_open+0x4b9/0x11b0 fs/open.c:817
 do_open fs/namei.c:3251 [inline]
 path_openat+0x1b9a/0x2730 fs/namei.c:3368
 do_filp_open+0x17e/0x3c0 fs/namei.c:3395
 do_sys_openat2+0x16d/0x420 fs/open.c:1168
 do_sys_open fs/open.c:1184 [inline]
 __do_sys_open fs/open.c:1192 [inline]
 __se_sys_open fs/open.c:1188 [inline]
 __x64_sys_open+0x119/0x1c0 fs/open.c:1188
 do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x405811
Code: Bad RIP value.
RSP: 002b:00007f3442d73980 EFLAGS: 00000293 ORIG_RAX: 0000000000000002
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 0000000000405811
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 00007f3442d73990
RBP: 6666666666666667 R08: 000000000000000f R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000293 R12: 00000000006dbc5c
R13: 00007fffc941905f R14: 00007f3442d749c0 R15: 20c49ba5e353f7cf
INFO: task syz-executor066:6867 blocked for more than 144 seconds.
      Not tainted 5.9.0-rc2-next-20200824-syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor066 state:D stack:28744 pid: 6867 ppid:  6855 flags:0x00000004
Call Trace:
 context_switch kernel/sched/core.c:3778 [inline]
 __schedule+0x8e5/0x21e0 kernel/sched/core.c:4527
 schedule+0xd0/0x2a0 kernel/sched/core.c:4602
 schedule_preempt_disabled+0xf/0x20 kernel/sched/core.c:4661
 __mutex_lock_common kernel/locking/mutex.c:1033 [inline]
 __mutex_lock+0x3e2/0x10e0 kernel/locking/mutex.c:1103
 __blkdev_get+0x4b8/0x1aa0 fs/block_dev.c:1492
 blkdev_get fs/block_dev.c:1639 [inline]
 blkdev_open+0x227/0x300 fs/block_dev.c:1753
 do_dentry_open+0x4b9/0x11b0 fs/open.c:817
 do_open fs/namei.c:3251 [inline]
 path_openat+0x1b9a/0x2730 fs/namei.c:3368
 do_filp_open+0x17e/0x3c0 fs/namei.c:3395
 do_sys_openat2+0x16d/0x420 fs/open.c:1168
 do_sys_open fs/open.c:1184 [inline]
 __do_sys_open fs/open.c:1192 [inline]
 __se_sys_open fs/open.c:1188 [inline]
 __x64_sys_open+0x119/0x1c0 fs/open.c:1188
 do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x405811
Code: Bad RIP value.
RSP: 002b:00007f3442d73980 EFLAGS: 00000293 ORIG_RAX: 0000000000000002
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 0000000000405811
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 00007f3442d73990
RBP: 6666666666666667 R08: 000000000000000f R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000293 R12: 00000000006dbc5c
R13: 00007fffc941905f R14: 00007f3442d749c0 R15: 20c49ba5e353f7cf

Showing all locks held in the system:
1 lock held by khungtaskd/1172:
 #0: ffffffff89c675c0 (rcu_read_lock){....}-{1:2}, at: debug_show_all_locks+0x53/0x260 kernel/locking/lockdep.c:5825
2 locks held by in:imklog/6558:
 #0: ffff8880a77981b0 (&f->f_pos_lock){+.+.}-{3:3}, at: __fdget_pos+0xe9/0x100 fs/file.c:930
 #1: ffffffff89c675c0 (rcu_read_lock){....}-{1:2}, at: rq_lock kernel/sched/sched.h:1292 [inline]
 #1: ffffffff89c675c0 (rcu_read_lock){....}-{1:2}, at: ttwu_queue kernel/sched/core.c:2698 [inline]
 #1: ffffffff89c675c0 (rcu_read_lock){....}-{1:2}, at: try_to_wake_up+0x52b/0x12b0 kernel/sched/core.c:2978
1 lock held by syz-executor066/6866:
 #0: ffff8880913452c0 (&bdev->bd_mutex){+.+.}-{3:3}, at: __blkdev_get+0x4b8/0x1aa0 fs/block_dev.c:1492
1 lock held by syz-executor066/6867:
 #0: ffff8880913452c0 (&bdev->bd_mutex){+.+.}-{3:3}, at: __blkdev_get+0x4b8/0x1aa0 fs/block_dev.c:1492

=============================================

NMI backtrace for cpu 1
CPU: 1 PID: 1172 Comm: khungtaskd Not tainted 5.9.0-rc2-next-20200824-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x18f/0x20d lib/dump_stack.c:118
 nmi_cpu_backtrace.cold+0x44/0xd7 lib/nmi_backtrace.c:105
 nmi_trigger_cpumask_backtrace+0x1b3/0x223 lib/nmi_backtrace.c:62
 trigger_all_cpu_backtrace include/linux/nmi.h:147 [inline]
 check_hung_uninterruptible_tasks kernel/hung_task.c:253 [inline]
 watchdog+0xd89/0xf30 kernel/hung_task.c:339
 kthread+0x3b5/0x4a0 kernel/kthread.c:292
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:294
Sending NMI from CPU 1 to CPUs 0:
NMI backtrace for cpu 0
CPU: 0 PID: 3887 Comm: systemd-journal Not tainted 5.9.0-rc2-next-20200824-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:__orc_find+0x6/0xf0 arch/x86/kernel/unwind_orc.c:34
Code: be e8 1e 0e 81 00 48 c7 c7 a0 d0 48 88 e8 d2 d6 81 02 cc cc 48 8b 07 c3 66 90 66 2e 0f 1f 84 00 00 00 00 00 41 57 89 d0 41 56 <41> 55 41 54 4c 8d 64 87 fc 55 53 48 83 ec 10 85 d2 0f 84 95 00 00
RSP: 0018:ffffc900054c79b8 EFLAGS: 00000006
RAX: 000000000000000c RBX: 1ffff92000a98f42 RCX: ffffffff87f5509c
RDX: 000000000000000c RSI: ffffffff8ba52a20 RDI: ffffffff8b1d959c
RBP: 0000000000000001 R08: ffffffff8ba52a68 R09: ffffffff8ba52a20
R10: 000000000007201e R11: 0000000000161242 R12: ffffc900054c7af0
R13: ffffc900054c7add R14: ffffc900054c7af8 R15: ffffc900054c7aa8
FS:  00007fa933e108c0(0000) GS:ffff8880ae600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fa9311c1000 CR3: 00000000941f8000 CR4: 00000000001506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 orc_find arch/x86/kernel/unwind_orc.c:172 [inline]
 unwind_next_frame+0x342/0x1f90 arch/x86/kernel/unwind_orc.c:449
 arch_stack_walk+0x81/0xf0 arch/x86/kernel/stacktrace.c:25
 stack_trace_save+0x8c/0xc0 kernel/stacktrace.c:123
 kasan_save_stack+0x1b/0x40 mm/kasan/common.c:48
 kasan_set_track+0x1c/0x30 mm/kasan/common.c:56
 kasan_set_free_info+0x1b/0x30 mm/kasan/generic.c:355
 __kasan_slab_free+0xd8/0x120 mm/kasan/common.c:422
 __cache_free mm/slab.c:3418 [inline]
 kmem_cache_free.part.0+0x67/0x1f0 mm/slab.c:3693
 __put_cred+0x1de/0x250 kernel/cred.c:148
 put_cred include/linux/cred.h:287 [inline]
 put_cred include/linux/cred.h:280 [inline]
 revert_creds+0x1a8/0x1f0 kernel/cred.c:598
 do_faccessat+0x2ca/0x820 fs/open.c:464
 do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x7fa9330cc9c7
Code: 83 c4 08 48 3d 01 f0 ff ff 73 01 c3 48 8b 0d c8 d4 2b 00 f7 d8 64 89 01 48 83 c8 ff c3 66 0f 1f 44 00 00 b8 15 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d a1 d4 2b 00 f7 d8 64 89 01 48
RSP: 002b:00007ffc39eb4fe8 EFLAGS: 00000246 ORIG_RAX: 0000000000000015
RAX: ffffffffffffffda RBX: 00007ffc39eb8010 RCX: 00007fa9330cc9c7
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000560f967b09a3
RBP: 00007ffc39eb5130 R08: 0000560f967a63e5 R09: 0000000000000018
R10: 0000000000000069 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 0000560f9771a8a0 R15: 00007ffc39eb5620


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
