Return-Path: <SRS0=nwpL=6I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B64DCC2BA1A
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 05:16:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 97E3B20767
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 05:16:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726458AbgDXFQQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Apr 2020 01:16:16 -0400
Received: from mail-il1-f197.google.com ([209.85.166.197]:49784 "EHLO
        mail-il1-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726051AbgDXFQQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Apr 2020 01:16:16 -0400
Received: by mail-il1-f197.google.com with SMTP id z18so8559593ilp.16
        for <linux-kernel@vger.kernel.org>; Thu, 23 Apr 2020 22:16:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=A6c/LQtJZc4+qQOkiE4dj1+HwbD1HzzkY4RQO9cB8zk=;
        b=HhFE2hrdJpUzzbDnz5PczM9KX4p2ks4rVVZaBkCUlXlPmaauGMt6ds00slSCqbWwqj
         4mKigjSp/BDXONBj/hui2XoNH5v50m6IouhRoly2ZMb+D/+fNUYNRx8h+BHDjH1uajfO
         5r9hhkUPfLfJhbQquqenJiS0FewPNGSJz+pyexHtbtNDn8m8FCqqyBMcxbTmSNExjy5b
         WW655I7GUyX0WlgzjSOE5albMXANLJKVs9JSyPvENoqL44G9UgXaEmVb0E7DoNS7RrCB
         5iKhs0I4aj6xhUXHyiSn+juplRBtb/fXULrLmQeD28vVMYQ2zOUsqNQL7j1ki9+AwNAh
         crMg==
X-Gm-Message-State: AGi0PuYzdBnBphMcJHIEztgI0deMxoJfC0yXA/D06+qlft9S2Vqgy6Bl
        FWgZTo4Zx8lf228S9F85ZKO7Wbthv2tCMnSkB07PmRFKDh/5
X-Google-Smtp-Source: APiQypI7qOhbzivl8UaVt3DFLRaetqjpp6n26KYC5aYYQI5TbSST3tKWkrjAJLyX/h2BFJctWSC/RQ4IPcI16SiPUE/NcerUG1sn
MIME-Version: 1.0
X-Received: by 2002:a92:7e8b:: with SMTP id q11mr6675708ill.281.1587705374979;
 Thu, 23 Apr 2020 22:16:14 -0700 (PDT)
Date:   Thu, 23 Apr 2020 22:16:14 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e23c2805a4027606@google.com>
Subject: INFO: task hung in vcs_open
From:   syzbot <syzbot+975c6b229a82b59591c0@syzkaller.appspotmail.com>
To:     gregkh@linuxfoundation.org, jslaby@suse.com,
        linux-kernel@vger.kernel.org, nico@fluxnic.net,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    90280eaa Merge tag 'docs-fixes' of git://git.lwn.net/linux
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=12afdef0100000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5d351a1019ed81a2
dashboard link: https://syzkaller.appspot.com/bug?extid=975c6b229a82b59591c0
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+975c6b229a82b59591c0@syzkaller.appspotmail.com

INFO: task syz-executor.1:9967 blocked for more than 143 seconds.
      Not tainted 5.7.0-rc1-syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
syz-executor.1  D27296  9967   7170 0x00000004
Call Trace:
 schedule+0xd0/0x2a0 kernel/sched/core.c:4163
 schedule_timeout+0x55b/0x850 kernel/time/timer.c:1874
 __down_common kernel/locking/semaphore.c:220 [inline]
 __down+0x176/0x2c0 kernel/locking/semaphore.c:237
 down+0x57/0x80 kernel/locking/semaphore.c:61
 console_lock+0x25/0x80 kernel/printk/printk.c:2314
 vcs_open+0x62/0xc0 drivers/tty/vt/vc_screen.c:688
 chrdev_open+0x219/0x5c0 fs/char_dev.c:414
 do_dentry_open+0x4ba/0x1290 fs/open.c:797
 do_open fs/namei.c:3229 [inline]
 path_openat+0x1e59/0x27d0 fs/namei.c:3346
 do_filp_open+0x192/0x260 fs/namei.c:3373
 do_sys_openat2+0x585/0x7d0 fs/open.c:1148
 do_sys_open+0xc3/0x140 fs/open.c:1164
 do_syscall_64+0xf6/0x7d0 arch/x86/entry/common.c:295
 entry_SYSCALL_64_after_hwframe+0x49/0xb3
RIP: 0033:0x416661
Code: 24 10 48 c7 44 24 18 02 00 00 00 e8 49 02 00 00 48 8b 44 24 20 48 89 c1 48 c1 e0 03 48 8b 94 24 80 00 00 00 48 39 d0 75 75 48 <89> c8 e9 67 ff ff ff 48 89 f0 b9 28 00 00 00 e8 fb 8f 04 00 48 89
RSP: 002b:00007f77ea7707a0 EFLAGS: 00000293 ORIG_RAX: 0000000000000002
RAX: ffffffffffffffda RBX: 6666666666666667 RCX: 0000000000416661
RDX: 0000000000000000 RSI: 0000000000101000 RDI: 00007f77ea770850
RBP: 000000000076bfa0 R08: 000000000000000f R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000293 R12: 00000000ffffffff
R13: 0000000000000c15 R14: 00000000004ce483 R15: 000000000076bfac
INFO: task syz-executor.1:9970 blocked for more than 143 seconds.
      Not tainted 5.7.0-rc1-syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
syz-executor.1  D27496  9970   7170 0x00000004
Call Trace:
 schedule+0xd0/0x2a0 kernel/sched/core.c:4163
 schedule_preempt_disabled+0xf/0x20 kernel/sched/core.c:4222
 __mutex_lock_common kernel/locking/mutex.c:1033 [inline]
 __mutex_lock+0x7ab/0x13c0 kernel/locking/mutex.c:1103
 lock_fb_info include/linux/fb.h:637 [inline]
 fb_open+0xd3/0x430 drivers/video/fbdev/core/fbmem.c:1418
 chrdev_open+0x219/0x5c0 fs/char_dev.c:414
 do_dentry_open+0x4ba/0x1290 fs/open.c:797
 do_open fs/namei.c:3229 [inline]
 path_openat+0x1e59/0x27d0 fs/namei.c:3346
 do_filp_open+0x192/0x260 fs/namei.c:3373
 do_sys_openat2+0x585/0x7d0 fs/open.c:1148
 do_sys_open+0xc3/0x140 fs/open.c:1164
 do_syscall_64+0xf6/0x7d0 arch/x86/entry/common.c:295
 entry_SYSCALL_64_after_hwframe+0x49/0xb3
RIP: 0033:0x45c869
Code: 04 24 48 89 4c 24 08 48 89 54 24 10 e8 d0 5c fa ff 80 7c 24 18 00 74 cf 48 8b 44 24 38 48 8b 48 60 48 85 c9 74 1a 8b 54 24 24 <85> d2 74 12 8b 5c 24 68 0f b7 0c 59 81 e1 ff 7f 00 00 39 d1 75 30
RSP: 002b:00007f77ea74fc78 EFLAGS: 00000246 ORIG_RAX: 0000000000000101
RAX: ffffffffffffffda RBX: 00007f77ea7506d4 RCX: 000000000045c869
RDX: 0000000000000000 RSI: 0000000020000180 RDI: ffffffffffffff9c
RBP: 000000000076c040 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000ffffffff
R13: 000000000000079a R14: 00000000004ca55c R15: 000000000076c04c
INFO: task syz-executor.1:10007 blocked for more than 143 seconds.
      Not tainted 5.7.0-rc1-syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
syz-executor.1  D28400 10007   7170 0x00000004
Call Trace:
 schedule+0xd0/0x2a0 kernel/sched/core.c:4163
 schedule_timeout+0x55b/0x850 kernel/time/timer.c:1874
 __down_common kernel/locking/semaphore.c:220 [inline]
 __down+0x176/0x2c0 kernel/locking/semaphore.c:237
 down+0x57/0x80 kernel/locking/semaphore.c:61
 console_lock+0x25/0x80 kernel/printk/printk.c:2314
 vcs_open+0x62/0xc0 drivers/tty/vt/vc_screen.c:688
 chrdev_open+0x219/0x5c0 fs/char_dev.c:414
 do_dentry_open+0x4ba/0x1290 fs/open.c:797
 do_open fs/namei.c:3229 [inline]
 path_openat+0x1e59/0x27d0 fs/namei.c:3346
 do_filp_open+0x192/0x260 fs/namei.c:3373
 do_sys_openat2+0x585/0x7d0 fs/open.c:1148
 do_sys_open+0xc3/0x140 fs/open.c:1164
 do_syscall_64+0xf6/0x7d0 arch/x86/entry/common.c:295
 entry_SYSCALL_64_after_hwframe+0x49/0xb3
RIP: 0033:0x416661
Code: 24 10 48 c7 44 24 18 02 00 00 00 e8 49 02 00 00 48 8b 44 24 20 48 89 c1 48 c1 e0 03 48 8b 94 24 80 00 00 00 48 39 d0 75 75 48 <89> c8 e9 67 ff ff ff 48 89 f0 b9 28 00 00 00 e8 fb 8f 04 00 48 89
RSP: 002b:00007f77ea70d7a0 EFLAGS: 00000293 ORIG_RAX: 0000000000000002
RAX: ffffffffffffffda RBX: 6666666666666667 RCX: 0000000000416661
RDX: 0000000000000000 RSI: 0000000000101000 RDI: 00007f77ea70d850
RBP: 000000000076c180 R08: 000000000000000f R09: 0000000000000000
R10: 00007f77ea70e9d0 R11: 0000000000000293 R12: 00000000ffffffff
R13: 0000000000000c15 R14: 00000000004ce483 R15: 000000000076c18c

Showing all locks held in the system:
1 lock held by khungtaskd/1140:
 #0: ffffffff899bed00 (rcu_read_lock){....}-{1:2}, at: debug_show_all_locks+0x53/0x260 kernel/locking/lockdep.c:5754
1 lock held by in:imklog/6702:
 #0: ffff8880a90ef0f0 (&f->f_pos_lock){+.+.}-{3:3}, at: __fdget_pos+0xe9/0x100 fs/file.c:826
2 locks held by syz-executor.1/9963:
1 lock held by syz-executor.1/9970:
 #0: ffff888218eb7078 (&fb_info->lock){+.+.}-{3:3}, at: lock_fb_info include/linux/fb.h:637 [inline]
 #0: ffff888218eb7078 (&fb_info->lock){+.+.}-{3:3}, at: fb_open+0xd3/0x430 drivers/video/fbdev/core/fbmem.c:1418

=============================================

NMI backtrace for cpu 0
CPU: 0 PID: 1140 Comm: khungtaskd Not tainted 5.7.0-rc1-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x188/0x20d lib/dump_stack.c:118
 nmi_cpu_backtrace.cold+0x70/0xb1 lib/nmi_backtrace.c:101
 nmi_trigger_cpumask_backtrace+0x231/0x27e lib/nmi_backtrace.c:62
 trigger_all_cpu_backtrace include/linux/nmi.h:146 [inline]
 check_hung_uninterruptible_tasks kernel/hung_task.c:205 [inline]
 watchdog+0xa8c/0x1010 kernel/hung_task.c:289
 kthread+0x388/0x470 kernel/kthread.c:268
 ret_from_fork+0x24/0x30 arch/x86/entry/entry_64.S:352
Sending NMI from CPU 0 to CPUs 1:
NMI backtrace for cpu 1
CPU: 1 PID: 9963 Comm: syz-executor.1 Not tainted 5.7.0-rc1-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:write_comp_data+0x1e/0x70 kernel/kcov.c:208
Code: 48 89 11 c3 0f 1f 84 00 00 00 00 00 65 4c 8b 04 25 00 1f 02 00 65 8b 05 68 ea 8e 7e a9 00 01 1f 00 75 51 41 8b 80 d8 13 00 00 <83> f8 03 75 45 49 8b 80 e0 13 00 00 45 8b 80 dc 13 00 00 4c 8b 08
RSP: 0018:ffffc9001606f590 EFLAGS: 00000246
RAX: 0000000000000002 RBX: 0000000000000050 RCX: ffffffff83c364ea
RDX: 000000000000003e RSI: 0000000000000050 RDI: 0000000000000004
RBP: 000000000000003e R08: ffff88805043c480 R09: ffffed10431c9dec
R10: ffff888218e4ef5f R11: ffffed10431c9deb R12: ffff8880000a003e
R13: ffff8880000a0000 R14: 0000000000000000 R15: 00000000f0bb4ad1
FS:  00007f77ea792700(0000) GS:ffff8880ae700000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fce82f67000 CR3: 0000000096c52000 CR4: 00000000001406e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 vga16fb_fillrect+0x9da/0x1960 drivers/video/fbdev/vga16fb.c:922
 bit_clear_margins+0x2d5/0x4a0 drivers/video/fbdev/core/bitblit.c:232
 fbcon_clear_margins+0x1de/0x240 drivers/video/fbdev/core/fbcon.c:1381
 fbcon_switch+0xd21/0x1740 drivers/video/fbdev/core/fbcon.c:2363
 redraw_screen+0x2ae/0x770 drivers/tty/vt/vt.c:1009
 fbcon_modechanged+0x5c3/0x790 drivers/video/fbdev/core/fbcon.c:3000
 fbcon_update_vcs+0x3a/0x50 drivers/video/fbdev/core/fbcon.c:3047
 fb_set_var+0xad0/0xd40 drivers/video/fbdev/core/fbmem.c:1056
 do_fb_ioctl+0x390/0x6e0 drivers/video/fbdev/core/fbmem.c:1109
 fb_ioctl+0xdd/0x130 drivers/video/fbdev/core/fbmem.c:1185
 vfs_ioctl fs/ioctl.c:47 [inline]
 ksys_ioctl+0x11a/0x180 fs/ioctl.c:763
 __do_sys_ioctl fs/ioctl.c:772 [inline]
 __se_sys_ioctl fs/ioctl.c:770 [inline]
 __x64_sys_ioctl+0x6f/0xb0 fs/ioctl.c:770
 do_syscall_64+0xf6/0x7d0 arch/x86/entry/common.c:295
 entry_SYSCALL_64_after_hwframe+0x49/0xb3
RIP: 0033:0x45c869
Code: 0d b7 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 0f 83 db b6 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007f77ea791c78 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f77ea7926d4 RCX: 000000000045c869
RDX: 0000000020000000 RSI: 0000000000004601 RDI: 0000000000000007
RBP: 000000000076bf00 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000ffffffff
R13: 00000000000002f0 R14: 00000000004c5524 R15: 000000000076bf0c


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
