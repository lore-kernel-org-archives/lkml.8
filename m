Return-Path: <SRS0=5bHT=BN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD6B6C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 16:25:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9E1F22070A
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 16:25:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727103AbgHCQZX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 12:25:23 -0400
Received: from mail-io1-f69.google.com ([209.85.166.69]:43079 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726239AbgHCQZX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 12:25:23 -0400
Received: by mail-io1-f69.google.com with SMTP id f19so2772515iol.10
        for <linux-kernel@vger.kernel.org>; Mon, 03 Aug 2020 09:25:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=iA6iOYktmK/Srv9I7wG9OHS6dI76LJtSQKyoubxTgUg=;
        b=bJpHPWWVfURa5Lj0GmdvqxHxfqiJtygWJClOAN+JxsOwHgCFm7EWy5xZ6E7QVUbcFk
         hAZFIPxyvT1ceZT7PnTlD84YGv8vNhd9Atalfnz5oVwq0X0ZCymARCTZ7nApVDW4x9FN
         NN2BWbw0tS8OQY0lehjdor/Lcc3RY2WyJ4QLUCbFdVAXG7XgvnevjOhK3pfgeFzSkD9G
         7gMvQo2jpEJeszkp/k7G9V9dLcBpjEUgFqZtlpIVO3K8FTPuDAZ5/vCv5OPQU3RpNTtz
         4NBQfYh7ROe3NFMB/b4kHAditZfBK5evqswUQQgWtihWOlnTUA0wZ1QXC3aNEHHHf0hd
         5B3w==
X-Gm-Message-State: AOAM53313ZT+fqr9Ia6FHFRcyxVBhi8dlWtRS/TUmJn60v2KVkwokSUs
        xK1veLuGnAy3FmTWuY/cSTBpJY9W8LHeyb6K6UXbJioNfo5P
X-Google-Smtp-Source: ABdhPJzlkcYXWTUiAtd5p1DnD2bzbaDQnhSUN7g/opyd+SYhhA0eRQh7Dp0J5GI3Y3n8WGlpDPfVBt7i45/zQTv+OMTltg/PyL5N
MIME-Version: 1.0
X-Received: by 2002:a92:ad03:: with SMTP id w3mr203136ilh.22.1596471921612;
 Mon, 03 Aug 2020 09:25:21 -0700 (PDT)
Date:   Mon, 03 Aug 2020 09:25:21 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c81ce605abfb956f@google.com>
Subject: INFO: rcu detected stall in addrconf_rs_timer (4)
From:   syzbot <syzbot+ca2665ae8487c46d365d@syzkaller.appspotmail.com>
To:     fweisbec@gmail.com, linux-kernel@vger.kernel.org, mingo@kernel.org,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    7cc2a8ea Merge tag 'block-5.8-2020-07-01' of git://git.ker..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=113132a7100000
kernel config:  https://syzkaller.appspot.com/x/.config?x=183dd243398ba7ec
dashboard link: https://syzkaller.appspot.com/bug?extid=ca2665ae8487c46d365d
compiler:       clang version 10.0.0 (https://github.com/llvm/llvm-project/ c2443155a0fb245c8f17f2c1c72b6ea391e86e81)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13db60a3100000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11d5a66d100000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+ca2665ae8487c46d365d@syzkaller.appspotmail.com

rcu: INFO: rcu_preempt self-detected stall on CPU
rcu: 	0-....: (1 GPs behind) idle=036/1/0x4000000000000000 softirq=8112/8113 fqs=5248 
	(t=10502 jiffies g=7165 q=165)
NMI backtrace for cpu 0
CPU: 0 PID: 7101 Comm: syz-executor548 Not tainted 5.8.0-rc3-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 <IRQ>
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x1f0/0x31e lib/dump_stack.c:118
 nmi_cpu_backtrace+0x9f/0x180 lib/nmi_backtrace.c:101
 nmi_trigger_cpumask_backtrace+0x16a/0x280 lib/nmi_backtrace.c:62
 trigger_single_cpu_backtrace include/linux/nmi.h:164 [inline]
 rcu_dump_cpu_stacks+0x199/0x2a0 kernel/rcu/tree_stall.h:320
 print_cpu_stall kernel/rcu/tree_stall.h:553 [inline]
 check_cpu_stall kernel/rcu/tree_stall.h:627 [inline]
 rcu_pending kernel/rcu/tree.c:3489 [inline]
 rcu_sched_clock_irq+0x1928/0x1eb0 kernel/rcu/tree.c:2504
 update_process_times+0x12c/0x180 kernel/time/timer.c:1726
 tick_sched_handle kernel/time/tick-sched.c:176 [inline]
 tick_sched_timer+0x254/0x410 kernel/time/tick-sched.c:1320
 __run_hrtimer kernel/time/hrtimer.c:1520 [inline]
 __hrtimer_run_queues+0x42d/0x930 kernel/time/hrtimer.c:1584
 hrtimer_interrupt+0x373/0xd60 kernel/time/hrtimer.c:1646
 local_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1080 [inline]
 __sysvec_apic_timer_interrupt+0xf0/0x260 arch/x86/kernel/apic/apic.c:1097
 run_on_irqstack_cond arch/x86/include/asm/irq_stack.h:50 [inline]
 sysvec_apic_timer_interrupt+0x112/0x130 arch/x86/kernel/apic/apic.c:1091
 asm_sysvec_apic_timer_interrupt+0x12/0x20 arch/x86/include/asm/idtentry.h:596
RIP: 0010:unwind_next_frame+0xb2/0x1e90 arch/x86/kernel/unwind_orc.c:437
Code: 00 00 48 89 4c 24 68 4c 89 6c 24 48 4c 89 64 24 40 4c 89 7c 24 58 48 89 6c 24 28 bf 01 00 00 00 e8 43 12 1d 00 48 89 5c 24 08 <48> 83 c3 50 48 89 d8 48 c1 e8 03 48 89 44 24 38 42 80 3c 30 00 74
RSP: 0018:ffffc90000007630 EFLAGS: 00000206
RAX: 0000000000000301 RBX: ffffc900000076f8 RCX: ffffc90001cd7f58
RDX: dffffc0000000000 RSI: ffffffff88200078 RDI: 0000000000000001
RBP: 1ffff92000000edf R08: 000000000000001a R09: ffffc900000077a8
R10: fffff52000000eeb R11: 0000000000000000 R12: ffffc90000007730
R13: 1ffff92000000ee6 R14: dffffc0000000000 R15: ffffffff88200078
 arch_stack_walk+0xb4/0xe0 arch/x86/kernel/stacktrace.c:25
 stack_trace_save+0xad/0x150 kernel/stacktrace.c:123
 save_stack mm/kasan/common.c:48 [inline]
 set_track mm/kasan/common.c:56 [inline]
 __kasan_kmalloc+0x103/0x140 mm/kasan/common.c:494
 slab_post_alloc_hook mm/slab.h:586 [inline]
 slab_alloc mm/slab.c:3320 [inline]
 __do_kmalloc mm/slab.c:3654 [inline]
 __kmalloc+0x228/0x330 mm/slab.c:3665
 kmalloc include/linux/slab.h:560 [inline]
 kzalloc+0x1d/0x40 include/linux/slab.h:669
 neigh_alloc net/core/neighbour.c:399 [inline]
 ___neigh_create+0x54c/0x1c50 net/core/neighbour.c:577
 ip6_finish_output2+0x95b/0x1400 net/ipv6/ip6_output.c:114
 dst_output include/net/dst.h:435 [inline]
 NF_HOOK include/linux/netfilter.h:307 [inline]
 ndisc_send_skb+0x92d/0xd20 net/ipv6/ndisc.c:506
 addrconf_rs_timer+0x226/0x680 net/ipv6/addrconf.c:3848
 call_timer_fn+0x91/0x160 kernel/time/timer.c:1404
 expire_timers kernel/time/timer.c:1449 [inline]
 __run_timers+0x736/0x930 kernel/time/timer.c:1773
 run_timer_softirq+0x46/0x80 kernel/time/timer.c:1786
 __do_softirq+0x268/0x80c kernel/softirq.c:292
 asm_call_on_stack+0xf/0x20 arch/x86/entry/entry_64.S:711
 </IRQ>
 __run_on_irqstack arch/x86/include/asm/irq_stack.h:22 [inline]
 run_on_irqstack_cond arch/x86/include/asm/irq_stack.h:48 [inline]
 do_softirq_own_stack+0xe0/0x1a0 arch/x86/kernel/irq_64.c:77
 invoke_softirq kernel/softirq.c:387 [inline]
 __irq_exit_rcu+0x1e1/0x1f0 kernel/softirq.c:417
 irq_exit_rcu+0x6/0x50 kernel/softirq.c:429
 sysvec_apic_timer_interrupt+0x117/0x130 arch/x86/kernel/apic/apic.c:1091
 asm_sysvec_apic_timer_interrupt+0x12/0x20 arch/x86/include/asm/idtentry.h:596
RIP: 0010:__sanitizer_cov_trace_switch+0x46/0x100 kernel/kcov.c:319
Code: d3 00 00 00 48 c1 e9 03 ba 8b 00 00 00 0f a3 ca 0f 83 c1 00 00 00 4c 8b 16 4d 85 d2 0f 84 b5 00 00 00 4c 8b 04 c5 48 7f 64 88 <4c> 8b 4c 24 20 65 4c 8b 1c 25 00 fe 01 00 31 d2 eb 14 0f 1f 84 00
RSP: 0018:ffffc90001cd7c68 EFLAGS: 00000202
RAX: 0000000000000007 RBX: 0000000000000001 RCX: 0000000000000007
RDX: 000000000000008b RSI: ffffffff89309a70 RDI: ffff888087e62340
RBP: ffff888087e62340 R08: 0000000000000007 R09: ffffed1012283d8a
R10: 0000000000000002 R11: 0000000000000000 R12: ffffffff8191d4d0
R13: 0000000000000001 R14: dffffc0000000000 R15: ffff888090a9b000
 event_function_call+0x181/0x580 kernel/events/core.c:274
 perf_remove_from_context+0xb0/0x1e0 kernel/events/core.c:2338
 perf_event_release_kernel+0x54b/0xc90 kernel/events/core.c:4918
 perf_release+0x37/0x40 kernel/events/core.c:5014
 __fput+0x2f0/0x750 fs/file_table.c:281
 task_work_run+0x137/0x1c0 kernel/task_work.c:135
 tracehook_notify_resume include/linux/tracehook.h:188 [inline]
 exit_to_usermode_loop arch/x86/entry/common.c:216 [inline]
 __prepare_exit_to_usermode+0x14c/0x1e0 arch/x86/entry/common.c:246
 do_syscall_64+0x7f/0xe0 arch/x86/entry/common.c:368
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x404670
Code: Bad RIP value.
RSP: 002b:00007ffc65f0e6b8 EFLAGS: 00000246 ORIG_RAX: 0000000000000003
RAX: 0000000000000000 RBX: 0000000000000004 RCX: 0000000000404670
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000003
RBP: 0000000000000000 R08: 0000000000000000 R09: 00007ffc00306777
R10: 00000000ffffffff R11: 0000000000000246 R12: 0000000000000036
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
