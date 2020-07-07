Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D325C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 01:42:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E47A52070C
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 01:42:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727072AbgGGBmV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jul 2020 21:42:21 -0400
Received: from mail-io1-f72.google.com ([209.85.166.72]:33607 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726625AbgGGBmV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jul 2020 21:42:21 -0400
Received: by mail-io1-f72.google.com with SMTP id x2so24798203iof.0
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jul 2020 18:42:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=SwTLkP/QL2z8xaD+quO7/wCVV+e6aH6Kgt+obfGjOvA=;
        b=BJWUOS4EDE/NqQiOEJNRTo+SC33uB+1a0XfNplXfkyGo+72x6yNxk4k6BnLyKgpN+6
         lPtIT11smx3ABKjR8RCgnAqBBFfXylR+st//HipkX2w3iqOGxf9Dkrzlu8UgC0QUPbuh
         bZNOSoK4VLp5Ti8pqyLDB/cQ5f4DqsrLMdTD0vji1MWfd/M0Q91Zf0jcHInwbI/zI1dC
         /3tbY+HnyuxCYGhuTPXc4KMWJvF2FVghMmRp5GO83EzNLxahsId6aMni3ZfLEdsLa4XV
         ZA63EUfVR/D/PuDVy2Hnzxl61CJ+s9kHJ10BnCDpditjhh5/lv2ukZFGrhIbMjQllEpV
         5Nbw==
X-Gm-Message-State: AOAM531t06Mg/whe/FOlrYfTh5FvviNFWTpnz4Gmq0IGnwEhOdoh6BwU
        cgbI45x2VqZyCmSD/JNoNo+KckiF4bI1p9GLiOpytjawe2nJ
X-Google-Smtp-Source: ABdhPJyQUeSiT3g8fMmj66ZYz5KW4VysfwBKL3q+otgEmBRDqAwOSPhPM4/qim7hyktLf9z9uWZrmh6XwTBqu+t8jdgTZASZf4zm
MIME-Version: 1.0
X-Received: by 2002:a92:190:: with SMTP id 138mr31615530ilb.5.1594086140022;
 Mon, 06 Jul 2020 18:42:20 -0700 (PDT)
Date:   Mon, 06 Jul 2020 18:42:20 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000001e16e605a9d01ab3@google.com>
Subject: BUG: soft lockup in __do_sys_clock_adjtime
From:   syzbot <syzbot+b63f85efcdedbba8b3be@syzkaller.appspotmail.com>
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
console output: https://syzkaller.appspot.com/x/log.txt?x=1361e6b7100000
kernel config:  https://syzkaller.appspot.com/x/.config?x=7be693511b29b338
dashboard link: https://syzkaller.appspot.com/bug?extid=b63f85efcdedbba8b3be
compiler:       gcc (GCC) 10.1.0-syz 20200507
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11f6948f100000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=138eb7a7100000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+b63f85efcdedbba8b3be@syzkaller.appspotmail.com

watchdog: BUG: soft lockup - CPU#1 stuck for 123s! [systemd-timesyn:4344]
Modules linked in:
irq event stamp: 102956
hardirqs last  enabled at (102955): [<ffffffff88000c42>] asm_sysvec_apic_timer_interrupt+0x12/0x20 arch/x86/include/asm/idtentry.h:596
hardirqs last disabled at (102956): [<ffffffff87e462cd>] idtentry_enter_cond_rcu+0x1d/0x50 arch/x86/entry/common.c:607
softirqs last  enabled at (76528): [<ffffffff862c5138>] sock_orphan include/net/sock.h:1872 [inline]
softirqs last  enabled at (76528): [<ffffffff862c5138>] sk_common_release+0x138/0x390 net/core/sock.c:3307
softirqs last disabled at (76526): [<ffffffff862c50c2>] sock_orphan include/net/sock.h:1868 [inline]
softirqs last disabled at (76526): [<ffffffff862c50c2>] sk_common_release+0xc2/0x390 net/core/sock.c:3307
CPU: 1 PID: 4344 Comm: systemd-timesyn Not tainted 5.8.0-rc3-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:csd_lock_wait kernel/smp.c:108 [inline]
RIP: 0010:smp_call_function_single+0x192/0x4f0 kernel/smp.c:382
Code: 10 8b 7c 24 1c 48 8d 74 24 40 48 89 44 24 50 48 8b 44 24 08 48 89 44 24 58 e8 fa f9 ff ff 41 89 c5 eb 07 e8 f0 ff 0a 00 f3 90 <44> 8b 64 24 48 31 ff 41 83 e4 01 44 89 e6 e8 5b fc 0a 00 45 85 e4
RSP: 0018:ffffc900018679e0 EFLAGS: 00000293
RAX: 0000000000000000 RBX: 1ffff9200030cf40 RCX: ffffffff8168b785
RDX: ffff8880a6700340 RSI: ffffffff8168b770 RDI: 0000000000000005
RBP: ffffc90001867ac0 R08: 0000000000000001 R09: ffff8880ae636dc7
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000001
R13: 0000000000000000 R14: 0000000000000001 R15: 0000000000000040
FS:  00007efe995408c0(0000) GS:ffff8880ae700000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055eae694ed48 CR3: 00000000a6bc5000 CR4: 00000000001406e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 smp_call_function_many_cond+0x1a4/0x990 kernel/smp.c:518
 smp_call_function_many kernel/smp.c:577 [inline]
 smp_call_function kernel/smp.c:599 [inline]
 on_each_cpu+0x4a/0x240 kernel/smp.c:699
 clock_was_set+0x18/0x20 kernel/time/hrtimer.c:872
 timekeeping_inject_offset+0x3e9/0x4d0 kernel/time/timekeeping.c:1305
 do_adjtimex+0x28f/0x990 kernel/time/timekeeping.c:2332
 do_clock_adjtime kernel/time/posix-timers.c:1109 [inline]
 __do_sys_clock_adjtime+0x155/0x250 kernel/time/posix-timers.c:1121
 do_syscall_64+0x60/0xe0 arch/x86/entry/common.c:359
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x7efe989361b7
Code: Bad RIP value.
RSP: 002b:00007ffc4cfe68e8 EFLAGS: 00000246 ORIG_RAX: 0000000000000131
RAX: ffffffffffffffda RBX: 0000562d621a2630 RCX: 00007efe989361b7
RDX: ffffffffe7ce3d82 RSI: 00007ffc4cfe69b0 RDI: 0000000000000000
RBP: 00007ffc4cfe69b0 R08: 0000000000000020 R09: 000000000000000d
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000ffffffff
R13: 00007ffc4cfe6aa0 R14: 0000000000000005 R15: 0000000000000001
Sending NMI from CPU 1 to CPUs 0:
NMI backtrace for cpu 0
CPU: 0 PID: 6820 Comm: syz-executor620 Not tainted 5.8.0-rc3-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:lock_acquire+0xa2/0xad0 kernel/locking/lockdep.c:4934
Code: 08 00 00 00 f3 c7 40 0c f3 f3 f3 f3 65 48 8b 04 25 28 00 00 00 48 89 84 24 b8 00 00 00 31 c0 48 89 f8 48 c1 e8 03 0f b6 0c 08 <48> 89 f8 83 e0 07 83 c0 03 38 c8 7c 08 84 c9 0f 85 61 07 00 00 45
RSP: 0018:ffffc90000007be8 EFLAGS: 00000807
RAX: 1ffff11014596d81 RBX: 0000000000000001 RCX: 0000000000000000
RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff8880a2cb6c0c
RBP: 0000000000000000 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
R13: ffffffff8cb15150 R14: 0000000000000000 R15: ffff8880a2cb6340
FS:  0000000002039880(0000) GS:ffff8880ae600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020000610 CR3: 000000009fdd4000 CR4: 00000000001406f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <IRQ>
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
 asm_sysvec_apic_timer_interrupt+0x12/0x20 arch/x86/include/asm/idtentry.h:596
RIP: 0010:arch_local_irq_restore arch/x86/include/asm/paravirt.h:765 [inline]
RIP: 0010:on_each_cpu+0x149/0x240 kernel/smp.c:702
Code: 00 fc ff df 48 c1 e8 03 80 3c 10 00 0f 85 e6 00 00 00 48 83 3d 57 12 4c 08 00 0f 84 af 00 00 00 e8 6c e9 0a 00 48 89 df 57 9d <0f> 1f 44 00 00 e8 5d e9 0a 00 bf 01 00 00 00 e8 83 a4 e6 ff 31 ff
RSP: 0018:ffffc90001747d70 EFLAGS: 00000293
RAX: 0000000000000000 RBX: 0000000000000293 RCX: 0000000000000000
RDX: ffff8880a2cb6340 RSI: ffffffff8168cdf4 RDI: 0000000000000293
RBP: 0000000000000200 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000000 R12: 0000000000000000
R13: 0000000000000000 R14: ffffc90001747ed0 R15: ffffffffa0fc31fd
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
RIP: 0033:0x4437c9
Code: Bad RIP value.
RSP: 002b:00007ffca52e53d8 EFLAGS: 00000246 ORIG_RAX: 00000000000000e3
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00000000004437c9
RDX: 00000000004437c9 RSI: 0000000020000400 RDI: 0000000000000000
RBP: 00007ffca52e53e0 R08: 0000000001bbbbbb R09: 0000000001bbbbbb
R10: 0000000001bbbbbb R11: 0000000000000246 R12: 00007ffca52e53f0
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
