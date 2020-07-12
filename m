Return-Path: <SRS0=5Khs=AX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E25DC433E0
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Jul 2020 17:54:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 72BF220725
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Jul 2020 17:54:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729362AbgGLRyR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 Jul 2020 13:54:17 -0400
Received: from mail-io1-f70.google.com ([209.85.166.70]:53296 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728882AbgGLRyR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jul 2020 13:54:17 -0400
Received: by mail-io1-f70.google.com with SMTP id g11so6689575ioc.20
        for <linux-kernel@vger.kernel.org>; Sun, 12 Jul 2020 10:54:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=K99nHX9ltplOmg8Lwic3wnIBuI65Kr+aOKhFf2vW74c=;
        b=KFUiXAjG8NjzVqH/U3RWJSo+dfTYCYCE1wvwHt6Jlc9MKfSmIQJoACiCs4x6zDf4n9
         RqjB4p6HxgWGw/RdefLi1x4jZzuzEdhID+4a3LzJDtdyrPfIr+J7tSJiEQ918Jk8IT4K
         UGvJjuxs+V9GJIwsSz96C5hG9i+OtvUkUvBLOQt8PQmzVni9A4w6SSvjOzCtVuUgSa+6
         TBW5K9fJUbSw0j6lVFt+mjWDKxitMilvwt7ubbNQ8Uyj9CNRghNkWmmSz4f51Zd/W8og
         41v3JnjIAOp9JV37WlAWYn+yBeNGDYSkoED0KXkDKDxBfWmBI01zRUZ5na8uLNEO1+hA
         lT1g==
X-Gm-Message-State: AOAM530U7qcNk022paky+MizKq6lHyd1J+WFmx/jJn1eWHnTnsMHi/9B
        A9UwGjsD3tDG20WKv9K28KJOelYfIwBpQQV+ngQg8zQXv1wR
X-Google-Smtp-Source: ABdhPJwPFmBYPB/IAsd1QjIW3v821UKvVTFrbbSPnlzoS1MVI/BVgQlMxkuSLrWDTd/ZINc5CmQH/GZzOUQ/KTZeuq8JnBRTAr07
MIME-Version: 1.0
X-Received: by 2002:a02:95ca:: with SMTP id b68mr10549054jai.0.1594576456484;
 Sun, 12 Jul 2020 10:54:16 -0700 (PDT)
Date:   Sun, 12 Jul 2020 10:54:16 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000418fc105aa4243aa@google.com>
Subject: INFO: rcu detected stall in sys_clock_settime
From:   syzbot <syzbot+f3bd350a4124f10acdae@syzkaller.appspotmail.com>
To:     linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        tglx@linutronix.de
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    0bddd227 Documentation: update for gcc 4.9 requirement
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=13178abd100000
kernel config:  https://syzkaller.appspot.com/x/.config?x=66ad203c2bb6d8b
dashboard link: https://syzkaller.appspot.com/bug?extid=f3bd350a4124f10acdae
compiler:       gcc (GCC) 10.1.0-syz 20200507
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1266a2fb100000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12fd03ff100000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+f3bd350a4124f10acdae@syzkaller.appspotmail.com

rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
rcu: 	0-...0: (1 GPs behind) idle=b0e/1/0x4000000000000000 softirq=8473/8474 fqs=5249 
	(detected by 1, t=10502 jiffies, g=8021, q=3628)
Sending NMI from CPU 1 to CPUs 0:
NMI backtrace for cpu 0
CPU: 0 PID: 6813 Comm: syz-executor178 Not tainted 5.8.0-rc4-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:rcu_lockdep_current_cpu_online kernel/rcu/tree.c:1145 [inline]
RIP: 0010:rcu_lockdep_current_cpu_online+0x44/0x110 kernel/rcu/tree.c:1136
Code: 85 d2 75 01 c3 55 53 48 83 ec 08 65 ff 05 74 44 a1 7e e8 af ed 83 06 48 c7 c3 00 6c 03 00 48 ba 00 00 00 00 00 fc ff df 89 c0 <48> 8d 3c c5 40 39 81 89 48 89 f9 48 c1 e9 03 80 3c 11 00 0f 85 82
RSP: 0018:ffffc90000007db8 EFLAGS: 00000002
RAX: 0000000000000000 RBX: 0000000000036c00 RCX: 1ffffffff1302728
RDX: dffffc0000000000 RSI: 0000000000010004 RDI: 0000000000000000
RBP: 176b61322ed6c264 R08: 0000000000000000 R09: ffffffff8aae5b0f
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000001
R13: ffff8880ae627840 R14: ffff8880905ab340 R15: dffffc0000000000
FS:  0000000001834880(0000) GS:ffff8880ae600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020000610 CR3: 00000000a710b000 CR4: 00000000001406f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <IRQ>
 rcu_read_lock_held_common kernel/rcu/update.c:122 [inline]
 rcu_read_lock_held_common kernel/rcu/update.c:112 [inline]
 rcu_read_lock_sched_held+0x25/0xb0 kernel/rcu/update.c:133
 trace_hrtimer_cancel include/trace/events/timer.h:290 [inline]
 debug_deactivate kernel/time/hrtimer.c:483 [inline]
 __run_hrtimer kernel/time/hrtimer.c:1488 [inline]
 __hrtimer_run_queues+0xd59/0xfc0 kernel/time/hrtimer.c:1584
 hrtimer_interrupt+0x32a/0x930 kernel/time/hrtimer.c:1646
 local_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1080 [inline]
 __sysvec_apic_timer_interrupt+0x142/0x5e0 arch/x86/kernel/apic/apic.c:1097
 asm_call_on_stack+0xf/0x20 arch/x86/entry/entry_64.S:711
 </IRQ>
 __run_on_irqstack arch/x86/include/asm/irq_stack.h:22 [inline]
 run_on_irqstack_cond arch/x86/include/asm/irq_stack.h:48 [inline]
 sysvec_apic_timer_interrupt+0xe0/0x120 arch/x86/kernel/apic/apic.c:1091
 asm_sysvec_apic_timer_interrupt+0x12/0x20 arch/x86/include/asm/idtentry.h:587
RIP: 0010:arch_local_irq_restore arch/x86/include/asm/paravirt.h:765 [inline]
RIP: 0010:on_each_cpu+0x149/0x240 kernel/smp.c:702
Code: 00 fc ff df 48 c1 e8 03 80 3c 10 00 0f 85 e6 00 00 00 48 83 3d 97 12 4c 08 00 0f 84 af 00 00 00 e8 6c e9 0a 00 48 89 df 57 9d <0f> 1f 44 00 00 e8 5d e9 0a 00 bf 01 00 00 00 e8 83 a4 e6 ff 31 ff
RSP: 0018:ffffc90001477d70 EFLAGS: 00000293
RAX: 0000000000000000 RBX: 0000000000000293 RCX: 0000000000000000
RDX: ffff8880a7e2c100 RSI: ffffffff8168cdf4 RDI: 0000000000000293
RBP: 0000000000000200 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000000 R12: 0000000000000000
R13: 0000000000000000 R14: ffffc90001477ed0 R15: ffffffffa0f8b034
 clock_was_set+0x18/0x20 kernel/time/hrtimer.c:872
 do_settimeofday64 kernel/time/timekeeping.c:1257 [inline]
 do_settimeofday64+0x350/0x4e0 kernel/time/timekeeping.c:1223
 do_sys_settimeofday64 kernel/time/time.c:195 [inline]
 do_sys_settimeofday64+0x1de/0x260 kernel/time/time.c:169
 __do_sys_clock_settime kernel/time/posix-timers.c:1079 [inline]
 __se_sys_clock_settime kernel/time/posix-timers.c:1067 [inline]
 __x64_sys_clock_settime+0x197/0x260 kernel/time/posix-timers.c:1067
 do_syscall_64+0x60/0xe0 arch/x86/entry/common.c:384
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x443849
Code: Bad RIP value.
RSP: 002b:00007ffe4b8100d8 EFLAGS: 00000246 ORIG_RAX: 00000000000000e3
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 0000000000443849
RDX: 0000000000443849 RSI: 0000000020000400 RDI: 0000000000000000
RBP: 00007ffe4b8100e0 R08: 0000000001bbbbbb R09: 0000000001bbbbbb
R10: 0000000001bbbbbb R11: 0000000000000246 R12: 00007ffe4b8100f0
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
