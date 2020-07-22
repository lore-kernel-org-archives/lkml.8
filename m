Return-Path: <SRS0=5pK+=BB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BCBAC433E5
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 18:22:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 41E2A22CAE
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 18:22:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731921AbgGVSWe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 14:22:34 -0400
Received: from mail-il1-f200.google.com ([209.85.166.200]:40118 "EHLO
        mail-il1-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729816AbgGVSW0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 14:22:26 -0400
Received: by mail-il1-f200.google.com with SMTP id z16so1675793ill.7
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jul 2020 11:22:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=QJptuQmPpK84AkiYZk0IVS1um85kAHPSR0himC5GjcI=;
        b=HpWb9nhP1n7EkfWF3zCwICF1//4/9e8HYZHOrqT15PQYQLeE2gAU4vqq94D6i6ETMr
         IoXsUTNbo46vi2KdB7Ch16i8NT9bI1RYbsqFxFKaAVW7ZhKK86Vz/MP5PLfP2Y6N5U1P
         zkGq53J7Lc2C3L1O0BZSSuyT/kCD8rxj39pZay3zsVrk34olKjjnL64sDXAQlxnl+xJK
         fw38NvzkaPfdsiI3wrgvSBfb7oCscKIHXdkrA1Evw4spdV6Cw/wBdyAKYb7P5K/v2Oes
         yZFGZ1tdr5vWa6s4BjNvhOUjogsuYPs5p/k62jKvwoBHcwopLpvNG3ToACRoz02OKoML
         JaqA==
X-Gm-Message-State: AOAM531oG5POzJftSBxwucNUWBEqKZ3QXIi58ZN+7QbXf13iOTl9Ro8F
        FdYk3njGCa2yxtGut6qTqo8lrQiwsXnGq7WQ7ZHBHOMeuRxw
X-Google-Smtp-Source: ABdhPJyQtTqA0zK+ihej3d/4CuVawBI+bfjAaCR0NYueZbIiI4LplmoLbi7sw1syf28I1el9+3xi40YtpmFd2b2mQ7aWPQ144KMy
MIME-Version: 1.0
X-Received: by 2002:a92:294:: with SMTP id 142mr1293463ilc.112.1595442144888;
 Wed, 22 Jul 2020 11:22:24 -0700 (PDT)
Date:   Wed, 22 Jul 2020 11:22:24 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000004e572405ab0bd283@google.com>
Subject: WARNING in ttwu_queue_wakelist
From:   syzbot <syzbot+c9cb7a5af4ab24dc9088@syzkaller.appspotmail.com>
To:     linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        tglx@linutronix.de
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    4fa640dc Merge tag 'vfio-v5.8-rc7' of git://github.com/awi..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=10ae7ec8900000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f3bc31881f1ae8a7
dashboard link: https://syzkaller.appspot.com/bug?extid=c9cb7a5af4ab24dc9088
compiler:       clang version 10.0.0 (https://github.com/llvm/llvm-project/ c2443155a0fb245c8f17f2c1c72b6ea391e86e81)

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+c9cb7a5af4ab24dc9088@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 1 PID: 22272 at kernel/sched/core.c:2382 __ttwu_queue_wakelist kernel/sched/core.c:2326 [inline]
WARNING: CPU: 1 PID: 22272 at kernel/sched/core.c:2382 ttwu_queue_wakelist+0x19a/0x250 kernel/sched/core.c:2386
Kernel panic - not syncing: panic_on_warn set ...
CPU: 1 PID: 22272 Comm: syz-executor.5 Not tainted 5.8.0-rc6-syzkaller #0
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
 asm_exc_invalid_op+0x12/0x20 arch/x86/include/asm/idtentry.h:540
RIP: 0010:ttwu_queue_wakelist+0x19a/0x250 kernel/sched/core.c:2326
Code: e8 03 42 8a 04 28 84 c0 0f 85 82 00 00 00 c7 03 01 00 00 00 49 83 c6 30 44 89 ff 4c 89 f6 e8 ed d2 17 00 b0 01 e9 a6 00 00 00 <0f> 0b 31 c0 e9 9d 00 00 00 89 d9 80 e1 07 80 c1 03 38 c1 0f 8c b6
RSP: 0018:ffffc90000da8cc8 EFLAGS: 00010046
RAX: 0000000000000001 RBX: ffff8880ae920cb4 RCX: dffffc0000000000
RDX: 0000000000000000 RSI: 0000000000010002 RDI: 0000000000000000
RBP: 1ffffffff125ab1d R08: dffffc0000000000 R09: fffffbfff131a7f1
R10: fffffbfff131a7f1 R11: 0000000000000000 R12: 0000000000000000
R13: ffff8880ae900000 R14: ffffffff892d58e8 R15: 0000000000000001
 ttwu_queue kernel/sched/core.c:2400 [inline]
 try_to_wake_up+0x774/0xbb0 kernel/sched/core.c:2666
 hrtimer_wakeup+0x60/0x80 kernel/time/hrtimer.c:1774
 __run_hrtimer kernel/time/hrtimer.c:1520 [inline]
 __hrtimer_run_queues+0x47f/0x930 kernel/time/hrtimer.c:1584
 hrtimer_interrupt+0x373/0xd60 kernel/time/hrtimer.c:1646
 local_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1080 [inline]
 __sysvec_apic_timer_interrupt+0xf0/0x260 arch/x86/kernel/apic/apic.c:1097
 asm_call_on_stack+0xf/0x20 arch/x86/entry/entry_64.S:711
 </IRQ>
 __run_on_irqstack arch/x86/include/asm/irq_stack.h:22 [inline]
 run_on_irqstack_cond arch/x86/include/asm/irq_stack.h:48 [inline]
 sysvec_apic_timer_interrupt+0xb9/0x130 arch/x86/kernel/apic/apic.c:1091
 asm_sysvec_apic_timer_interrupt+0x12/0x20 arch/x86/include/asm/idtentry.h:585
RIP: 0010:arch_local_irq_restore arch/x86/include/asm/paravirt.h:770 [inline]
RIP: 0010:lock_acquire+0x1bf/0x720 kernel/locking/lockdep.c:4962
Code: c1 e8 03 80 3c 10 00 74 0c 48 c7 c7 f8 c7 4b 89 e8 a6 03 5a 00 48 83 3d c6 2b f2 07 00 0f 84 09 05 00 00 48 8b 7c 24 10 57 9d <0f> 1f 44 00 00 65 48 8b 04 25 28 00 00 00 48 3b 44 24 50 0f 85 e0
RSP: 0018:ffffc900018779c8 EFLAGS: 00000286
RAX: 1ffffffff12978ff RBX: 0000000000000001 RCX: 67ea766929fc7dd6
RDX: dffffc0000000000 RSI: ffff888054d56bf8 RDI: 0000000000000286
RBP: 1ffff1100a9aad79 R08: dffffc0000000000 R09: fffffbfff1674eb1
R10: fffffbfff1674eb1 R11: 0000000000000000 R12: 0000000000000001
R13: 0000000000000000 R14: ffff888054d56bcc R15: 0000000000000000
 percpu_down_read_trylock include/linux/percpu-rwsem.h:92 [inline]
 __sb_start_write+0x29d/0x410 fs/super.c:1674
 sb_start_write_trylock include/linux/fs.h:1670 [inline]
 touch_atime+0xb7/0x2a0 fs/inode.c:1831
 file_accessed include/linux/fs.h:2229 [inline]
 shmem_file_read_iter+0x8c4/0xb60 mm/shmem.c:2604
 call_read_iter include/linux/fs.h:1902 [inline]
 generic_file_splice_read+0x3c4/0x660 fs/splice.c:312
 do_splice_to fs/splice.c:870 [inline]
 splice_direct_to_actor+0x3bd/0xb60 fs/splice.c:950
 do_splice_direct+0x201/0x340 fs/splice.c:1059
 do_sendfile+0x809/0xfe0 fs/read_write.c:1540
 __do_sys_sendfile64 fs/read_write.c:1601 [inline]
 __se_sys_sendfile64 fs/read_write.c:1587 [inline]
 __x64_sys_sendfile64+0x164/0x1a0 fs/read_write.c:1587
 do_syscall_64+0x73/0xe0 arch/x86/entry/common.c:384
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x45c1f9
Code: Bad RIP value.
RSP: 002b:00007f87766dbc78 EFLAGS: 00000246 ORIG_RAX: 0000000000000028
RAX: ffffffffffffffda RBX: 00000000000260c0 RCX: 000000000045c1f9
RDX: 0000000000000000 RSI: 0000000000000005 RDI: 0000000000000004
RBP: 000000000078bf48 R08: 0000000000000000 R09: 0000000000000000
R10: 02008000fffffffe R11: 0000000000000246 R12: 000000000078bf0c
R13: 00007fff4986196f R14: 00007f87766dc9c0 R15: 000000000078bf0c

======================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
