Return-Path: <SRS0=AA2M=7E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_DIGITS,
	FROM_LOCAL_HEX,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C552C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 16:33:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 24CA220727
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 16:33:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730568AbgEVQdV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 May 2020 12:33:21 -0400
Received: from mail-io1-f71.google.com ([209.85.166.71]:48749 "EHLO
        mail-io1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730464AbgEVQdU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 May 2020 12:33:20 -0400
Received: by mail-io1-f71.google.com with SMTP id c15so7587606iom.15
        for <linux-kernel@vger.kernel.org>; Fri, 22 May 2020 09:33:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=L/tp6KRYPIrFpoc4+kQ4wqfjpED3EHEtDPL8QSIlP5U=;
        b=L/kq4Qx6ObV6GKSvpzPAXH+JnMJ1KcLmE9PTWVYL+hWiSYFCf0MkdAJBXPOvitN/b3
         K/axETsVgETMB/DSAdwnbeMus86NLD9jEYRBlW7On/ek/kEzFGIGHtT8bfD7nY6YZKcx
         sIPZGzj+u32oDzFcr9//i5lXE44AUNNOAKa1zjYYWkm1n/RNc+C0+878YAg6uIgLZYTz
         w7K4B1dyXVl2RUMBYCDria+XornhFSGMd/sr93Q4wxmNHgX6PYBCV2MLSLwrcPwxrSTT
         E1NBXWww7s59VMnGNxbSsJvPusoHhh2+Hh7oWpiy0df771EDVCfo8UDJOnMKBL3MLS7K
         Wnyw==
X-Gm-Message-State: AOAM532GBso4cMeT/7GHW5J3l9qVfUSxu2ihJNqQdGlwtAg+M+7DF2Zp
        WjQmok9Q7V9RBRwwfHKYR8nkWERC7lWT0fHADgd2fOPLJPPo
X-Google-Smtp-Source: ABdhPJzByk0/cxo5ZC5aOxNe54XhbafzONktXiefREhbe+/i6YP/dL2vMPN6iAo7VTT0vsYw9jvozLI/yJ+el8AyGthgwfrnDAQb
MIME-Version: 1.0
X-Received: by 2002:a92:c6c7:: with SMTP id v7mr11580078ilm.277.1590165197405;
 Fri, 22 May 2020 09:33:17 -0700 (PDT)
Date:   Fri, 22 May 2020 09:33:17 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b9c33505a63f2fea@google.com>
Subject: KASAN: slab-out-of-bounds Read in mark_lock
From:   syzbot <syzbot+31610284091be1bf04f4@syzkaller.appspotmail.com>
To:     andreyknvl@google.com, balbi@kernel.org,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        rafael@kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    d2f8825a Merge tag 'for_linus' of git://git.kernel.org/pub..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=132ed272100000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c33c7f7c5471fd39
dashboard link: https://syzkaller.appspot.com/bug?extid=31610284091be1bf04f4
compiler:       clang version 10.0.0 (https://github.com/llvm/llvm-project/ c2443155a0fb245c8f17f2c1c72b6ea391e86e81)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14797b81100000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11f86d6e100000

The bug was bisected to:

commit f2c2e717642c66f7fe7e5dd69b2e8ff5849f4d10
Author: Andrey Konovalov <andreyknvl@google.com>
Date:   Mon Feb 24 16:13:03 2020 +0000

    usb: gadget: add raw-gadget interface

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1277ece2100000
final crash:    https://syzkaller.appspot.com/x/report.txt?x=1177ece2100000
console output: https://syzkaller.appspot.com/x/log.txt?x=1677ece2100000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+31610284091be1bf04f4@syzkaller.appspotmail.com
Fixes: f2c2e717642c ("usb: gadget: add raw-gadget interface")

usb 1-1: New USB device strings: Mfr=1, Product=2, SerialNumber=3
usb 1-1: Product: syz
usb 1-1: Manufacturer: syz
usb 1-1: SerialNumber: syz
usb 1-1: config 0 descriptor??
==================================================================
BUG: KASAN: slab-out-of-bounds in hex_string+0x416/0x520 lib/vsprintf.c:1144
Read of size 1 at addr ffff8880a6c1301b by task kworker/1:8/4076

CPU: 1 PID: 4076 Comm: kworker/1:8 Not tainted 5.7.0-rc6-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Workqueue: usb_hub_wq hub_event
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x1e9/0x30e lib/dump_stack.c:118
 print_address_description+0x74/0x5c0 mm/kasan/report.c:382
 printk+0x62/0x83 kernel/printk/printk.c:2081
 __kasan_report+0x103/0x1a0 mm/kasan/report.c:511
 hex_string+0x416/0x520 lib/vsprintf.c:1144
 test_bit include/asm-generic/bitops/instrumented-non-atomic.h:110 [inline]
 hlock_class kernel/locking/lockdep.c:179 [inline]
 mark_lock+0x102/0x1b00 kernel/locking/lockdep.c:3912
 hex_string+0x416/0x520 lib/vsprintf.c:1144
 kasan_report+0x4d/0x80 mm/kasan/common.c:625
 test_bit include/asm-generic/bitops/instrumented-non-atomic.h:110 [inline]
 hlock_class kernel/locking/lockdep.c:179 [inline]
 mark_lock+0x102/0x1b00 kernel/locking/lockdep.c:3912
 hex_string+0x416/0x520 lib/vsprintf.c:1144
 pointer+0x539/0x970 lib/vsprintf.c:2204
 vsnprintf+0xbf4/0x1aa0 lib/vsprintf.c:2597
 va_format lib/vsprintf.c:1659 [inline]
 pointer+0x12d/0x970 lib/vsprintf.c:2232
 vsnprintf+0xbf4/0x1aa0 lib/vsprintf.c:2597
 vscnprintf+0x29/0x80 lib/vsprintf.c:2696
 vprintk_store+0x4b/0x680 kernel/printk/printk.c:1942
 vprintk_emit+0x128/0x3c0 kernel/printk/printk.c:2003
 dev_vprintk_emit+0x494/0x512 drivers/base/core.c:3774
 __raw_spin_unlock_irqrestore include/linux/spinlock_api_smp.h:161 [inline]
 _raw_spin_unlock_irqrestore+0xb4/0xd0 kernel/locking/spinlock.c:191
 __debug_check_no_obj_freed lib/debugobjects.c:977 [inline]
 debug_check_no_obj_freed+0x592/0x640 lib/debugobjects.c:998
 mark_held_locks kernel/locking/lockdep.c:3628 [inline]
 __trace_hardirqs_on_caller kernel/locking/lockdep.c:3657 [inline]
 lockdep_hardirqs_on+0x4a4/0x8a0 kernel/locking/lockdep.c:3702
 dev_printk_emit+0x6a/0x8c drivers/base/core.c:3785
 usb_control_msg+0x2f3/0x420 drivers/usb/core/message.c:159
 _dev_info+0xb9/0xdb drivers/base/core.c:3843
 dlfb_parse_vendor_descriptor drivers/video/fbdev/udlfb.c:1588 [inline]
 dlfb_usb_probe+0x3ee/0x2080 drivers/video/fbdev/udlfb.c:1672
 dlfb_parse_vendor_descriptor drivers/video/fbdev/udlfb.c:1589 [inline]
 dlfb_usb_probe+0x443/0x2080 drivers/video/fbdev/udlfb.c:1672
 __raw_spin_unlock_irqrestore include/linux/spinlock_api_smp.h:160 [inline]
 _raw_spin_unlock_irqrestore+0x6f/0xd0 kernel/locking/spinlock.c:191
 __raw_spin_unlock_irqrestore include/linux/spinlock_api_smp.h:161 [inline]
 _raw_spin_unlock_irqrestore+0xb4/0xd0 kernel/locking/spinlock.c:191
 __pm_runtime_set_status+0x89e/0xb50 drivers/base/power/runtime.c:1251
 usb_probe_interface+0x614/0xac0 drivers/usb/core/driver.c:374
 really_probe+0x761/0xf60 drivers/base/dd.c:524
 driver_probe_device+0xe6/0x230 drivers/base/dd.c:697
 coredump_store+0x90/0x90 drivers/base/dd.c:373
 bus_for_each_drv+0x108/0x170 drivers/base/bus.c:431
 __device_attach+0x20c/0x3a0 drivers/base/dd.c:870
 bus_probe_device+0xb8/0x1f0 drivers/base/bus.c:491
 device_add+0x14a4/0x1ba0 drivers/base/core.c:2529
 device_add+0x1828/0x1ba0 drivers/base/core.c:2538
 usb_set_configuration+0x19d2/0x1f20 drivers/usb/core/message.c:2032
 usb_generic_driver_probe+0x82/0x140 drivers/usb/core/generic.c:241
 usb_probe_device+0x12d/0x1d0 drivers/usb/core/driver.c:272
 really_probe+0x761/0xf60 drivers/base/dd.c:524
 driver_probe_device+0xe6/0x230 drivers/base/dd.c:697
 coredump_store+0x90/0x90 drivers/base/dd.c:373
 bus_for_each_drv+0x108/0x170 drivers/base/bus.c:431
 __device_attach+0x20c/0x3a0 drivers/base/dd.c:870
 bus_probe_device+0xb8/0x1f0 drivers/base/bus.c:491
 device_add+0x14a4/0x1ba0 drivers/base/core.c:2529
 device_add+0x1828/0x1ba0 drivers/base/core.c:2538
 usb_new_device+0xcc3/0x1650 drivers/usb/core/hub.c:2554
 hub_port_connect drivers/usb/core/hub.c:5208 [inline]
 hub_port_connect_change drivers/usb/core/hub.c:5348 [inline]
 port_event drivers/usb/core/hub.c:5494 [inline]
 hub_event+0x2823/0x4cb0 drivers/usb/core/hub.c:5576
 lock_is_held include/linux/lockdep.h:406 [inline]
 rcu_read_lock_sched_held+0x106/0x170 kernel/rcu/update.c:121
 process_one_work+0x76e/0xfd0 kernel/workqueue.c:2268
 worker_thread+0xa7f/0x1450 kernel/workqueue.c:2414
 kthread+0x353/0x380 kernel/kthread.c:268
 rcu_lock_release+0x20/0x20 include/linux/rcupdate.h:213
 kthread_blkcg+0xd0/0xd0 kernel/kthread.c:1247
 ret_from_fork+0x24/0x30 arch/x86/entry/entry_64.S:351

Allocated by task 4076:
 save_stack mm/kasan/common.c:49 [inline]
 set_track mm/kasan/common.c:57 [inline]
 __kasan_kmalloc+0x114/0x160 mm/kasan/common.c:495
 __do_kmalloc mm/slab.c:3656 [inline]
 __kmalloc+0x24b/0x330 mm/slab.c:3665
 kmalloc include/linux/slab.h:560 [inline]
 usb_get_configuration+0x2d7/0x48e0 drivers/usb/core/config.c:919
 usb_enumerate_device drivers/usb/core/hub.c:2387 [inline]
 usb_new_device+0xf4/0x1650 drivers/usb/core/hub.c:2523
 hub_port_connect drivers/usb/core/hub.c:5208 [inline]
 hub_port_connect_change drivers/usb/core/hub.c:5348 [inline]
 port_event drivers/usb/core/hub.c:5494 [inline]
 hub_event+0x2823/0x4cb0 drivers/usb/core/hub.c:5576
 process_one_work+0x76e/0xfd0 kernel/workqueue.c:2268
 worker_thread+0xa7f/0x1450 kernel/workqueue.c:2414
 kthread+0x353/0x380 kernel/kthread.c:268
 ret_from_fork+0x24/0x30 arch/x86/entry/entry_64.S:351

Freed by task 5147:
 save_stack mm/kasan/common.c:49 [inline]
 set_track mm/kasan/common.c:57 [inline]
 kasan_set_free_info mm/kasan/common.c:317 [inline]
 __kasan_slab_free+0x125/0x190 mm/kasan/common.c:456
 __cache_free mm/slab.c:3426 [inline]
 kfree+0x10a/0x220 mm/slab.c:3757
 tomoyo_check_open_permission+0x6e2/0x900 security/tomoyo/file.c:786
 security_file_open+0x50/0xc0 security/security.c:1548
 do_dentry_open+0x35d/0x10b0 fs/open.c:784
 do_open fs/namei.c:3229 [inline]
 path_openat+0x2790/0x38b0 fs/namei.c:3346
 do_filp_open+0x191/0x3a0 fs/namei.c:3373
 do_sys_openat2+0x463/0x770 fs/open.c:1148
 do_sys_open fs/open.c:1164 [inline]
 ksys_open include/linux/syscalls.h:1386 [inline]
 __do_sys_open fs/open.c:1170 [inline]
 __se_sys_open fs/open.c:1168 [inline]
 __x64_sys_open+0x1af/0x1e0 fs/open.c:1168
 do_syscall_64+0xf3/0x1b0 arch/x86/entry/common.c:295
 entry_SYSCALL_64_after_hwframe+0x49/0xb3

The buggy address belongs to the object at ffff8880a6c13000
 which belongs to the cache kmalloc-32 of size 32
The buggy address is located 27 bytes inside of
 32-byte region [ffff8880a6c13000, ffff8880a6c13020)
The buggy address belongs to the page:
page:ffffea00029b04c0 refcount:1 mapcount:0 mapping:0000000000000000 index:0xffff8880a6c13fc1
flags: 0xfffe0000000200(slab)
raw: 00fffe0000000200 ffffea00025f7e88 ffffea0002a6ff48 ffff8880aa4001c0
raw: ffff8880a6c13fc1 ffff8880a6c13000 000000010000003e 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
 ffff8880a6c12f00: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
 ffff8880a6c12f80: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
>ffff8880a6c13000: 00 00 00 03 fc fc fc fc 00 00 01 fc fc fc fc fc
                            ^
 ffff8880a6c13080: fb fb fb fb fc fc fc fc 00 00 01 fc fc fc fc fc
 ffff8880a6c13100: 00 00 01 fc fc fc fc fc 00 00 01 fc fc fc fc fc
==================================================================


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
