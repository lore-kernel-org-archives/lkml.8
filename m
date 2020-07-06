Return-Path: <SRS0=eGSO=AR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CF3FC433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 15:42:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DC25720724
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 15:42:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729525AbgGFPmo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jul 2020 11:42:44 -0400
Received: from mail-il1-f199.google.com ([209.85.166.199]:42481 "EHLO
        mail-il1-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729565AbgGFPmZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jul 2020 11:42:25 -0400
Received: by mail-il1-f199.google.com with SMTP id d3so28097654ilq.9
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jul 2020 08:42:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=qVtrf7MKT2krp8tCRVff+TkuYaoVX+pY+sW/llawYnI=;
        b=uaPkNflt8Ww92kDWPISRXVkKFDWnWwA1pabJuyhKoi9YoV+Jc+oYILHs4eIYitvmI7
         rpCKiQ1YtIVKtz5afQN04kOzoPBCfC5Qft4VN3z4g7qWOexE2hd7zx1gohvN0P633l0K
         YJZS6ofyMkFRV4DTBnleiLrJF9VJYqUaTCV6ehwm13YnHaR+LaqMVjl0l9YAWUmC8OZz
         I9wAkDylnkgDp2rhqT002Ifvqo0Lc3YY3d24r6VuhlMVwf1+7CRqNkFfNXdexyD1h+8i
         Mny3sD6Lz4LY6zoNdaFZWR1RzpTUcZh+bV9Tf7a+6H9UHZGnt4Dzs5z8Ak+KXe6cz5iQ
         OxSw==
X-Gm-Message-State: AOAM533zw0TaXyjoNV8x3bbcX3f1Ttc0sRd5VRKUhHp7fV9GPeYykKb8
        GjpxdX4vSnrPQQ5uZNtRFYZ28IbooqRCO3XZNWE4BLjiAr8b
X-Google-Smtp-Source: ABdhPJxovul4xnDw06o2CGn0j0tdYIlYWXtccXwIz49ZmnCj15lFzt7TnY0Oz25CayUbjxuxWspVgSbsMYoTrYy82rjvR/vFfmdt
MIME-Version: 1.0
X-Received: by 2002:a02:cd06:: with SMTP id g6mr22654782jaq.37.1594050144410;
 Mon, 06 Jul 2020 08:42:24 -0700 (PDT)
Date:   Mon, 06 Jul 2020 08:42:24 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000009caba805a9c7b840@google.com>
Subject: INFO: rcu detected stall in __se_sys_mount
From:   syzbot <syzbot+3f2db34df769d77edf8c@syzkaller.appspotmail.com>
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
console output: https://syzkaller.appspot.com/x/log.txt?x=15ea5e6b100000
kernel config:  https://syzkaller.appspot.com/x/.config?x=183dd243398ba7ec
dashboard link: https://syzkaller.appspot.com/bug?extid=3f2db34df769d77edf8c
compiler:       clang version 10.0.0 (https://github.com/llvm/llvm-project/ c2443155a0fb245c8f17f2c1c72b6ea391e86e81)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13901c1f100000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+3f2db34df769d77edf8c@syzkaller.appspotmail.com

rcu: INFO: rcu_preempt self-detected stall on CPU
rcu: 	0-....: (1 GPs behind) idle=53a/1/0x4000000000000000 softirq=11025/11028 fqs=5230 
	(t=10500 jiffies g=9573 q=1291)
NMI backtrace for cpu 0
CPU: 0 PID: 8924 Comm: syz-executor.3 Not tainted 5.8.0-rc3-syzkaller #0
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
 asm_call_on_stack+0xf/0x20 arch/x86/entry/entry_64.S:711
 </IRQ>
 __run_on_irqstack arch/x86/include/asm/irq_stack.h:22 [inline]
 run_on_irqstack_cond arch/x86/include/asm/irq_stack.h:48 [inline]
 sysvec_apic_timer_interrupt+0xb9/0x130 arch/x86/kernel/apic/apic.c:1091
 asm_sysvec_apic_timer_interrupt+0x12/0x20 arch/x86/include/asm/idtentry.h:596
RIP: 0010:arch_local_irq_restore arch/x86/include/asm/paravirt.h:765 [inline]
RIP: 0010:slab_alloc mm/slab.c:3313 [inline]
RIP: 0010:kmem_cache_alloc+0x1a8/0x2d0 mm/slab.c:3484
Code: 8b 3c 24 57 9d 0f 1f 44 00 00 e8 c3 30 c7 ff eb 1e e8 ac 2b c7 ff 48 83 3d a4 d6 78 07 00 0f 84 26 01 00 00 48 8b 3c 24 57 9d <0f> 1f 44 00 00 41 0f 18 0e e9 21 00 00 00 89 e8 c1 e8 08 83 e0 01
RSP: 0018:ffffc90001587d88 EFLAGS: 00000282
RAX: 0000000007e4a93f RBX: 0000000000000cc0 RCX: dffffc0000000000
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000282
RBP: 0000000000000cc0 R08: ffffffff817a1d20 R09: ffffed10154bbe01
R10: ffffed10154bbe01 R11: 0000000000000000 R12: ffff88821bc4e700
R13: ffff88821bc4e700 R14: ffff888079f3a840 R15: ffffffff81bf92c8
 getname_flags+0xb8/0x610 fs/namei.c:138
 user_path_at_empty+0x28/0x50 fs/namei.c:2646
 user_path_at include/linux/namei.h:59 [inline]
 do_mount+0xd1/0x2900 fs/namespace.c:3137
 __do_sys_mount fs/namespace.c:3409 [inline]
 __se_sys_mount+0xd3/0x100 fs/namespace.c:3386
 do_syscall_64+0x73/0xe0 arch/x86/entry/common.c:359
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x45f57a
Code: Bad RIP value.
RSP: 002b:00007ffe24a11b48 EFLAGS: 00000246 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 000000000050a560 RCX: 000000000045f57a
RDX: 00007ffe24a11bc0 RSI: 0000000000000000 RDI: 00007ffe24a11be0
RBP: 000000000078bf00 R08: 00007ffe24a11c20 R09: 00007ffe24a11bc0
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000ffffffff
R13: 0000000000000c3b R14: 00000000004ce8d8 R15: 0000000001b1c914


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
