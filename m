Return-Path: <SRS0=5Khs=AX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB74DC433E1
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Jul 2020 23:02:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A453A20720
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Jul 2020 23:02:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728225AbgGLXCX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 Jul 2020 19:02:23 -0400
Received: from mail-il1-f197.google.com ([209.85.166.197]:53358 "EHLO
        mail-il1-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727785AbgGLXCW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jul 2020 19:02:22 -0400
Received: by mail-il1-f197.google.com with SMTP id r4so8367241ilq.20
        for <linux-kernel@vger.kernel.org>; Sun, 12 Jul 2020 16:02:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=UdjO1eLr/5A+FN4BKlMeA1Pr1agWTj0BB3DV6d2qMto=;
        b=LXybxdW7Fv/Tq6bjmgSzk2ShhjLDFWvkdg0G6hcblypzz3CBIANVTP+ehjW32S9XPl
         M2i/8K6J+nAZlln0/WUECFIcyfiQCaiqnVf/c33tmAGEwEsaHN/j5EBIQEYUs1vEz1Ti
         qYk//sWEWHiT+J8HOHg8WGn+4RTO3ktFalGzM2p769IipRZVPxJ8AU9oNuDDZDhVbEY2
         v0xW7jxwXjSChnb7AGFdkmMB6BMq8l/BOq/+zKQzeDwrriZlyAN5IVC4o54m4/lmZqF8
         akwAZQgdE1KStOP/3CUszxntN4mdnfOE54B9nPV+fK9fMYHtW+NN55UOG3/kxS88dvOq
         gsfw==
X-Gm-Message-State: AOAM533ORVtNPNAnwCGmprLtqy75+w20swI2lbqpQGPHw/X5hF5vn4hl
        IiM2FW0m+WVpw6iHoegA2N4d5NRPG7E9lw3fiwGv3G7agRb7
X-Google-Smtp-Source: ABdhPJzY6E+fJV5jBgA1yl2h+TneODo3CYcgo4KGGWkChv7J3vK55DPm3I1J/3UZHlgRRxZe6IZQEhYXcZ1ki7T29l7cXuC00QGP
MIME-Version: 1.0
X-Received: by 2002:a92:b655:: with SMTP id s82mr64954868ili.268.1594594941207;
 Sun, 12 Jul 2020 16:02:21 -0700 (PDT)
Date:   Sun, 12 Jul 2020 16:02:21 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000080a5f05aa4691a8@google.com>
Subject: BUG: soft lockup in smp_call_function
From:   syzbot <syzbot+cce3691658bef1b12ac9@syzkaller.appspotmail.com>
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

HEAD commit:    4437dd6e Merge tag 'io_uring-5.8-2020-07-12' of git://git...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=17183f0b100000
kernel config:  https://syzkaller.appspot.com/x/.config?x=66ad203c2bb6d8b
dashboard link: https://syzkaller.appspot.com/bug?extid=cce3691658bef1b12ac9
compiler:       gcc (GCC) 10.1.0-syz 20200507

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+cce3691658bef1b12ac9@syzkaller.appspotmail.com

watchdog: BUG: soft lockup - CPU#0 stuck for 123s! [syz-executor.5:6928]
Modules linked in:
irq event stamp: 45064
hardirqs last  enabled at (45063): [<ffffffff88000c42>] asm_sysvec_apic_timer_interrupt+0x12/0x20 arch/x86/include/asm/idtentry.h:587
hardirqs last disabled at (45064): [<ffffffff87e4f2ed>] idtentry_enter_cond_rcu+0x1d/0x50 arch/x86/entry/common.c:649
softirqs last  enabled at (44672): [<ffffffff88200748>] __do_softirq+0x748/0xa60 kernel/softirq.c:319
softirqs last disabled at (44667): [<ffffffff88000f0f>] asm_call_on_stack+0xf/0x20 arch/x86/entry/entry_64.S:711
CPU: 0 PID: 6928 Comm: syz-executor.5 Not tainted 5.8.0-rc4-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:csd_lock_wait kernel/smp.c:108 [inline]
RIP: 0010:smp_call_function_single+0x197/0x4f0 kernel/smp.c:382
Code: 48 8d 74 24 40 48 89 44 24 50 48 8b 44 24 08 48 89 44 24 58 e8 fa f9 ff ff 41 89 c5 eb 07 e8 90 00 0b 00 f3 90 44 8b 64 24 48 <31> ff 41 83 e4 01 44 89 e6 e8 fb fc 0a 00 45 85 e4 75 e1 e8 71 00
RSP: 0018:ffffc90008b27aa0 EFLAGS: 00000293
RAX: 0000000000000000 RBX: 1ffff92001164f58 RCX: ffffffff8168b985
RDX: ffff88805cd7e4c0 RSI: ffffffff8168b970 RDI: 0000000000000005
RBP: ffffc90008b27b68 R08: 0000000000000001 R09: ffff8880ae736dc7
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000011
R13: 0000000000000000 R14: 0000000000000001 R15: ffffc90008b27c88
FS:  00000000014c3940(0000) GS:ffff8880ae600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000556f55a93ed3 CR3: 0000000213330000 CR4: 00000000001406f0
DR0: 0000000020000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000600
Call Trace:
 task_function_call+0xd7/0x160 kernel/events/core.c:116
 event_function_call+0x20a/0x420 kernel/events/core.c:283
 perf_remove_from_context+0x9b/0x1c0 kernel/events/core.c:2338
 perf_event_release_kernel+0x485/0xe00 kernel/events/core.c:4918
 perf_release+0x33/0x40 kernel/events/core.c:5014
 __fput+0x33c/0x880 fs/file_table.c:281
 task_work_run+0xdd/0x190 kernel/task_work.c:135
 tracehook_notify_resume include/linux/tracehook.h:188 [inline]
 exit_to_usermode_loop arch/x86/entry/common.c:239 [inline]
 __prepare_exit_to_usermode+0x1e9/0x1f0 arch/x86/entry/common.c:269
 do_syscall_64+0x6c/0xe0 arch/x86/entry/common.c:393
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x416721
Code: Bad RIP value.
RSP: 002b:00007ffdb12d68f0 EFLAGS: 00000293 ORIG_RAX: 0000000000000003
RAX: 0000000000000000 RBX: 0000000000000005 RCX: 0000000000416721
RDX: 0000000000000000 RSI: 0000000000000e0d RDI: 0000000000000004
RBP: 0000000000000001 R08: 00000000569bce0a R09: 00000000569bce0e
R10: 00007ffdb12d69e0 R11: 0000000000000293 R12: 000000000078c900
R13: 000000000078c900 R14: ffffffffffffffff R15: 000000000078bf0c
Sending NMI from CPU 0 to CPUs 1:
NMI backtrace for cpu 1
CPU: 1 PID: 6932 Comm: syz-executor.5 Not tainted 5.8.0-rc4-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:hlock_class kernel/locking/lockdep.c:179 [inline]
RIP: 0010:mark_lock+0xc4/0x1710 kernel/locking/lockdep.c:3937
Code: 20 66 81 e3 ff 1f 0f b7 db be 08 00 00 00 48 89 d8 48 c1 f8 06 48 8d 3c c5 20 3a 59 8c e8 e4 6d 59 00 48 0f a3 1d 6c b6 ff 0a <0f> 83 c1 00 00 00 48 69 db b8 00 00 00 48 81 c3 40 3e 59 8c 48 8d
RSP: 0018:ffffc90000da8a48 EFLAGS: 00000047
RAX: 0000000000000001 RBX: 0000000000000000 RCX: ffffffff815983ac
RDX: fffffbfff18b2745 RSI: 0000000000000008 RDI: ffffffff8c593a20
RBP: ffff8880336c0540 R08: 0000000000000000 R09: ffffffff8c593a27
R10: fffffbfff18b2744 R11: 0000000000000001 R12: 0000000000000008
R13: ffff8880336c0e5a R14: ffff8880336c0e38 R15: ffff8880336c0e10
FS:  00007fd045d50700(0000) GS:ffff8880ae700000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000012ec08cc CR3: 0000000213330000 CR4: 00000000001406e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000600
Call Trace:
 <IRQ>
 mark_usage kernel/locking/lockdep.c:3885 [inline]
 __lock_acquire+0x944/0x56e0 kernel/locking/lockdep.c:4334
 lock_acquire+0x1f1/0xad0 kernel/locking/lockdep.c:4959
 __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
 _raw_spin_lock_irqsave+0x8c/0xc0 kernel/locking/spinlock.c:159
 debug_object_deactivate lib/debugobjects.c:710 [inline]
 debug_object_deactivate+0x101/0x300 lib/debugobjects.c:698
 debug_hrtimer_deactivate kernel/time/hrtimer.c:421 [inline]
 debug_deactivate kernel/time/hrtimer.c:482 [inline]
 __run_hrtimer kernel/time/hrtimer.c:1488 [inline]
 __hrtimer_run_queues+0x3cb/0xfc0 kernel/time/hrtimer.c:1584
 hrtimer_interrupt+0x32a/0x930 kernel/time/hrtimer.c:1646
 local_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1080 [inline]
 __sysvec_apic_timer_interrupt+0x142/0x5e0 arch/x86/kernel/apic/apic.c:1097
 asm_call_on_stack+0xf/0x20 arch/x86/entry/entry_64.S:711
 </IRQ>
 __run_on_irqstack arch/x86/include/asm/irq_stack.h:22 [inline]
 run_on_irqstack_cond arch/x86/include/asm/irq_stack.h:48 [inline]
 sysvec_apic_timer_interrupt+0xe0/0x120 arch/x86/kernel/apic/apic.c:1091
 asm_sysvec_apic_timer_interrupt+0x12/0x20 arch/x86/include/asm/idtentry.h:587
RIP: 0010:arch_static_branch arch/x86/include/asm/jump_label.h:25 [inline]
RIP: 0010:static_key_false include/linux/jump_label.h:200 [inline]
RIP: 0010:native_write_msr+0x6/0x20 arch/x86/include/asm/msr.h:164
Code: c3 89 ef e8 0c 0b f9 ff b8 40 00 00 00 0f 00 d8 89 ef e8 dd 0b f9 ff eb d2 e8 96 6a b2 06 66 0f 1f 44 00 00 89 f9 89 f0 0f 30 <0f> 1f 44 00 00 c3 48 c1 e2 20 89 f6 48 09 d6 31 d2 e9 f4 7c 7a 02
RSP: 0018:ffffc90008b87970 EFLAGS: 00000282
RAX: 00000000000000fb RBX: ffff8880ae619374 RCX: 0000000000000830
RDX: 0000000000000000 RSI: 00000000000000fb RDI: 0000000000000830
RBP: 00000000000000fb R08: 0000000000000001 R09: ffff8880ae636dc7
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000001 R15: 0000000000000040
 paravirt_write_msr arch/x86/include/asm/paravirt.h:173 [inline]
 wrmsrl arch/x86/include/asm/paravirt.h:206 [inline]
 native_x2apic_icr_write arch/x86/include/asm/apic.h:249 [inline]
 __x2apic_send_IPI_dest arch/x86/kernel/apic/x2apic_phys.c:112 [inline]
 x2apic_send_IPI+0xb5/0x100 arch/x86/kernel/apic/x2apic_phys.c:41
 __smp_call_single_queue kernel/smp.c:150 [inline]
 generic_exec_single+0x118/0x480 kernel/smp.c:181
 smp_call_function_single+0x186/0x4f0 kernel/smp.c:379
 smp_call_function_many_cond+0x1a4/0x990 kernel/smp.c:518
 smp_call_function_many kernel/smp.c:577 [inline]
 smp_call_function kernel/smp.c:599 [inline]
 on_each_cpu+0x4a/0x240 kernel/smp.c:699
 clock_was_set+0x18/0x20 kernel/time/hrtimer.c:872
 timekeeping_inject_offset+0x3e9/0x4d0 kernel/time/timekeeping.c:1305
 do_adjtimex+0x28f/0x990 kernel/time/timekeeping.c:2332
 do_clock_adjtime kernel/time/posix-timers.c:1109 [inline]
 __do_sys_clock_adjtime+0x155/0x250 kernel/time/posix-timers.c:1121
 do_syscall_64+0x60/0xe0 arch/x86/entry/common.c:384
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x45cba9
Code: Bad RIP value.
RSP: 002b:00007fd045d4fc78 EFLAGS: 00000246 ORIG_RAX: 0000000000000131
RAX: ffffffffffffffda RBX: 00000000004dbac0 RCX: 000000000045cba9
RDX: 0000000000000000 RSI: 0000000020000300 RDI: 0000000000000000
RBP: 000000000078bf00 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000ffffffff
R13: 0000000000000077 R14: 00000000004c34f3 R15: 00007fd045d506d4


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
