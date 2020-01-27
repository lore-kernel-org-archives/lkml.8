Return-Path: <SRS0=1cir=3Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BAF4C32771
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jan 2020 06:32:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F92C214AF
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jan 2020 06:32:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727084AbgA0GcJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jan 2020 01:32:09 -0500
Received: from mail-io1-f72.google.com ([209.85.166.72]:34265 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725763AbgA0GcJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jan 2020 01:32:09 -0500
Received: by mail-io1-f72.google.com with SMTP id n26so5581581ioj.1
        for <linux-kernel@vger.kernel.org>; Sun, 26 Jan 2020 22:32:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=hgVKFRaMNuongEBRUC9dpzBJOx9XtPWFcBLNDou2zK8=;
        b=Unyoih45ptkTRAi23ArPsP0QjAMDkyBQgnucAplrBrqSyP9q0f6tITWqNRci7a+9s9
         A0LHVCi9ycY+i0bQnFr2QkP0e7ETqVsCl82h30T05JauVDOmLwAe018giHG3/8ClxqPk
         EIcoL9MAka7IhbxnOULH//dL/+Q16LFntuj31+3zR2bThnNBMcgl6a0WgBZFbEBPVqAx
         dSa0wy1SRRML7aKqS/1mPy/CUIPL0sfBdrk60yF+ZRxBwkRbC0JP/Gj5pmLQMa0ZTTX5
         8OgwDGnZwVhctoWlVnBNBeuClGZ+69EVx7gtheCXVbbQ6IhfOWPcaV2Nl+2ATJ7YvTGA
         AVxA==
X-Gm-Message-State: APjAAAX8S3dwWjCOOL4j7Y/P/VVUU73Qqfh1UQLOHbnRcWS4IDUFtBGW
        ChxDzeHJAiTblFw8w+hfEXaqRlR8MxBDEfIKiaSJT+jV5I2N
X-Google-Smtp-Source: APXvYqxKt0vPuL5nr/m9itU4E/noQB9UMmOrJ2zj5jY/W1xPvJuGmBUC75Vv3cgspvlNioNlNLV+9qDNH8lAjTkBcdc0Rj4OrJ2V
MIME-Version: 1.0
X-Received: by 2002:a5e:c707:: with SMTP id f7mr5386924iop.160.1580106728355;
 Sun, 26 Jan 2020 22:32:08 -0800 (PST)
Date:   Sun, 26 Jan 2020 22:32:08 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000403e51059d19449a@google.com>
Subject: KASAN: invalid-free in rcu_core (2)
From:   syzbot <syzbot+606ef46437b57b782489@syzkaller.appspotmail.com>
To:     bp@alien8.de, hpa@zytor.com, linux-kernel@vger.kernel.org,
        mingo@redhat.com, peterz@infradead.org,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de,
        tony.luck@intel.com, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    6381b442 Merge tag 'iommu-fixes-v5.5-rc7' of git://git.ker..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1499d6bee00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=cf8e288883e40aba
dashboard link: https://syzkaller.appspot.com/bug?extid=606ef46437b57b782489
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+606ef46437b57b782489@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: double-free or invalid-free in __rcu_reclaim kernel/rcu/rcu.h:215 [inline]
BUG: KASAN: double-free or invalid-free in rcu_do_batch kernel/rcu/tree.c:2183 [inline]
BUG: KASAN: double-free or invalid-free in rcu_core+0x635/0x1540 kernel/rcu/tree.c:2408

CPU: 0 PID: 9842 Comm: syz-executor.0 Not tainted 5.5.0-rc7-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 <IRQ>
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x197/0x210 lib/dump_stack.c:118
 print_address_description.constprop.0.cold+0xd4/0x30b mm/kasan/report.c:374
 kasan_report_invalid_free+0x65/0xa0 mm/kasan/report.c:468
 __kasan_slab_free+0x13a/0x150 mm/kasan/common.c:453
 kasan_slab_free+0xe/0x10 mm/kasan/common.c:483
 __cache_free mm/slab.c:3426 [inline]
 kfree+0x10a/0x2c0 mm/slab.c:3757
 __rcu_reclaim kernel/rcu/rcu.h:215 [inline]
 rcu_do_batch kernel/rcu/tree.c:2183 [inline]
 rcu_core+0x635/0x1540 kernel/rcu/tree.c:2408
 rcu_core_si+0x9/0x10 kernel/rcu/tree.c:2417
 __do_softirq+0x262/0x98c kernel/softirq.c:292
 invoke_softirq kernel/softirq.c:373 [inline]
 irq_exit+0x19b/0x1e0 kernel/softirq.c:413
 exiting_irq arch/x86/include/asm/apic.h:536 [inline]
 smp_apic_timer_interrupt+0x1a3/0x610 arch/x86/kernel/apic/apic.c:1137
 apic_timer_interrupt+0xf/0x20 arch/x86/entry/entry_64.S:829
 </IRQ>
RIP: 0010:__raw_spin_unlock_irq include/linux/spinlock_api_smp.h:169 [inline]
RIP: 0010:_raw_spin_unlock_irq+0x4f/0x80 kernel/locking/spinlock.c:199
Code: c0 a8 33 93 89 48 ba 00 00 00 00 00 fc ff df 48 c1 e8 03 80 3c 10 00 75 33 48 83 3d 82 db be 01 00 74 20 fb 66 0f 1f 44 00 00 <bf> 01 00 00 00 e8 57 32 7c f9 65 8b 05 48 c6 2d 78 85 c0 74 06 41
RSP: 0018:ffffc9000205fb10 EFLAGS: 00000282 ORIG_RAX: ffffffffffffff13
RAX: 1ffffffff1326675 RBX: ffff8880a8bd6640 RCX: 0000000000000000
RDX: dffffc0000000000 RSI: 0000000000000006 RDI: ffff8880a8bd6ed4
RBP: ffffc9000205fb18 R08: ffff8880a8bd6640 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: ffff8880ae837340
R13: ffff88804fd5a2c0 R14: 0000000000000000 R15: 0000000000000001
 finish_lock_switch kernel/sched/core.c:3124 [inline]
 finish_task_switch+0x147/0x750 kernel/sched/core.c:3224
 context_switch kernel/sched/core.c:3388 [inline]
 __schedule+0x93c/0x1f90 kernel/sched/core.c:4081
 schedule+0xdc/0x2b0 kernel/sched/core.c:4155
 freezable_schedule include/linux/freezer.h:172 [inline]
 do_nanosleep+0x21f/0x640 kernel/time/hrtimer.c:1874
 hrtimer_nanosleep+0x297/0x550 kernel/time/hrtimer.c:1927
 __do_sys_nanosleep kernel/time/hrtimer.c:1961 [inline]
 __se_sys_nanosleep kernel/time/hrtimer.c:1948 [inline]
 __x64_sys_nanosleep+0x1a6/0x220 kernel/time/hrtimer.c:1948
 do_syscall_64+0xfa/0x790 arch/x86/entry/common.c:294
 entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x4597f0
Code: c0 5b 5d c3 66 0f 1f 44 00 00 8b 04 24 48 83 c4 18 5b 5d c3 66 0f 1f 44 00 00 83 3d 41 f1 61 00 00 75 14 b8 23 00 00 00 0f 05 <48> 3d 01 f0 ff ff 0f 83 d4 d1 fb ff c3 48 83 ec 08 e8 ea 46 00 00
RSP: 002b:0000000000a6fd88 EFLAGS: 00000246 ORIG_RAX: 0000000000000023
RAX: ffffffffffffffda RBX: 0000000000123cb4 RCX: 00000000004597f0
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000a6fd90
RBP: 0000000000006aa7 R08: 0000000000000001 R09: 0000000000e9d940
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000002
R13: 0000000000a6fde0 R14: 0000000000123c7d R15: 0000000000a6fdf0

Allocated by task 0:
(stack is not available)

Freed by task 0:
(stack is not available)

The buggy address belongs to the object at ffff888000804980
 which belongs to the cache radix_tree_node of size 576
The buggy address is located 24 bytes inside of
 576-byte region [ffff888000804980, ffff888000804bc0)
The buggy address belongs to the page:
page:ffffea0000020100 refcount:1 mapcount:0 mapping:ffff8880aa4311c0 index:0xffff888000804ffb
raw: 007ffe0000000200 ffffea000246c7c8 ffffea0002589648 ffff8880aa4311c0
raw: ffff888000804ffb ffff888000804140 0000000100000004 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
 ffff888000804880: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff888000804900: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>ffff888000804980: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
                            ^
 ffff888000804a00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ffff888000804a80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
==================================================================


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
