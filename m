Return-Path: <SRS0=eGSO=AR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAE23C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 10:47:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C24F82074D
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 10:47:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728946AbgGFKrT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jul 2020 06:47:19 -0400
Received: from mail-il1-f197.google.com ([209.85.166.197]:44202 "EHLO
        mail-il1-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728849AbgGFKrQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jul 2020 06:47:16 -0400
Received: by mail-il1-f197.google.com with SMTP id x2so18948348ila.11
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jul 2020 03:47:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=8uzDPbjz7PB3i0ByH+Lgh/Al6pGSPusuqFlL3uWyGdg=;
        b=o3fGWW6LqzGbm5NCy+DeavKF6BsEpDesPCes9TN/nfQ7vNPIpBx8IQqcF4kxVNTxJO
         AJro2xdHUO2qnm2153RE/FL7lHcmiYi/Js2yOYavD9ldw+cXhQyUP62Bavh3yIeyWqeJ
         dyGzlclS4GMQWz4C6eR0VYqa1ZDpAT9ectKYkPZJJCPP61nO2usrNLBv1y7WcoM1cux4
         1rw31DU65m43/HckwuC7jjBnNnGf42U04u0pOAevA0NPmTbbmhq4veRAkSRFUXdrBpBt
         ym2B8xUroOsU/Ys8x0th9vu6HId6FajFZWrdGmInrk7H8Esn1pyXG531wYELexHEnTfC
         1tOw==
X-Gm-Message-State: AOAM531xPwvd8YThEJHAV5vVC+BjW9SO8eyO7fPJjqbGf++5TkprfN9u
        RhtA5Z/SMAbGAmIfbELkLQrcKl+ruTfC5R+tj+GjPPKzHegW
X-Google-Smtp-Source: ABdhPJyl3onVDQ0C7BeIb8U1xZo/jKD2MFRf+sOYl1iY+iZePYTbR0rKcR4Gn6J3dE51knP05RmqMiDZ9pOLhJ4XvkuGJH3AFk1V
MIME-Version: 1.0
X-Received: by 2002:a6b:1ce:: with SMTP id 197mr25305094iob.76.1594032435830;
 Mon, 06 Jul 2020 03:47:15 -0700 (PDT)
Date:   Mon, 06 Jul 2020 03:47:15 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000001926b505a9c39918@google.com>
Subject: WARNING in update_curr
From:   syzbot <syzbot+64ee4429b2be89db53db@syzkaller.appspotmail.com>
To:     bigeasy@linutronix.de, linux-kernel@vger.kernel.org,
        mingo@kernel.org, peterz@infradead.org,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    719fdd32 afs: Fix storage of cell names
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=10e0f8a3100000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ce0957b53c175ac4
dashboard link: https://syzkaller.appspot.com/bug?extid=64ee4429b2be89db53db
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+64ee4429b2be89db53db@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 1 PID: 59 at kernel/sched/sched.h:1132 rq_clock_task kernel/sched/sched.h:1132 [inline]
WARNING: CPU: 1 PID: 59 at kernel/sched/sched.h:1132 update_curr+0x295/0x8a0 kernel/sched/fair.c:847
Kernel panic - not syncing: panic_on_warn set ...
CPU: 1 PID: 59 Comm: kworker/1:1 Not tainted 5.8.0-rc2-syzkaller #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.12.0-59-gc9ba5276e321-prebuilt.qemu.org 04/01/2014
Workqueue: events close_work
Call Trace:
 <IRQ>
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x18f/0x20d lib/dump_stack.c:118
 panic+0x2e3/0x75c kernel/panic.c:231
 __warn.cold+0x2f/0x3a kernel/panic.c:600
 report_bug+0x271/0x2f0 lib/bug.c:198
 exc_invalid_op+0x1b9/0x370 arch/x86/kernel/traps.c:235
 asm_exc_invalid_op+0x12/0x20 arch/x86/include/asm/idtentry.h:563
RIP: 0010:rq_clock_task kernel/sched/sched.h:1132 [inline]
RIP: 0010:update_curr+0x295/0x8a0 kernel/sched/fair.c:847
Code: 80 3c 02 00 0f 85 5c 05 00 00 4c 01 65 20 e9 af fe ff ff 49 8d 7c 24 18 be ff ff ff ff e8 b3 38 8d 06 85 c0 0f 85 04 fe ff ff <0f> 0b e9 fd fd ff ff 4c 8d 73 80 0f 1f 44 00 00 65 44 8b 2d 63 ba
RSP: 0018:ffffc900004e8d88 EFLAGS: 00010046
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000001
RDX: dffffc0000000000 RSI: ffff88802d035e18 RDI: 0000000000000086
RBP: ffff8880280afc00 R08: 0000000000000000 R09: fffffbfff137464b
R10: ffffffff89ba3257 R11: 0000000000000000 R12: ffff88802d035e00
R13: 0000000000000000 R14: dffffc0000000000 R15: ffff888060f98180
 enqueue_entity+0x1eb/0x1830 kernel/sched/fair.c:4190
 enqueue_task_fair+0x1a0/0x1a30 kernel/sched/fair.c:5485
 enqueue_task kernel/sched/core.c:1295 [inline]
 activate_task+0x10d/0x3f0 kernel/sched/core.c:1317
 ttwu_do_activate+0xca/0x130 kernel/sched/core.c:2247
 sched_ttwu_pending+0x16f/0x200 kernel/sched/core.c:2297
 flush_smp_call_function_queue+0x409/0x6e0 kernel/smp.c:314
 __sysvec_call_function_single+0x98/0x490 arch/x86/kernel/smp.c:248
 asm_call_on_stack+0xf/0x20 arch/x86/entry/entry_64.S:711
 </IRQ>
 __run_on_irqstack arch/x86/include/asm/irq_stack.h:22 [inline]
 run_on_irqstack_cond arch/x86/include/asm/irq_stack.h:48 [inline]
 sysvec_call_function_single+0x1bf/0x210 arch/x86/kernel/smp.c:243
 asm_sysvec_call_function_single+0x12/0x20 arch/x86/include/asm/idtentry.h:604
RIP: 0010:arch_local_irq_restore arch/x86/include/asm/paravirt.h:765 [inline]
RIP: 0010:__raw_spin_unlock_irqrestore include/linux/spinlock_api_smp.h:160 [inline]
RIP: 0010:_raw_spin_unlock_irqrestore+0x8c/0xe0 kernel/locking/spinlock.c:191
Code: 48 c7 c0 80 b4 b4 89 48 ba 00 00 00 00 00 fc ff df 48 c1 e8 03 80 3c 10 00 75 37 48 83 3d 4b d7 d1 01 00 74 22 48 89 df 57 9d <0f> 1f 44 00 00 bf 01 00 00 00 e8 35 3f 6c f9 65 8b 05 6e 21 1f 78
RSP: 0018:ffffc900006c7d10 EFLAGS: 00000286
RAX: 1ffffffff1369690 RBX: 0000000000000286 RCX: 1ffffffff155c832
RDX: dffffc0000000000 RSI: 0000000000000000 RDI: 0000000000000286
RBP: ffff88802809e998 R08: 0000000000000000 R09: 0000000000000001
R10: ffffffff8c58db0f R11: fffffbfff18b1b61 R12: 0000000000000080
R13: ffff88802809e958 R14: ffff88802bdc0f00 R15: ffff88802cf35600
 process_one_work+0x965/0x1690 kernel/workqueue.c:2269
 worker_thread+0x96/0xe10 kernel/workqueue.c:2415
 kthread+0x3b5/0x4a0 kernel/kthread.c:291
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:293
Kernel Offset: disabled


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
