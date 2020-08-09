Return-Path: <SRS0=dnKw=BT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6091C433DF
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Aug 2020 16:28:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AA6D82068F
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Aug 2020 16:28:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726515AbgHIQ17 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Aug 2020 12:27:59 -0400
Received: from mail-io1-f69.google.com ([209.85.166.69]:53175 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726401AbgHIQ1U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Aug 2020 12:27:20 -0400
Received: by mail-io1-f69.google.com with SMTP id k12so5371831iom.19
        for <linux-kernel@vger.kernel.org>; Sun, 09 Aug 2020 09:27:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=aym2sNLpeh8rdhf7LigtiRmebev+2OT77Mxrdz8HH8s=;
        b=hwpDqod6RPFL0NZG4Q+L7bjKHjwPZN9r36TvmPbfnXp5BFDeC0wpp2dU1CGSlvJ8jQ
         3FWhArejpEIwm7bUkU+qH7pH8viwui01Qcosx1jgOjthk3mIiPFOhxvkUVRDiE6bL15p
         eq6Aa7ng9DjByvS4DN7bjFeBaD9jLCOUAix/HLmBhaoMaC3578jgfRinf8kYla+ewy8+
         4pgoyOrjOxZsO5NQXr+s7Qhy+O35UfxZK9ZWrSaTOkJ/PKvzEbyKJ0eeropwD60iVFV6
         JxQ5CAJZ2w5jofxXDOTuIlZg31wT2uwx+68gSdhIBnxNzesWGmgr/S+7vJ3q/xJ96v9U
         dnTw==
X-Gm-Message-State: AOAM533rAx/JtgLhpsi/geycuBffgdGCy/6+zRy0EFbR+UE1xdG/QVU5
        7encIfPD8Za+Y0WdeVQeUDITtThDNXax2nSCdmoKBDkmADkZ
X-Google-Smtp-Source: ABdhPJxvVCh427zVTWoewbojXIZVnZHEKwIItYwQvNZfv6FWWOJRqkNluh4P+T3I7Z72WuEl+PWQsyYez+HqczoynjQ67ZY767wd
MIME-Version: 1.0
X-Received: by 2002:a92:1f14:: with SMTP id i20mr13685168ile.280.1596990438669;
 Sun, 09 Aug 2020 09:27:18 -0700 (PDT)
Date:   Sun, 09 Aug 2020 09:27:18 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ce85c405ac744ff6@google.com>
Subject: KMSAN: kernel-infoleak in raw_ioctl
From:   syzbot <syzbot+a7e220df5a81d1ab400e@syzkaller.appspotmail.com>
To:     andreyknvl@google.com, balbi@kernel.org, dan.carpenter@oracle.com,
        glider@google.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    ce8056d1 wip: changed copy_from_user where instrumented
git tree:       https://github.com/google/kmsan.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=141eb8b2900000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3afe005fb99591f
dashboard link: https://syzkaller.appspot.com/bug?extid=a7e220df5a81d1ab400e
compiler:       clang version 10.0.0 (https://github.com/llvm/llvm-project/ c2443155a0fb245c8f17f2c1c72b6ea391e86e81)
userspace arch: i386

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+a7e220df5a81d1ab400e@syzkaller.appspotmail.com

=====================================================
BUG: KMSAN: kernel-infoleak in kmsan_copy_to_user+0x81/0x90 mm/kmsan/kmsan_hooks.c:253
CPU: 0 PID: 22259 Comm: syz-executor.5 Not tainted 5.8.0-rc5-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x21c/0x280 lib/dump_stack.c:118
 kmsan_report+0xf7/0x1e0 mm/kmsan/kmsan_report.c:121
 kmsan_internal_check_memory+0x238/0x3d0 mm/kmsan/kmsan.c:423
 kmsan_copy_to_user+0x81/0x90 mm/kmsan/kmsan_hooks.c:253
 instrument_copy_to_user include/linux/instrumented.h:91 [inline]
 _copy_to_user+0x18e/0x260 lib/usercopy.c:39
 copy_to_user include/linux/uaccess.h:186 [inline]
 raw_ioctl_event_fetch drivers/usb/gadget/legacy/raw_gadget.c:567 [inline]
 raw_ioctl+0x4995/0x5810 drivers/usb/gadget/legacy/raw_gadget.c:1213
 __do_compat_sys_ioctl fs/ioctl.c:847 [inline]
 __se_compat_sys_ioctl+0x55f/0x1100 fs/ioctl.c:798
 __ia32_compat_sys_ioctl+0x4a/0x70 fs/ioctl.c:798
 do_syscall_32_irqs_on arch/x86/entry/common.c:430 [inline]
 __do_fast_syscall_32+0x2af/0x480 arch/x86/entry/common.c:477
 do_fast_syscall_32+0x6b/0xd0 arch/x86/entry/common.c:505
 do_SYSENTER_32+0x73/0x90 arch/x86/entry/common.c:554
 entry_SYSENTER_compat_after_hwframe+0x4d/0x5c
RIP: 0023:0xf7fbd549
Code: Bad RIP value.
RSP: 002b:00000000f55b5058 EFLAGS: 00000246 ORIG_RAX: 0000000000000036
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 0000000080085502
RDX: 00000000f55b60ac RSI: 000000000002acf0 RDI: 0000000000000003
RBP: 00000000f55b7228 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000

Uninit was stored to memory at:
 kmsan_save_stack_with_flags mm/kmsan/kmsan.c:144 [inline]
 kmsan_internal_chain_origin+0xad/0x130 mm/kmsan/kmsan.c:310
 kmsan_memcpy_memmove_metadata+0x272/0x2e0 mm/kmsan/kmsan.c:247
 kmsan_memcpy_metadata+0xb/0x10 mm/kmsan/kmsan.c:267
 __msan_memcpy+0x43/0x50 mm/kmsan/kmsan_instr.c:116
 raw_event_queue_add drivers/usb/gadget/legacy/raw_gadget.c:74 [inline]
 raw_queue_event+0x2b3/0x5c0 drivers/usb/gadget/legacy/raw_gadget.c:225
 gadget_setup+0x48c/0x530 drivers/usb/gadget/legacy/raw_gadget.c:343
 dummy_timer+0x2c4d/0x71c0 drivers/usb/gadget/udc/dummy_hcd.c:1899
 call_timer_fn+0x226/0x550 kernel/time/timer.c:1404
 expire_timers+0x4fc/0x780 kernel/time/timer.c:1449
 __run_timers+0xaf4/0xd30 kernel/time/timer.c:1773
 run_timer_softirq+0x2d/0x50 kernel/time/timer.c:1786
 __do_softirq+0x2ea/0x7f5 kernel/softirq.c:293

Uninit was stored to memory at:
 kmsan_save_stack_with_flags mm/kmsan/kmsan.c:144 [inline]
 kmsan_internal_chain_origin+0xad/0x130 mm/kmsan/kmsan.c:310
 __msan_chain_origin+0x50/0x90 mm/kmsan/kmsan_instr.c:165
 dummy_timer+0x1d82/0x71c0 drivers/usb/gadget/udc/dummy_hcd.c:1867
 call_timer_fn+0x226/0x550 kernel/time/timer.c:1404
 expire_timers+0x4fc/0x780 kernel/time/timer.c:1449
 __run_timers+0xaf4/0xd30 kernel/time/timer.c:1773
 run_timer_softirq+0x2d/0x50 kernel/time/timer.c:1786
 __do_softirq+0x2ea/0x7f5 kernel/softirq.c:293

Uninit was stored to memory at:
 kmsan_save_stack_with_flags mm/kmsan/kmsan.c:144 [inline]
 kmsan_internal_chain_origin+0xad/0x130 mm/kmsan/kmsan.c:310
 __msan_chain_origin+0x50/0x90 mm/kmsan/kmsan_instr.c:165
 usb_control_msg+0x5df/0x820 drivers/usb/core/message.c:149
 __usbnet_write_cmd drivers/net/usb/usbnet.c:2035 [inline]
 usbnet_write_cmd+0x3de/0x480 drivers/net/usb/usbnet.c:2073
 asix_write_cmd+0x18b/0x2c0 drivers/net/usb/asix_common.c:48
 ax88772_hw_reset+0x1bd/0xc30 drivers/net/usb/asix_devices.c:361
 ax88772_bind+0x8f3/0x1400 drivers/net/usb/asix_devices.c:730
 usbnet_probe+0x1152/0x3f90 drivers/net/usb/usbnet.c:1737
 usb_probe_interface+0xece/0x1550 drivers/usb/core/driver.c:374
 really_probe+0xf20/0x20b0 drivers/base/dd.c:529
 driver_probe_device+0x293/0x390 drivers/base/dd.c:701
 __device_attach_driver+0x63f/0x830 drivers/base/dd.c:807
 bus_for_each_drv+0x2ca/0x3f0 drivers/base/bus.c:431
 __device_attach+0x4e2/0x7f0 drivers/base/dd.c:873
 device_initial_probe+0x4a/0x60 drivers/base/dd.c:920
 bus_probe_device+0x177/0x3d0 drivers/base/bus.c:491
 device_add+0x3b0e/0x40d0 drivers/base/core.c:2680
 usb_set_configuration+0x380f/0x3f10 drivers/usb/core/message.c:2032
 usb_generic_driver_probe+0x138/0x300 drivers/usb/core/generic.c:241
 usb_probe_device+0x311/0x490 drivers/usb/core/driver.c:272
 really_probe+0xf20/0x20b0 drivers/base/dd.c:529
 driver_probe_device+0x293/0x390 drivers/base/dd.c:701
 __device_attach_driver+0x63f/0x830 drivers/base/dd.c:807
 bus_for_each_drv+0x2ca/0x3f0 drivers/base/bus.c:431
 __device_attach+0x4e2/0x7f0 drivers/base/dd.c:873
 device_initial_probe+0x4a/0x60 drivers/base/dd.c:920
 bus_probe_device+0x177/0x3d0 drivers/base/bus.c:491
 device_add+0x3b0e/0x40d0 drivers/base/core.c:2680
 usb_new_device+0x1bd4/0x2a30 drivers/usb/core/hub.c:2554
 hub_port_connect drivers/usb/core/hub.c:5208 [inline]
 hub_port_connect_change drivers/usb/core/hub.c:5348 [inline]
 port_event drivers/usb/core/hub.c:5494 [inline]
 hub_event+0x5e7b/0x8a70 drivers/usb/core/hub.c:5576
 process_one_work+0x1688/0x2140 kernel/workqueue.c:2269
 worker_thread+0x10bc/0x2730 kernel/workqueue.c:2415
 kthread+0x551/0x590 kernel/kthread.c:292
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:293

Uninit was stored to memory at:
 kmsan_save_stack_with_flags mm/kmsan/kmsan.c:144 [inline]
 kmsan_internal_chain_origin+0xad/0x130 mm/kmsan/kmsan.c:310
 __msan_chain_origin+0x50/0x90 mm/kmsan/kmsan_instr.c:165
 ax88772_bind+0x82e/0x1400 drivers/net/usb/asix_devices.c:720
 usbnet_probe+0x1152/0x3f90 drivers/net/usb/usbnet.c:1737
 usb_probe_interface+0xece/0x1550 drivers/usb/core/driver.c:374
 really_probe+0xf20/0x20b0 drivers/base/dd.c:529
 driver_probe_device+0x293/0x390 drivers/base/dd.c:701
 __device_attach_driver+0x63f/0x830 drivers/base/dd.c:807
 bus_for_each_drv+0x2ca/0x3f0 drivers/base/bus.c:431
 __device_attach+0x4e2/0x7f0 drivers/base/dd.c:873
 device_initial_probe+0x4a/0x60 drivers/base/dd.c:920
 bus_probe_device+0x177/0x3d0 drivers/base/bus.c:491
 device_add+0x3b0e/0x40d0 drivers/base/core.c:2680
 usb_set_configuration+0x380f/0x3f10 drivers/usb/core/message.c:2032
 usb_generic_driver_probe+0x138/0x300 drivers/usb/core/generic.c:241
 usb_probe_device+0x311/0x490 drivers/usb/core/driver.c:272
 really_probe+0xf20/0x20b0 drivers/base/dd.c:529
 driver_probe_device+0x293/0x390 drivers/base/dd.c:701
 __device_attach_driver+0x63f/0x830 drivers/base/dd.c:807
 bus_for_each_drv+0x2ca/0x3f0 drivers/base/bus.c:431
 __device_attach+0x4e2/0x7f0 drivers/base/dd.c:873
 device_initial_probe+0x4a/0x60 drivers/base/dd.c:920
 bus_probe_device+0x177/0x3d0 drivers/base/bus.c:491
 device_add+0x3b0e/0x40d0 drivers/base/core.c:2680
 usb_new_device+0x1bd4/0x2a30 drivers/usb/core/hub.c:2554
 hub_port_connect drivers/usb/core/hub.c:5208 [inline]
 hub_port_connect_change drivers/usb/core/hub.c:5348 [inline]
 port_event drivers/usb/core/hub.c:5494 [inline]
 hub_event+0x5e7b/0x8a70 drivers/usb/core/hub.c:5576
 process_one_work+0x1688/0x2140 kernel/workqueue.c:2269
 worker_thread+0x10bc/0x2730 kernel/workqueue.c:2415
 kthread+0x551/0x590 kernel/kthread.c:292
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:293

Local variable ----buf.i@asix_get_phy_addr created at:
 asix_read_cmd drivers/net/usb/asix_common.c:312 [inline]
 asix_read_phy_addr drivers/net/usb/asix_common.c:295 [inline]
 asix_get_phy_addr+0x4d/0x290 drivers/net/usb/asix_common.c:314
 asix_read_cmd drivers/net/usb/asix_common.c:312 [inline]
 asix_read_phy_addr drivers/net/usb/asix_common.c:295 [inline]
 asix_get_phy_addr+0x4d/0x290 drivers/net/usb/asix_common.c:314

Byte 10 of 16 is uninitialized
Memory access of size 16 starts at ffff88810839b4d0
Data copied to user address 00000000f55b60ac
=====================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
