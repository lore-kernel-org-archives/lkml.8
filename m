Return-Path: <SRS0=eGSO=AR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79CEEC433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 14:02:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 57C9A2073E
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 14:02:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729322AbgGFOCV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jul 2020 10:02:21 -0400
Received: from mail-il1-f200.google.com ([209.85.166.200]:34253 "EHLO
        mail-il1-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729140AbgGFOCU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jul 2020 10:02:20 -0400
Received: by mail-il1-f200.google.com with SMTP id y3so15991154ily.1
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jul 2020 07:02:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=TU56PJ0SruRVGlc+hyGDp//x46DEkSJQb6WxaluOrro=;
        b=XHw9cXJmDiEdGRiZTQcB4nShvi4cJCq0HUpe0GJvXvoEGzZ6xNn60dIGO5Ccxyd/Bt
         N0mbCsMZ4eZRKHQ0Qz0pxOsiQ489gKvAaUuM5r89SwwFbjMjFTYWN9IudNmrk0mDroQO
         RE41vjQBW7vhmQPLdCK9mskBqIt+m9i62qzCdsKGkYH+lkqwjqdxNXQFgVhyL9U5sFla
         VvVWeblLexKe6Pj8GJfJJq093upo0jgkWPWtTnYkx14yPXqx4cDqgzVoGE2olmpCcB0b
         pU4KGknZjv8TQ6gxVzvq8HJNAr3a/VDuImbQeta0U/LueRWrtmMZi9OA6De49RU6oWTy
         5ztg==
X-Gm-Message-State: AOAM531M+0D1bguI87NcrpWY3kUHGI0RGqpbtv5aaGmjUtQOoiC5wV4P
        m3l2qQTBBCiwByF3eCv/SrJwp1jlgu8rvOebjxoPTXzSn2cX
X-Google-Smtp-Source: ABdhPJxMkirRHFifp7/A0JE2Uz061gcLSy9lmW8OXP8N6ifj8OoUfvqs7L3WuB7sHKBcWzZFwM/9TiBbuXoAifJCXchtzsj5dvH2
MIME-Version: 1.0
X-Received: by 2002:a05:6602:2805:: with SMTP id d5mr25528098ioe.124.1594044139324;
 Mon, 06 Jul 2020 07:02:19 -0700 (PDT)
Date:   Mon, 06 Jul 2020 07:02:19 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ae492f05a9c6527a@google.com>
Subject: INFO: task hung in __do_sys_reboot
From:   syzbot <syzbot+805f5f6ae37411f15b64@syzkaller.appspotmail.com>
To:     andreyknvl@google.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        rafael@kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    768a0741 usb: dwc2: gadget: Remove assigned but never used..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git usb-testing
console output: https://syzkaller.appspot.com/x/log.txt?x=14ec52b7100000
kernel config:  https://syzkaller.appspot.com/x/.config?x=999be4eb2478ffa5
dashboard link: https://syzkaller.appspot.com/bug?extid=805f5f6ae37411f15b64
compiler:       gcc (GCC) 10.1.0-syz 20200507

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+805f5f6ae37411f15b64@syzkaller.appspotmail.com

INFO: task systemd-shutdow:1 blocked for more than 143 seconds.
      Not tainted 5.8.0-rc3-syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
systemd-shutdow D24504     1      0 0x00004000
Call Trace:
 context_switch kernel/sched/core.c:3453 [inline]
 __schedule+0x88a/0x1cb0 kernel/sched/core.c:4178
 schedule+0xcd/0x2b0 kernel/sched/core.c:4253
 wait_for_device_probe+0x1be/0x220 drivers/base/dd.c:665
 device_shutdown+0x18/0x5b5 drivers/base/core.c:3748
 kernel_restart_prepare kernel/reboot.c:76 [inline]
 kernel_restart kernel/reboot.c:246 [inline]
 __do_sys_reboot.cold+0x5d/0x9d kernel/reboot.c:347
 do_syscall_64+0x50/0x90 arch/x86/entry/common.c:359
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x7fc0c04788c6
Code: Bad RIP value.
RSP: 002b:00007fff74038008 EFLAGS: 00000202 ORIG_RAX: 00000000000000a9
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007fc0c04788c6
RDX: 0000000001234567 RSI: 0000000028121969 RDI: fffffffffee1dead
RBP: 00007fff74038098 R08: 0000000000000028 R09: 0000000000000005
R10: 0000000000000002 R11: 0000000000000202 R12: 0000000000000000
R13: 0000000000000000 R14: 000055b9797c9150 R15: 00007fff74038388

Showing all locks held in the system:
1 lock held by systemd-shutdow/1:
 #0: ffffffff872e8f68 (system_transition_mutex){+.+.}-{3:3}, at: __do_sys_reboot+0x1a4/0x3e0 kernel/reboot.c:344
1 lock held by khungtaskd/23:
 #0: ffffffff873124a0 (rcu_read_lock){....}-{1:2}, at: debug_show_all_locks+0x53/0x264 kernel/locking/lockdep.c:5779
5 locks held by kworker/1:2/67:
 #0: ffff8881d880ed38 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
 #0: ffff8881d880ed38 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: atomic64_set include/asm-generic/atomic-instrumented.h:856 [inline]
 #0: ffff8881d880ed38 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: atomic_long_set include/asm-generic/atomic-long.h:41 [inline]
 #0: ffff8881d880ed38 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: set_work_data kernel/workqueue.c:616 [inline]
 #0: ffff8881d880ed38 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: set_work_pool_and_clear_pending kernel/workqueue.c:643 [inline]
 #0: ffff8881d880ed38 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: process_one_work+0x82b/0x15f0 kernel/workqueue.c:2240
 #1: ffff8881d583fda8 ((work_completion)(&hub->events)){+.+.}-{0:0}, at: process_one_work+0x85f/0x15f0 kernel/workqueue.c:2244
 #2: ffff8881d450a218 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:768 [inline]
 #2: ffff8881d450a218 (&dev->mutex){....}-{3:3}, at: hub_event+0x1c5/0x4390 drivers/usb/core/hub.c:5522
 #3: ffff8881d23a4218 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:768 [inline]
 #3: ffff8881d23a4218 (&dev->mutex){....}-{3:3}, at: __device_attach+0x7a/0x430 drivers/base/dd.c:850
 #4: ffff8881ab7591a8 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:768 [inline]
 #4: ffff8881ab7591a8 (&dev->mutex){....}-{3:3}, at: __device_attach+0x7a/0x430 drivers/base/dd.c:850

=============================================

NMI backtrace for cpu 0
CPU: 0 PID: 23 Comm: khungtaskd Not tainted 5.8.0-rc3-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0xf6/0x16e lib/dump_stack.c:118
 nmi_cpu_backtrace.cold+0x74/0xb6 lib/nmi_backtrace.c:101
 nmi_trigger_cpumask_backtrace+0x1da/0x1f4 lib/nmi_backtrace.c:62
 trigger_all_cpu_backtrace include/linux/nmi.h:146 [inline]
 check_hung_uninterruptible_tasks kernel/hung_task.c:209 [inline]
 watchdog+0xd6a/0xfd0 kernel/hung_task.c:295
 kthread+0x392/0x470 kernel/kthread.c:291
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:293
Sending NMI from CPU 0 to CPUs 1:
NMI backtrace for cpu 1 skipped: idling at native_safe_halt arch/x86/include/asm/irqflags.h:60 [inline]
NMI backtrace for cpu 1 skipped: idling at arch_safe_halt arch/x86/include/asm/irqflags.h:103 [inline]
NMI backtrace for cpu 1 skipped: idling at acpi_safe_halt+0x72/0x90 drivers/acpi/processor_idle.c:111


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
