Return-Path: <SRS0=7RkH=3E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D69FC33CB1
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 06:36:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E02C22467A
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 06:36:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729149AbgAOGgM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jan 2020 01:36:12 -0500
Received: from mail-il1-f198.google.com ([209.85.166.198]:50729 "EHLO
        mail-il1-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725999AbgAOGgM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jan 2020 01:36:12 -0500
Received: by mail-il1-f198.google.com with SMTP id z12so12497370ilh.17
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jan 2020 22:36:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=BABYpJWtnJJErwq6DGr7FSaf10bR1R1zdKta/SludJg=;
        b=C9e6Vj+p9Uaey5WOp7WvV1/WehjkZBQ9jd+UuK9+VU+C2HiCw1qGm7xOWKqDUiOvyF
         /sI2rckBTQiArsjeN/S8Z1SWCKJRrJiVOcTv1aSFsKI4w0n2mS3o0AwwBoa3wp6mdaVy
         lTdfWckSWxpn3jg+T0PwgGLheCtM8XZdVNPdR3H/8nZBi82TOawtwX6+bU4aLg+2T5vV
         2dz/eRsEIJ3vRTSVJX0YuBFaYBKFHBHKqGO2NDNzhayq4ejxwxXmzYBS2xwhF1s1hDxe
         jwDgO1ya6JGUSfqIqVO67mbFQgSWwrOvgDVRERdHDnV+xal9h3CAXMTMcCQTK+O7exwS
         K6eg==
X-Gm-Message-State: APjAAAUzNFF3+zqnaAvvLLH4FFlWfEkokkj6WmM7J5odOm1oycKMtHVj
        ahJr1F0OOeHHvBIwsLFvvjgeJArtVPdqihi0Zo7Ta44rSs4C
X-Google-Smtp-Source: APXvYqw6K0+Jar+KO4A9aa2tKwHBxlzPOgc3NDw/iYl4DbPwT4IJtfT+AUSsZXiLFOmwCKNyVfUgVGI6a6FD3cbLXiZmcf9Vr5XN
MIME-Version: 1.0
X-Received: by 2002:a92:1f16:: with SMTP id i22mr2339029ile.206.1579070170948;
 Tue, 14 Jan 2020 22:36:10 -0800 (PST)
Date:   Tue, 14 Jan 2020 22:36:10 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000009d6d71059c27ecf1@google.com>
Subject: KASAN: stack-out-of-bounds Read in i801_isr
From:   syzbot <syzbot+8c8dedc0ba9e03f6c79e@syzkaller.appspotmail.com>
To:     jdelvare@suse.com, linux-i2c@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    452424cd Merge branch 'parisc-5.5-3' of git://git.kernel.o..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=17f7ac21e00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d9290aeb7e6cf1c4
dashboard link: https://syzkaller.appspot.com/bug?extid=8c8dedc0ba9e03f6c79e
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
userspace arch: i386

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+8c8dedc0ba9e03f6c79e@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: stack-out-of-bounds in i801_isr_byte_done  
drivers/i2c/busses/i2c-i801.c:603 [inline]
BUG: KASAN: stack-out-of-bounds in i801_isr  
drivers/i2c/busses/i2c-i801.c:663 [inline]
BUG: KASAN: stack-out-of-bounds in i801_isr+0xcb7/0xcf0  
drivers/i2c/busses/i2c-i801.c:644
Read of size 1 at addr ffffc9000beb7d38 by task syz-executor.3/2994

CPU: 1 PID: 2994 Comm: syz-executor.3 Not tainted 5.5.0-rc6-syzkaller #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS  
rel-1.12.0-59-gc9ba5276e321-prebuilt.qemu.org 04/01/2014
Call Trace:
  <IRQ>
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x197/0x210 lib/dump_stack.c:118
  print_address_description.constprop.0.cold+0x5/0x30b mm/kasan/report.c:374
  __kasan_report.cold+0x1b/0x41 mm/kasan/report.c:506
  kasan_report+0x12/0x20 mm/kasan/common.c:639
  __asan_report_load1_noabort+0x14/0x20 mm/kasan/generic_report.c:132
  i801_isr_byte_done drivers/i2c/busses/i2c-i801.c:603 [inline]
  i801_isr drivers/i2c/busses/i2c-i801.c:663 [inline]
  i801_isr+0xcb7/0xcf0 drivers/i2c/busses/i2c-i801.c:644
  __handle_irq_event_percpu+0x15d/0x970 kernel/irq/handle.c:149
  handle_irq_event_percpu+0x74/0x160 kernel/irq/handle.c:189
  handle_irq_event+0xa7/0x134 kernel/irq/handle.c:206
  handle_fasteoi_irq+0x281/0x670 kernel/irq/chip.c:725
  generic_handle_irq_desc include/linux/irqdesc.h:156 [inline]
  do_IRQ+0xde/0x280 arch/x86/kernel/irq.c:250
  common_interrupt+0xf/0xf arch/x86/entry/entry_64.S:607
RIP: 0010:ffs arch/x86/include/asm/bitops.h:297 [inline]
RIP: 0010:__do_softirq+0x227/0x98c kernel/softirq.c:280
Code: c7 c0 e8 34 93 89 48 c1 e8 03 42 80 3c 30 00 0f 85 b1 06 00 00 48 83  
3d ce 32 93 01 00 0f 84 d6 05 00 00 fb 66 0f 1f 44 00 00 <b8> ff ff ff ff  
48 c7 45 c8 00 91 80 89 0f bc 45 d4 83 c0 01 89 45
RSP: 0018:ffffc900004e8f18 EFLAGS: 00000282 ORIG_RAX: ffffffffffffffdd
RAX: 1ffffffff132669d RBX: ffff88801eccdf00 RCX: 0000000000000002
RDX: 0000000000000000 RSI: 0000000000000008 RDI: ffff88801ecce794
RBP: ffffc900004e8f98 R08: 1ffffffff165e7a6 R09: fffffbfff165e7a7
R10: fffffbfff165e7a6 R11: ffffffff8b2f3d37 R12: 0000000000000000
R13: 0000000000000000 R14: dffffc0000000000 R15: 0000000000000000
  invoke_softirq kernel/softirq.c:373 [inline]
  irq_exit+0x19b/0x1e0 kernel/softirq.c:413
  exiting_irq arch/x86/include/asm/apic.h:536 [inline]
  smp_apic_timer_interrupt+0x1a3/0x610 arch/x86/kernel/apic/apic.c:1137
  apic_timer_interrupt+0xf/0x20 arch/x86/entry/entry_64.S:829
  </IRQ>
RIP: 0010:arch_local_irq_restore arch/x86/include/asm/paravirt.h:752  
[inline]
RIP: 0010:__raw_spin_unlock_irqrestore include/linux/spinlock_api_smp.h:160  
[inline]
RIP: 0010:_raw_spin_unlock_irqrestore+0x90/0xe0  
kernel/locking/spinlock.c:191
Code: 48 c7 c0 d8 34 93 89 48 ba 00 00 00 00 00 fc ff df 48 c1 e8 03 80 3c  
10 00 75 39 48 83 3d 7f e0 be 01 00 74 24 48 89 df 57 9d <0f> 1f 44 00 00  
bf 01 00 00 00 e8 11 36 7c f9 65 8b 05 12 ca 2d 78
RSP: 0018:ffffc9000c6e7b90 EFLAGS: 00000282 ORIG_RAX: ffffffffffffff13
RAX: 1ffffffff132669b RBX: 0000000000000282 RCX: 0000000000000006
RDX: dffffc0000000000 RSI: 0000000000000008 RDI: 0000000000000282
RBP: ffffc9000c6e7ba0 R08: 1ffffffff165e7a6 R09: fffffbfff165e7a7
R10: fffffbfff165e7a6 R11: ffffffff8b2f3d37 R12: ffff88802a79d158
R13: ffff88802a79d150 R14: 0000000000000282 R15: ffff88802a79d158
  kthread_queue_work+0xa4/0x160 kernel/kthread.c:829
  kthread_flush_worker+0xca/0x110 kernel/kthread.c:1165
  loop_unprepare_queue drivers/block/loop.c:894 [inline]
  __loop_clr_fd+0x5d9/0xd80 drivers/block/loop.c:1157
  loop_clr_fd drivers/block/loop.c:1237 [inline]
  lo_ioctl+0x2bd/0x1460 drivers/block/loop.c:1606
  lo_compat_ioctl+0xb6/0x110 drivers/block/loop.c:1782
  compat_blkdev_ioctl+0x274/0x1c30 block/compat_ioctl.c:422
  __do_compat_sys_ioctl fs/compat_ioctl.c:214 [inline]
  __se_compat_sys_ioctl fs/compat_ioctl.c:142 [inline]
  __ia32_compat_sys_ioctl+0x233/0x610 fs/compat_ioctl.c:142
  do_syscall_32_irqs_on arch/x86/entry/common.c:337 [inline]
  do_fast_syscall_32+0x27b/0xe16 arch/x86/entry/common.c:408
  entry_SYSENTER_compat+0x70/0x7f arch/x86/entry/entry_64_compat.S:139
RIP: 0023:0xf7fe2a39
Code: 00 00 00 89 d3 5b 5e 5f 5d c3 b8 80 96 98 00 eb c4 8b 04 24 c3 8b 1c  
24 c3 8b 34 24 c3 8b 3c 24 c3 51 52 55 89 e5 0f 34 cd 80 <5d> 5a 59 c3 90  
90 90 90 eb 0d 90 90 90 90 90 90 90 90 90 90 90 90
RSP: 002b:00000000f5dddf08 EFLAGS: 00000292 ORIG_RAX: 0000000000000036
RAX: ffffffffffffffda RBX: 0000000000000004 RCX: 0000000000004c01
RDX: 0000000000000000 RSI: 000000000812d000 RDI: 0000000000000000
RBP: 00000000f5dde158 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000


Memory state around the buggy address:
  ffffc9000beb7c00: f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9
  ffffc9000beb7c80: f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9
> ffffc9000beb7d00: f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9
                                         ^
  ffffc9000beb7d80: f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9
  ffffc9000beb7e00: f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9
==================================================================


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
