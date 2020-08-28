Return-Path: <SRS0=aBbL=CG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D74DBC433E2
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 12:52:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AEA852086A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 12:52:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729501AbgH1Mwc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Aug 2020 08:52:32 -0400
Received: from mail-io1-f72.google.com ([209.85.166.72]:48634 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729172AbgH1MwS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Aug 2020 08:52:18 -0400
Received: by mail-io1-f72.google.com with SMTP id k10so810699iow.15
        for <linux-kernel@vger.kernel.org>; Fri, 28 Aug 2020 05:52:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=aH/xVZKT59e9fqybNQgxAsPp9qZltpZTome6AJmbByo=;
        b=BDRIHWI0rtzsdofSY35/DPHFMtGtqROVcFsrbmgYCwUYkSqxrMHoN9dhluNlJVYvJx
         HTFSESNYlyTLUD3S/95FrsjlVmGj/YX1h0wChQL6lWsziiwN1mNYXSD9DYgRP8xoOZNq
         RmqmjxmP2VeWRcRwi0PSadMpwePCmtva8DEuORfMXgCklVDALVtQclL45RCq3M0bC1ub
         uF+ptxduO2JHQdpDQd96ig+3RBut3qtFARMAQYgYxYQ8VkaJt9yno1WpFZ07/lS3Vxxw
         2QDm8XeA+rToiuQo+fC1z2S8E5DwqQ5Fy+9vYlBZRz9Ub9gzcj46Mbf+T7LzNue2WqY+
         GpBw==
X-Gm-Message-State: AOAM531hybG5DoqMD1IZc+K8I+ssS0fHtrnk2lIuASENsCgqWUyBFZqX
        /Ed4SJWNjWCXYm/38QjviwXs6US9bsQi2CsN19ufPYuvPEWb
X-Google-Smtp-Source: ABdhPJxyGLO2wQws8Ithxes0F1VVHW/onOapxqkMjNLFd9dD9PSLcEQfazHCtiYn4tK2qtwCDYS9GxpB9BX2ugTZRrGCVvOng0U+
MIME-Version: 1.0
X-Received: by 2002:a05:6638:24d1:: with SMTP id y17mr1043497jat.42.1598619136726;
 Fri, 28 Aug 2020 05:52:16 -0700 (PDT)
Date:   Fri, 28 Aug 2020 05:52:16 -0700
In-Reply-To: <000000000000d3c499057536ce86@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c69c7805adef8597@google.com>
Subject: Re: INFO: task hung in usb_bulk_msg
From:   syzbot <syzbot+7a7613e5ba9ae7bd15f9@syzkaller.appspotmail.com>
To:     andriy.shevchenko@linux.intel.com, bigeasy@linutronix.de,
        felipe.balbi@linux.intel.com, gregkh@linuxfoundation.org,
        joe@perches.com, johan@kernel.org, kai.heng.feng@canonical.com,
        keescook@chromium.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, rafael.j.wysocki@intel.com,
        stern@rowland.harvard.edu, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has found a reproducer for the following issue on:

HEAD commit:    15bc20c6 Merge tag 'tty-5.9-rc3' of git://git.kernel.org/p..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1052a669900000
kernel config:  https://syzkaller.appspot.com/x/.config?x=978db74cb30aa994
dashboard link: https://syzkaller.appspot.com/bug?extid=7a7613e5ba9ae7bd15f9
compiler:       gcc (GCC) 10.1.0-syz 20200507
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=101c328e900000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=155eff41900000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+7a7613e5ba9ae7bd15f9@syzkaller.appspotmail.com

INFO: task syz-executor790:9958 blocked for more than 143 seconds.
      Not tainted 5.9.0-rc2-syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor790 state:D stack:28240 pid: 9958 ppid:  6854 flags:0x00004004
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
RIP: 0033:0x44d089
Code: Bad RIP value.
RSP: 002b:00007f70887dadb8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00000000006dec48 RCX: 000000000044d089
RDX: 0000000020000000 RSI: 00000000c0185502 RDI: 0000000000000003
RBP: 00000000006dec40 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000006dec4c
R13: 00007ffebdfc131f R14: 00007f70887db9c0 R15: 0000000000000064

Showing all locks held in the system:
1 lock held by ksoftirqd/1/16:
 #0: ffff8880ae735e18 (&rq->lock){-.-.}-{2:2}, at: rq_lock kernel/sched/sched.h:1292 [inline]
 #0: ffff8880ae735e18 (&rq->lock){-.-.}-{2:2}, at: __schedule+0x232/0x21e0 kernel/sched/core.c:4445
1 lock held by khungtaskd/1169:
 #0: ffffffff89bd6900 (rcu_read_lock){....}-{1:2}, at: debug_show_all_locks+0x53/0x260 kernel/locking/lockdep.c:5825
1 lock held by in:imklog/6531:
 #0: ffff8880a83bab70 (&f->f_pos_lock){+.+.}-{3:3}, at: __fdget_pos+0xe9/0x100 fs/file.c:930
3 locks held by kworker/u4:0/6882:
1 lock held by syz-executor790/24330:
 #0: ffff8880ae635e18 (&rq->lock){-.-.}-{2:2}, at: rq_lock kernel/sched/sched.h:1292 [inline]
 #0: ffff8880ae635e18 (&rq->lock){-.-.}-{2:2}, at: __schedule+0x232/0x21e0 kernel/sched/core.c:4445

=============================================

NMI backtrace for cpu 0
CPU: 0 PID: 1169 Comm: khungtaskd Not tainted 5.9.0-rc2-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x18f/0x20d lib/dump_stack.c:118
 nmi_cpu_backtrace.cold+0x70/0xb1 lib/nmi_backtrace.c:101
 nmi_trigger_cpumask_backtrace+0x1b3/0x223 lib/nmi_backtrace.c:62
 trigger_all_cpu_backtrace include/linux/nmi.h:146 [inline]
 check_hung_uninterruptible_tasks kernel/hung_task.c:209 [inline]
 watchdog+0xd7d/0x1000 kernel/hung_task.c:295
 kthread+0x3b5/0x4a0 kernel/kthread.c:292
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:294
Sending NMI from CPU 0 to CPUs 1:
NMI backtrace for cpu 1
CPU: 1 PID: 6851 Comm: syz-executor790 Not tainted 5.9.0-rc2-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:get_timespec64+0x1b3/0x220 kernel/time/time.c:801
Code: 89 73 08 e8 8f f6 10 00 48 b8 00 00 00 00 00 fc ff df 49 c7 04 04 00 00 00 00 48 8b 44 24 58 65 48 2b 04 25 28 00 00 00 75 45 <48> 83 c4 60 44 89 e8 5b 5d 41 5c 41 5d 41 5e c3 e8 58 f6 10 00 45
RSP: 0018:ffffc90001667e20 EFLAGS: 00000246
RAX: 0000000000000000 RBX: ffffc90001667ed0 RCX: ffffffff81634853
RDX: ffff8880a77381c0 RSI: ffffffff81634881 RDI: ffffc90001667ed8
RBP: 0000000000000000 R08: 00000000000f4240 R09: ffffc90001667e4f
R10: 0000000000000000 R11: 0000000000000000 R12: 1ffff920002ccfc4
R13: 0000000000000000 R14: 00000000000f4240 R15: 0000000000000000
FS:  000000000153e880(0000) GS:ffff8880ae700000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00000000004c6238 CR3: 00000000a93cd000 CR4: 00000000001506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 __do_sys_nanosleep kernel/time/hrtimer.c:1962 [inline]
 __se_sys_nanosleep kernel/time/hrtimer.c:1957 [inline]
 __x64_sys_nanosleep+0xaa/0x260 kernel/time/hrtimer.c:1957
 do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x44b800
Code: c0 5b 5d c3 66 0f 1f 44 00 00 8b 04 24 48 83 c4 18 5b 5d c3 66 0f 1f 44 00 00 83 3d b1 a0 29 00 00 75 14 b8 23 00 00 00 0f 05 <48> 3d 01 f0 ff ff 0f 83 24 e4 fb ff c3 48 83 ec 08 e8 7a 43 00 00
RSP: 002b:00007ffebdfc1378 EFLAGS: 00000246 ORIG_RAX: 0000000000000023
RAX: ffffffffffffffda RBX: 00000000000025c4 RCX: 000000000044b800
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 00007ffebdfc1380
RBP: 000000000009bbed R08: 0000000000000001 R09: 000000000153e880
R10: 0000000000000000 R11: 0000000000000246 R12: 00007ffebdfc13e0
R13: 000000000040a140 R14: 0000000000000000 R15: 0000000000000000

