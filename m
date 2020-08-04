Return-Path: <SRS0=pusq=BO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 269C5C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 00:36:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 361EB2076C
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 00:36:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729312AbgHDAgX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 20:36:23 -0400
Received: from mail-io1-f71.google.com ([209.85.166.71]:45706 "EHLO
        mail-io1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727115AbgHDAgX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 20:36:23 -0400
Received: by mail-io1-f71.google.com with SMTP id p17so24743259iod.12
        for <linux-kernel@vger.kernel.org>; Mon, 03 Aug 2020 17:36:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=aNPnG4pemYsbWypDWx/FCY3K33DVbGZf35WAcDiCetI=;
        b=PZlls54FFJBaGLY95x/QND4c/2ul+B9OMRP1eU0VXNue7b4dAc+UPQxoJ4Xe9U/GIb
         Gp+HSTul9oInaNzZ/m8DoI8M/zqELO7QQ28hW/GrvAYZ4v19WFyticgVwjwAYJZ3uPpd
         DgJwVLHMq15YSdV9fbCrSTyZqDzdSc9O4h7f3aTTICVykuKngzu8yq/HhpxYmnwTZAa3
         plREZK3uEZ3GT/jqA52aAk6Ebp8oF2QbXvr755PXnT8hrjstQsHeip9y956EqCS/fKO4
         OcpZmzINwICtKttLLNtL7aCKQp92KebnTMlEUfOmrWwk9IJi2Hmraiv4sJZXYqPo5o6Y
         Ar7w==
X-Gm-Message-State: AOAM531jPXeXO8kCBzY3EbXuyS1xGVdxmrbwKVUngXP/Srfj++v8TrLj
        jJuuOKQ/ZkVUhE6ceYKbWYhFGl4kNW5DJ2I5nDHMgE5R5QNU
X-Google-Smtp-Source: ABdhPJzTtEOCu2hEhFj4IZhkOsrFyxcI8KnGwaI8UvnOe+DaiXkYrwdZn1kWlHIR8SzV6R3sjk/55QQh9ebIamjwmf1QxKxe98Al
MIME-Version: 1.0
X-Received: by 2002:a5e:d906:: with SMTP id n6mr2555034iop.106.1596501382370;
 Mon, 03 Aug 2020 17:36:22 -0700 (PDT)
Date:   Mon, 03 Aug 2020 17:36:22 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c79c6b05ac027164@google.com>
Subject: WARNING in __queue_work (3)
From:   syzbot <syzbot+63bed493aebbf6872647@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, bp@alien8.de, hkallweit1@gmail.com,
        hpa@zytor.com, linux-kernel@vger.kernel.org, luto@kernel.org,
        mingo@redhat.com, syzkaller-bugs@googlegroups.com,
        tglx@linutronix.de, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    e2c46b57 Merge tag 'block-5.8-2020-07-30' of git://git.ker..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1269bcb8900000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e956cd46a325a50c
dashboard link: https://syzkaller.appspot.com/bug?extid=63bed493aebbf6872647
compiler:       gcc (GCC) 10.1.0-syz 20200507
userspace arch: i386

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+63bed493aebbf6872647@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 1 PID: 0 at kernel/workqueue.c:1413 __queue_work+0xc2c/0xff0 kernel/workqueue.c:1413
Kernel panic - not syncing: panic_on_warn set ...
CPU: 1 PID: 0 Comm: swapper/1 Not tainted 5.8.0-rc7-syzkaller #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.12.0-59-gc9ba5276e321-prebuilt.qemu.org 04/01/2014
Call Trace:
 <IRQ>
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x18f/0x20d lib/dump_stack.c:118
 panic+0x2e3/0x75c kernel/panic.c:231
 __warn.cold+0x20/0x45 kernel/panic.c:600
 report_bug+0x1bd/0x210 lib/bug.c:198
 handle_bug+0x38/0x90 arch/x86/kernel/traps.c:235
 exc_invalid_op+0x13/0x40 arch/x86/kernel/traps.c:255
 asm_exc_invalid_op+0x12/0x20 arch/x86/include/asm/idtentry.h:540
RIP: 0010:__queue_work+0xc2c/0xff0 kernel/workqueue.c:1413
Code: e0 07 83 c0 03 38 d0 7c 09 84 d2 74 05 e8 ec 38 67 00 8b 5b 24 31 ff 83 e3 20 89 de e8 8d d0 27 00 85 db 75 7c e8 04 d4 27 00 <0f> 0b e9 42 fa ff ff e8 f8 d3 27 00 0f 0b e9 bb f9 ff ff e8 ec d3
RSP: 0018:ffffc900004e8cb0 EFLAGS: 00010046
RAX: 0000000000000000 RBX: 0000000000000100 RCX: ffffffff814be8b3
RDX: ffff88802c1ec380 RSI: ffffffff814be90c RDI: 0000000000000005
RBP: 0000000000000101 R08: 0000000000000001 R09: ffffffff8cb6a4a3
R10: 0000000000000000 R11: 0000000000000000 R12: ffff88805fdfe128
R13: 0000000000000000 R14: ffff88802930e000 R15: 0000000000000040
 call_timer_fn+0x1ac/0x760 kernel/time/timer.c:1416
 expire_timers kernel/time/timer.c:1456 [inline]
 __run_timers.part.0+0x376/0xa20 kernel/time/timer.c:1792
 __run_timers kernel/time/timer.c:1764 [inline]
 run_timer_softirq+0xae/0x1a0 kernel/time/timer.c:1805
 __do_softirq+0x34c/0xa60 kernel/softirq.c:292
 asm_call_on_stack+0xf/0x20 arch/x86/entry/entry_64.S:711
 </IRQ>
 __run_on_irqstack arch/x86/include/asm/irq_stack.h:22 [inline]
 run_on_irqstack_cond arch/x86/include/asm/irq_stack.h:48 [inline]
 do_softirq_own_stack+0x111/0x170 arch/x86/kernel/irq_64.c:77
 invoke_softirq kernel/softirq.c:387 [inline]
 __irq_exit_rcu kernel/softirq.c:417 [inline]
 irq_exit_rcu+0x229/0x270 kernel/softirq.c:429
 sysvec_apic_timer_interrupt+0x54/0x120 arch/x86/kernel/apic/apic.c:1091
 asm_sysvec_apic_timer_interrupt+0x12/0x20 arch/x86/include/asm/idtentry.h:585
RIP: 0010:native_safe_halt+0xe/0x10 arch/x86/include/asm/irqflags.h:61
Code: ff 4c 89 ef e8 e3 69 c8 f9 e9 8e fe ff ff 48 89 df e8 d6 69 c8 f9 eb 8a cc cc cc cc e9 07 00 00 00 0f 00 2d b4 ff 5d 00 fb f4 <c3> 90 e9 07 00 00 00 0f 00 2d a4 ff 5d 00 f4 c3 cc cc 55 53 e8 a9
RSP: 0018:ffffc9000041fde8 EFLAGS: 00000282
RAX: 1ffffffff1369c14 RBX: ffff88802c1ec380 RCX: 0000000000000000
RDX: dffffc0000000000 RSI: 0000000000000000 RDI: ffffffff87eab336
RBP: dffffc0000000000 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000000 R12: ffffed100583d870
R13: 0000000000000001 R14: ffffffff8aaf2548 R15: 0000000000000000
 arch_safe_halt arch/x86/include/asm/paravirt.h:150 [inline]
 default_idle+0x40/0x70 arch/x86/kernel/process.c:686
 cpuidle_idle_call kernel/sched/idle.c:163 [inline]
 do_idle+0x38f/0x6d0 kernel/sched/idle.c:276
 cpu_startup_entry+0x14/0x20 kernel/sched/idle.c:372
 start_secondary+0x2b3/0x370 arch/x86/kernel/smpboot.c:268
 secondary_startup_64+0xa4/0xb0 arch/x86/kernel/head_64.S:243
Kernel Offset: disabled
Rebooting in 86400 seconds..


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
