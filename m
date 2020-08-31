Return-Path: <SRS0=8grS=CJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D45ECC43461
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 16:47:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B1F7320707
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 16:47:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728675AbgHaQrh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Aug 2020 12:47:37 -0400
Received: from mail-io1-f70.google.com ([209.85.166.70]:37638 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727949AbgHaQrW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 12:47:22 -0400
Received: by mail-io1-f70.google.com with SMTP id 80so4470205iou.4
        for <linux-kernel@vger.kernel.org>; Mon, 31 Aug 2020 09:47:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=wStrx+w9cg4MJN1sqeclOzlihfsrmPUHTb1URkLm6dI=;
        b=hY4WL0J2eaXC5kkbcp8U57onH0qg2iDKvtUQEThH0wVA89c73jNzTC8zICIwo5KEAP
         vE9VRNNSv7TVks86cEBx4G+vDE47hO61mVXHUio+VhkTh0GYjNhSbz8L64mOSx2dgyIT
         KANNF+aYgoAq652AkpKgQwmoUIxChwJ3zbw3ZBSUHPcb5NNM3YXGC4ftvwk/ypgniaiL
         EFJXffsLo9uuI6huj7Aci4u3tRJP6gkPnfra/D8X43T/JS0+xPhA8aea9uOZcy0q6X3j
         38k7vMQdtl1XrE9Sx6wX/nHQ9yMg+SpWPo9Pn2473MkQkhUGQBY6yT54ki90zGWJaxFz
         ERbg==
X-Gm-Message-State: AOAM531TV+BJXvK8VjJzq/KDv3NDcV6/ssrnud9aHO/T/2IUuLPtFc1s
        Jb2AzdgTfu76pvQAa/ysjHK/QKBxGzd9JianlYdc2SUKLEum
X-Google-Smtp-Source: ABdhPJyMLkWyfV9IXG3RdY5g9LqhcNRN2B7RVIXNy/D6Mzzdf0RWcwYTaMx4tpWzzFS++sVRuz1q5nf5pHetmBNie2nC7DLzFujg
MIME-Version: 1.0
X-Received: by 2002:a92:ba02:: with SMTP id o2mr1987546ili.219.1598892440478;
 Mon, 31 Aug 2020 09:47:20 -0700 (PDT)
Date:   Mon, 31 Aug 2020 09:47:20 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f2e88105ae2f2768@google.com>
Subject: INFO: task can't die in usb_start_wait_urb
From:   syzbot <syzbot+c3df2ca09fe4beef4d67@syzkaller.appspotmail.com>
To:     andriy.shevchenko@linux.intel.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        rafael.j.wysocki@intel.com, stern@rowland.harvard.edu,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    b36c9697 Add linux-next specific files for 20200828
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=156a598e900000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5e3cf99580b5542c
dashboard link: https://syzkaller.appspot.com/bug?extid=c3df2ca09fe4beef4d67
compiler:       gcc (GCC) 10.1.0-syz 20200507
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16c3301e900000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16d2df49900000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+c3df2ca09fe4beef4d67@syzkaller.appspotmail.com

INFO: task syz-executor787:6840 can't die for more than 143 seconds.
task:syz-executor787 state:D stack:26864 pid: 6840 ppid:  6833 flags:0x00000004
Call Trace:
 context_switch kernel/sched/core.c:3778 [inline]
 __schedule+0x8e5/0x21e0 kernel/sched/core.c:4527
 schedule+0xd0/0x2a0 kernel/sched/core.c:4602
 schedule_timeout+0x1d8/0x250 kernel/time/timer.c:1855
 do_wait_for_common kernel/sched/completion.c:85 [inline]
 __wait_for_common kernel/sched/completion.c:106 [inline]
 wait_for_common kernel/sched/completion.c:117 [inline]
 wait_for_completion_timeout+0x15e/0x270 kernel/sched/completion.c:157
 usb_start_wait_urb+0x144/0x2b0 drivers/usb/core/message.c:63
 usb_bulk_msg+0x226/0x550 drivers/usb/core/message.c:254
 do_proc_bulk+0x39b/0x710 drivers/usb/core/devio.c:1231
 proc_bulk drivers/usb/core/devio.c:1268 [inline]
 usbdev_do_ioctl drivers/usb/core/devio.c:2542 [inline]
 usbdev_ioctl+0x586/0x3360 drivers/usb/core/devio.c:2708
 vfs_ioctl fs/ioctl.c:48 [inline]
 __do_sys_ioctl fs/ioctl.c:753 [inline]
 __se_sys_ioctl fs/ioctl.c:739 [inline]
 __x64_sys_ioctl+0x193/0x200 fs/ioctl.c:739
 do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x449659
Code: Bad RIP value.
RSP: 002b:00007f02ac79cdb8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00000000006dac28 RCX: 0000000000449659
RDX: 0000000020000000 RSI: 00000000c0185502 RDI: 0000000000000003
RBP: 00000000006dac20 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000006dac2c
R13: 00007ffe8f1fe93f R14: 00007f02ac79d9c0 R15: 20c49ba5e353f7cf
INFO: task syz-executor787:6840 blocked for more than 143 seconds.
      Not tainted 5.9.0-rc2-next-20200828-syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor787 state:D stack:26864 pid: 6840 ppid:  6833 flags:0x00000004
Call Trace:
 context_switch kernel/sched/core.c:3778 [inline]
 __schedule+0x8e5/0x21e0 kernel/sched/core.c:4527
 schedule+0xd0/0x2a0 kernel/sched/core.c:4602
 schedule_timeout+0x1d8/0x250 kernel/time/timer.c:1855
 do_wait_for_common kernel/sched/completion.c:85 [inline]
 __wait_for_common kernel/sched/completion.c:106 [inline]
 wait_for_common kernel/sched/completion.c:117 [inline]
 wait_for_completion_timeout+0x15e/0x270 kernel/sched/completion.c:157
 usb_start_wait_urb+0x144/0x2b0 drivers/usb/core/message.c:63
 usb_bulk_msg+0x226/0x550 drivers/usb/core/message.c:254
 do_proc_bulk+0x39b/0x710 drivers/usb/core/devio.c:1231
 proc_bulk drivers/usb/core/devio.c:1268 [inline]
 usbdev_do_ioctl drivers/usb/core/devio.c:2542 [inline]
 usbdev_ioctl+0x586/0x3360 drivers/usb/core/devio.c:2708
 vfs_ioctl fs/ioctl.c:48 [inline]
 __do_sys_ioctl fs/ioctl.c:753 [inline]
 __se_sys_ioctl fs/ioctl.c:739 [inline]
 __x64_sys_ioctl+0x193/0x200 fs/ioctl.c:739
 do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x449659
Code: Bad RIP value.
RSP: 002b:00007f02ac79cdb8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00000000006dac28 RCX: 0000000000449659
RDX: 0000000020000000 RSI: 00000000c0185502 RDI: 0000000000000003
RBP: 00000000006dac20 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000006dac2c
R13: 00007ffe8f1fe93f R14: 00007f02ac79d9c0 R15: 20c49ba5e353f7cf

Showing all locks held in the system:
1 lock held by khungtaskd/1173:
 #0: ffffffff89c67640 (rcu_read_lock){....}-{1:2}, at: debug_show_all_locks+0x53/0x260 kernel/locking/lockdep.c:5825
1 lock held by in:imklog/6531:
 #0: ffff888098a9c130 (&f->f_pos_lock){+.+.}-{3:3}, at: __fdget_pos+0xe9/0x100 fs/file.c:930

=============================================

NMI backtrace for cpu 0
CPU: 0 PID: 1173 Comm: khungtaskd Not tainted 5.9.0-rc2-next-20200828-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x18f/0x20d lib/dump_stack.c:118
 nmi_cpu_backtrace.cold+0x44/0xd7 lib/nmi_backtrace.c:105
 nmi_trigger_cpumask_backtrace+0x1b3/0x223 lib/nmi_backtrace.c:62
 trigger_all_cpu_backtrace include/linux/nmi.h:147 [inline]
 check_hung_uninterruptible_tasks kernel/hung_task.c:253 [inline]
 watchdog+0xd89/0xf30 kernel/hung_task.c:339
 kthread+0x3b5/0x4a0 kernel/kthread.c:292
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:294
Sending NMI from CPU 0 to CPUs 1:
NMI backtrace for cpu 1
CPU: 1 PID: 3891 Comm: systemd-journal Not tainted 5.9.0-rc2-next-20200828-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:lookup_chain_cache kernel/locking/lockdep.c:3109 [inline]
RIP: 0010:lookup_chain_cache_add kernel/locking/lockdep.c:3128 [inline]
RIP: 0010:validate_chain kernel/locking/lockdep.c:3183 [inline]
RIP: 0010:__lock_acquire+0x1750/0x5640 kernel/locking/lockdep.c:4426
Code: 74 5d 49 bd 00 00 00 00 00 fc ff df 48 8b 54 24 08 eb 06 49 83 ec 08 74 46 49 8d 7c 24 18 48 89 f8 48 c1 e8 03 42 80 3c 28 00 <0f> 85 43 2a 00 00 49 8b 44 24 18 48 39 c2 0f 84 26 f5 ff ff 49 8d
RSP: 0018:ffffc90004807b00 EFLAGS: 00000046
RAX: 1ffffffff1806a53 RBX: 0000000000003fe4 RCX: ffffffff815a153b
RDX: 62386d250e98b09e RSI: 0000000000000008 RDI: ffffffff8c035298
RBP: ffff888093da49f0 R08: 0000000000000000 R09: ffffffff8c6a59f7
R10: fffffbfff18d4b3e R11: 0000000000000000 R12: ffffffff8c035280
R13: dffffc0000000000 R14: ffff888093da4100 R15: 0000000000000001
FS:  00007ff896ba08c0(0000) GS:ffff8880ae700000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ff893f44000 CR3: 000000009398b000 CR4: 00000000001506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 lock_acquire+0x1f1/0xad0 kernel/locking/lockdep.c:5005
 __raw_spin_lock include/linux/spinlock_api_smp.h:142 [inline]
 _raw_spin_lock+0x2a/0x40 kernel/locking/spinlock.c:151
 spin_lock include/linux/spinlock.h:354 [inline]
 __alloc_fd+0x34/0x600 fs/file.c:500
 do_sys_openat2+0x134/0x420 fs/open.c:1166
 do_sys_open fs/open.c:1184 [inline]
 __do_sys_open fs/open.c:1192 [inline]
 __se_sys_open fs/open.c:1188 [inline]
 __x64_sys_open+0x119/0x1c0 fs/open.c:1188
 do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x7ff896130840
Code: 73 01 c3 48 8b 0d 68 77 20 00 f7 d8 64 89 01 48 83 c8 ff c3 66 0f 1f 44 00 00 83 3d 89 bb 20 00 00 75 10 b8 02 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 31 c3 48 83 ec 08 e8 1e f6 ff ff 48 89 04 24
RSP: 002b:00007fffa7dee6b8 EFLAGS: 00000246 ORIG_RAX: 0000000000000002
RAX: ffffffffffffffda RBX: 00007fffa7dee9c0 RCX: 00007ff896130840
RDX: 00000000000001a0 RSI: 0000000000080042 RDI: 0000560b7f41acd0
RBP: 000000000000000d R08: 000000000000ffc0 R09: 00000000ffffffff
R10: 0000000000000069 R11: 0000000000000246 R12: 00000000ffffffff
R13: 0000560b7f40f040 R14: 00007fffa7dee980 R15: 0000560b7f41aaf0


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
