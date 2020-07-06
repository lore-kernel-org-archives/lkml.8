Return-Path: <SRS0=eGSO=AR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A1D9C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 15:22:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6123520715
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 15:22:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729438AbgGFPW3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jul 2020 11:22:29 -0400
Received: from mail-io1-f69.google.com ([209.85.166.69]:38354 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729336AbgGFPW1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jul 2020 11:22:27 -0400
Received: by mail-io1-f69.google.com with SMTP id l13so23815381ioj.5
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jul 2020 08:22:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=J0r91f0Uu6n7S0zI4M1hL1CS5fiLgRGxOSQz0TCnJG0=;
        b=bD1ah3Xw4OTC97GgYvL0AGIZGJudfDU+tGmfJ6wyPtWt5Dd1qjPRbGHmpJq18vhfN4
         wpmixZb2UBBJPnJE+a0L+a5zdgns6aEwK5dxn9q+4wkgH5MXf8GkiQA2tzW5BHgJxwIf
         rR9J8Rgmn7U2UUxovm25Z+Vczor2ro6EIUCQIt30LZNobE/iB1bG6M7ASeMXLk4xhh47
         4QirOWsrFHzOp/at9ivw+cJ6V6ecbnWGFH7TYKvT7jz5olQ5lxah0+tDKRg8EZUH2io+
         bgRB2cEQF5fkvpx49cCwytL7SydrkCIcVpyWtLwAunEZrtCAZw3Gttq774XhI1zn8qL2
         gB/Q==
X-Gm-Message-State: AOAM533Z8IVrK/xOF4ZwofzsHtkELSAjiSged00pmA3xKIyRuFW6sxus
        D1IItQ7Yva86WheFne9f6KSltDygzajK5PFqmdCYpYsnhS/Z
X-Google-Smtp-Source: ABdhPJwkasiEyzWLshoxtDrYo/liAUDgKPisONkfnnWIypCOy3nUtu+FagA8JWN3DhlUAgMz95bdSxZhCopZi79ZAKLBEchHU1Go
MIME-Version: 1.0
X-Received: by 2002:a02:c948:: with SMTP id u8mr3310147jao.124.1594048946527;
 Mon, 06 Jul 2020 08:22:26 -0700 (PDT)
Date:   Mon, 06 Jul 2020 08:22:26 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000003664ff05a9c7711f@google.com>
Subject: INFO: task hung in usleep_range
From:   syzbot <syzbot+e0d64e9a2b4e87b2a0fe@syzkaller.appspotmail.com>
To:     bp@alien8.de, hpa@zytor.com, linux-kernel@vger.kernel.org,
        luto@kernel.org, mingo@redhat.com, syzkaller-bugs@googlegroups.com,
        tglx@linutronix.de, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    642b151f Merge branch 'fixes' of git://git.kernel.org/pub/..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=125ac27e100000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5298b51a2988dbd9
dashboard link: https://syzkaller.appspot.com/bug?extid=e0d64e9a2b4e87b2a0fe
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+e0d64e9a2b4e87b2a0fe@syzkaller.appspotmail.com

INFO: task syz-executor.3:22291 blocked for more than 143 seconds.
      Not tainted 5.7.0-rc6-syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
syz-executor.3  D28392 22291   7333 0x00004004
Call Trace:
 context_switch kernel/sched/core.c:3367 [inline]
 __schedule+0x937/0x1ff0 kernel/sched/core.c:4083
 __sched_text_start+0x8/0x8
 mark_held_locks+0xe0/0xe0 kernel/locking/lockdep.c:3620
 lock_downgrade+0x840/0x840 kernel/locking/lockdep.c:4579
 schedule+0xd0/0x2a0 kernel/sched/core.c:4158
 schedule_timeout+0x55b/0x850 kernel/time/timer.c:1874
 find_held_lock+0x2d/0x110 kernel/locking/lockdep.c:4458
 usleep_range+0x160/0x160 kernel/time/timer.c:2093
 do_wait_for_common kernel/sched/completion.c:84 [inline]
 __wait_for_common kernel/sched/completion.c:106 [inline]
 wait_for_common kernel/sched/completion.c:117 [inline]
 wait_for_completion_timeout+0x15a/0x280 kernel/sched/completion.c:157
 do_syscall_64+0xf6/0x7d0 arch/x86/entry/common.c:295
 entry_SYSCALL_64_after_hwframe+0x49/0xb3
 lock_downgrade+0x840/0x840 kernel/locking/lockdep.c:4579
 atomic_try_cmpxchg include/asm-generic/atomic-instrumented.h:694 [inline]
 queued_spin_lock include/asm-generic/qspinlock.h:78 [inline]
 do_raw_spin_lock+0x129/0x2e0 kernel/locking/spinlock_debug.c:113
 rwlock_bug.part.0+0x90/0x90 include/linux/sched.h:1329
 entry_SYSCALL_64_after_hwframe+0x49/0xb3
 __raw_spin_unlock_irq include/linux/spinlock_api_smp.h:168 [inline]
 _raw_spin_unlock_irq+0x1f/0x80 kernel/locking/spinlock.c:199
 do_wait_for_common kernel/sched/completion.c:85 [inline]
 __wait_for_common kernel/sched/completion.c:106 [inline]
 wait_for_common kernel/sched/completion.c:117 [inline]
 wait_for_completion_timeout+0x162/0x280 kernel/sched/completion.c:157
 wait_for_completion_io_timeout+0x280/0x280 kernel/sched/completion.c:89
 usb_submit_urb+0x6ed/0x13b0 drivers/usb/core/urb.c:570
 lockdep_init_map_waits+0x1d3/0x890 kernel/locking/lockdep.c:4119
 usb_start_wait_urb+0x144/0x2b0 drivers/usb/core/message.c:63
 sg_clean+0x230/0x230 drivers/usb/core/message.c:262
 memset+0x20/0x40 mm/kasan/common.c:85
 usb_bulk_msg+0x228/0x550 drivers/usb/core/message.c:254
 proc_bulk+0x41a/0x780 drivers/usb/core/devio.c:1235
 processcompl_compat+0x670/0x670 drivers/usb/core/devio.c:2120
 kfree+0x1eb/0x2b0 mm/slab.c:3758
 tomoyo_path_number_perm+0x411/0x4d0 security/tomoyo/file.c:736
 __trace_hardirqs_on_caller kernel/locking/lockdep.c:3657 [inline]
 lockdep_hardirqs_on+0x463/0x620 kernel/locking/lockdep.c:3702
 tomoyo_path_number_perm+0x238/0x4d0 security/tomoyo/file.c:721
 usbdev_do_ioctl drivers/usb/core/devio.c:2539 [inline]
 usbdev_ioctl+0x543/0x31e0 drivers/usb/core/devio.c:2705
 proc_do_submiturb+0x3530/0x3530 include/linux/list.h:70
 rcu_read_unlock include/linux/rcupdate.h:651 [inline]
 __fget_files+0x30d/0x500 fs/file.c:734
 __sanitizer_cov_trace_switch+0x45/0x70 kernel/kcov.c:310
 ioctl_fioasync fs/ioctl.c:601 [inline]
 do_vfs_ioctl+0x50c/0x1360 fs/ioctl.c:704
 ioctl_file_clone+0x180/0x180 fs/ioctl.c:253
 rcu_lock_release include/linux/rcupdate.h:213 [inline]
 rcu_read_unlock include/linux/rcupdate.h:655 [inline]
 __fget_files+0x32f/0x500 fs/file.c:734
 ksys_dup3+0x3c0/0x3c0 include/linux/compiler.h:199
 __do_sys_futex kernel/futex.c:3869 [inline]
 __se_sys_futex kernel/futex.c:3837 [inline]
 __x64_sys_futex+0x380/0x4f0 kernel/futex.c:3837
 proc_do_submiturb+0x3530/0x3530 include/linux/list.h:70
 vfs_ioctl fs/ioctl.c:47 [inline]
 ksys_ioctl+0x11a/0x180 fs/ioctl.c:771
 __do_sys_ioctl fs/ioctl.c:780 [inline]
 __se_sys_ioctl fs/ioctl.c:778 [inline]
 __x64_sys_ioctl+0x6f/0xb0 fs/ioctl.c:778
 __trace_hardirqs_on_caller kernel/locking/lockdep.c:3657 [inline]
 lockdep_hardirqs_on+0x463/0x620 kernel/locking/lockdep.c:3702
 do_syscall_64+0xf6/0x7d0 arch/x86/entry/common.c:295
 entry_SYSCALL_64_after_hwframe+0x49/0xb3

Showing all locks held in the system:
5 locks held by kworker/u4:6/364:
1 lock held by khungtaskd/1142:
 #0: ffffffff899bea80 (rcu_read_lock){....}-{1:2}, at: debug_show_all_locks+0x53/0x260 kernel/locking/lockdep.c:5754
1 lock held by in:imklog/6669:
 #0: ffff888094b56df0 (&f->f_pos_lock){+.+.}-{3:3}, at: __fdget_pos+0xe9/0x100 fs/file.c:826
4 locks held by kworker/0:5/10219:
 #0: ffff8880ae637998 (&rq->lock){-.-.}-{2:2}, at: rq_lock kernel/sched/sched.h:1262 [inline]
 #0: ffff8880ae637998 (&rq->lock){-.-.}-{2:2}, at: __schedule+0x233/0x1ff0 kernel/sched/core.c:4029
 #1: ffff8880ae622ec8 (&per_cpu_ptr(group->pcpu, cpu)->seq){-.-.}-{0:0}, at: psi_task_switch+0x304/0x410 kernel/sched/psi.c:817
 #2: ffffffff899b37f8 (logbuf_lock){-.-.}-{2:2}, at: console_unlock+0x691/0xf00 kernel/printk/printk.c:2524
 #3: ffffffff899b37f8 (logbuf_lock){-.-.}-{2:2}, at: console_unlock+0x1c2/0xf00 kernel/printk/printk.c:2439

=============================================

NMI backtrace for cpu 0
CPU: 0 PID: 1142 Comm: khungtaskd Not tainted 5.7.0-rc6-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x188/0x20d lib/dump_stack.c:118
 nmi_cpu_backtrace.cold+0x70/0xb1 lib/nmi_backtrace.c:101
 lapic_can_unplug_cpu.cold+0x3b/0x3b
 nmi_trigger_cpumask_backtrace+0x231/0x27e lib/nmi_backtrace.c:62
 trigger_all_cpu_backtrace include/linux/nmi.h:146 [inline]
 check_hung_uninterruptible_tasks kernel/hung_task.c:205 [inline]
 watchdog+0xa8c/0x1010 kernel/hung_task.c:289
 reset_hung_task_detector+0x30/0x30 kernel/hung_task.c:243
 kthread+0x388/0x470 kernel/kthread.c:268
 kthread_mod_delayed_work+0x1a0/0x1a0 kernel/kthread.c:1090
 ret_from_fork+0x24/0x30 arch/x86/entry/entry_64.S:351
Sending NMI from CPU 0 to CPUs 1:
NMI backtrace for cpu 1
CPU: 1 PID: 364 Comm: kworker/u4:6 Not tainted 5.7.0-rc6-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Workqueue: krdsd rds_connect_worker
RIP: 0010:__local_bh_enable_ip+0x130/0x270 kernel/softirq.c:182
Code: 00 0f 84 cb 00 00 00 fa 66 0f 1f 44 00 00 e8 37 a9 32 00 65 8b 05 b8 14 bc 7e 25 00 ff 00 00 3d 00 02 00 00 0f 84 94 00 00 00 <8d> 7b ff e8 58 00 09 00 65 8b 05 99 14 bc 7e a9 00 ff 1f 00 0f 84
RSP: 0018:ffffc90001c379d8 EFLAGS: 00000046
RAX: 0000000000000007 RBX: 0000000000000201 RCX: 1ffffffff18ccc1c
RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff8880a8742d84
RBP: ffffffff86965491 R08: 0000000000000001 R09: fffff52000b641da
R10: ffffc90005b20ecb R11: fffff52000b641d9 R12: ffff8880a87424c0
R13: ffff888022a80580 R14: dffffc0000000000 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff8880ae700000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f3ca0e51ab4 CR3: 00000000a8fa3000 CR4: 00000000001406e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 spin_unlock_bh include/linux/spinlock.h:398 [inline]
 inet_csk_find_open_port net/ipv4/inet_connection_sock.c:235 [inline]
 inet_csk_get_port+0xdb1/0x2590 net/ipv4/inet_connection_sock.c:312
 inet_csk_listen_stop+0xb20/0xb20 net/ipv4/inet_connection_sock.c:1041
 mark_held_locks+0x9f/0xe0 kernel/locking/lockdep.c:3628
 __local_bh_enable_ip+0x159/0x270 kernel/softirq.c:194
 __inet_bind+0x5b2/0xbd0 net/ipv4/af_inet.c:524
 inet_bind+0xf3/0x160 net/ipv4/af_inet.c:453
 rds_tcp_conn_path_connect+0x536/0x880 net/rds/tcp_connect.c:144
 rds_tcp_state_change+0x270/0x270 net/rds/tcp_connect.c:70
 lock_is_held include/linux/lockdep.h:406 [inline]
 rcu_read_lock_sched_held+0x9c/0xd0 kernel/rcu/update.c:121
 rds_connect_worker+0x1a5/0x2c0 net/rds/threads.c:176
 process_one_work+0x965/0x16a0 kernel/workqueue.c:2268
 lock_release+0x800/0x800 kernel/locking/lockdep.c:4689
 pwq_dec_nr_in_flight+0x310/0x310 kernel/workqueue.c:1198
 rwlock_bug.part.0+0x90/0x90 include/linux/sched.h:1329
 worker_thread+0x96/0xe20 kernel/workqueue.c:2414
 process_one_work+0x16a0/0x16a0 kernel/workqueue.c:2273
 kthread+0x388/0x470 kernel/kthread.c:268
 kthread_mod_delayed_work+0x1a0/0x1a0 kernel/kthread.c:1090
 ret_from_fork+0x24/0x30 arch/x86/entry/entry_64.S:351


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
