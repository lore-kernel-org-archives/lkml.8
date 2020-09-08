Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 990C5C43461
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 19:09:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4F1AB20C09
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 19:09:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731293AbgIHTJZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 15:09:25 -0400
Received: from mail-il1-f208.google.com ([209.85.166.208]:51073 "EHLO
        mail-il1-f208.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729014AbgIHTJT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 15:09:19 -0400
Received: by mail-il1-f208.google.com with SMTP id l8so37759ilo.17
        for <linux-kernel@vger.kernel.org>; Tue, 08 Sep 2020 12:09:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=kdSN2vYziC5nyS2kHyKwaX4YlJbrNG86WAglARJxLz4=;
        b=JljOlcqzGIDWp/nNm8qFDf8kVwZfVPVoJKGJDMRILt0nSzT/IFVGDkbuFDAuQs9QUQ
         AbXXxkEnYFl05LRKqr/Ie6nqyJKg9+s8VXuBtlT5O/+fLenNnIEYvtISsIyPhU5TXPgK
         lBfHynjCk5GFexvMeb9OpNjTqrjtN4j72T9LMgkyyS1dTNBmJFJoL4XCclL1n4n9mTd1
         kuHYZcOb5RW5yiy1aKaWB4wmeKLQ9kAj7fDUSagKfo9fSA3EHovBYyYl37a20O/+38pK
         0urXB7rqGKl8vaWVNo29Ds0Alo6LfcXItHXmP8CpiwPaFmMg2o1oZ3NZ9evRN09nWbWz
         eyUg==
X-Gm-Message-State: AOAM5306ZhoSb0eT3fUtlClLVWhSfL3VFudVHgNvblZd47nqFZnAj5Bo
        7P/zLaWREYmNnf2YuHb6BqisqW9yDv/3iwFa//p0B6U4KaNr
X-Google-Smtp-Source: ABdhPJxYz0dVRgE3CR2bdRaAY1wHuuUQAFn5Vxb50ZJnNco2ltdVZn4f/LGKY9z2ivNT312u9chRHOmyfl77sjrE5Xl/uZLXguyO
MIME-Version: 1.0
X-Received: by 2002:a92:c603:: with SMTP id p3mr244528ilm.56.1599592157278;
 Tue, 08 Sep 2020 12:09:17 -0700 (PDT)
Date:   Tue, 08 Sep 2020 12:09:17 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000051f7d005aed212a8@google.com>
Subject: INFO: trying to register non-static key in call_timer_fn
From:   syzbot <syzbot+f16dae8eab3e2aa546c0@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, bp@alien8.de, hpa@zytor.com,
        linux-kernel@vger.kernel.org, luto@kernel.org, mingo@redhat.com,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    59126901 Merge tag 'perf-tools-fixes-for-v5.9-2020-09-03' ..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=104cc1f9900000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3c5f6ce8d5b68299
dashboard link: https://syzkaller.appspot.com/bug?extid=f16dae8eab3e2aa546c0
compiler:       gcc (GCC) 10.1.0-syz 20200507

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+f16dae8eab3e2aa546c0@syzkaller.appspotmail.com

INFO: trying to register non-static key.
the code is fine but needs lockdep annotation.
turning off the locking correctness validator.
CPU: 1 PID: 6870 Comm: syz-executor.0 Not tainted 5.9.0-rc3-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 <IRQ>
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x198/0x1fd lib/dump_stack.c:118
 assign_lock_key kernel/locking/lockdep.c:894 [inline]
 register_lock_class+0x157d/0x1630 kernel/locking/lockdep.c:1206
 __lock_acquire+0xf9/0x5570 kernel/locking/lockdep.c:4305
 lock_acquire+0x1f3/0xae0 kernel/locking/lockdep.c:5006
 call_timer_fn+0x12e/0x760 kernel/time/timer.c:1410
 expire_timers kernel/time/timer.c:1458 [inline]
 __run_timers.part.0+0x67c/0xaa0 kernel/time/timer.c:1755
 __run_timers kernel/time/timer.c:1736 [inline]
 run_timer_softirq+0xae/0x1a0 kernel/time/timer.c:1768
 __do_softirq+0x1f7/0xa91 kernel/softirq.c:298
 asm_call_on_stack+0xf/0x20 arch/x86/entry/entry_64.S:706
 </IRQ>
 __run_on_irqstack arch/x86/include/asm/irq_stack.h:22 [inline]
 run_on_irqstack_cond arch/x86/include/asm/irq_stack.h:48 [inline]
 do_softirq_own_stack+0x9d/0xd0 arch/x86/kernel/irq_64.c:77
 invoke_softirq kernel/softirq.c:393 [inline]
 __irq_exit_rcu kernel/softirq.c:423 [inline]
 irq_exit_rcu+0x235/0x280 kernel/softirq.c:435
 sysvec_apic_timer_interrupt+0x51/0xf0 arch/x86/kernel/apic/apic.c:1091
 asm_sysvec_apic_timer_interrupt+0x12/0x20 arch/x86/include/asm/idtentry.h:581
RIP: 0010:check_kcov_mode kernel/kcov.c:163 [inline]
RIP: 0010:__sanitizer_cov_trace_pc+0x10/0x60 kernel/kcov.c:197
Code: f6 25 27 02 66 0f 1f 44 00 00 48 8b be b0 01 00 00 e8 b4 ff ff ff 31 c0 c3 90 65 48 8b 14 25 c0 fe 01 00 65 8b 05 70 b3 8d 7e <a9> 00 01 ff 00 48 8b 34 24 74 0f f6 c4 01 74 35 8b 82 24 14 00 00
RSP: 0018:ffffc9000548fea8 EFLAGS: 00000286
RAX: 0000000080000000 RBX: 0000000000000000 RCX: 1ffffffff15644f9
RDX: ffff888089592380 RSI: 0000000000000000 RDI: 0000000000000282
RBP: 1ffff92000a91fd6 R08: 0000000000000001 R09: 0000000000000001
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
R13: 00000000000f4240 R14: ffff888089592380 R15: 0000000000000000
 __do_sys_nanosleep kernel/time/hrtimer.c:1966 [inline]
 __se_sys_nanosleep kernel/time/hrtimer.c:1957 [inline]
 __x64_sys_nanosleep+0x1ed/0x260 kernel/time/hrtimer.c:1957
 do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x45ba81
Code: 75 14 b8 23 00 00 00 0f 05 48 3d 01 f0 ff ff 0f 83 84 cf fb ff c3 48 83 ec 08 e8 ea 46 00 00 48 89 04 24 b8 23 00 00 00 0f 05 <48> 8b 3c 24 48 89 c2 e8 33 47 00 00 48 89 d0 48 83 c4 08 48 3d 01
RSP: 002b:00007fff6f087e40 EFLAGS: 00000293 ORIG_RAX: 0000000000000023
RAX: ffffffffffffffda RBX: 000000000021c581 RCX: 000000000045ba81
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 00007fff6f087e50
RBP: 000000000000128d R08: 0000000000000000 R09: 0000000002d3e940
R10: 0000000000000000 R11: 0000000000000293 R12: 0000000000000005
R13: 00007fff6f087ea0 R14: 000000000021c517 R15: 00007fff6f087eb0
BUG: kernel NULL pointer dereference, address: 0000000000000000
#PF: supervisor instruction fetch in kernel mode
#PF: error_code(0x0010) - not-present page
PGD 86a3c067 P4D 86a3c067 PUD 86a3d067 PMD 0 
Oops: 0010 [#1] PREEMPT SMP KASAN
CPU: 1 PID: 6870 Comm: syz-executor.0 Not tainted 5.9.0-rc3-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:0x0
Code: Bad RIP value.
RSP: 0018:ffffc90000da8d18 EFLAGS: 00010246
RAX: 0000000000000000 RBX: ffff88800011e790 RCX: ffffffff81642da8
RDX: ffff888089592380 RSI: ffffffff81642952 RDI: ffff88800011e790
RBP: 0000000000000100 R08: 0000000000000000 R09: ffffffff8ab2640f
R10: 0000000000000000 R11: 0000000000003143 R12: ffffc90000da8d68
R13: 0000000000000000 R14: 1ffff920001b51a7 R15: ffff8880ae7255c0
FS:  0000000002d3e940(0000) GS:ffff8880ae700000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffffffffffffd6 CR3: 0000000086a3b000 CR4: 00000000001526e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <IRQ>
 call_timer_fn+0x1ac/0x760 kernel/time/timer.c:1413
 expire_timers kernel/time/timer.c:1458 [inline]
 __run_timers.part.0+0x67c/0xaa0 kernel/time/timer.c:1755
 __run_timers kernel/time/timer.c:1736 [inline]
 run_timer_softirq+0xae/0x1a0 kernel/time/timer.c:1768
 __do_softirq+0x1f7/0xa91 kernel/softirq.c:298
 asm_call_on_stack+0xf/0x20 arch/x86/entry/entry_64.S:706
 </IRQ>
 __run_on_irqstack arch/x86/include/asm/irq_stack.h:22 [inline]
 run_on_irqstack_cond arch/x86/include/asm/irq_stack.h:48 [inline]
 do_softirq_own_stack+0x9d/0xd0 arch/x86/kernel/irq_64.c:77
 invoke_softirq kernel/softirq.c:393 [inline]
 __irq_exit_rcu kernel/softirq.c:423 [inline]
 irq_exit_rcu+0x235/0x280 kernel/softirq.c:435
 sysvec_apic_timer_interrupt+0x51/0xf0 arch/x86/kernel/apic/apic.c:1091
 asm_sysvec_apic_timer_interrupt+0x12/0x20 arch/x86/include/asm/idtentry.h:581
RIP: 0010:check_kcov_mode kernel/kcov.c:163 [inline]
RIP: 0010:__sanitizer_cov_trace_pc+0x10/0x60 kernel/kcov.c:197
Code: f6 25 27 02 66 0f 1f 44 00 00 48 8b be b0 01 00 00 e8 b4 ff ff ff 31 c0 c3 90 65 48 8b 14 25 c0 fe 01 00 65 8b 05 70 b3 8d 7e <a9> 00 01 ff 00 48 8b 34 24 74 0f f6 c4 01 74 35 8b 82 24 14 00 00
RSP: 0018:ffffc9000548fea8 EFLAGS: 00000286
RAX: 0000000080000000 RBX: 0000000000000000 RCX: 1ffffffff15644f9
RDX: ffff888089592380 RSI: 0000000000000000 RDI: 0000000000000282
RBP: 1ffff92000a91fd6 R08: 0000000000000001 R09: 0000000000000001
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
R13: 00000000000f4240 R14: ffff888089592380 R15: 0000000000000000
 __do_sys_nanosleep kernel/time/hrtimer.c:1966 [inline]
 __se_sys_nanosleep kernel/time/hrtimer.c:1957 [inline]
 __x64_sys_nanosleep+0x1ed/0x260 kernel/time/hrtimer.c:1957
 do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x45ba81
Code: 75 14 b8 23 00 00 00 0f 05 48 3d 01 f0 ff ff 0f 83 84 cf fb ff c3 48 83 ec 08 e8 ea 46 00 00 48 89 04 24 b8 23 00 00 00 0f 05 <48> 8b 3c 24 48 89 c2 e8 33 47 00 00 48 89 d0 48 83 c4 08 48 3d 01
RSP: 002b:00007fff6f087e40 EFLAGS: 00000293 ORIG_RAX: 0000000000000023
RAX: ffffffffffffffda RBX: 000000000021c581 RCX: 000000000045ba81
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 00007fff6f087e50
RBP: 000000000000128d R08: 0000000000000000 R09: 0000000002d3e940
R10: 0000000000000000 R11: 0000000000000293 R12: 0000000000000005
R13: 00007fff6f087ea0 R14: 000000000021c517 R15: 00007fff6f087eb0
Modules linked in:
CR2: 0000000000000000
---[ end trace 2e45133794e19161 ]---
RIP: 0010:0x0
Code: Bad RIP value.
RSP: 0018:ffffc90000da8d18 EFLAGS: 00010246
RAX: 0000000000000000 RBX: ffff88800011e790 RCX: ffffffff81642da8
RDX: ffff888089592380 RSI: ffffffff81642952 RDI: ffff88800011e790
RBP: 0000000000000100 R08: 0000000000000000 R09: ffffffff8ab2640f
R10: 0000000000000000 R11: 0000000000003143 R12: ffffc90000da8d68
R13: 0000000000000000 R14: 1ffff920001b51a7 R15: ffff8880ae7255c0
FS:  0000000002d3e940(0000) GS:ffff8880ae700000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffffffffffffd6 CR3: 0000000086a3b000 CR4: 00000000001526e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
