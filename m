Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22B6FC433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 07:23:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 021FD2065D
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 07:23:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728253AbgGGHXW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 03:23:22 -0400
Received: from mail-io1-f69.google.com ([209.85.166.69]:42798 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725825AbgGGHXV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 03:23:21 -0400
Received: by mail-io1-f69.google.com with SMTP id a16so25361316iow.9
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jul 2020 00:23:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=oy41SKBkErG3J2dP+7cSghZGFr9e10J2b7nPcKRRNLo=;
        b=BOWazahmDQJ6m7r7zSqmoVyM9vnrHxRlZD2lDXHCyJ8mW4CdKJ5Uex2MjLt7warw0A
         Y3S2/4H46qq3KHI+9yiYDQB6LsP8uZVr5AM5Cqcua9x6JtFITobWO4gK0QAAc03AwkMO
         tHWkVHISmu0gzHA71AxoPjrbP9bmzENTyj+X4GenvSiilRsvUPGesmfZOokSvedhja69
         7P4cBSc1/M6YhcACaiefuuVuNcFa1io2peZLpqh4LBcEDIkNqWCtiGrkqYV3yvwvykvA
         fQ23Bs1+tajAFdMGvAR+1ghgnQDi7Qh39mUwrOdJH5z3zztyR4tSDyESRtLDrnB5FZqr
         46vQ==
X-Gm-Message-State: AOAM5315qQc1M9wq87kYQVxNAS2CJTgf9NvYWOEBix5gLO323Sr8WeXE
        wVbnTNF+q9uziu8r9P89v7wzzOjPJFTE1RpeR/cZJ6HElz/h
X-Google-Smtp-Source: ABdhPJy64nUZxFqP1kQO06UD7QZWM39cRKYPkJkQKaeFDeb8ID0fGV5U1U17TA0ynpiFqj73qXgvBURF33IuJc171B9h3pOxsZcs
MIME-Version: 1.0
X-Received: by 2002:a02:ac8e:: with SMTP id x14mr57137364jan.57.1594106599916;
 Tue, 07 Jul 2020 00:23:19 -0700 (PDT)
Date:   Tue, 07 Jul 2020 00:23:19 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000009f4ecd05a9d4dd9f@google.com>
Subject: INFO: rcu detected stall in iterate_cleanup_work (2)
From:   syzbot <syzbot+cc8495ea4052b9b79b72@syzkaller.appspotmail.com>
To:     linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        tglx@linutronix.de
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    cd77006e Merge tag 'hyperv-fixes-signed' of git://git.kern..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=103ff25b100000
kernel config:  https://syzkaller.appspot.com/x/.config?x=7be693511b29b338
dashboard link: https://syzkaller.appspot.com/bug?extid=cc8495ea4052b9b79b72
compiler:       gcc (GCC) 10.1.0-syz 20200507
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12e567e5100000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=126ffccd100000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+cc8495ea4052b9b79b72@syzkaller.appspotmail.com

rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
rcu: 	0-...!: (2 GPs behind) idle=89e/1/0x4000000000000000 softirq=9541/9542 fqs=10 
	(detected by 1, t=10502 jiffies, g=8501, q=157)
Sending NMI from CPU 1 to CPUs 0:
NMI backtrace for cpu 0
CPU: 0 PID: 3843 Comm: kworker/0:10 Not tainted 5.8.0-rc3-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Workqueue: events iterate_cleanup_work
RIP: 0010:check_memory_region_inline mm/kasan/generic.c:172 [inline]
RIP: 0010:check_memory_region+0x9/0x180 mm/kasan/generic.c:192
Code: 00 48 89 f2 be f5 00 00 00 e9 43 25 ff 01 0f 1f 00 48 89 f2 be f8 00 00 00 e9 33 25 ff 01 0f 1f 00 48 85 f6 0f 84 70 01 00 00 <49> 89 f9 41 54 44 0f b6 c2 49 01 f1 55 53 0f 82 18 01 00 00 48 b8
RSP: 0018:ffffc90000007b30 EFLAGS: 00000002
RAX: 0000000000000001 RBX: 0000000000000054 RCX: ffffffff8159836c
RDX: 0000000000000000 RSI: 0000000000000008 RDI: ffffffff8c58fa28
RBP: ffff8880995340c0 R08: 0000000000000000 R09: ffffffff8c58fa2f
R10: fffffbfff18b1f45 R11: 0000000000000001 R12: 0000000000000000
R13: ffff888099534a2a R14: ffff888099534a08 R15: 0000000000000003
FS:  0000000000000000(0000) GS:ffff8880ae600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00000000004c9088 CR3: 0000000009a79000 CR4: 00000000001406f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <IRQ>
 instrument_atomic_read include/linux/instrumented.h:56 [inline]
 test_bit include/asm-generic/bitops/instrumented-non-atomic.h:110 [inline]
 hlock_class kernel/locking/lockdep.c:179 [inline]
 mark_lock+0xbc/0x1710 kernel/locking/lockdep.c:3937
 mark_usage kernel/locking/lockdep.c:3856 [inline]
 __lock_acquire+0x1422/0x56e0 kernel/locking/lockdep.c:4334
 lock_acquire+0x1f1/0xad0 kernel/locking/lockdep.c:4959
 __raw_spin_lock_irq include/linux/spinlock_api_smp.h:128 [inline]
 _raw_spin_lock_irq+0x5b/0x80 kernel/locking/spinlock.c:167
 __run_hrtimer kernel/time/hrtimer.c:1524 [inline]
 __hrtimer_run_queues+0x252/0xfc0 kernel/time/hrtimer.c:1584
 hrtimer_interrupt+0x32a/0x930 kernel/time/hrtimer.c:1646
 local_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1080 [inline]
 __sysvec_apic_timer_interrupt+0x142/0x5e0 arch/x86/kernel/apic/apic.c:1097
 asm_call_on_stack+0xf/0x20 arch/x86/entry/entry_64.S:711
 </IRQ>
 __run_on_irqstack arch/x86/include/asm/irq_stack.h:22 [inline]
 run_on_irqstack_cond arch/x86/include/asm/irq_stack.h:48 [inline]
 sysvec_apic_timer_interrupt+0xe0/0x120 arch/x86/kernel/apic/apic.c:1091
 asm_sysvec_apic_timer_interrupt+0x12/0x20 arch/x86/include/asm/idtentry.h:596
RIP: 0010:__sanitizer_cov_trace_pc+0x55/0x60 kernel/kcov.c:207
Code: 82 e0 13 00 00 83 f8 02 75 20 48 8b 8a e8 13 00 00 8b 92 e4 13 00 00 48 8b 01 48 83 c0 01 48 39 c2 76 07 48 89 34 c1 48 89 01 <c3> 66 2e 0f 1f 84 00 00 00 00 00 41 55 41 54 49 89 fc 55 48 bd eb
RSP: 0018:ffffc90004a3fbc0 EFLAGS: 00000293
RAX: 0000000000000000 RBX: 0000000000000000 RCX: ffffffff866f7422
RDX: ffff8880995340c0 RSI: ffffffff866f742f RDI: 0000000000000001
RBP: dffffc0000000000 R08: 0000000000000001 R09: 0000000000000003
R10: 0000000000000000 R11: 0000000000000000 R12: ffffffff89a6fc80
R13: 0000000000007f07 R14: 0000000000000000 R15: 0000000000000001
 get_next_corpse net/netfilter/nf_conntrack_core.c:2215 [inline]
 nf_ct_iterate_cleanup+0x11f/0x330 net/netfilter/nf_conntrack_core.c:2259
 nf_ct_iterate_cleanup_net net/netfilter/nf_conntrack_core.c:2344 [inline]
 nf_ct_iterate_cleanup_net+0x113/0x170 net/netfilter/nf_conntrack_core.c:2329
 iterate_cleanup_work+0x45/0x130 net/netfilter/nf_nat_masquerade.c:216
 process_one_work+0x94c/0x1670 kernel/workqueue.c:2269
 worker_thread+0x64c/0x1120 kernel/workqueue.c:2415
 kthread+0x3b5/0x4a0 kernel/kthread.c:291
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:293
INFO: NMI handler (nmi_cpu_backtrace_handler) took too long to run: 0.000 msecs
rcu: rcu_preempt kthread starved for 10482 jiffies! g8501 f0x0 RCU_GP_WAIT_FQS(5) ->state=0x402 ->cpu=1
rcu: 	Unless rcu_preempt kthread gets sufficient CPU time, OOM is now expected behavior.
rcu: RCU grace-period kthread stack dump:
rcu_preempt     I29664    10      2 0x00004000
Call Trace:
 context_switch kernel/sched/core.c:3453 [inline]
 __schedule+0x8e1/0x1eb0 kernel/sched/core.c:4178
 schedule+0xd0/0x2a0 kernel/sched/core.c:4253
 schedule_timeout+0x148/0x250 kernel/time/timer.c:1897
 rcu_gp_fqs_loop kernel/rcu/tree.c:1874 [inline]
 rcu_gp_kthread+0xae5/0x1b50 kernel/rcu/tree.c:2044
 kthread+0x3b5/0x4a0 kernel/kthread.c:291
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:293


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
