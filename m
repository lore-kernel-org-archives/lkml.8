Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A2BBC433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 15:13:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4284E20663
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 15:13:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728194AbgGGPNT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 11:13:19 -0400
Received: from mail-io1-f72.google.com ([209.85.166.72]:49962 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727777AbgGGPNS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 11:13:18 -0400
Received: by mail-io1-f72.google.com with SMTP id d20so26062360iom.16
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jul 2020 08:13:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=I8n5rZKIAPnIo1jKPBjEGsh0wkqyxk3DPzjupYQhwvo=;
        b=Tf6O9hCXx/9YnJl5kpLmKsOlhnBeIk/RuTaXz4CS0ojT5Tqo1q8rz04Ydsbc/Azx5n
         T7O4d3+MgotuY5KWNcbZel78QwFBWfGwJ15C+9mq7a470rn3fdO4I5K64jYz5oFy4Jqm
         54OouGIbC2rUNK6bIU1cuE3zd0BME94vmznqJXiDhLswU5O1/7N8XGwhtvbH1zF/rIdt
         1An8Szix05WmEpiyJkcxtNlZ/eIcuFwS7qoAj0Lyc9zATMvKmFdtPXQm/8/BMOxlzp7c
         GNqNIJNf3wygaa+rg3Y+6dM0zrU7fueycf/QL3RoJZ62ZawPvaKjCxLv/3tsNQvdaeaE
         Ma9Q==
X-Gm-Message-State: AOAM532vosT+xy8m83x8UYxXL1zD9n+F/jE6Kr7C9iFvg3h46IeSHXBu
        8NyT2cIoIJ7fvRbaVajElZrRMSq/txwFnSZ6SmwJGJkR0v+B
X-Google-Smtp-Source: ABdhPJxbPhMx5LdIKwvmZReWSt8AwQSMHVUpJhrDQkaawGVaiCwhdTP8NO8Om5IV8RsM0J4xPbU7TdtavJ9QERFWYNFO+HQRXwlL
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:138f:: with SMTP id d15mr33680582ilo.63.1594134796825;
 Tue, 07 Jul 2020 08:13:16 -0700 (PDT)
Date:   Tue, 07 Jul 2020 08:13:16 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000049fa3b05a9db6edb@google.com>
Subject: INFO: rcu detected stall in sys_clock_adjtime
From:   syzbot <syzbot+25b7addb06e92c482190@syzkaller.appspotmail.com>
To:     fweisbec@gmail.com, linux-kernel@vger.kernel.org, mingo@kernel.org,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    7cc2a8ea Merge tag 'block-5.8-2020-07-01' of git://git.ker..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1204932f100000
kernel config:  https://syzkaller.appspot.com/x/.config?x=183dd243398ba7ec
dashboard link: https://syzkaller.appspot.com/bug?extid=25b7addb06e92c482190
compiler:       clang version 10.0.0 (https://github.com/llvm/llvm-project/ c2443155a0fb245c8f17f2c1c72b6ea391e86e81)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1531b0bd100000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15514c33100000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+25b7addb06e92c482190@syzkaller.appspotmail.com

rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
rcu: 	Tasks blocked on level-0 rcu_node (CPUs 0-1):
------------[ cut here ]------------
IRQs not enabled as expected
WARNING: CPU: 1 PID: 4737 at kernel/sched/core.c:2698 try_invoke_on_locked_down_task+0x18b/0x320 kernel/sched/core.c:2698
Kernel panic - not syncing: panic_on_warn set ...
CPU: 1 PID: 4737 Comm: systemd-timesyn Not tainted 5.8.0-rc3-syzkaller #0
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
 asm_exc_invalid_op+0x12/0x20 arch/x86/include/asm/idtentry.h:563
RIP: 0010:try_invoke_on_locked_down_task+0x18b/0x320 kernel/sched/core.c:2698
Code: 48 89 df e8 a7 35 09 00 4c 89 f7 e8 3f 63 ce 06 e9 b5 00 00 00 c6 05 92 7d 18 08 01 48 c7 c7 fc a9 e7 88 31 c0 e8 65 a8 f5 ff <0f> 0b e9 15 ff ff ff 48 c7 c1 70 5d 6d 89 80 e1 07 80 c1 03 38 c1
RSP: 0018:ffffc90000da8c50 EFLAGS: 00010046
RAX: 82cfb6c0e4d32500 RBX: ffff888096c1ee08 RCX: ffff888096c1e580
RDX: 0000000000010004 RSI: 0000000000010004 RDI: 0000000000000000
RBP: ffff888096c1ee4c R08: ffffffff815dc419 R09: ffffed1015d241c3
R10: ffffed1015d241c3 R11: 0000000000000000 R12: 0000000000000000
R13: ffff8880a9990040 R14: ffff8880a99903c0 R15: dffffc0000000000
 rcu_print_task_stall kernel/rcu/tree_stall.h:269 [inline]
 print_other_cpu_stall kernel/rcu/tree_stall.h:477 [inline]
 check_cpu_stall kernel/rcu/tree_stall.h:636 [inline]
 rcu_pending kernel/rcu/tree.c:3489 [inline]
 rcu_sched_clock_irq+0x12ec/0x1eb0 kernel/rcu/tree.c:2504
 update_process_times+0x12c/0x180 kernel/time/timer.c:1726
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
 asm_sysvec_apic_timer_interrupt+0x12/0x20 arch/x86/include/asm/idtentry.h:596
RIP: 0010:csd_lock_wait kernel/smp.c:108 [inline]
RIP: 0010:smp_call_function_single+0x311/0x450 kernel/smp.c:382
Code: 83 e5 01 75 14 e8 4f 00 0b 00 eb 45 0f 1f 00 66 2e 0f 1f 84 00 00 00 00 00 f3 90 42 0f b6 04 23 84 c0 75 0d 41 f6 07 01 74 22 <e8> 2a 00 0b 00 eb e8 44 89 f9 80 e1 07 80 c1 03 38 c1 7c e6 4c 89
RSP: 0018:ffffc90001c27be0 EFLAGS: 00000202
RAX: 0000000000000000 RBX: 1ffff92000384f81 RCX: ffff888096c1e580
RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000000
RBP: ffffc90001c27c80 R08: ffffffff81697bb6 R09: ffffed1015d06d11
R10: ffffed1015d06d11 R11: 0000000000000000 R12: dffffc0000000000
R13: 0000000000000001 R14: 0000000000000000 R15: ffffc90001c27c08
 smp_call_function_many kernel/smp.c:577 [inline]
 smp_call_function kernel/smp.c:599 [inline]
 on_each_cpu+0x4d/0x1f0 kernel/smp.c:699
 clock_was_set+0x18/0x20 kernel/time/hrtimer.c:872
 timekeeping_inject_offset+0x5e6/0x610 kernel/time/timekeeping.c:1305
 do_adjtimex+0x3ac/0x8f0 kernel/time/timekeeping.c:2332
 do_clock_adjtime kernel/time/posix-timers.c:1109 [inline]
 __do_sys_clock_adjtime kernel/time/posix-timers.c:1121 [inline]
 __se_sys_clock_adjtime kernel/time/posix-timers.c:1112 [inline]
 __x64_sys_clock_adjtime+0x17e/0x210 kernel/time/posix-timers.c:1112
 do_syscall_64+0x73/0xe0 arch/x86/entry/common.c:359
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x7f4117ebd1b7
Code: Bad RIP value.
RSP: 002b:00007ffeedde6cd8 EFLAGS: 00000246 ORIG_RAX: 0000000000000131
RAX: ffffffffffffffda RBX: 000055f707897630 RCX: 00007f4117ebd1b7
RDX: ffffffffe7ce77f1 RSI: 00007ffeedde6da0 RDI: 0000000000000000
RBP: 00007ffeedde6da0 R08: 0000000000000020 R09: 000000000000000d
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000ffffffff
R13: 00007ffeedde6e90 R14: 0000000000000005 R15: 0000000000000001
Shutting down cpus with NMI
Kernel Offset: disabled
Rebooting in 86400 seconds..


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
