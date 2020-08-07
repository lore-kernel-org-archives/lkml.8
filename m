Return-Path: <SRS0=KWFo=BR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFB4EC433E0
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 07:07:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 76AC420866
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 07:07:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726579AbgHGHHW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Aug 2020 03:07:22 -0400
Received: from mail-io1-f72.google.com ([209.85.166.72]:45077 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726350AbgHGHHS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Aug 2020 03:07:18 -0400
Received: by mail-io1-f72.google.com with SMTP id q5so954546ion.12
        for <linux-kernel@vger.kernel.org>; Fri, 07 Aug 2020 00:07:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=29COMVJJ9zWLyYRwO7E5QPM3HQ4152TI677F1dd/mMI=;
        b=NsaPV7iRa03Hu2+AXDP6QAtWuDHOr0f3U2qp/11GBRpu88ElMh12+v6QdQmRm4oUzO
         koiyqRoMGpGwnTl2JxGo6bqjuJwSlqPCVGyS51OsVOBX7Z+7ruw5tCdBr23+dNmMIYMN
         OU2G6UfROpuLCPEcDYH0VrGt4+dwxaxUmdySGbolRxOUo4tXqMGIyRoNsco9xcN4tLIf
         Bb3cKrFE3ldjJAEh49kMToooF20iw5ep7EeomgY0L4rGPMTUaRozmYg1nYl/KaNRSykK
         g3it8t/dbPSfTl7OHWHykS1I9fbXdKm+bJwb0tOdt2eOY0jBghb8dfRRT1BOuWyQF6Bf
         nzaA==
X-Gm-Message-State: AOAM533c6wvzx/WHdR/9gHITiRUgxl1LMmajuzybiPLniHHOjWa/Urnb
        oR05m21qTL18+FZr4HbURumwBv4ZwO1BTE2C8VsJYEL1ir0f
X-Google-Smtp-Source: ABdhPJxWSjDRQG78oxLIu4fKqxSaOKRwTDfdxu60Q5pR6Wa2B0z8ipLGZEskB8Jeaz88bOqT4/LwZQjZeuF0LrJcMA9PPBajFcLk
MIME-Version: 1.0
X-Received: by 2002:a05:6602:58:: with SMTP id z24mr3208509ioz.76.1596784036687;
 Fri, 07 Aug 2020 00:07:16 -0700 (PDT)
Date:   Fri, 07 Aug 2020 00:07:16 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000004a381905ac444162@google.com>
Subject: KASAN: use-after-free Read in __usb_hcd_giveback_urb
From:   syzbot <syzbot+bb9cb5f2cd814f87212a@syzkaller.appspotmail.com>
To:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, m.szyprowski@samsung.com,
        noring@nocrew.org, syzkaller-bugs@googlegroups.com,
        tweek@google.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    fffe3ae0 Merge tag 'for-linus-hmm' of git://git.kernel.org..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=12b22fda900000
kernel config:  https://syzkaller.appspot.com/x/.config?x=226c7a97d80bec54
dashboard link: https://syzkaller.appspot.com/bug?extid=bb9cb5f2cd814f87212a
compiler:       clang version 10.0.0 (https://github.com/llvm/llvm-project/ c2443155a0fb245c8f17f2c1c72b6ea391e86e81)

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+bb9cb5f2cd814f87212a@syzkaller.appspotmail.com

xpad 3-1:0.65: xpad_irq_in - usb_submit_urb failed with result -19
xpad 3-1:0.65: xpad_irq_out - usb_submit_urb failed with result -19
==================================================================
BUG: KASAN: use-after-free in register_lock_class+0x12a8/0x1520 kernel/locking/lockdep.c:1250
Read of size 2 at addr ffff8880a1f5c092 by task systemd-udevd/1571

CPU: 0 PID: 1571 Comm: systemd-udevd Not tainted 5.8.0-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 <IRQ>
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x1f0/0x31e lib/dump_stack.c:118
 print_address_description+0x66/0x5a0 mm/kasan/report.c:383
 __kasan_report mm/kasan/report.c:513 [inline]
 kasan_report+0x132/0x1d0 mm/kasan/report.c:530
 register_lock_class+0x12a8/0x1520 kernel/locking/lockdep.c:1250
 __lock_acquire+0xfa/0x2ab0 kernel/locking/lockdep.c:4305
 lock_acquire+0x160/0x730 kernel/locking/lockdep.c:5005
 __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
 _raw_spin_lock_irqsave+0x9e/0xc0 kernel/locking/spinlock.c:159
 __wake_up_common_lock kernel/sched/wait.c:122 [inline]
 __wake_up+0xb8/0x150 kernel/sched/wait.c:142
 __usb_hcd_giveback_urb+0x340/0x4b0 drivers/usb/core/hcd.c:1653
 dummy_timer+0x71b/0x3e10 drivers/usb/gadget/udc/dummy_hcd.c:1967
 call_timer_fn+0x91/0x160 kernel/time/timer.c:1413
 expire_timers kernel/time/timer.c:1458 [inline]
 __run_timers+0x65e/0x830 kernel/time/timer.c:1755
 run_timer_softirq+0x46/0x80 kernel/time/timer.c:1768
 __do_softirq+0x236/0x66c kernel/softirq.c:298
 asm_call_on_stack+0xf/0x20 arch/x86/entry/entry_64.S:706
 </IRQ>
 __run_on_irqstack arch/x86/include/asm/irq_stack.h:22 [inline]
 run_on_irqstack_cond arch/x86/include/asm/irq_stack.h:48 [inline]
 do_softirq_own_stack+0x91/0xe0 arch/x86/kernel/irq_64.c:77
 invoke_softirq kernel/softirq.c:393 [inline]
 __irq_exit_rcu+0x1e1/0x1f0 kernel/softirq.c:423
 irq_exit_rcu+0x5/0x10 kernel/softirq.c:435
 sysvec_apic_timer_interrupt+0xd5/0xf0 arch/x86/kernel/apic/apic.c:1091
 asm_sysvec_apic_timer_interrupt+0x12/0x20 arch/x86/include/asm/idtentry.h:581
RIP: 0010:do_inode_permission fs/namei.c:396 [inline]
RIP: 0010:inode_permission+0x53/0x4a0 fs/namei.c:463
Code: 00 00 00 00 fc ff df 83 e3 02 48 89 1c 24 0f 85 b4 00 00 00 e8 7e 87 b4 ff 4d 8d 7e 02 4c 89 fb 48 c1 eb 03 49 89 ed 8a 04 2b <84> c0 0f 85 23 03 00 00 41 0f b7 2f 83 e5 01 31 ff 89 ee e8 c5 8a
RSP: 0018:ffffc90017927c20 EFLAGS: 00000a06
RAX: ffffffff81c05000 RBX: 1ffff110145e86b8 RCX: ffff88801bc50380
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: dffffc0000000000 R08: ffffffff81c05013 R09: fffff52002f24fb6
R10: fffff52002f24fb6 R11: 0000000000000000 R12: 0000000000000001
R13: dffffc0000000000 R14: ffff8880a2f435c0 R15: ffff8880a2f435c2
 may_lookup fs/namei.c:1575 [inline]
 link_path_walk+0x20e/0xba0 fs/namei.c:2125
 path_lookupat+0xab/0x960 fs/namei.c:2332
 filename_lookup+0x1ab/0x5d0 fs/namei.c:2366
 user_path_at include/linux/namei.h:59 [inline]
 do_faccessat+0x3a0/0x870 fs/open.c:423
 do_syscall_64+0x31/0x70 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x7f25ea32d9c7
Code: 83 c4 08 48 3d 01 f0 ff ff 73 01 c3 48 8b 0d c8 d4 2b 00 f7 d8 64 89 01 48 83 c8 ff c3 66 0f 1f 44 00 00 b8 15 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d a1 d4 2b 00 f7 d8 64 89 01 48
RSP: 002b:00007ffc5e5cb2f8 EFLAGS: 00000246 ORIG_RAX: 0000000000000015
RAX: ffffffffffffffda RBX: 0000558966534980 RCX: 00007f25ea32d9c7
RDX: 00746e657665752f RSI: 0000000000000000 RDI: 00007ffc5e5cb300
RBP: 00007ffc5e5cb370 R08: 0000000000000122 R09: 0000000000001010
R10: 00007f25ea5ebb58 R11: 0000000000000246 R12: 0000558965bff856
R13: 000055896653ac10 R14: 00007ffc5e5cb300 R15: 000055896653a268

Allocated by task 472:
 save_stack mm/kasan/common.c:48 [inline]
 set_track mm/kasan/common.c:56 [inline]
 __kasan_kmalloc+0x103/0x140 mm/kasan/common.c:494
 kmem_cache_alloc_trace+0x234/0x300 mm/slab.c:3551
 kmalloc include/linux/slab.h:555 [inline]
 kzalloc include/linux/slab.h:669 [inline]
 xpad_probe+0x389/0x1a10 drivers/input/joystick/xpad.c:1729
 usb_probe_interface+0x614/0xac0 drivers/usb/core/driver.c:374
 really_probe+0x753/0x1110 drivers/base/dd.c:557
 driver_probe_device+0x106/0x1a0 drivers/base/dd.c:738
 bus_for_each_drv+0x108/0x170 drivers/base/bus.c:431
 __device_attach+0x262/0x3f0 drivers/base/dd.c:912
 bus_probe_device+0xb8/0x1f0 drivers/base/bus.c:491
 device_add+0x1630/0x19b0 drivers/base/core.c:2930
 usb_set_configuration+0x19d2/0x1f20 drivers/usb/core/message.c:2032
 usb_generic_driver_probe+0x82/0x140 drivers/usb/core/generic.c:239
 usb_probe_device+0x12d/0x1d0 drivers/usb/core/driver.c:272
 really_probe+0x753/0x1110 drivers/base/dd.c:557
 driver_probe_device+0x106/0x1a0 drivers/base/dd.c:738
 bus_for_each_drv+0x108/0x170 drivers/base/bus.c:431
 __device_attach+0x262/0x3f0 drivers/base/dd.c:912
 bus_probe_device+0xb8/0x1f0 drivers/base/bus.c:491
 device_add+0x1630/0x19b0 drivers/base/core.c:2930
 usb_new_device+0xcc3/0x1650 drivers/usb/core/hub.c:2554
 hub_port_connect drivers/usb/core/hub.c:5208 [inline]
 hub_port_connect_change drivers/usb/core/hub.c:5348 [inline]
 port_event drivers/usb/core/hub.c:5494 [inline]
 hub_event+0x2823/0x4cb0 drivers/usb/core/hub.c:5576
 process_one_work+0x789/0xfc0 kernel/workqueue.c:2269
 worker_thread+0xaa4/0x1460 kernel/workqueue.c:2415
 kthread+0x37e/0x3a0 drivers/block/aoe/aoecmd.c:1234
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:294

Freed by task 22084:
 save_stack mm/kasan/common.c:48 [inline]
 set_track mm/kasan/common.c:56 [inline]
 kasan_set_free_info mm/kasan/common.c:316 [inline]
 __kasan_slab_free+0x114/0x170 mm/kasan/common.c:455
 __cache_free mm/slab.c:3426 [inline]
 kfree+0x10a/0x220 mm/slab.c:3757
 xpad_disconnect+0x2ec/0x3f0 drivers/input/joystick/xpad.c:1877
 usb_unbind_interface+0x1d2/0x840 drivers/usb/core/driver.c:436
 __device_release_driver drivers/base/dd.c:1153 [inline]
 device_release_driver_internal+0x516/0x7b0 drivers/base/dd.c:1184
 bus_remove_device+0x2eb/0x360 drivers/base/bus.c:533
 device_del+0x7b9/0x1280 drivers/base/core.c:3107
 usb_disable_device+0x3ee/0xc80 drivers/usb/core/message.c:1245
 usb_disconnect+0x346/0x880 drivers/usb/core/hub.c:2217
 hub_port_connect drivers/usb/core/hub.c:5059 [inline]
 hub_port_connect_change drivers/usb/core/hub.c:5348 [inline]
 port_event drivers/usb/core/hub.c:5494 [inline]
 hub_event+0x1c18/0x4cb0 drivers/usb/core/hub.c:5576
 process_one_work+0x789/0xfc0 kernel/workqueue.c:2269
 worker_thread+0xaa4/0x1460 kernel/workqueue.c:2415
 kthread+0x37e/0x3a0 drivers/block/aoe/aoecmd.c:1234
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:294

The buggy address belongs to the object at ffff8880a1f5c000
 which belongs to the cache kmalloc-1k of size 1024
The buggy address is located 146 bytes inside of
 1024-byte region [ffff8880a1f5c000, ffff8880a1f5c400)
The buggy address belongs to the page:
page:ffffea000287d700 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0
flags: 0xfffe0000000200(slab)
raw: 00fffe0000000200 ffffea0002448208 ffffea000260c7c8 ffff8880aa400c40
raw: 0000000000000000 ffff8880a1f5c000 0000000100000002 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
 ffff8880a1f5bf80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff8880a1f5c000: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff8880a1f5c080: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                         ^
 ffff8880a1f5c100: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff8880a1f5c180: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
