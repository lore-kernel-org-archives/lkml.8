Return-Path: <SRS0=6o4L=5Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C24C7C2D0EE
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 17:11:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95D1020848
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 17:11:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731321AbgCaRLU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Mar 2020 13:11:20 -0400
Received: from mail-il1-f200.google.com ([209.85.166.200]:40850 "EHLO
        mail-il1-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730589AbgCaRLS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 13:11:18 -0400
Received: by mail-il1-f200.google.com with SMTP id g79so20779481ild.7
        for <linux-kernel@vger.kernel.org>; Tue, 31 Mar 2020 10:11:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=EyDp4btlxTXSYwvdl0Y98kicMeV4NzdgfeZTbW4ksBY=;
        b=dUO+MK838JiiuUDXcEEaYNeYFosE91FqkRudHzNool4iUEXmkUzibUaYfemSEmcEUr
         vLG4uokB4cpjsXGJAf+YDM4WY6QaqT/dtzXRnRrbpjpPK4gae4uQBmFo7eZNNhRLt842
         tChAr46/IHqnTLhFP0EfYZK/oGasAN+wcH3F0lu9krGYez4wuc9xC/JfcDq7WYCuGRnO
         YatISpJOjIhwYKvX9MPUsxWljhwmzbOKb2RsXGlhBAzeowFPtidbU6AZaB7qAXWACORU
         FByk9/ldG8nZzqslI9hVpdaiwDbrYTJEQpuR0vRSs6hvpMHe6SgXPgStcx75/gLt47RE
         yM3w==
X-Gm-Message-State: ANhLgQ0qHZqT1+UsCgE0kNOg14jcg3PEdYYc0TxeeoTF8mXIKVeTNysC
        Dw+bkqbVvpkrelZNNNXsYCECKAE2NixKEA+mRj6gqUOswAMt
X-Google-Smtp-Source: ADFU+vuwNbGVZ6nu62Y2MCS8/x42kVg3jMHz8afcagAoZqKUNlJCwmYpWJa58dpQxmLf50GVT6wN+ZKLIad3fTGJvMB425/YBEbz
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:589:: with SMTP id c9mr16222647ils.33.1585674674801;
 Tue, 31 Mar 2020 10:11:14 -0700 (PDT)
Date:   Tue, 31 Mar 2020 10:11:14 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b8935105a229a739@google.com>
Subject: KASAN: use-after-free Read in __hrtimer_run_queues
From:   syzbot <syzbot+62c155c276e580cfb606@syzkaller.appspotmail.com>
To:     bigeasy@linutronix.de, linux-kernel@vger.kernel.org,
        peterz@infradead.org, syzkaller-bugs@googlegroups.com,
        tglx@linutronix.de
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    673b41e0 staging/octeon: fix up merge error
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1488940be00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3e9c99d33a5ab36f
dashboard link: https://syzkaller.appspot.com/bug?extid=62c155c276e580cfb606
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
userspace arch: i386
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=158ed16de00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12b41b9de00000

The bug was bisected to:

commit 40db173965c05a1d803451240ed41707d5bd978d
Author: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Date:   Sat Mar 21 11:26:02 2020 +0000

    lockdep: Add hrtimer context tracing bits

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=15b40697e00000
final crash:    https://syzkaller.appspot.com/x/report.txt?x=17b40697e00000
console output: https://syzkaller.appspot.com/x/log.txt?x=13b40697e00000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+62c155c276e580cfb606@syzkaller.appspotmail.com
Fixes: 40db173965c0 ("lockdep: Add hrtimer context tracing bits")

vxcan0: j1939_tp_rxtimer: 0x00000000008c9d66: rx timeout, send abort
vxcan0: j1939_tp_rxtimer: 0x00000000008c9d66: abort rx timeout. Force session deactivation
==================================================================
BUG: KASAN: use-after-free in __run_hrtimer kernel/time/hrtimer.c:1521 [inline]
BUG: KASAN: use-after-free in __hrtimer_run_queues+0xe18/0xf10 kernel/time/hrtimer.c:1583
Read of size 1 at addr ffff8880934d1d73 by task swapper/1/0

CPU: 1 PID: 0 Comm: swapper/1 Not tainted 5.6.0-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 <IRQ>
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x188/0x20d lib/dump_stack.c:118
 print_address_description.constprop.0.cold+0xd3/0x315 mm/kasan/report.c:374
 __kasan_report.cold+0x1a/0x32 mm/kasan/report.c:506
 kasan_report+0xe/0x20 mm/kasan/common.c:641
 __run_hrtimer kernel/time/hrtimer.c:1521 [inline]
 __hrtimer_run_queues+0xe18/0xf10 kernel/time/hrtimer.c:1583
 hrtimer_run_softirq+0x16d/0x250 kernel/time/hrtimer.c:1600
 __do_softirq+0x26c/0x9f7 kernel/softirq.c:292
 invoke_softirq kernel/softirq.c:373 [inline]
 irq_exit+0x192/0x1d0 kernel/softirq.c:413
 exiting_irq arch/x86/include/asm/apic.h:546 [inline]
 smp_apic_timer_interrupt+0x19e/0x600 arch/x86/kernel/apic/apic.c:1140
 apic_timer_interrupt+0xf/0x20 arch/x86/entry/entry_64.S:829
 </IRQ>
RIP: 0010:native_safe_halt+0xe/0x10 arch/x86/include/asm/irqflags.h:61
Code: cc cc cc cc cc cc cc cc cc cc cc cc e9 07 00 00 00 0f 00 2d 94 59 4c 00 f4 c3 66 90 e9 07 00 00 00 0f 00 2d 84 59 4c 00 fb f4 <c3> cc 41 56 41 55 41 54 55 53 e8 63 8d a4 f9 e8 9e 9f d7 fb 0f 1f
RSP: 0018:ffffc90000d3fdb8 EFLAGS: 00000282 ORIG_RAX: ffffffffffffff13
RAX: 1ffffffff12e90e7 RBX: ffff8880a9638340 RCX: 0000000000000000
RDX: dffffc0000000000 RSI: 0000000000000006 RDI: ffff8880a9638bfc
RBP: dffffc0000000000 R08: ffff8880a9638340 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: ffffed10152c7068
R13: 0000000000000001 R14: ffffffff8a673000 R15: 0000000000000000
 arch_safe_halt arch/x86/include/asm/paravirt.h:144 [inline]
 default_idle+0x49/0x350 arch/x86/kernel/process.c:695
 cpuidle_idle_call kernel/sched/idle.c:154 [inline]
 do_idle+0x393/0x690 kernel/sched/idle.c:269
 cpu_startup_entry+0x14/0x20 kernel/sched/idle.c:361
 start_secondary+0x2f3/0x400 arch/x86/kernel/smpboot.c:268
 secondary_startup_64+0xa4/0xb0 arch/x86/kernel/head_64.S:242

Allocated by task 7030:
 save_stack+0x1b/0x80 mm/kasan/common.c:72
 set_track mm/kasan/common.c:80 [inline]
 __kasan_kmalloc mm/kasan/common.c:515 [inline]
 __kasan_kmalloc.constprop.0+0xbf/0xd0 mm/kasan/common.c:488
 kmem_cache_alloc_trace+0x153/0x7d0 mm/slab.c:3551
 kmalloc include/linux/slab.h:555 [inline]
 kzalloc include/linux/slab.h:669 [inline]
 j1939_session_new+0x7c/0x3f0 net/can/j1939/transport.c:1418
 j1939_tp_send+0x22f/0x800 net/can/j1939/transport.c:1877
 j1939_sk_send_loop net/can/j1939/socket.c:1037 [inline]
 j1939_sk_sendmsg+0xabf/0x1360 net/can/j1939/socket.c:1160
 sock_sendmsg_nosec net/socket.c:652 [inline]
 sock_sendmsg+0xcf/0x120 net/socket.c:672
 ____sys_sendmsg+0x6bf/0x7e0 net/socket.c:2362
 ___sys_sendmsg+0x100/0x170 net/socket.c:2416
 __sys_sendmsg+0xec/0x1b0 net/socket.c:2449
 do_syscall_32_irqs_on arch/x86/entry/common.c:337 [inline]
 do_fast_syscall_32+0x270/0xe8f arch/x86/entry/common.c:408
 entry_SYSENTER_compat+0x70/0x7f arch/x86/entry/entry_64_compat.S:139

Freed by task 0:
 save_stack+0x1b/0x80 mm/kasan/common.c:72
 set_track mm/kasan/common.c:80 [inline]
 kasan_set_free_info mm/kasan/common.c:337 [inline]
 __kasan_slab_free+0xf7/0x140 mm/kasan/common.c:476
 __cache_free mm/slab.c:3426 [inline]
 kfree+0x109/0x2b0 mm/slab.c:3757
 j1939_session_destroy net/can/j1939/transport.c:276 [inline]
 __j1939_session_release net/can/j1939/transport.c:284 [inline]
 kref_put include/linux/kref.h:65 [inline]
 j1939_session_put+0x25c/0x330 net/can/j1939/transport.c:289
 j1939_tp_rxtimer+0x2e9/0x2f4 net/can/j1939/transport.c:1194
 __run_hrtimer kernel/time/hrtimer.c:1519 [inline]
 __hrtimer_run_queues+0x3a2/0xf10 kernel/time/hrtimer.c:1583
 hrtimer_run_softirq+0x16d/0x250 kernel/time/hrtimer.c:1600
 __do_softirq+0x26c/0x9f7 kernel/softirq.c:292

The buggy address belongs to the object at ffff8880934d1c00
 which belongs to the cache kmalloc-512 of size 512
The buggy address is located 371 bytes inside of
 512-byte region [ffff8880934d1c00, ffff8880934d1e00)
The buggy address belongs to the page:
page:ffffea00024d3440 refcount:1 mapcount:0 mapping:ffff8880aa000a80 index:0x0
flags: 0xfffe0000000200(slab)
raw: 00fffe0000000200 ffffea00024fbd48 ffffea00024fb888 ffff8880aa000a80
raw: 0000000000000000 ffff8880934d1000 0000000100000004 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
 ffff8880934d1c00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff8880934d1c80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff8880934d1d00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                                             ^
 ffff8880934d1d80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff8880934d1e00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
==================================================================


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
