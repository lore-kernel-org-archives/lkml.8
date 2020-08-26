Return-Path: <SRS0=kGB5=CE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEE14C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 14:27:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9301821741
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 14:27:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727979AbgHZO13 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 10:27:29 -0400
Received: from mail-io1-f71.google.com ([209.85.166.71]:39167 "EHLO
        mail-io1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726950AbgHZO1V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 10:27:21 -0400
Received: by mail-io1-f71.google.com with SMTP id v10so1353271iot.6
        for <linux-kernel@vger.kernel.org>; Wed, 26 Aug 2020 07:27:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=2t2imlzUJImx6gGVkGASznZ5mLOsmh2h9yveaDOOsmQ=;
        b=OgeMuxilEw403c/lfznn1u9YGucnzVOrQ/pZ4OxoszxGOQZPADT7qhuC7I/KPameeu
         uxdGt0CpibzVm0w8PuyFz4A05djtao4TWJNnWXrKNqwet9uqs+yW0zwU2QOKxAzkBOUD
         KQiRRZUycMJu8Gr2SznRwVG2GsR2SN/Sgv9OX/pOP/Kx5zjKTMHuSgv7DFA285m8Egyp
         N2jNsXCBZnKbC5FRU/OYGR55EBodfpVsm7BoeUrmF9lFIsv4VIG5n/rJOrONBRYYgyki
         f5sy6fHKc8qNIcFo2105rCHtAl+GF0u51b+8ENH98dXOo3/SwrGrmORqEnm7lSrsjdff
         hXgA==
X-Gm-Message-State: AOAM5332WT6NvKi8EqzxrsiluNzcUG4q+lMCWk9kFIq42m8yMt5DfSfN
        loVjow+MgsIx63GN1CddWpp1hvGrzvLy30t3HJJrSBPL0aMK
X-Google-Smtp-Source: ABdhPJxsdSc3sDn3B4+ihFDNyOQDunKNE96JPJyLreZd3lon0uehkjiCIVmdeeNvC+2yVc2Wsa6pz/VE7TNQ9EBB0vkcgaIG5W/0
MIME-Version: 1.0
X-Received: by 2002:a92:d2c1:: with SMTP id w1mr12335216ilg.273.1598452040492;
 Wed, 26 Aug 2020 07:27:20 -0700 (PDT)
Date:   Wed, 26 Aug 2020 07:27:20 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000106c1305adc89e60@google.com>
Subject: INFO: rcu detected stall in process_one_work (3)
From:   syzbot <syzbot+f0f857c714a8800e048c@syzkaller.appspotmail.com>
To:     fweisbec@gmail.com, linux-kernel@vger.kernel.org, mingo@kernel.org,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    abb3438d Merge tag 'm68knommu-for-v5.9-rc3' of git://git.k..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=11563996900000
kernel config:  https://syzkaller.appspot.com/x/.config?x=978db74cb30aa994
dashboard link: https://syzkaller.appspot.com/bug?extid=f0f857c714a8800e048c
compiler:       gcc (GCC) 10.1.0-syz 20200507
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15f47cb9900000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14171941900000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+f0f857c714a8800e048c@syzkaller.appspotmail.com

rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
rcu: 	Tasks blocked on level-0 rcu_node (CPUs 0-1):
------------[ cut here ]------------
WARNING: CPU: 1 PID: 6878 at kernel/sched/core.c:3013 rq_unlock kernel/sched/sched.h:1326 [inline]
WARNING: CPU: 1 PID: 6878 at kernel/sched/core.c:3013 try_invoke_on_locked_down_task+0x214/0x2c0 kernel/sched/core.c:3019
Kernel panic - not syncing: panic_on_warn set ...
CPU: 1 PID: 6878 Comm: kworker/1:0 Not tainted 5.9.0-rc2-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Workqueue: rcu_gp srcu_invoke_callbacks
Call Trace:
 <IRQ>
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x18f/0x20d lib/dump_stack.c:118
 panic+0x2e3/0x75c kernel/panic.c:231
 __warn.cold+0x20/0x4a kernel/panic.c:600
 report_bug+0x1bd/0x210 lib/bug.c:198
 handle_bug+0x38/0x90 arch/x86/kernel/traps.c:234
 exc_invalid_op+0x14/0x40 arch/x86/kernel/traps.c:254
 asm_exc_invalid_op+0x12/0x20 arch/x86/include/asm/idtentry.h:536
RIP: 0010:try_invoke_on_locked_down_task+0x214/0x2c0 kernel/sched/core.c:3013
Code: 45 31 f6 49 39 c0 74 3a 8b 74 24 38 49 8d 78 18 4c 89 04 24 e8 2d 99 08 00 4c 8b 04 24 4c 89 c7 e8 41 33 a5 06 e9 29 ff ff ff <0f> 0b e9 86 fe ff ff 4c 89 ee 48 89 ef 41 ff d4 41 89 c6 e9 11 ff
RSP: 0018:ffffc90000da8bd8 EFLAGS: 00010046
RAX: 0000000000000000 RBX: 1ffff920001b517d RCX: 0000000000000001
RDX: 0000000000000000 RSI: ffffffff81612380 RDI: ffff8880953c2540
RBP: ffff8880953c2540 R08: 0000000000000033 R09: ffffffff89bcb363
R10: 0000000000000629 R11: 0000000000000001 R12: ffffffff81612380
R13: ffffc90000da8d00 R14: ffff8880953c28c0 R15: ffff8880ae736c00
 rcu_print_task_stall kernel/rcu/tree_stall.h:267 [inline]
 print_other_cpu_stall kernel/rcu/tree_stall.h:475 [inline]
 check_cpu_stall kernel/rcu/tree_stall.h:634 [inline]
 rcu_pending kernel/rcu/tree.c:3637 [inline]
 rcu_sched_clock_irq.cold+0x92e/0xccd kernel/rcu/tree.c:2519
 update_process_times+0x25/0xa0 kernel/time/timer.c:1710
 tick_sched_handle+0x9b/0x180 kernel/time/tick-sched.c:176
 tick_sched_timer+0x1d1/0x2a0 kernel/time/tick-sched.c:1328
 __run_hrtimer kernel/time/hrtimer.c:1524 [inline]
 __hrtimer_run_queues+0x1d5/0xfc0 kernel/time/hrtimer.c:1588
 hrtimer_interrupt+0x32a/0x930 kernel/time/hrtimer.c:1650
 local_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1080 [inline]
 __sysvec_apic_timer_interrupt+0x142/0x5e0 arch/x86/kernel/apic/apic.c:1097
 asm_call_on_stack+0xf/0x20 arch/x86/entry/entry_64.S:706
 </IRQ>
 __run_on_irqstack arch/x86/include/asm/irq_stack.h:22 [inline]
 run_on_irqstack_cond arch/x86/include/asm/irq_stack.h:48 [inline]
 sysvec_apic_timer_interrupt+0xb2/0xf0 arch/x86/kernel/apic/apic.c:1091
 asm_sysvec_apic_timer_interrupt+0x12/0x20 arch/x86/include/asm/idtentry.h:581
RIP: 0010:arch_local_irq_restore arch/x86/include/asm/paravirt.h:770 [inline]
RIP: 0010:__raw_spin_unlock_irqrestore include/linux/spinlock_api_smp.h:160 [inline]
RIP: 0010:_raw_spin_unlock_irqrestore+0x8c/0xe0 kernel/locking/spinlock.c:191
Code: 48 c7 c0 c8 3b b6 89 48 ba 00 00 00 00 00 fc ff df 48 c1 e8 03 80 3c 10 00 75 37 48 83 3d f3 0f c0 01 00 74 22 48 89 df 57 9d <0f> 1f 44 00 00 bf 01 00 00 00 e8 95 87 59 f9 65 8b 05 8e d2 0b 78
RSP: 0018:ffffc90003ac7c28 EFLAGS: 00000286
RAX: 1ffffffff136c779 RBX: 0000000000000286 RCX: 0000000000000002
RDX: dffffc0000000000 RSI: 0000000000000000 RDI: 0000000000000286
RBP: ffffc90000dd7c30 R08: 0000000000000001 R09: ffffffff8c5f3a0f
R10: fffffbfff18be741 R11: 0000000000000001 R12: ffffe8ffffd0a740
R13: ffffe8ffffd0a680 R14: ffffe8ffffd0a640 R15: ffffc90000dd7c18
 srcu_invoke_callbacks+0x207/0x399 kernel/rcu/srcutree.c:1201
 process_one_work+0x94c/0x1670 kernel/workqueue.c:2269
 worker_thread+0x64c/0x1120 kernel/workqueue.c:2415
 kthread+0x3b5/0x4a0 kernel/kthread.c:292
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:294
Shutting down cpus with NMI
Kernel Offset: disabled
Rebooting in 86400 seconds..


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
