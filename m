Return-Path: <SRS0=6o4L=5Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1FF2C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 13:28:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2D8120772
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 13:28:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730803AbgCaN2N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Mar 2020 09:28:13 -0400
Received: from mail-il1-f198.google.com ([209.85.166.198]:36325 "EHLO
        mail-il1-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730358AbgCaN2N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 09:28:13 -0400
Received: by mail-il1-f198.google.com with SMTP id e5so20095621ilg.3
        for <linux-kernel@vger.kernel.org>; Tue, 31 Mar 2020 06:28:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=WvmhAf0EGJmTxhNiU7nyoRchCTTyqnhKZ752rwUmOl4=;
        b=b9DAmA/JY8DLlzRdUsZ8/LXM21XPv/2MEaOysW/z+Csy0i7gva7xKM/vxSjlLm1yA5
         ynuL/4jF7YyE7RQ/8VvtMNzlWvSYn7QG8by19dD196dTwSchagX//m3nsddl9MmY+ID7
         1BSAHJcM6LgOeP/BSyxwVW8448boeuGEyg3yyJ70/c5Av+gp9lhnD0Na0R79RWjVZ83B
         iTu9uGg5pOfl2ILxxVUaIF2Qv5UjQ4rp++CQdOa+2sutM6wdQM8ua9GBSV4mjjqZut/8
         nd0Z7SmVegYFTe53YHGbXkwuF4u/Vvny1R6IoKoWbw5f8xR4vfrXf/48JnIXSPN/09mf
         bFkw==
X-Gm-Message-State: ANhLgQ1z2O2soaovBYGtDoLCYacVmv9Q0uAxgnnfiOJSIK1XX0LzPUXq
        PtAT0vZ95utalSLUwhZ+ltOIMmZcxJJaiTMeWTXJ/gYmsWjy
X-Google-Smtp-Source: ADFU+vtzU60QcWXLltTCiroA+e4JhpT7Zs3tJ3iv68NAgY7D22nae+pvxCGmubot3MzRXrgdeomIpn2yYTIyoAfn/dYSRvrRcOtJ
MIME-Version: 1.0
X-Received: by 2002:a6b:e316:: with SMTP id u22mr15303726ioc.1.1585661292754;
 Tue, 31 Mar 2020 06:28:12 -0700 (PDT)
Date:   Tue, 31 Mar 2020 06:28:12 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000016bac605a2268a08@google.com>
Subject: WARNING in percpu_ref_switch_to_atomic_rcu
From:   syzbot <syzbot+0076781e1606f479425e@syzkaller.appspotmail.com>
To:     bp@alien8.de, hpa@zytor.com, linux-kernel@vger.kernel.org,
        mingo@redhat.com, peterz@infradead.org,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    770fbb32 Add linux-next specific files for 20200228
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=1414f7ade00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=576314276bce4ad5
dashboard link: https://syzkaller.appspot.com/bug?extid=0076781e1606f479425e
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+0076781e1606f479425e@syzkaller.appspotmail.com

------------[ cut here ]------------
percpu ref (io_file_data_ref_zero) <= 0 (0) after switching to atomic
WARNING: CPU: 0 PID: 0 at lib/percpu-refcount.c:160 percpu_ref_switch_to_atomic_rcu+0x436/0x540 lib/percpu-refcount.c:160
Kernel panic - not syncing: panic_on_warn set ...
CPU: 0 PID: 0 Comm: swapper/0 Not tainted 5.6.0-rc3-next-20200228-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 <IRQ>
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x188/0x20d lib/dump_stack.c:118
 panic+0x2e3/0x75c kernel/panic.c:221
 __warn.cold+0x2f/0x35 kernel/panic.c:582
 report_bug+0x27b/0x2f0 lib/bug.c:195
 fixup_bug arch/x86/kernel/traps.c:175 [inline]
 fixup_bug arch/x86/kernel/traps.c:170 [inline]
 do_error_trap+0x12b/0x220 arch/x86/kernel/traps.c:267
 do_invalid_op+0x32/0x40 arch/x86/kernel/traps.c:286
 invalid_op+0x23/0x30 arch/x86/entry/entry_64.S:1027
RIP: 0010:percpu_ref_switch_to_atomic_rcu+0x436/0x540 lib/percpu-refcount.c:160
Code: 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 80 3c 02 00 0f 85 f7 00 00 00 49 8b 75 e8 4c 89 e2 48 c7 c7 e0 d1 71 88 e8 02 36 b5 fd <0f> 0b e9 2b fd ff ff e8 7e 6a e3 fd be 08 00 00 00 48 89 ef e8 51
RSP: 0018:ffffc90000007df0 EFLAGS: 00010282
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
RDX: 0000000000000100 RSI: ffffffff815c4e91 RDI: fffff52000000fb0
RBP: ffff88808c4b2810 R08: ffffffff8987a480 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
R13: ffff88808c4b2838 R14: 0000000000000002 R15: 0000000000000007
 rcu_do_batch kernel/rcu/tree.c:2218 [inline]
 rcu_core+0x59f/0x1370 kernel/rcu/tree.c:2445
 __do_softirq+0x26c/0x99d kernel/softirq.c:292
 invoke_softirq kernel/softirq.c:373 [inline]
 irq_exit+0x192/0x1d0 kernel/softirq.c:413
 exiting_irq arch/x86/include/asm/apic.h:546 [inline]
 smp_apic_timer_interrupt+0x19e/0x600 arch/x86/kernel/apic/apic.c:1146
 apic_timer_interrupt+0xf/0x20 arch/x86/entry/entry_64.S:829
 </IRQ>
RIP: 0010:native_safe_halt+0xe/0x10 arch/x86/include/asm/irqflags.h:61
Code: cc cc cc cc cc cc cc cc cc cc cc cc e9 07 00 00 00 0f 00 2d e4 35 65 00 f4 c3 66 90 e9 07 00 00 00 0f 00 2d d4 35 65 00 fb f4 <c3> cc 41 56 41 55 41 54 55 53 e8 f3 25 9d f9 e8 8e f7 cf fb 0f 1f
RSP: 0018:ffffffff89807d98 EFLAGS: 00000286 ORIG_RAX: ffffffffffffff13
RAX: 1ffffffff132790a RBX: ffffffff8987a480 RCX: 0000000000000000
RDX: dffffc0000000000 RSI: 0000000000000006 RDI: ffffffff8987ad1c
RBP: dffffc0000000000 R08: ffffffff8987a480 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: fffffbfff130f490
R13: 0000000000000000 R14: ffffffff8a862140 R15: 0000000000000000
 arch_safe_halt arch/x86/include/asm/paravirt.h:144 [inline]
 default_idle+0x49/0x350 arch/x86/kernel/process.c:698
 cpuidle_idle_call kernel/sched/idle.c:154 [inline]
 do_idle+0x393/0x690 kernel/sched/idle.c:269
 cpu_startup_entry+0x14/0x20 kernel/sched/idle.c:361
 start_kernel+0x867/0x8a1 init/main.c:1001
 secondary_startup_64+0xa4/0xb0 arch/x86/kernel/head_64.S:242
Kernel Offset: disabled
Rebooting in 86400 seconds..


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
