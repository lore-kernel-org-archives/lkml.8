Return-Path: <SRS0=j27y=4W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FAC4C3F2D1
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 17:35:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FBDA2072D
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 17:35:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726859AbgCERfM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Mar 2020 12:35:12 -0500
Received: from mail-io1-f71.google.com ([209.85.166.71]:49630 "EHLO
        mail-io1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726211AbgCERfL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 12:35:11 -0500
Received: by mail-io1-f71.google.com with SMTP id v2so4463128ioq.16
        for <linux-kernel@vger.kernel.org>; Thu, 05 Mar 2020 09:35:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=J22kxp4BNuwMstNi9lcwjW2uSd1Dg5Ss2XhXJn3O4S4=;
        b=i+bhmIlE5dlNV4DQQvhMFwjSeG1PkK75X3Ou1HGt4iM3yQX1iVQKR17QKfQ4N6qGyt
         znGplYc1CshQSGnOlmTZCNpeSklNzHDWDu0K5bRiEKoKT16tHYDrZIkOPp5YcRTuSN57
         x+X9nHZ+GcpmOzSk2oRjbvjxJVIPoDToyZyJD3ODFjEj7QrSzXe6Lcg85dYY6XXU1Xv2
         U2PpwSloKOnr0pKS6kqtdEV8I6lLMRMIN75Jq8gQdHajDfBI1XLvmnYfsoiBAeQF92Kk
         z6IdxBEyXua85J143trlMT298NvlCAfuQiYlc7Lrv9RUSElDdqQTK1EpqzNnwh1OQbrn
         AYGw==
X-Gm-Message-State: ANhLgQ3P8wQZI7tNGPB0s7ZjFDPMesAGPFZXJLmGdyZJ79lz0aw4BI/f
        a7QWKsbddgqg2B9eB7kBSKT2tVCKOoaWSFK+Ure1MMB1sB9O
X-Google-Smtp-Source: ADFU+vteBSOQ0/QG+CsPVBCQTt9GV3zfOTGle6Md0xngnSpRu0XtNHkIcy5OwuwGAnCBWXt+D1hW+mzlPxSKAo8RB1bsFe7n0T9J
MIME-Version: 1.0
X-Received: by 2002:a5d:8956:: with SMTP id b22mr103393iot.263.1583429710715;
 Thu, 05 Mar 2020 09:35:10 -0800 (PST)
Date:   Thu, 05 Mar 2020 09:35:10 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000006f20e205a01ef5e1@google.com>
Subject: possible deadlock in __static_key_slow_dec
From:   syzbot <syzbot+61ffbb75d30176841f76@syzkaller.appspotmail.com>
To:     bristot@redhat.com, kuba@kernel.org, linux-kernel@vger.kernel.org,
        mingo@kernel.org, peterz@infradead.org, simon.horman@netronome.com,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    63623fd4 Merge tag 'for-linus' of git://git.kernel.org/pub..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=154474f9e00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5d2e033af114153f
dashboard link: https://syzkaller.appspot.com/bug?extid=61ffbb75d30176841f76
compiler:       clang version 10.0.0 (https://github.com/llvm/llvm-project/ c2443155a0fb245c8f17f2c1c72b6ea391e86e81)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14f0efa1e00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=119cf3b5e00000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+61ffbb75d30176841f76@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
5.6.0-rc3-syzkaller #0 Not tainted
------------------------------------------------------
syz-executor374/8758 is trying to acquire lock:
ffffffff892c9f18 (cpu_hotplug_lock.rw_sem){++++}, at: __static_key_slow_dec+0x14/0x90 kernel/jump_label.c:254

but task is already holding lock:
ffff88808438c7d8 (&mm->mmap_sem#2){++++}, at: vm_mmap_pgoff+0xf6/0x1d0 mm/util.c:504

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #2 (&mm->mmap_sem#2){++++}:
       lock_acquire+0x154/0x250 kernel/locking/lockdep.c:4484
       down_write+0x57/0x140 kernel/locking/rwsem.c:1534
       mpol_rebind_mm+0x37/0x210 mm/mempolicy.c:382
       cpuset_attach+0x35f/0x4c0 kernel/cgroup/cpuset.c:2203
       cgroup_migrate_execute+0x7ac/0xff0 kernel/cgroup/cgroup.c:2445
       cgroup_migrate+0x181/0x190 kernel/cgroup/cgroup.c:2701
       cgroup_attach_task+0x786/0xa10 kernel/cgroup/cgroup.c:2738
       __cgroup1_procs_write+0x257/0x390 kernel/cgroup/cgroup-v1.c:521
       cgroup1_procs_write+0x2a/0x40 kernel/cgroup/cgroup-v1.c:534
       cgroup_file_write+0x223/0x5f0 kernel/cgroup/cgroup.c:3695
       kernfs_fop_write+0x3f0/0x4f0 fs/kernfs/file.c:315
       __vfs_write+0xb8/0x740 fs/read_write.c:494
       vfs_write+0x270/0x580 fs/read_write.c:558
       ksys_write+0x117/0x220 fs/read_write.c:611
       __do_sys_write fs/read_write.c:623 [inline]
       __se_sys_write fs/read_write.c:620 [inline]
       __x64_sys_write+0x7b/0x90 fs/read_write.c:620
       do_syscall_64+0xf7/0x1c0 arch/x86/entry/common.c:294
       entry_SYSCALL_64_after_hwframe+0x49/0xbe

-> #1 (&cpuset_rwsem){++++}:
       lock_acquire+0x154/0x250 kernel/locking/lockdep.c:4484
       percpu_down_read include/linux/percpu-rwsem.h:40 [inline]
       cpuset_read_lock+0x3e/0x130 kernel/cgroup/cpuset.c:340
       __sched_setscheduler+0x624/0x1b00 kernel/sched/core.c:4869
       _sched_setscheduler kernel/sched/core.c:5041 [inline]
       sched_setscheduler_nocheck+0x125/0x240 kernel/sched/core.c:5087
       __kthread_create_on_node+0x2eb/0x3b0 kernel/kthread.c:349
       kthread_create_on_node+0x72/0xa0 kernel/kthread.c:388
       create_worker+0x396/0x890 kernel/workqueue.c:1924
       workqueue_prepare_cpu+0x98/0x110 kernel/workqueue.c:5024
       cpuhp_invoke_callback+0x4c9/0x8b0 kernel/cpu.c:172
       cpuhp_up_callbacks kernel/cpu.c:599 [inline]
       _cpu_up+0x307/0x550 kernel/cpu.c:1165
       do_cpu_up+0x159/0x1a0 kernel/cpu.c:1200
       cpu_up+0x18/0x20 kernel/cpu.c:1208
       smp_init+0x107/0x29a kernel/smp.c:604
       kernel_init_freeable+0x2f2/0x429 init/main.c:1432
       kernel_init+0x11/0x290 init/main.c:1346
       ret_from_fork+0x24/0x30 arch/x86/entry/entry_64.S:352

-> #0 (cpu_hotplug_lock.rw_sem){++++}:
       check_prev_add kernel/locking/lockdep.c:2475 [inline]
       check_prevs_add kernel/locking/lockdep.c:2580 [inline]
       validate_chain+0x1507/0x7be0 kernel/locking/lockdep.c:2970
       __lock_acquire+0xc5a/0x1bc0 kernel/locking/lockdep.c:3954
       lock_acquire+0x154/0x250 kernel/locking/lockdep.c:4484
       percpu_down_read include/linux/percpu-rwsem.h:40 [inline]
       cpus_read_lock+0x3e/0x130 kernel/cpu.c:292
       __static_key_slow_dec+0x14/0x90 kernel/jump_label.c:254
       static_key_slow_dec+0x50/0xa0 kernel/jump_label.c:270
       sw_perf_event_destroy+0x78/0x170 kernel/events/core.c:8840
       _free_event+0x825/0xdc0 kernel/events/core.c:4616
       put_event kernel/events/core.c:4710 [inline]
       perf_mmap_close+0xc04/0xea0 kernel/events/core.c:5754
       remove_vma mm/mmap.c:177 [inline]
       remove_vma_list mm/mmap.c:2568 [inline]
       __do_munmap+0x1006/0x14b0 mm/mmap.c:2812
       do_munmap mm/mmap.c:2820 [inline]
       mmap_region+0x8c8/0x1c40 mm/mmap.c:1713
       do_mmap+0xa8f/0x1100 mm/mmap.c:1543
       do_mmap_pgoff include/linux/mm.h:2334 [inline]
       vm_mmap_pgoff+0x13d/0x1d0 mm/util.c:506
       ksys_mmap_pgoff+0x45b/0x540 mm/mmap.c:1593
       __do_sys_mmap arch/x86/kernel/sys_x86_64.c:99 [inline]
       __se_sys_mmap arch/x86/kernel/sys_x86_64.c:90 [inline]
       __x64_sys_mmap+0x103/0x120 arch/x86/kernel/sys_x86_64.c:90
       do_syscall_64+0xf7/0x1c0 arch/x86/entry/common.c:294
       entry_SYSCALL_64_after_hwframe+0x49/0xbe

other info that might help us debug this:

Chain exists of:
  cpu_hotplug_lock.rw_sem --> &cpuset_rwsem --> &mm->mmap_sem#2

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&mm->mmap_sem#2);
                               lock(&cpuset_rwsem);
                               lock(&mm->mmap_sem#2);
  lock(cpu_hotplug_lock.rw_sem);

 *** DEADLOCK ***

1 lock held by syz-executor374/8758:
 #0: ffff88808438c7d8 (&mm->mmap_sem#2){++++}, at: vm_mmap_pgoff+0xf6/0x1d0 mm/util.c:504

stack backtrace:
CPU: 1 PID: 8758 Comm: syz-executor374 Not tainted 5.6.0-rc3-syzkaller #0
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
 percpu_down_read include/linux/percpu-rwsem.h:40 [inline]
 cpus_read_lock+0x3e/0x130 kernel/cpu.c:292
 __static_key_slow_dec+0x14/0x90 kernel/jump_label.c:254
 static_key_slow_dec+0x50/0xa0 kernel/jump_label.c:270
 sw_perf_event_destroy+0x78/0x170 kernel/events/core.c:8840
 _free_event+0x825/0xdc0 kernel/events/core.c:4616
 put_event kernel/events/core.c:4710 [inline]
 perf_mmap_close+0xc04/0xea0 kernel/events/core.c:5754
 remove_vma mm/mmap.c:177 [inline]
 remove_vma_list mm/mmap.c:2568 [inline]
 __do_munmap+0x1006/0x14b0 mm/mmap.c:2812
 do_munmap mm/mmap.c:2820 [inline]
 mmap_region+0x8c8/0x1c40 mm/mmap.c:1713
 do_mmap+0xa8f/0x1100 mm/mmap.c:1543
 do_mmap_pgoff include/linux/mm.h:2334 [inline]
 vm_mmap_pgoff+0x13d/0x1d0 mm/util.c:506
 ksys_mmap_pgoff+0x45b/0x540 mm/mmap.c:1593
 __do_sys_mmap arch/x86/kernel/sys_x86_64.c:99 [inline]
 __se_sys_mmap arch/x86/kernel/sys_x86_64.c:90 [inline]
 __x64_sys_mmap+0x103/0x120 arch/x86/kernel/sys_x86_64.c:90
 do_syscall_64+0xf7/0x1c0 arch/x86/entry/common.c:294
 entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x4473b9
Code: e8 4c bb 02 00 48 83 c4 18 c3 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 0f 83 5b 07 fc ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007f0272a71da8 EFLAGS: 00000246 ORIG_RAX: 0000000000000009
RAX: ffffffffffffffda RBX: 00000000006dcc38 RCX: 00000000004473b9
RDX: 0000000000000000 RSI: 0000000000003000 RDI: 0000000020ffd000
RBP: 00000000006dcc30 R08: 0000000000000004 R09: 0000000000000000
R10: 0000000000000011 R11: 0000000000000246 R12: 00000000006dcc3c
R13: 00007ffcae9c6f0f R14: 00007f0272a729c0 R15: 0000000000000000


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
