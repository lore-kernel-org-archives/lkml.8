Return-Path: <SRS0=PfNx=4F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7847C34022
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 14:42:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBE3C20718
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 14:42:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729107AbgBQOmO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Feb 2020 09:42:14 -0500
Received: from mail-il1-f197.google.com ([209.85.166.197]:36294 "EHLO
        mail-il1-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728104AbgBQOmO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Feb 2020 09:42:14 -0500
Received: by mail-il1-f197.google.com with SMTP id d22so14478780ild.3
        for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2020 06:42:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=8tm0zLcIehJgGki+g0KSiS60v4xRC8oauTsffyhl/VA=;
        b=WBoP70mpzAukSKDq2PjpxnjDa2qiZPdTbmQU+q6H2T7AgC8P2oocN2ygtHQ8A/vH6v
         0s9YFlvLNJ2yZeOp6q8nS+fNzwRCyQJwQb6Q3oKM2dPrx4HWh/QLAIMATaY3vqy6QlxE
         MqbI/36x+qtufvoIcFUMknjNs0/4GLZ5SORE3LliSP3iPFS4FTu+iw629q+5/G+wGWw8
         8k9VdWYasOgG7Vn2dZp1WsIErWQQviBkXaBlSHzMP8PU42PF/r+zp3KCyadTYPGfHdFH
         AeAWHc0WmZz7pjyuKA3laZajIzwvo7/bl/4ghPedx+d9Qex2b0+mZOqR/1ykHHOSY7zD
         ul+g==
X-Gm-Message-State: APjAAAWYl4IVi9o6CQG/ep9dRIAvVthZS69gxwjtXpCUF88HByFMjabB
        WFn9acsHADFrhZVm5U1JVBEv64C8L6n5uRrodstD1y2mnT+0
X-Google-Smtp-Source: APXvYqzyvX5rcwGteCDILdOOVLMfQnIlO75hFq9sXFORMLbiO+BZFnKIr7KGpBePOqf2vBr2WRdgp8bXAOSfoZ+l70+620klayo3
MIME-Version: 1.0
X-Received: by 2002:a6b:6103:: with SMTP id v3mr12583077iob.49.1581950533787;
 Mon, 17 Feb 2020 06:42:13 -0800 (PST)
Date:   Mon, 17 Feb 2020 06:42:13 -0800
In-Reply-To: <000000000000fd7fc3059e6deb38@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000009e654f059ec68f22@google.com>
Subject: Re: possible deadlock in tty_port_close_start
From:   syzbot <syzbot+044000e5acdb5e1d5eed@syzkaller.appspotmail.com>
To:     gregkh@linuxfoundation.org, jslaby@suse.com,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has found a reproducer for the following crash on:

HEAD commit:    11a48a5a Linux 5.6-rc2
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1489faa1e00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b1248cc89e4dba4
dashboard link: https://syzkaller.appspot.com/bug?extid=044000e5acdb5e1d5eed
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=169bae0de00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1147947ee00000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+044000e5acdb5e1d5eed@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
5.6.0-rc2-syzkaller #0 Not tainted
------------------------------------------------------
syz-executor309/9972 is trying to acquire lock:
ffffffff89ba1160 (console_owner){-.-.}, at: console_trylock_spinning kernel/printk/printk.c:1724 [inline]
ffffffff89ba1160 (console_owner){-.-.}, at: vprintk_emit+0x3fd/0x700 kernel/printk/printk.c:1995

but task is already holding lock:
ffffffff8c3694a0 (&(&port->lock)->rlock){-.-.}, at: tty_port_close_start.part.0+0x2b/0x580 drivers/tty/tty_port.c:566

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

2 locks held by syz-executor309/9972:
 #0: ffff8880a7fbd198 (&tty->legacy_mutex){+.+.}, at: tty_lock+0xc7/0x130 drivers/tty/tty_mutex.c:19
 #1: ffffffff8c3694a0 (&(&port->lock)->rlock){-.-.}, at: tty_port_close_start.part.0+0x2b/0x580 drivers/tty/tty_port.c:566

stack backtrace:
CPU: 1 PID: 9972 Comm: syz-executor309 Not tainted 5.6.0-rc2-syzkaller #0
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
RIP: 0033:0x409451
Code: 75 14 b8 03 00 00 00 0f 05 48 3d 01 f0 ff ff 0f 83 24 1a 00 00 c3 48 83 ec 08 e8 0a fc ff ff 48 89 04 24 b8 03 00 00 00 0f 05 <48> 8b 3c 24 48 89 c2 e8 53 fc ff ff 48 89 d0 48 83 c4 08 48 3d 01
RSP: 002b:00007fffaff80890 EFLAGS: 00000293 ORIG_RAX: 0000000000000003
RAX: 0000000000000000 RBX: 0000000000000004 RCX: 0000000000409451
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000003
RBP: 00000000006e6a10 R08: 00000000004b33a9 R09: 00000000004b33a9
R10: 00007fffaff808c0 R11: 0000000000000293 R12: 00000000006e6a1c
R13: 0000000000000001 R14: 000000000000002d R15: 20c49ba5e353f7cf

