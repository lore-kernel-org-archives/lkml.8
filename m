Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA7B1C352A3
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 04:57:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 681A420848
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 04:57:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729495AbgBME5M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 23:57:12 -0500
Received: from mail-il1-f200.google.com ([209.85.166.200]:44587 "EHLO
        mail-il1-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729406AbgBME5M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 23:57:12 -0500
Received: by mail-il1-f200.google.com with SMTP id h87so3669284ild.11
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2020 20:57:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=FAFRYHPulwp+qIVSwIOWKxgbTgqHTJpnhwRX/u3DBE0=;
        b=m1c8KsbXm39zu+M1tmZrHP62JSsZuZWFDNAQudwEk17CAenXYiJcDJOZ7xBawhAIEl
         qJKW9K5Bf71zNei4kqFY7SFvFf5A5cRVSOr04bZnH4VXVot/5l6jmzgz39rf2/g1wz/o
         Nr7jgrMjdKxfyeCxQmsTrObeFuiT/ZzWPKv+hvpsSAsX8P3gItCOosdaWhQnFj9IDXN3
         PBx1iM6GxwzgkEln7YMDu+/mZ/DgbX+BkHVI75ikWGAFt4xmC7ym8cIuzOG0FPKzsKJj
         3eUjP6T0WTHe3BP8ZfoIKWLGsZ962IYXuL7hztcwesbRadv3iY5q0qz6apprkv+WLDpw
         JYdA==
X-Gm-Message-State: APjAAAXN47L67rf9aFfl3dKDcyYyI4JehiLfY+P+fNPQw0vjWNBk7s85
        w9TmZsI7rkMWGjnAzRYY/dctJRsANb3NGzdH5HJ+BiGTidMZ
X-Google-Smtp-Source: APXvYqzKUxINiEZgt2mrArZ91QClXaHIdUmo2U41fTCF4jExupNLdLJARIHARjA7veppu239qP/7dj2He4f0sUjSek+Bh2bbS0kR
MIME-Version: 1.0
X-Received: by 2002:a92:9f92:: with SMTP id z18mr14863860ilk.38.1581569831434;
 Wed, 12 Feb 2020 20:57:11 -0800 (PST)
Date:   Wed, 12 Feb 2020 20:57:11 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000fd7fc3059e6deb38@google.com>
Subject: possible deadlock in tty_port_close_start
From:   syzbot <syzbot+044000e5acdb5e1d5eed@syzkaller.appspotmail.com>
To:     gregkh@linuxfoundation.org, jslaby@suse.com,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    f2850dd5 Merge tag 'kbuild-fixes-v5.6' of git://git.kernel..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=13fe1fcde00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=735296e4dd620b10
dashboard link: https://syzkaller.appspot.com/bug?extid=044000e5acdb5e1d5eed
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+044000e5acdb5e1d5eed@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
5.6.0-rc1-syzkaller #0 Not tainted
------------------------------------------------------
syz-executor.0/9638 is trying to acquire lock:
ffffffff89ba1160 (console_owner){-.-.}, at: console_trylock_spinning kernel/printk/printk.c:1724 [inline]
ffffffff89ba1160 (console_owner){-.-.}, at: vprintk_emit+0x3fd/0x700 kernel/printk/printk.c:1995

but task is already holding lock:
ffffffff8c369460 (&(&port->lock)->rlock){-.-.}, at: tty_port_close_start.part.0+0x2b/0x580 drivers/tty/tty_port.c:566

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #2 (&(&port->lock)->rlock){-.-.}:
       __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
       _raw_spin_lock_irqsave+0x95/0xcd kernel/locking/spinlock.c:159
       tty_port_tty_get+0x24/0x100 drivers/tty/tty_port.c:287
       tty_port_default_wakeup+0x16/0x40 drivers/tty/tty_port.c:47
       tty_port_tty_wakeup+0x57/0x70 drivers/tty/tty_port.c:387
       uart_write_wakeup+0x46/0x70 drivers/tty/serial/serial_core.c:104
       serial8250_tx_chars+0x495/0xaf0 drivers/tty/serial/8250/8250_port.c:1760
       serial8250_handle_irq.part.0+0x261/0x2b0 drivers/tty/serial/8250/8250_port.c:1833
       serial8250_handle_irq drivers/tty/serial/8250/8250_port.c:1819 [inline]
       serial8250_default_handle_irq+0xc0/0x150 drivers/tty/serial/8250/8250_port.c:1849
       serial8250_interrupt+0xf1/0x1a0 drivers/tty/serial/8250/8250_core.c:126
       __handle_irq_event_percpu+0x15d/0x970 kernel/irq/handle.c:149
       handle_irq_event_percpu+0x74/0x160 kernel/irq/handle.c:189
       handle_irq_event+0xa7/0x134 kernel/irq/handle.c:206
       handle_edge_irq+0x25e/0x8d0 kernel/irq/chip.c:830
       generic_handle_irq_desc include/linux/irqdesc.h:156 [inline]
       do_IRQ+0xde/0x280 arch/x86/kernel/irq.c:250
       ret_from_intr+0x0/0x36
       arch_local_irq_restore arch/x86/include/asm/paravirt.h:752 [inline]
       __raw_spin_unlock_irqrestore include/linux/spinlock_api_smp.h:160 [inline]
       _raw_spin_unlock_irqrestore+0x90/0xe0 kernel/locking/spinlock.c:191
       spin_unlock_irqrestore include/linux/spinlock.h:393 [inline]
       uart_write+0x3b6/0x6f0 drivers/tty/serial/serial_core.c:613
       process_output_block drivers/tty/n_tty.c:595 [inline]
       n_tty_write+0x40e/0x1080 drivers/tty/n_tty.c:2333
       do_tty_write drivers/tty/tty_io.c:962 [inline]
       tty_write+0x496/0x7f0 drivers/tty/tty_io.c:1046
       redirected_tty_write+0xb2/0xc0 drivers/tty/tty_io.c:1067
       __vfs_write+0x8a/0x110 fs/read_write.c:494
       vfs_write+0x268/0x5d0 fs/read_write.c:558
       ksys_write+0x14f/0x290 fs/read_write.c:611
       __do_sys_write fs/read_write.c:623 [inline]
       __se_sys_write fs/read_write.c:620 [inline]
       __x64_sys_write+0x73/0xb0 fs/read_write.c:620
       do_syscall_64+0xfa/0x790 arch/x86/entry/common.c:294
       entry_SYSCALL_64_after_hwframe+0x49/0xbe

-> #1 (&port_lock_key){-.-.}:
       __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
       _raw_spin_lock_irqsave+0x95/0xcd kernel/locking/spinlock.c:159
       serial8250_console_write+0x253/0x9a0 drivers/tty/serial/8250/8250_port.c:3142
       univ8250_console_write+0x5f/0x70 drivers/tty/serial/8250/8250_core.c:587
       call_console_drivers kernel/printk/printk.c:1791 [inline]
       console_unlock+0xb7a/0xf00 kernel/printk/printk.c:2473
       vprintk_emit+0x2a0/0x700 kernel/printk/printk.c:1996
       vprintk_default+0x28/0x30 kernel/printk/printk.c:2023
       vprintk_func+0x7e/0x189 kernel/printk/printk_safe.c:386
       printk+0xba/0xed kernel/printk/printk.c:2056
       register_console+0x745/0xb50 kernel/printk/printk.c:2798
       univ8250_console_init+0x3e/0x4b drivers/tty/serial/8250/8250_core.c:682
       console_init+0x461/0x67b kernel/printk/printk.c:2884
       start_kernel+0x636/0x8c5 init/main.c:920
       x86_64_start_reservations+0x29/0x2b arch/x86/kernel/head64.c:490
       x86_64_start_kernel+0x77/0x7b arch/x86/kernel/head64.c:471
       secondary_startup_64+0xa4/0xb0 arch/x86/kernel/head_64.S:242

-> #0 (console_owner){-.-.}:
       check_prev_add kernel/locking/lockdep.c:2475 [inline]
       check_prevs_add kernel/locking/lockdep.c:2580 [inline]
       validate_chain kernel/locking/lockdep.c:2970 [inline]
       __lock_acquire+0x2596/0x4a00 kernel/locking/lockdep.c:3954
       lock_acquire+0x190/0x410 kernel/locking/lockdep.c:4484
       console_trylock_spinning kernel/printk/printk.c:1745 [inline]
       vprintk_emit+0x43a/0x700 kernel/printk/printk.c:1995
       vprintk_default+0x28/0x30 kernel/printk/printk.c:2023
       vprintk_func+0x7e/0x189 kernel/printk/printk_safe.c:386
       printk+0xba/0xed kernel/printk/printk.c:2056
       tty_port_close_start.part.0+0x52a/0x580 drivers/tty/tty_port.c:568
       tty_port_close_start drivers/tty/tty_port.c:640 [inline]
       tty_port_close+0x4e/0x100 drivers/tty/tty_port.c:633
       tpk_close+0x8e/0xa4 drivers/char/ttyprintk.c:110
       tty_release+0x3ba/0xe90 drivers/tty/tty_io.c:1683
       __fput+0x2ff/0x890 fs/file_table.c:280
       ____fput+0x16/0x20 fs/file_table.c:313
       task_work_run+0x145/0x1c0 kernel/task_work.c:113
       tracehook_notify_resume include/linux/tracehook.h:188 [inline]
       exit_to_usermode_loop+0x316/0x380 arch/x86/entry/common.c:164
       prepare_exit_to_usermode arch/x86/entry/common.c:195 [inline]
       syscall_return_slowpath arch/x86/entry/common.c:278 [inline]
       do_syscall_64+0x676/0x790 arch/x86/entry/common.c:304
       entry_SYSCALL_64_after_hwframe+0x49/0xbe

other info that might help us debug this:

Chain exists of:
  console_owner --> &port_lock_key --> &(&port->lock)->rlock

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&(&port->lock)->rlock);
                               lock(&port_lock_key);
                               lock(&(&port->lock)->rlock);
  lock(console_owner);

 *** DEADLOCK ***

2 locks held by syz-executor.0/9638:
 #0: ffff88808cf69198 (&tty->legacy_mutex){+.+.}, at: tty_lock+0xc7/0x130 drivers/tty/tty_mutex.c:19
 #1: ffffffff8c369460 (&(&port->lock)->rlock){-.-.}, at: tty_port_close_start.part.0+0x2b/0x580 drivers/tty/tty_port.c:566

stack backtrace:
CPU: 1 PID: 9638 Comm: syz-executor.0 Not tainted 5.6.0-rc1-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x197/0x210 lib/dump_stack.c:118
 print_circular_bug.isra.0.cold+0x163/0x172 kernel/locking/lockdep.c:1684
 check_noncircular+0x32e/0x3e0 kernel/locking/lockdep.c:1808
 check_prev_add kernel/locking/lockdep.c:2475 [inline]
 check_prevs_add kernel/locking/lockdep.c:2580 [inline]
 validate_chain kernel/locking/lockdep.c:2970 [inline]
 __lock_acquire+0x2596/0x4a00 kernel/locking/lockdep.c:3954
 lock_acquire+0x190/0x410 kernel/locking/lockdep.c:4484
 console_trylock_spinning kernel/printk/printk.c:1745 [inline]
 vprintk_emit+0x43a/0x700 kernel/printk/printk.c:1995
 vprintk_default+0x28/0x30 kernel/printk/printk.c:2023
 vprintk_func+0x7e/0x189 kernel/printk/printk_safe.c:386
 printk+0xba/0xed kernel/printk/printk.c:2056
 tty_port_close_start.part.0+0x52a/0x580 drivers/tty/tty_port.c:568
 tty_port_close_start drivers/tty/tty_port.c:640 [inline]
 tty_port_close+0x4e/0x100 drivers/tty/tty_port.c:633
 tpk_close+0x8e/0xa4 drivers/char/ttyprintk.c:110
 tty_release+0x3ba/0xe90 drivers/tty/tty_io.c:1683
 __fput+0x2ff/0x890 fs/file_table.c:280
 ____fput+0x16/0x20 fs/file_table.c:313
 task_work_run+0x145/0x1c0 kernel/task_work.c:113
 tracehook_notify_resume include/linux/tracehook.h:188 [inline]
 exit_to_usermode_loop+0x316/0x380 arch/x86/entry/common.c:164
 prepare_exit_to_usermode arch/x86/entry/common.c:195 [inline]
 syscall_return_slowpath arch/x86/entry/common.c:278 [inline]
 do_syscall_64+0x676/0x790 arch/x86/entry/common.c:304
 entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x414f51
Code: 75 14 b8 03 00 00 00 0f 05 48 3d 01 f0 ff ff 0f 83 04 1b 00 00 c3 48 83 ec 08 e8 0a fc ff ff 48 89 04 24 b8 03 00 00 00 0f 05 <48> 8b 3c 24 48 89 c2 e8 53 fc ff ff 48 89 d0 48 83 c4 08 48 3d 01
RSP: 002b:00007ffcd8ec83e0 EFLAGS: 00000293 ORIG_RAX: 0000000000000003
RAX: 0000000000000000 RBX: 0000000000000008 RCX: 0000000000414f51
RDX: 0000000000000000 RSI: 0000000000000081 RDI: 0000000000000007
RBP: 0000000000000000 R08: 0000000000760f50 R09: ffffffffffffffff
R10: 00007ffcd8ec84b0 R11: 0000000000000293 R12: 000000000075bf20
R13: 0000000000000003 R14: 0000000000760f58 R15: 000000000075bf2c


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
