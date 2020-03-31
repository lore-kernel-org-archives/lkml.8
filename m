Return-Path: <SRS0=6o4L=5Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19150C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 05:01:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8CA020776
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 05:01:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726314AbgCaFBO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Mar 2020 01:01:14 -0400
Received: from mail-io1-f71.google.com ([209.85.166.71]:47621 "EHLO
        mail-io1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725809AbgCaFBO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 01:01:14 -0400
Received: by mail-io1-f71.google.com with SMTP id c2so18303900iok.14
        for <linux-kernel@vger.kernel.org>; Mon, 30 Mar 2020 22:01:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=h1EcTAjBL9giECRKEy/OwPSPCm+qEqUPJT92ImACxKU=;
        b=fpn0TkfmgIhtg5nuMibI46S66CcRdSWWW4kh5bwoN2UWEofaObxBtFl0QPKOQU/YAI
         k+FN00MWl2e15iaFj9TjI8lIBYtVw43g6nZdJ0KuRLBx/T9toMjVxobgRrGb8WPPB1tk
         +GHTCq9DVGseUAqrbcelct1YI7fFGlWobbTAhFn34fTZiHl6gz4t8VaggSFrhXHjMJid
         L8yOvEZiKJIQl6f7h8CJRcHnDZcZBkxI9w1oZVT3nRZlPMhE90tfrRa+m2k6M491/plJ
         YWgLiQRZKWKHKngCf5TpJ2a9jr4sDL8lu7ZzJpamIKXhoGg/xo8TyviGiQCxHu3Qcw7D
         MGLg==
X-Gm-Message-State: ANhLgQ20eXKwDzAMBy6n49Psa/fsmgWi5d19svDvu4lE/AEQOs5LuwNw
        CAZtNKsT78m35866JQRH1E3pP2jp/31ygml9eUcdlJ8bQdEn
X-Google-Smtp-Source: ADFU+vs8PEM6n/rOiITdNiiyeJ82cuLzZayEjKLAJ7DTImTlXS234lT8tWx2MLM2/7MEa6TXZgYZ9RkLAF3OnzGV8sPOPAJ8Cxj7
MIME-Version: 1.0
X-Received: by 2002:a6b:d808:: with SMTP id y8mr13638810iob.121.1585630872865;
 Mon, 30 Mar 2020 22:01:12 -0700 (PDT)
Date:   Mon, 30 Mar 2020 22:01:12 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ec257905a21f7415@google.com>
Subject: INFO: trying to register non-static key in try_to_wake_up
From:   syzbot <syzbot+e84d7ebd1361da13c356@syzkaller.appspotmail.com>
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

HEAD commit:    9420e8ad Merge tag 'for-linus' of git://git.kernel.org/pub..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1206ed4be00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=27392dd2975fd692
dashboard link: https://syzkaller.appspot.com/bug?extid=e84d7ebd1361da13c356
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+e84d7ebd1361da13c356@syzkaller.appspotmail.com

INFO: trying to register non-static key.
the code is fine but needs lockdep annotation.
turning off the locking correctness validator.
CPU: 1 PID: 1014 Comm: syz-executor.0 Not tainted 5.6.0-rc7-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 <IRQ>
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x188/0x20d lib/dump_stack.c:118
 assign_lock_key kernel/locking/lockdep.c:880 [inline]
 register_lock_class+0x14c4/0x1540 kernel/locking/lockdep.c:1189
 __lock_acquire+0xfc/0x3ca0 kernel/locking/lockdep.c:3836
 lock_acquire+0x197/0x420 kernel/locking/lockdep.c:4484
 __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
 _raw_spin_lock_irqsave+0x8c/0xbf kernel/locking/spinlock.c:159
 try_to_wake_up+0x9f/0x17c0 kernel/sched/core.c:2547
 wake_up_worker kernel/workqueue.c:836 [inline]
 insert_work+0x2ad/0x3a0 kernel/workqueue.c:1337
 __queue_work+0x50d/0x1280 kernel/workqueue.c:1488
 call_timer_fn+0x195/0x760 kernel/time/timer.c:1404
 expire_timers kernel/time/timer.c:1444 [inline]
 __run_timers kernel/time/timer.c:1773 [inline]
 __run_timers kernel/time/timer.c:1740 [inline]
 run_timer_softirq+0x412/0x1600 kernel/time/timer.c:1786
 __do_softirq+0x26c/0x99d kernel/softirq.c:292
 invoke_softirq kernel/softirq.c:373 [inline]
 irq_exit+0x192/0x1d0 kernel/softirq.c:413
 exiting_irq arch/x86/include/asm/apic.h:546 [inline]
 smp_apic_timer_interrupt+0x19e/0x600 arch/x86/kernel/apic/apic.c:1146
 apic_timer_interrupt+0xf/0x20 arch/x86/entry/entry_64.S:829
 </IRQ>
RIP: 0010:slow_down_io arch/x86/include/asm/paravirt.h:42 [inline]
RIP: 0010:outb_p arch/x86/include/asm/io.h:334 [inline]
RIP: 0010:vga_io_w include/video/vga.h:209 [inline]
RIP: 0010:vga_io_rgfx include/video/vga.h:388 [inline]
RIP: 0010:setcolor drivers/video/fbdev/vga16fb.c:170 [inline]
RIP: 0010:vga_imageblit_expand drivers/video/fbdev/vga16fb.c:1164 [inline]
RIP: 0010:vga16fb_imageblit+0x91b/0x2210 drivers/video/fbdev/vga16fb.c:1260
Code: 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 0f b6 04 02 84 c0 74 09 3c 03 7f 05 e8 91 43 f7 fd 41 8b 5f 10 31 c0 ba ce 03 00 00 ee <48> c7 c2 b8 b3 73 89 48 b8 00 00 00 00 00 fc ff df 48 c1 ea 03 80
RSP: 0018:ffffc900163cf5a0 EFLAGS: 00000246 ORIG_RAX: ffffffffffffff13
RAX: 0000000000000000 RBX: 0000000000000007 RCX: ffffc90001a49000
RDX: 00000000000003ce RSI: ffffffff83b7a8ce RDI: ffffc900163cf748
RBP: ffffc900163cf73c R08: ffff88803ac523c0 R09: 0000000000000000
R10: ffffed10431bd353 R11: ffff888218de9a9f R12: 0000000000000000
R13: ffff8880a3500f00 R14: 0000000000000001 R15: ffffc900163cf738
 bit_putcs_unaligned drivers/video/fbdev/core/bitblit.c:139 [inline]
 bit_putcs+0x910/0xe10 drivers/video/fbdev/core/bitblit.c:188
 fbcon_putcs+0x345/0x3f0 drivers/video/fbdev/core/fbcon.c:1360
 do_update_region+0x398/0x630 drivers/tty/vt/vt.c:677
 redraw_screen+0x646/0x770 drivers/tty/vt/vt.c:1022
 fbcon_blank+0x8ca/0xc10 drivers/video/fbdev/core/fbcon.c:2421
 do_unblank_screen drivers/tty/vt/vt.c:4286 [inline]
 do_unblank_screen+0x23c/0x420 drivers/tty/vt/vt.c:4254
 vt_ioctl+0xdc0/0x2470 drivers/tty/vt/vt_ioctl.c:490
 tty_ioctl+0xedd/0x1440 drivers/tty/tty_io.c:2656
 vfs_ioctl fs/ioctl.c:47 [inline]
 ksys_ioctl+0x11a/0x180 fs/ioctl.c:763
 __do_sys_ioctl fs/ioctl.c:772 [inline]
 __se_sys_ioctl fs/ioctl.c:770 [inline]
 __x64_sys_ioctl+0x6f/0xb0 fs/ioctl.c:770
 do_syscall_64+0xf6/0x7d0 arch/x86/entry/common.c:294
 entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x45c849
Code: ad b6 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 0f 83 7b b6 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007f91f6f81c78 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f91f6f826d4 RCX: 000000000045c849
RDX: 0000000000000000 RSI: 0000000000004b3a RDI: 0000000000000003
RBP: 000000000076bf00 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000ffffffff
R13: 0000000000000573 R14: 00000000004c8075 R15: 000000000076bf0c


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
