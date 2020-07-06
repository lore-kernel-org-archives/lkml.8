Return-Path: <SRS0=eGSO=AR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB95FC433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 15:13:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B231A20715
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 15:13:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729505AbgGFPM5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jul 2020 11:12:57 -0400
Received: from mail-il1-f197.google.com ([209.85.166.197]:55778 "EHLO
        mail-il1-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729268AbgGFPMY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jul 2020 11:12:24 -0400
Received: by mail-il1-f197.google.com with SMTP id b2so22114303ilh.22
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jul 2020 08:12:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=edWhtSQQL1CQu95ZZu1CWmk7TT4t+ZfKC4pk8oH+xIE=;
        b=Ix7c/lokcqMecS7LNIR2wnSWinf/5W0FQ6oNYZ03Kd8Oju7SY/f73s+V0Dm84s18MN
         C4mxSg6OUUMjZkJUzSwXzCA0thx6pl+a9dcppr7v07iemmn3u9U5j0jRDS3uwzWXcPKR
         6r+s7/wyp9L8AxRz7/fQbI6bTLLAnrB8vG7KoRmvPtoUJqtHJ95PUFu88t2hc6exWMve
         vPDI7N0SnxWVjgAQfC03XdV7sWng8VZxDy09u07K008Xgw8FMU8tjolsjP8H2YNYtFfz
         QdQPJvhI5AY3+sLmgDhbKwDj9gZemjQB1TMZ88rv0lOUIk6zT8byP2gkK6u4U61A3O+H
         JfbQ==
X-Gm-Message-State: AOAM5337HzgL2No8sJFaM7+xs/YJ03a9LPac2w/eXH8m20GINEC9S1fO
        ziBzs7kAFIl3UWnirjH7ss8I5Gahkq0OUzLSmH7DpBhsUg+e
X-Google-Smtp-Source: ABdhPJxhhYMBrnfcEmokqoOaEB5jmEK3zqXKg0U8geTLTpoCjCLfbmQ+W+P0vml/L9045hMMWKGP05d1fwYM0krLAGSfEVtQTdaX
MIME-Version: 1.0
X-Received: by 2002:a05:6602:449:: with SMTP id e9mr25549891iov.71.1594048342801;
 Mon, 06 Jul 2020 08:12:22 -0700 (PDT)
Date:   Mon, 06 Jul 2020 08:12:22 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000003a41f705a9c74dfa@google.com>
Subject: INFO: task hung in usb_register_dev
From:   syzbot <syzbot+e761775e8f4a28711f19@syzkaller.appspotmail.com>
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
console output: https://syzkaller.appspot.com/x/log.txt?x=14bc067b100000
kernel config:  https://syzkaller.appspot.com/x/.config?x=999be4eb2478ffa5
dashboard link: https://syzkaller.appspot.com/bug?extid=e761775e8f4a28711f19
compiler:       gcc (GCC) 10.1.0-syz 20200507

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+e761775e8f4a28711f19@syzkaller.appspotmail.com

INFO: task kworker/0:6:3156 blocked for more than 143 seconds.
      Not tainted 5.8.0-rc3-syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
kworker/0:6     D23384  3156      2 0x80004000
Workqueue: usb_hub_wq hub_event
Call Trace:
 context_switch kernel/sched/core.c:3453 [inline]
 __schedule+0x88a/0x1cb0 kernel/sched/core.c:4178
 schedule+0xcd/0x2b0 kernel/sched/core.c:4253
 rwsem_down_write_slowpath+0x603/0xc60 kernel/locking/rwsem.c:1235
 __down_write kernel/locking/rwsem.c:1389 [inline]
 down_write+0x13c/0x150 kernel/locking/rwsem.c:1532
 usb_register_dev drivers/usb/core/file.c:187 [inline]
 usb_register_dev+0x19d/0x740 drivers/usb/core/file.c:156
 adu_probe+0x6a3/0x830 drivers/usb/misc/adutux.c:733
 usb_probe_interface+0x315/0x7f0 drivers/usb/core/driver.c:374
 really_probe+0x291/0xc90 drivers/base/dd.c:525
 driver_probe_device+0x26b/0x3d0 drivers/base/dd.c:701
 __device_attach_driver+0x1d1/0x290 drivers/base/dd.c:807
 bus_for_each_drv+0x15f/0x1e0 drivers/base/bus.c:431
 __device_attach+0x28d/0x430 drivers/base/dd.c:873
 bus_probe_device+0x1e4/0x290 drivers/base/bus.c:491
 device_add+0xb09/0x1b40 drivers/base/core.c:2680
 usb_set_configuration+0xf05/0x18a0 drivers/usb/core/message.c:2032
 usb_generic_driver_probe+0xba/0xf2 drivers/usb/core/generic.c:241
 usb_probe_device+0xd9/0x250 drivers/usb/core/driver.c:272
 really_probe+0x291/0xc90 drivers/base/dd.c:525
 driver_probe_device+0x26b/0x3d0 drivers/base/dd.c:701
 __device_attach_driver+0x1d1/0x290 drivers/base/dd.c:807
 bus_for_each_drv+0x15f/0x1e0 drivers/base/bus.c:431
 __device_attach+0x28d/0x430 drivers/base/dd.c:873
 bus_probe_device+0x1e4/0x290 drivers/base/bus.c:491
 device_add+0xb09/0x1b40 drivers/base/core.c:2680
 usb_new_device.cold+0x71d/0xfd4 drivers/usb/core/hub.c:2554
 hub_port_connect drivers/usb/core/hub.c:5208 [inline]
 hub_port_connect_change drivers/usb/core/hub.c:5348 [inline]
 port_event drivers/usb/core/hub.c:5494 [inline]
 hub_event+0x2361/0x4390 drivers/usb/core/hub.c:5576
 process_one_work+0x94c/0x15f0 kernel/workqueue.c:2269
 worker_thread+0x64c/0x1120 kernel/workqueue.c:2415
 kthread+0x392/0x470 kernel/kthread.c:291
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:293
INFO: task kworker/0:0:15224 blocked for more than 143 seconds.
      Not tainted 5.8.0-rc3-syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
kworker/0:0     D23480 15224      2 0x80004000
Workqueue: usb_hub_wq hub_event
Call Trace:
 context_switch kernel/sched/core.c:3453 [inline]
 __schedule+0x88a/0x1cb0 kernel/sched/core.c:4178
 schedule+0xcd/0x2b0 kernel/sched/core.c:4253
 rwsem_down_write_slowpath+0x603/0xc60 kernel/locking/rwsem.c:1235
 __down_write kernel/locking/rwsem.c:1389 [inline]
 down_write+0x13c/0x150 kernel/locking/rwsem.c:1532
 usb_deregister_dev+0xaa/0x300 drivers/usb/core/file.c:239
 wdm_disconnect+0x21/0x450 drivers/usb/class/cdc-wdm.c:979
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
 worker_thread+0x64c/0x1120 kernel/workqueue.c:2415
 kthread+0x392/0x470 kernel/kthread.c:291
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:293
INFO: task syz-executor.1:3812 blocked for more than 144 seconds.
      Not tainted 5.8.0-rc3-syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
syz-executor.1  D29352  3812    346 0x00000004
Call Trace:
 context_switch kernel/sched/core.c:3453 [inline]
 __schedule+0x88a/0x1cb0 kernel/sched/core.c:4178
 schedule+0xcd/0x2b0 kernel/sched/core.c:4253
 rwsem_down_read_slowpath+0x2f7/0xc90 kernel/locking/rwsem.c:1099
 __down_read kernel/locking/rwsem.c:1341 [inline]
 down_read+0x1f0/0x420 kernel/locking/rwsem.c:1494
 usb_open+0x23/0x270 drivers/usb/core/file.c:39
 chrdev_open+0x266/0x770 fs/char_dev.c:414
 do_dentry_open+0x4ff/0x1170 fs/open.c:828
 do_open fs/namei.c:3243 [inline]
 path_openat+0x192c/0x26b0 fs/namei.c:3360
 do_filp_open+0x17e/0x3c0 fs/namei.c:3387
 do_sys_openat2+0x16f/0x3b0 fs/open.c:1179
 do_sys_open fs/open.c:1195 [inline]
 ksys_open include/linux/syscalls.h:1388 [inline]
 __do_sys_open fs/open.c:1201 [inline]
 __se_sys_open fs/open.c:1199 [inline]
 __x64_sys_open+0x119/0x1c0 fs/open.c:1199
 do_syscall_64+0x50/0x90 arch/x86/entry/common.c:359
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x416921
Code: Bad RIP value.
RSP: 002b:00007f3dc9c297a0 EFLAGS: 00000293 ORIG_RAX: 0000000000000002
RAX: ffffffffffffffda RBX: 000000000050a8c0 RCX: 0000000000416921
RDX: 0000000000000000 RSI: 0000000000000002 RDI: 00007f3dc9c297d0
RBP: 000000000078bf00 R08: 0000000000000000 R09: 000000000000000f
R10: 0000000000000064 R11: 0000000000000293 R12: 00000000ffffffff
R13: 0000000000000c46 R14: 00000000004ce9a6 R15: 00007f3dc9c2a6d4
INFO: task syz-executor.4:3919 blocked for more than 144 seconds.
      Not tainted 5.8.0-rc3-syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
syz-executor.4  D29160  3919    343 0x00000004
Call Trace:
 context_switch kernel/sched/core.c:3453 [inline]
 __schedule+0x88a/0x1cb0 kernel/sched/core.c:4178
 schedule+0xcd/0x2b0 kernel/sched/core.c:4253
 rwsem_down_read_slowpath+0x2f7/0xc90 kernel/locking/rwsem.c:1099
 __down_read kernel/locking/rwsem.c:1341 [inline]
 down_read+0x1f0/0x420 kernel/locking/rwsem.c:1494
 usb_open+0x23/0x270 drivers/usb/core/file.c:39
 chrdev_open+0x266/0x770 fs/char_dev.c:414
 do_dentry_open+0x4ff/0x1170 fs/open.c:828
 do_open fs/namei.c:3243 [inline]
 path_openat+0x192c/0x26b0 fs/namei.c:3360
 do_filp_open+0x17e/0x3c0 fs/namei.c:3387
 do_sys_openat2+0x16f/0x3b0 fs/open.c:1179
 do_sys_open fs/open.c:1195 [inline]
 ksys_open include/linux/syscalls.h:1388 [inline]
 __do_sys_open fs/open.c:1201 [inline]
 __se_sys_open fs/open.c:1199 [inline]
 __x64_sys_open+0x119/0x1c0 fs/open.c:1199
 do_syscall_64+0x50/0x90 arch/x86/entry/common.c:359
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x416921
Code: Bad RIP value.
RSP: 002b:00007f33da2f47a0 EFLAGS: 00000293 ORIG_RAX: 0000000000000002
RAX: ffffffffffffffda RBX: 000000000050a8c0 RCX: 0000000000416921
RDX: 0000000000000000 RSI: 0000000000000002 RDI: 00007f33da2f47d0
RBP: 000000000078bf00 R08: 0000000000000000 R09: 000000000000000f
R10: 0000000000000064 R11: 0000000000000293 R12: 00000000ffffffff
R13: 0000000000000c46 R14: 00000000004ce9a6 R15: 00007f33da2f56d4

Showing all locks held in the system:
1 lock held by khungtaskd/23:
 #0: ffffffff873124a0 (rcu_read_lock){....}-{1:2}, at: debug_show_all_locks+0x53/0x264 kernel/locking/lockdep.c:5779
1 lock held by in:imklog/237:
 #0: ffff8881c717aaf0 (&f->f_pos_lock){+.+.}-{3:3}, at: __fdget_pos+0xe9/0x100 fs/file.c:826
2 locks held by agetty/240:
 #0: ffff8881d1b94098 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x22/0x80 drivers/tty/tty_ldisc.c:267
 #1: ffffc90000a022e8 (&ldata->atomic_read_lock){+.+.}-{3:3}, at: n_tty_read+0x223/0x1a30 drivers/tty/n_tty.c:2156
6 locks held by kworker/0:4/3138:
 #0: ffff8881d880ed38 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
 #0: ffff8881d880ed38 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: atomic64_set include/asm-generic/atomic-instrumented.h:856 [inline]
 #0: ffff8881d880ed38 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: atomic_long_set include/asm-generic/atomic-long.h:41 [inline]
 #0: ffff8881d880ed38 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: set_work_data kernel/workqueue.c:616 [inline]
 #0: ffff8881d880ed38 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: set_work_pool_and_clear_pending kernel/workqueue.c:643 [inline]
 #0: ffff8881d880ed38 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: process_one_work+0x82b/0x15f0 kernel/workqueue.c:2240
 #1: ffff8881cfd1fda8 ((work_completion)(&hub->events)){+.+.}-{0:0}, at: process_one_work+0x85f/0x15f0 kernel/workqueue.c:2244
 #2: ffff8881d453d218 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:768 [inline]
 #2: ffff8881d453d218 (&dev->mutex){....}-{3:3}, at: hub_event+0x1c5/0x4390 drivers/usb/core/hub.c:5522
 #3: ffff8881d21b6218 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:768 [inline]
 #3: ffff8881d21b6218 (&dev->mutex){....}-{3:3}, at: __device_attach+0x7a/0x430 drivers/base/dd.c:850
 #4: ffff8881cb5fd1a8 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:768 [inline]
 #4: ffff8881cb5fd1a8 (&dev->mutex){....}-{3:3}, at: __device_attach+0x7a/0x430 drivers/base/dd.c:850
 #5: ffffffff878ac990 (minor_rwsem#2){++++}-{3:3}, at: usb_register_dev drivers/usb/core/file.c:187 [inline]
 #5: ffffffff878ac990 (minor_rwsem#2){++++}-{3:3}, at: usb_register_dev+0x19d/0x740 drivers/usb/core/file.c:156
6 locks held by kworker/0:6/3156:
 #0: ffff8881d880ed38 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
 #0: ffff8881d880ed38 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: atomic64_set include/asm-generic/atomic-instrumented.h:856 [inline]
 #0: ffff8881d880ed38 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: atomic_long_set include/asm-generic/atomic-long.h:41 [inline]
 #0: ffff8881d880ed38 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: set_work_data kernel/workqueue.c:616 [inline]
 #0: ffff8881d880ed38 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: set_work_pool_and_clear_pending kernel/workqueue.c:643 [inline]
 #0: ffff8881d880ed38 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: process_one_work+0x82b/0x15f0 kernel/workqueue.c:2240
 #1: ffff8881ccc37da8 ((work_completion)(&hub->events)){+.+.}-{0:0}, at: process_one_work+0x85f/0x15f0 kernel/workqueue.c:2244
 #2: ffff8881d4465218 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:768 [inline]
 #2: ffff8881d4465218 (&dev->mutex){....}-{3:3}, at: hub_event+0x1c5/0x4390 drivers/usb/core/hub.c:5522
 #3: ffff8881cabba218 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:768 [inline]
 #3: ffff8881cabba218 (&dev->mutex){....}-{3:3}, at: __device_attach+0x7a/0x430 drivers/base/dd.c:850
 #4: ffff8881ce3491a8 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:768 [inline]
 #4: ffff8881ce3491a8 (&dev->mutex){....}-{3:3}, at: __device_attach+0x7a/0x430 drivers/base/dd.c:850
 #5: ffffffff878ac990 (minor_rwsem#2){++++}-{3:3}, at: usb_register_dev drivers/usb/core/file.c:187 [inline]
 #5: ffffffff878ac990 (minor_rwsem#2){++++}-{3:3}, at: usb_register_dev+0x19d/0x740 drivers/usb/core/file.c:156
6 locks held by kworker/0:0/15224:
 #0: ffff8881d880ed38 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
 #0: ffff8881d880ed38 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: atomic64_set include/asm-generic/atomic-instrumented.h:856 [inline]
 #0: ffff8881d880ed38 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: atomic_long_set include/asm-generic/atomic-long.h:41 [inline]
 #0: ffff8881d880ed38 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: set_work_data kernel/workqueue.c:616 [inline]
 #0: ffff8881d880ed38 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: set_work_pool_and_clear_pending kernel/workqueue.c:643 [inline]
 #0: ffff8881d880ed38 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: process_one_work+0x82b/0x15f0 kernel/workqueue.c:2240
 #1: ffff8881cc307da8 ((work_completion)(&hub->events)){+.+.}-{0:0}, at: process_one_work+0x85f/0x15f0 kernel/workqueue.c:2244
 #2: ffff8881d441d218 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:768 [inline]
 #2: ffff8881d441d218 (&dev->mutex){....}-{3:3}, at: hub_event+0x1c5/0x4390 drivers/usb/core/hub.c:5522
 #3: ffff8881d2745218 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:768 [inline]
 #3: ffff8881d2745218 (&dev->mutex){....}-{3:3}, at: usb_disconnect.cold+0x43/0x780 drivers/usb/core/hub.c:2208
 #4: ffff8881c809d1a8 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:768 [inline]
 #4: ffff8881c809d1a8 (&dev->mutex){....}-{3:3}, at: __device_driver_lock drivers/base/dd.c:936 [inline]
 #4: ffff8881c809d1a8 (&dev->mutex){....}-{3:3}, at: device_release_driver_internal drivers/base/dd.c:1141 [inline]
 #4: ffff8881c809d1a8 (&dev->mutex){....}-{3:3}, at: device_release_driver+0x1c/0x40 drivers/base/dd.c:1167
 #5: ffffffff878ac990 (minor_rwsem#2){++++}-{3:3}, at: usb_deregister_dev+0xaa/0x300 drivers/usb/core/file.c:239
2 locks held by agetty/18569:
 #0: ffff8881c8d0d098 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x22/0x80 drivers/tty/tty_ldisc.c:267
 #1: ffffc9000f9c42e8 (&ldata->atomic_read_lock){+.+.}-{3:3}, at: n_tty_read+0x223/0x1a30 drivers/tty/n_tty.c:2156
2 locks held by agetty/3409:
 #0: ffff8881ce34b098 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x22/0x80 drivers/tty/tty_ldisc.c:267
 #1: ffffc9000fd982e8 (&ldata->atomic_read_lock){+.+.}-{3:3}, at: n_tty_read+0x223/0x1a30 drivers/tty/n_tty.c:2156
2 locks held by syz-executor.0/3840:
 #0: ffffffff878ac990 (minor_rwsem#2){++++}-{3:3}, at: usb_open+0x23/0x270 drivers/usb/core/file.c:39
 #1: ffff8881c954b0d0 (&(sisusb->lock)){+.+.}-{3:3}, at: sisusb_open+0xb2/0x4d0 drivers/usb/misc/sisusbvga/sisusb.c:2396
1 lock held by syz-executor.1/3812:
 #0: ffffffff878ac990 (minor_rwsem#2){++++}-{3:3}, at: usb_open+0x23/0x270 drivers/usb/core/file.c:39
1 lock held by syz-executor.4/3919:
 #0: ffffffff878ac990 (minor_rwsem#2){++++}-{3:3}, at: usb_open+0x23/0x270 drivers/usb/core/file.c:39

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
