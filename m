Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 672E9C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 00:00:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3A9BD206F6
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 00:00:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727072AbgGGAA0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jul 2020 20:00:26 -0400
Received: from mail-io1-f69.google.com ([209.85.166.69]:55879 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726799AbgGGAAZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jul 2020 20:00:25 -0400
Received: by mail-io1-f69.google.com with SMTP id k10so24279632ioh.22
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jul 2020 17:00:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=Uqjz2TX5uNywSbbShLqNrkP+zlRKaCFlCcxWS6b2pWc=;
        b=SiGaPVoQJl7UseOBaYT6edTmolajFcd+a3aD0d2h1gWxkaG6iRS7pD+AJTYH4VmCZH
         9t1098FhrFTxABYksIA1ZUqJjvAm6tWhXjA+r8xEF2mOXt0Ksuwg4kVAe9AF9XUDBC7Z
         q0u9lbQGXpxV874JgTxeZKZYtq6YWl9WJ5M0k1etbrfH8THgfVwyZA5cfi2uzcvHhX3a
         m8Hv2ltMDvGAEpVX4B1CXIwBCfdEMX/bYBMgISy5BuE1y7AiVQvTGbmUa+PbvAgvDXPx
         JJouO1KHOLC1YthxA+EJT8ZNOd4e6NfMLMieiSOiqxUhIKxhAgT70aOG8Xf46hPfxgBu
         jZeA==
X-Gm-Message-State: AOAM533zDlyK/iFf+ApHpcsiaDdy2QqEpuf/C8WL5ulqdLuqc8vC3/FB
        XqZDPrPPIochJ3sHTLADviyDBuZ11D+tWF1jl5VvWQ3grREP
X-Google-Smtp-Source: ABdhPJzHFF41n5bDJVYiAzAqVfqcqr8wu9NJlDjU2hd7Zxg6mHEMwSbZpotmvGTx5c/VEjqGS5oLiu+11040tg/fGC9m2hIi3GhG
MIME-Version: 1.0
X-Received: by 2002:a92:c8c5:: with SMTP id c5mr33165847ilq.47.1594080024214;
 Mon, 06 Jul 2020 17:00:24 -0700 (PDT)
Date:   Mon, 06 Jul 2020 17:00:24 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000096415705a9cead51@google.com>
Subject: BUG: soft lockup in sys_clock_settime
From:   syzbot <syzbot+76d006fc5c8b6d4f44a0@syzkaller.appspotmail.com>
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

HEAD commit:    7cc2a8ea Merge tag 'block-5.8-2020-07-01' of git://git.ker..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=16e4b197100000
kernel config:  https://syzkaller.appspot.com/x/.config?x=7be693511b29b338
dashboard link: https://syzkaller.appspot.com/bug?extid=76d006fc5c8b6d4f44a0
compiler:       gcc (GCC) 10.1.0-syz 20200507

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+76d006fc5c8b6d4f44a0@syzkaller.appspotmail.com

watchdog: BUG: soft lockup - CPU#0 stuck for 123s! [syz-executor.1:2970]
Modules linked in:
irq event stamp: 29938
hardirqs last  enabled at (29937): [<ffffffff88000c42>] asm_sysvec_apic_timer_interrupt+0x12/0x20 arch/x86/include/asm/idtentry.h:596
hardirqs last disabled at (29938): [<ffffffff87e462cd>] idtentry_enter_cond_rcu+0x1d/0x50 arch/x86/entry/common.c:607
softirqs last  enabled at (24182): [<ffffffff88200748>] __do_softirq+0x748/0xa60 kernel/softirq.c:319
softirqs last disabled at (24173): [<ffffffff88000f0f>] asm_call_on_stack+0xf/0x20 arch/x86/entry/entry_64.S:711
CPU: 0 PID: 2970 Comm: syz-executor.1 Not tainted 5.8.0-rc3-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:csd_lock_wait kernel/smp.c:108 [inline]
RIP: 0010:smp_call_function_single+0x192/0x4f0 kernel/smp.c:382
Code: 10 8b 7c 24 1c 48 8d 74 24 40 48 89 44 24 50 48 8b 44 24 08 48 89 44 24 58 e8 fa f9 ff ff 41 89 c5 eb 07 e8 f0 ff 0a 00 f3 90 <44> 8b 64 24 48 31 ff 41 83 e4 01 44 89 e6 e8 5b fc 0a 00 45 85 e4
RSP: 0018:ffffc90004a27c00 EFLAGS: 00000293
RAX: 0000000000000000 RBX: 1ffff92000944f84 RCX: ffffffff8168b785
RDX: ffff88804f868500 RSI: ffffffff8168b770 RDI: 0000000000000005
RBP: ffffc90004a27cc8 R08: 0000000000000001 R09: ffff8880ae736dc7
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000001
R13: 0000000000000000 R14: 0000000000000001 R15: 0000000000000040
FS:  00007fa61e16a700(0000) GS:ffff8880ae600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fa61e127db8 CR3: 000000003e870000 CR4: 00000000001406f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 smp_call_function_many_cond+0x1a4/0x990 kernel/smp.c:518
 smp_call_function_many kernel/smp.c:577 [inline]
 smp_call_function kernel/smp.c:599 [inline]
 on_each_cpu+0x4a/0x240 kernel/smp.c:699
 clock_was_set+0x18/0x20 kernel/time/hrtimer.c:872
 do_settimeofday64 kernel/time/timekeeping.c:1257 [inline]
 do_settimeofday64+0x350/0x4e0 kernel/time/timekeeping.c:1223
 do_sys_settimeofday64 kernel/time/time.c:195 [inline]
 do_sys_settimeofday64+0x1de/0x260 kernel/time/time.c:169
 __do_sys_clock_settime kernel/time/posix-timers.c:1079 [inline]
 __se_sys_clock_settime kernel/time/posix-timers.c:1067 [inline]
 __x64_sys_clock_settime+0x197/0x260 kernel/time/posix-timers.c:1067
 do_syscall_64+0x60/0xe0 arch/x86/entry/common.c:359
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x45cb29
Code: Bad RIP value.
RSP: 002b:00007fa61e169c78 EFLAGS: 00000246 ORIG_RAX: 00000000000000e3
RAX: ffffffffffffffda RBX: 00000000004db560 RCX: 000000000045cb29
RDX: 0000000000000000 RSI: 0000000020000400 RDI: 0000000000000000
RBP: 000000000078bf00 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000ffffffff
R13: 000000000000007b R14: 00000000004c34ac R15: 00007fa61e16a6d4
Sending NMI from CPU 0 to CPUs 1:
NMI backtrace for cpu 1
CPU: 1 PID: 2956 Comm: syz-executor.3 Not tainted 5.8.0-rc3-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:get_current arch/x86/include/asm/current.h:15 [inline]
RIP: 0010:__sanitizer_cov_trace_pc+0x0/0x60 kernel/kcov.c:196
Code: 48 89 ef 5d e9 01 07 3f 00 5d be 03 00 00 00 e9 26 b3 23 02 66 0f 1f 44 00 00 48 8b be b0 01 00 00 e8 b4 ff ff ff 31 c0 c3 90 <65> 48 8b 14 25 00 ff 01 00 65 8b 05 50 47 8e 7e a9 00 01 ff 00 48
RSP: 0018:ffffc90000da8de0 EFLAGS: 00000046
RAX: ffff888089f82480 RBX: ffff888089f82480 RCX: 0000000000000000
RDX: dffffc0000000000 RSI: ffffffff89bc1180 RDI: ffff888089f82d38
RBP: 0000000000000001 R08: 0000000000000001 R09: ffff888089f82d48
R10: fffffbfff155cb29 R11: 0000000000000000 R12: ffff8880ae727740
R13: ffff8880ae727840 R14: ffff888091f6e340 R15: dffffc0000000000
FS:  00007f7625d5c700(0000) GS:ffff8880ae700000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f68ff5c0240 CR3: 000000004c5a3000 CR4: 00000000001406e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <IRQ>
 arch_static_branch arch/x86/include/asm/jump_label.h:25 [inline]
 static_key_false include/linux/jump_label.h:200 [inline]
 trace_hrtimer_expire_exit include/trace/events/timer.h:279 [inline]
 __run_hrtimer kernel/time/hrtimer.c:1523 [inline]
 __hrtimer_run_queues+0x1de/0xfc0 kernel/time/hrtimer.c:1584
 hrtimer_interrupt+0x32a/0x930 kernel/time/hrtimer.c:1646
 local_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1080 [inline]
 __sysvec_apic_timer_interrupt+0x142/0x5e0 arch/x86/kernel/apic/apic.c:1097
 asm_call_on_stack+0xf/0x20 arch/x86/entry/entry_64.S:711
 </IRQ>
 __run_on_irqstack arch/x86/include/asm/irq_stack.h:22 [inline]
 run_on_irqstack_cond arch/x86/include/asm/irq_stack.h:48 [inline]
 sysvec_apic_timer_interrupt+0xe0/0x120 arch/x86/kernel/apic/apic.c:1091
 asm_sysvec_apic_timer_interrupt+0x12/0x20 arch/x86/include/asm/idtentry.h:596
RIP: 0010:arch_local_irq_restore arch/x86/include/asm/paravirt.h:765 [inline]
RIP: 0010:lock_acquire+0x270/0xad0 kernel/locking/lockdep.c:4962
Code: 00 00 00 00 fc ff df 48 c1 e8 03 80 3c 10 00 0f 85 f8 06 00 00 48 83 3d 6d d0 5a 08 00 0f 84 a6 05 00 00 48 8b 7c 24 08 57 9d <0f> 1f 44 00 00 48 b8 00 00 00 00 00 fc ff df 48 03 44 24 10 48 c7
RSP: 0018:ffffc900049b7610 EFLAGS: 00000282
RAX: 1ffffffff1369c08 RBX: ffff888089f82480 RCX: 0000000000000001
RDX: dffffc0000000000 RSI: e297a4d1167c23bf RDI: 0000000000000282
RBP: 0000000000000000 R08: 0000000000000000 R09: ffffffff8c58fa27
R10: fffffbfff18b1f44 R11: 0000000000000000 R12: 0000000000000002
R13: ffffffff89bc1180 R14: 0000000000000000 R15: ffff8880975374a8
 rcu_lock_acquire include/linux/rcupdate.h:241 [inline]
 rcu_read_lock include/linux/rcupdate.h:634 [inline]
 lock_page_memcg+0x63/0x260 mm/memcontrol.c:1977
 page_remove_rmap+0x25/0x1670 mm/rmap.c:1328
 zap_pte_range mm/memory.c:1089 [inline]
 zap_pmd_range mm/memory.c:1193 [inline]
 zap_pud_range mm/memory.c:1222 [inline]
 zap_p4d_range mm/memory.c:1243 [inline]
 unmap_page_range+0xf3b/0x2940 mm/memory.c:1264
 unmap_single_vma+0x198/0x300 mm/memory.c:1309
 unmap_vmas+0x16f/0x2f0 mm/memory.c:1341
 exit_mmap+0x2b1/0x510 mm/mmap.c:3150
 __mmput+0x122/0x470 kernel/fork.c:1093
 mmput+0x53/0x60 kernel/fork.c:1114
 exit_mm kernel/exit.c:482 [inline]
 do_exit+0xa8f/0x2a40 kernel/exit.c:792
 do_group_exit+0x125/0x310 kernel/exit.c:903
 get_signal+0x40b/0x1ee0 kernel/signal.c:2743
 do_signal+0x82/0x2520 arch/x86/kernel/signal.c:810
 exit_to_usermode_loop arch/x86/entry/common.c:212 [inline]
 __prepare_exit_to_usermode+0x156/0x1f0 arch/x86/entry/common.c:246
 do_syscall_64+0x6c/0xe0 arch/x86/entry/common.c:368
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x45cb29
Code: Bad RIP value.
RSP: 002b:00007f7625d5bc78 EFLAGS: 00000246 ORIG_RAX: 00000000000000a6
RAX: 0000000000000000 RBX: 000000000050b9e0 RCX: 000000000045cb29
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000020000500
RBP: 000000000078bfa0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000ffffffff
R13: 0000000000000c8d R14: 00000000004ceea7 R15: 00007f7625d5c6d4


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
