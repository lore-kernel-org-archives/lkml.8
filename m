Return-Path: <SRS0=eGSO=AR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2F20C433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 15:22:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A53F820723
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 15:22:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729454AbgGFPWa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jul 2020 11:22:30 -0400
Received: from mail-io1-f72.google.com ([209.85.166.72]:56690 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729408AbgGFPW2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jul 2020 11:22:28 -0400
Received: by mail-io1-f72.google.com with SMTP id a10so1249803ioc.23
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jul 2020 08:22:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=4cHfqkRjzxg1VnQM1C8ubWq970NchbBwNDh1ciyyhLk=;
        b=o3MU28AMvY7zzMgunFGRXbM2PRnPQ4z2kkd51jHNJNc//sgYF51Ty7rGm0H0lw1To+
         SWO23pKQJLddJerBaADlDESTP/INVU50Ck0eraDczTOMfFJn3ruA3Z7aB0vzpEuWYd5+
         ORCU/wMdr6A21XIzDTIzrnNIBL3rf75LizTmNQ5Iuu9RPQ1GWJiaeoCYLbx6v6ov7sxM
         S8IpeKnToE5muthaku4LRWfyZ8U1grWW/ZB61lIRbwByCJsPXPIGzul21wLT2q0K5T5s
         QUqeWIEaddMiTkSzP1vmKWM4py0mteJKfsB4Euv/wugRDgsdulBWUsf/gKXZk6JnsdB1
         2xeg==
X-Gm-Message-State: AOAM5300Epc1IeJaCbL7n7S31NpXZJOHNgzTdkmFPWkqBkXO+BxXvA6k
        cPqZqR8v90IlV6EWfloPKV47skWu5ChBdNXhkk3Py8MQHwgx
X-Google-Smtp-Source: ABdhPJziQOTBujqI89TNC4kQE+65+pL5lq1L1F/haTVkr4cEbSudFMQSC78lwhNvDISRk9dLm1nVXSvjYuXOxxWLaZ7GcNtuvnIA
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1082:: with SMTP id r2mr32011820ilj.263.1594048946727;
 Mon, 06 Jul 2020 08:22:26 -0700 (PDT)
Date:   Mon, 06 Jul 2020 08:22:26 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000003971f105a9c77168@google.com>
Subject: INFO: task hung in usb_deregister_dev
From:   syzbot <syzbot+4189d5cde8630463053f@syzkaller.appspotmail.com>
To:     andreyknvl@google.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        stern@rowland.harvard.edu, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    768a0741 usb: dwc2: gadget: Remove assigned but never used..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git usb-testing
console output: https://syzkaller.appspot.com/x/log.txt?x=17c88f87100000
kernel config:  https://syzkaller.appspot.com/x/.config?x=999be4eb2478ffa5
dashboard link: https://syzkaller.appspot.com/bug?extid=4189d5cde8630463053f
compiler:       gcc (GCC) 10.1.0-syz 20200507

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+4189d5cde8630463053f@syzkaller.appspotmail.com

INFO: task kworker/1:4:3051 blocked for more than 143 seconds.
      Not tainted 5.8.0-rc3-syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
kworker/1:4     D23384  3051      2 0x80004000
Workqueue: usb_hub_wq hub_event
Call Trace:
 context_switch kernel/sched/core.c:3453 [inline]
 __schedule+0x88a/0x1cb0 kernel/sched/core.c:4178
 schedule+0xcd/0x2b0 kernel/sched/core.c:4253
 rwsem_down_write_slowpath+0x603/0xc60 kernel/locking/rwsem.c:1235
 __down_write kernel/locking/rwsem.c:1389 [inline]
 down_write+0x13c/0x150 kernel/locking/rwsem.c:1532
 usb_deregister_dev+0xaa/0x300 drivers/usb/core/file.c:239
 sisusb_disconnect+0x5a/0x200 drivers/usb/misc/sisusbvga/sisusb.c:3166
 usb_unbind_interface+0x1d8/0x8d0 drivers/usb/core/driver.c:436
 __device_release_driver+0x3b7/0x6e0 drivers/base/dd.c:1113
 device_release_driver_internal drivers/base/dd.c:1144 [inline]
 device_release_driver+0x26/0x40 drivers/base/dd.c:1167
 bus_remove_device+0x2eb/0x5a0 drivers/base/bus.c:533
 device_del+0x47c/0xd20 drivers/base/core.c:2857
 usb_disable_device+0x387/0x930 drivers/usb/core/message.c:1245
 usb_disconnect.cold+0x27d/0x780 drivers/usb/core/hub.c:2217
 hub_port_connect drivers/usb/core/hub.c:5059 [inline]
 hub_port_connect_change drivers/usb/core/hub.c:5348 [inline]
 port_event drivers/usb/core/hub.c:5494 [inline]
 hub_event+0x1c93/0x4390 drivers/usb/core/hub.c:5576
 process_one_work+0x94c/0x15f0 kernel/workqueue.c:2269
 process_scheduled_works kernel/workqueue.c:2331 [inline]
 worker_thread+0x82b/0x1120 kernel/workqueue.c:2417
 kthread+0x392/0x470 kernel/kthread.c:291
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:293

Showing all locks held in the system:
1 lock held by khungtaskd/23:
 #0: ffffffff873124a0 (rcu_read_lock){....}-{1:2}, at: debug_show_all_locks+0x53/0x264 kernel/locking/lockdep.c:5779
2 locks held by in:imklog/252:
 #0: ffff8881ca734d70 (&f->f_pos_lock){+.+.}-{3:3}, at: __fdget_pos+0xe9/0x100 fs/file.c:826
 #1: ffffffff873a1be0 (fs_reclaim){+.+.}-{0:0}, at: __debug_check_no_obj_freed lib/debugobjects.c:955 [inline]
 #1: ffffffff873a1be0 (fs_reclaim){+.+.}-{0:0}, at: debug_check_no_obj_freed+0xc7/0x41c lib/debugobjects.c:998
2 locks held by agetty/248:
 #0: ffff8881d3ea4098 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x22/0x80 drivers/tty/tty_ldisc.c:267
 #1: ffffc90000a022e8 (&ldata->atomic_read_lock){+.+.}-{3:3}, at: n_tty_read+0x223/0x1a30 drivers/tty/n_tty.c:2156
2 locks held by agetty/250:
 #0: ffff8881c74e4098 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x22/0x80 drivers/tty/tty_ldisc.c:267
 #1: ffffc900009f62e8 (&ldata->atomic_read_lock){+.+.}-{3:3}, at: n_tty_read+0x223/0x1a30 drivers/tty/n_tty.c:2156
2 locks held by agetty/253:
 #0: ffff8881d1e41098 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x22/0x80 drivers/tty/tty_ldisc.c:267
 #1: ffffc900009fe2e8 (&ldata->atomic_read_lock){+.+.}-{3:3}, at: n_tty_read+0x223/0x1a30 drivers/tty/n_tty.c:2156
2 locks held by agetty/255:
 #0: ffff8881ce014098 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x22/0x80 drivers/tty/tty_ldisc.c:267
 #1: ffffc900009de2e8 (&ldata->atomic_read_lock){+.+.}-{3:3}, at: n_tty_read+0x223/0x1a30 drivers/tty/n_tty.c:2156
2 locks held by agetty/256:
 #0: ffff8881ce952098 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x22/0x80 drivers/tty/tty_ldisc.c:267
 #1: ffffc900009ee2e8 (&ldata->atomic_read_lock){+.+.}-{3:3}, at: n_tty_read+0x223/0x1a30 drivers/tty/n_tty.c:2156
6 locks held by kworker/1:4/3051:
 #0: ffff8881d8862938 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
 #0: ffff8881d8862938 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: atomic64_set include/asm-generic/atomic-instrumented.h:856 [inline]
 #0: ffff8881d8862938 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: atomic_long_set include/asm-generic/atomic-long.h:41 [inline]
 #0: ffff8881d8862938 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: set_work_data kernel/workqueue.c:616 [inline]
 #0: ffff8881d8862938 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: set_work_pool_and_clear_pending kernel/workqueue.c:643 [inline]
 #0: ffff8881d8862938 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: process_one_work+0x82b/0x15f0 kernel/workqueue.c:2240
 #1: ffff8881ad5ffda8 ((work_completion)(&hub->events)){+.+.}-{0:0}, at: process_one_work+0x85f/0x15f0 kernel/workqueue.c:2244
 #2: ffff8881d44dc218 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:768 [inline]
 #2: ffff8881d44dc218 (&dev->mutex){....}-{3:3}, at: hub_event+0x1c5/0x4390 drivers/usb/core/hub.c:5522
 #3: ffff8881ca58e218 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:768 [inline]
 #3: ffff8881ca58e218 (&dev->mutex){....}-{3:3}, at: usb_disconnect.cold+0x43/0x780 drivers/usb/core/hub.c:2208
 #4: ffff8881c3b4e1a8 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:768 [inline]
 #4: ffff8881c3b4e1a8 (&dev->mutex){....}-{3:3}, at: __device_driver_lock drivers/base/dd.c:936 [inline]
 #4: ffff8881c3b4e1a8 (&dev->mutex){....}-{3:3}, at: device_release_driver_internal drivers/base/dd.c:1141 [inline]
 #4: ffff8881c3b4e1a8 (&dev->mutex){....}-{3:3}, at: device_release_driver+0x1c/0x40 drivers/base/dd.c:1167
 #5: ffffffff878ac990 (minor_rwsem){++++}-{3:3}, at: usb_deregister_dev+0xaa/0x300 drivers/usb/core/file.c:239
2 locks held by syz-executor.1/10703:
 #0: ffffffff878ac990 (minor_rwsem){++++}-{3:3}, at: usb_open+0x23/0x270 drivers/usb/core/file.c:39
 #1: ffff8881cb9880d0 (&(sisusb->lock)){+.+.}-{3:3}, at: sisusb_open+0xb2/0x4d0 drivers/usb/misc/sisusbvga/sisusb.c:2396

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
