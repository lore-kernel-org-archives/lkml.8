Return-Path: <SRS0=g5yc=BI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AB94C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 08:44:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7C65020838
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 08:44:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727923AbgG2IoS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jul 2020 04:44:18 -0400
Received: from mail-il1-f198.google.com ([209.85.166.198]:53211 "EHLO
        mail-il1-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727849AbgG2IoR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jul 2020 04:44:17 -0400
Received: by mail-il1-f198.google.com with SMTP id o17so16122281ilt.19
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jul 2020 01:44:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=anzIlk8uQ2cLlHxDMSgByVSFr/B869Yekt2qxwnA7oA=;
        b=nlXVqo9TamVtCgMLVTQ3/ZGS78uQknt7MJeKY2h1DGk6DMbT66/VNA42tGu+Zd8CaI
         WSlhrIAVJgXOa6Ejm8LE81/xpb/yQowSPPU0BCdGYpvVhQocmUX2KS9Zzd5DNH98DZ9Z
         VkQ42kkzEAp7I60V1aAwPffMCRy9jjH4cjQ0cU+WYQVO3kQxyMoFxJti3XsPrzqt3MOi
         F/C3h8h2lQoqCpcG/QyQOsaBm+s6Nhet4fU4qlfjH8SeK0hmQepfhbjy0O4llG/jDZ+r
         04jk+c5Owxpn24lyEH+rckJO+mdPnmQei1S/JPV+vzSiK46pRbtk4dfK0B7MiQVirbzC
         4ujw==
X-Gm-Message-State: AOAM531Lggiiq0KEzZD1Yb3LHEQxWrxg70uc+BWHnRnq6WJFTWygXf7I
        TbqeW90HGGgCYKYLzcebKaH6BBbqKrbQFbf2fFCLxqHcOduf
X-Google-Smtp-Source: ABdhPJynPK1t3lnNnbdq5kkpeHB0FMH/dDa47bfj7obpIa0e2iQNibVSj4ceL7COUZmWH8C/vgRU0zC11syELo0U3gGpVxB4WM7Z
MIME-Version: 1.0
X-Received: by 2002:a6b:9242:: with SMTP id u63mr30892261iod.92.1596012255787;
 Wed, 29 Jul 2020 01:44:15 -0700 (PDT)
Date:   Wed, 29 Jul 2020 01:44:15 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000903d5805ab908fc4@google.com>
Subject: INFO: rcu detected stall in smp_call_function
From:   syzbot <syzbot+cb3b69ae80afd6535b0e@syzkaller.appspotmail.com>
To:     fweisbec@gmail.com, linux-kernel@vger.kernel.org, mingo@kernel.org,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    6ba1b005 Merge tag 'asm-generic-fixes-5.8' of git://git.ke..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=14da5522900000
kernel config:  https://syzkaller.appspot.com/x/.config?x=812bbfcb6ae2cd60
dashboard link: https://syzkaller.appspot.com/bug?extid=cb3b69ae80afd6535b0e
compiler:       clang version 10.0.0 (https://github.com/llvm/llvm-project/ c2443155a0fb245c8f17f2c1c72b6ea391e86e81)

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+cb3b69ae80afd6535b0e@syzkaller.appspotmail.com

rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
rcu: 	Tasks blocked on level-0 rcu_node (CPUs 0-1):
------------[ cut here ]------------
IRQs not enabled as expected
WARNING: CPU: 0 PID: 32297 at kernel/sched/core.c:2701 try_invoke_on_locked_down_task+0x18b/0x320 kernel/sched/core.c:2701
Kernel panic - not syncing: panic_on_warn set ...
CPU: 0 PID: 32297 Comm: syz-executor.2 Not tainted 5.8.0-rc7-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 <IRQ>
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x1f0/0x31e lib/dump_stack.c:118
 panic+0x264/0x7a0 kernel/panic.c:231
 __warn+0x227/0x250 kernel/panic.c:600
 report_bug+0x1b1/0x2e0 lib/bug.c:198
 handle_bug+0x42/0x80 arch/x86/kernel/traps.c:235
 exc_invalid_op+0x16/0x40 arch/x86/kernel/traps.c:255
 asm_exc_invalid_op+0x12/0x20 arch/x86/include/asm/idtentry.h:540
RIP: 0010:try_invoke_on_locked_down_task+0x18b/0x320 kernel/sched/core.c:2701
Code: 48 89 df e8 f7 35 09 00 4c 89 f7 e8 df b5 cf 06 e9 b5 00 00 00 c6 05 34 82 38 08 01 48 c7 c7 8c d7 07 89 31 c0 e8 a5 a9 f5 ff <0f> 0b e9 15 ff ff ff 48 c7 c1 30 71 8d 89 80 e1 07 80 c1 03 38 c1
RSP: 0018:ffffc90000007c50 EFLAGS: 00010046
RAX: 1aaa08be6903c500 RBX: ffff888085d16ac8 RCX: ffff888085d16240
RDX: 0000000000010004 RSI: 0000000000010004 RDI: 0000000000000000
RBP: ffff888085d16b0c R08: ffffffff815dd389 R09: ffffed1015d041c3
R10: ffffed1015d041c3 R11: 0000000000000000 R12: 0000000000000000
R13: ffff8880a8bac140 R14: ffff8880a8bac4c0 R15: dffffc0000000000
 rcu_print_task_stall kernel/rcu/tree_stall.h:269 [inline]
 print_other_cpu_stall kernel/rcu/tree_stall.h:477 [inline]
 check_cpu_stall kernel/rcu/tree_stall.h:636 [inline]
 rcu_pending kernel/rcu/tree.c:3489 [inline]
 rcu_sched_clock_irq+0x12ec/0x1eb0 kernel/rcu/tree.c:2504
 update_process_times+0x12c/0x180 kernel/time/timer.c:1737
 tick_sched_handle kernel/time/tick-sched.c:176 [inline]
 tick_sched_timer+0x254/0x410 kernel/time/tick-sched.c:1320
 __run_hrtimer kernel/time/hrtimer.c:1520 [inline]
 __hrtimer_run_queues+0x42d/0x930 kernel/time/hrtimer.c:1584
 hrtimer_interrupt+0x373/0xd60 kernel/time/hrtimer.c:1646
 local_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1080 [inline]
 __sysvec_apic_timer_interrupt+0xf0/0x260 arch/x86/kernel/apic/apic.c:1097
 asm_call_on_stack+0xf/0x20 arch/x86/entry/entry_64.S:711
 </IRQ>
 __run_on_irqstack arch/x86/include/asm/irq_stack.h:22 [inline]
 run_on_irqstack_cond arch/x86/include/asm/irq_stack.h:48 [inline]
 sysvec_apic_timer_interrupt+0xb9/0x130 arch/x86/kernel/apic/apic.c:1091
 asm_sysvec_apic_timer_interrupt+0x12/0x20 arch/x86/include/asm/idtentry.h:585
RIP: 0010:csd_lock_wait kernel/smp.c:108 [inline]
RIP: 0010:smp_call_function_single+0x307/0x450 kernel/smp.c:382
Code: e6 01 31 ff e8 6a 05 0b 00 41 83 e5 01 75 14 e8 4f 01 0b 00 eb 45 0f 1f 00 66 2e 0f 1f 84 00 00 00 00 00 f3 90 42 0f b6 04 23 <84> c0 75 0d 41 f6 07 01 74 22 e8 2a 01 0b 00 eb e8 44 89 f9 80 e1
RSP: 0018:ffffc90006d5faa0 EFLAGS: 00000293
RAX: 0000000000000000 RBX: 1ffff92000dabf59 RCX: ffff888085d16240
RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000000
RBP: ffffc90006d5fb28 R08: ffffffff816990e6 R09: ffffed1015d26d11
R10: ffffed1015d26d11 R11: 0000000000000000 R12: dffffc0000000000
R13: 0000000000000001 R14: 0000000000000000 R15: ffffc90006d5fac8
 smp_call_function_many kernel/smp.c:577 [inline]
 smp_call_function kernel/smp.c:599 [inline]
 on_each_cpu+0x4d/0x1f0 kernel/smp.c:699
 text_poke_sync arch/x86/kernel/alternative.c:996 [inline]
 text_poke_bp_batch+0x1df/0x640 arch/x86/kernel/alternative.c:1174
 text_poke_flush arch/x86/kernel/alternative.c:1296 [inline]
 text_poke_finish+0x16/0x30 arch/x86/kernel/alternative.c:1303
 arch_jump_label_transform_apply+0x13/0x20 arch/x86/kernel/jump_label.c:126
 __static_key_slow_dec_cpuslocked kernel/jump_label.c:248 [inline]
 __static_key_slow_dec+0x109/0x140 kernel/jump_label.c:255
 tracepoint_remove_func kernel/tracepoint.c:285 [inline]
 tracepoint_probe_unregister+0x48a/0x540 kernel/tracepoint.c:355
 trace_event_reg+0x215/0x250 kernel/trace/trace_events.c:308
 perf_trace_event_unreg+0xb1/0x1d0 kernel/trace/trace_event_perf.c:162
 perf_trace_destroy+0x93/0xb0 kernel/trace/trace_event_perf.c:243
 _free_event+0xc08/0x1120 kernel/events/core.c:4795
 put_event kernel/events/core.c:4889 [inline]
 perf_event_release_kernel+0xbd7/0xc90 kernel/events/core.c:5004
 perf_release+0x37/0x40 kernel/events/core.c:5014
 __fput+0x2f0/0x750 fs/file_table.c:281
 task_work_run+0x137/0x1c0 kernel/task_work.c:135
 tracehook_notify_resume include/linux/tracehook.h:188 [inline]
 exit_to_usermode_loop arch/x86/entry/common.c:239 [inline]
 __prepare_exit_to_usermode+0x14c/0x1e0 arch/x86/entry/common.c:269
 do_syscall_64+0x7f/0xe0 arch/x86/entry/common.c:393
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x415ee1
Code: 75 14 b8 03 00 00 00 0f 05 48 3d 01 f0 ff ff 0f 83 04 1b 00 00 c3 48 83 ec 08 e8 0a fc ff ff 48 89 04 24 b8 03 00 00 00 0f 05 <48> 8b 3c 24 48 89 c2 e8 53 fc ff ff 48 89 d0 48 83 c4 08 48 3d 01
RSP: 002b:00007ffcaab40390 EFLAGS: 00000293 ORIG_RAX: 0000000000000003
RAX: 0000000000000000 RBX: 0000000000000005 RCX: 0000000000415ee1
RDX: 0000000000000000 RSI: 0000000000001c3c RDI: 0000000000000004
RBP: 0000000000000001 R08: 00000000ad6d3c3b R09: 00000000ad6d3c3f
R10: 00007ffcaab40480 R11: 0000000000000293 R12: 000000000078c900
R13: 000000000078c900 R14: ffffffffffffffff R15: 000000000078bfac
Shutting down cpus with NMI
Kernel Offset: disabled
Rebooting in 86400 seconds..


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
