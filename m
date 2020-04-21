Return-Path: <SRS0=8uoY=6F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7588AC54FD0
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 15:35:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 540F52070B
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 15:35:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726245AbgDUPfW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Apr 2020 11:35:22 -0400
Received: from mail-io1-f69.google.com ([209.85.166.69]:57216 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725902AbgDUPfT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 11:35:19 -0400
Received: by mail-io1-f69.google.com with SMTP id v3so16778987iod.23
        for <linux-kernel@vger.kernel.org>; Tue, 21 Apr 2020 08:35:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=uDoabOnDihDzePs5cq8ckk24k7w3tGEgwv1V/VPbKlI=;
        b=fPfbwbETup3UeKD8o3+BgvcglFw45hX/COxzpxW3DqkbKR0fo8lFhbSHXK5irofu30
         iGd8xg/ZXnoi0zL5XowqUftvEze33tQQILqeZb8edC4bNtRMe3agYtjVKSb94yL6Qc9v
         SqMAQwcaphxwQOb6ERjSFzLi6w7mdS+oyDrMbIDmI91jstxQX0nmSAhYcczbKBOykV1r
         EKVjFhKryHYwv0RzI+Jd3O+rLY0aDqfeIGPrKtGENKJ4KlpwWiMmLdaC8O9fp/Tjzk/9
         GP7LlxE6gPuYl5NEBfsZSLpHuPXBh2+2K1hADR8oHh3/T+BKKsmzldUvTvcEl6nbkU+7
         f9tw==
X-Gm-Message-State: AGi0PuZEs9nEH4txZhpNCYIbu4WX/BcAbhAeGFfc7u5kbA/7BaDpP8nE
        pqOiP5KU+RUG9a7kwBUYKqWq5rVOz2w3FJ5RiND54wxYIiMq
X-Google-Smtp-Source: APiQypKZP0IAt1uO6cFzXI+o1BCMS7PP9IlVG2Q5+++Gi/b5Zokp0aIOu38U10+4yn0SjYzglA/2bF9RxYVxBlAynPzL4Gpyjbf7
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:e03:: with SMTP id a3mr15673301ilk.239.1587483318307;
 Tue, 21 Apr 2020 08:35:18 -0700 (PDT)
Date:   Tue, 21 Apr 2020 08:35:18 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000046503905a3cec366@google.com>
Subject: KASAN: use-after-free Read in usblp_bulk_read
From:   syzbot <syzbot+be5b5f86a162a6c281e6@syzkaller.appspotmail.com>
To:     andreyknvl@google.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, zaitcev@redhat.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    0fa84af8 Merge tag 'usb-serial-5.7-rc1' of https://git.ker..
git tree:       https://github.com/google/kasan.git usb-fuzzer
console output: https://syzkaller.appspot.com/x/log.txt?x=126f75d7e00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6b9c154b0c23aecf
dashboard link: https://syzkaller.appspot.com/bug?extid=be5b5f86a162a6c281e6
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+be5b5f86a162a6c281e6@syzkaller.appspotmail.com

usblp0: nonzero read bulk status received: -71
==================================================================
BUG: KASAN: use-after-free in __lock_acquire+0x31af/0x3b60 kernel/locking/lockdep.c:3827
Read of size 8 at addr ffff8881c4563920 by task systemd-udevd/154

CPU: 0 PID: 154 Comm: systemd-udevd Not tainted 5.6.0-rc7-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 <IRQ>
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0xef/0x16e lib/dump_stack.c:118
 print_address_description.constprop.0.cold+0xd3/0x314 mm/kasan/report.c:374
 __kasan_report.cold+0x37/0x77 mm/kasan/report.c:506
 kasan_report+0xe/0x20 mm/kasan/common.c:641
 __lock_acquire+0x31af/0x3b60 kernel/locking/lockdep.c:3827
 lock_acquire+0x130/0x340 kernel/locking/lockdep.c:4484
 __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
 _raw_spin_lock_irqsave+0x32/0x50 kernel/locking/spinlock.c:159
 usblp_bulk_read+0x211/0x270 drivers/usb/class/usblp.c:303
 __usb_hcd_giveback_urb+0x1f2/0x470 drivers/usb/core/hcd.c:1648
 usb_hcd_giveback_urb+0x368/0x420 drivers/usb/core/hcd.c:1713
 dummy_timer+0x1258/0x32ae drivers/usb/gadget/udc/dummy_hcd.c:1966
 call_timer_fn+0x195/0x6f0 kernel/time/timer.c:1404
 expire_timers kernel/time/timer.c:1449 [inline]
 __run_timers kernel/time/timer.c:1773 [inline]
 __run_timers kernel/time/timer.c:1740 [inline]
 run_timer_softirq+0x5f9/0x1500 kernel/time/timer.c:1786
 __do_softirq+0x21e/0x950 kernel/softirq.c:292
 invoke_softirq kernel/softirq.c:373 [inline]
 irq_exit+0x178/0x1a0 kernel/softirq.c:413
 exiting_irq arch/x86/include/asm/apic.h:546 [inline]
 smp_apic_timer_interrupt+0x141/0x540 arch/x86/kernel/apic/apic.c:1146
 apic_timer_interrupt+0xf/0x20 arch/x86/entry/entry_64.S:829
 </IRQ>
RIP: 0010:unwind_next_frame+0x160/0x19e0 arch/x86/kernel/unwind_orc.c:407
Code: 88 00 00 00 03 0f 85 07 05 00 00 4c 8d 63 35 48 b8 00 00 00 00 00 fc ff df 4c 89 e2 48 c1 ea 03 0f b6 04 02 4c 89 e2 83 e2 07 <38> d0 7f 08 84 c0 0f 85 6f 0b 00 00 4c 89 f1 0f b6 43 35 48 ba 00
RSP: 0018:ffff8881cf93f598 EFLAGS: 00000206 ORIG_RAX: ffffffffffffff13
RAX: 0000000000000000 RBX: ffff8881cf93f670 RCX: 0000000000000001
RDX: 0000000000000005 RSI: 0000000000000000 RDI: ffff8881cf93f670
RBP: 1ffff11039f27ebb R08: 0000000000000001 R09: 0000000000000001
R10: 000000000001af58 R11: 0000000000000001 R12: ffff8881cf93f6a5
R13: ffff8881cf93f6c0 R14: ffff8881cf93f6b8 R15: 0000000000000001
 arch_stack_walk+0x74/0xd0 arch/x86/kernel/stacktrace.c:25
 stack_trace_save+0x8c/0xc0 kernel/stacktrace.c:123
 save_stack+0x1b/0x80 mm/kasan/common.c:72
 set_track mm/kasan/common.c:80 [inline]
 __kasan_kmalloc mm/kasan/common.c:515 [inline]
 __kasan_kmalloc.constprop.0+0xbf/0xd0 mm/kasan/common.c:488
 slab_post_alloc_hook mm/slab.h:584 [inline]
 slab_alloc_node mm/slub.c:2786 [inline]
 slab_alloc mm/slub.c:2794 [inline]
 kmem_cache_alloc+0xd8/0x300 mm/slub.c:2799
 anon_vma_alloc mm/rmap.c:83 [inline]
 anon_vma_fork+0xed/0x490 mm/rmap.c:361
 dup_mmap kernel/fork.c:559 [inline]
 dup_mm+0x8e6/0x1180 kernel/fork.c:1360
 copy_mm kernel/fork.c:1416 [inline]
 copy_process+0x26ef/0x6640 kernel/fork.c:2081
 _do_fork+0x12d/0xfd0 kernel/fork.c:2430
 __do_sys_clone kernel/fork.c:2585 [inline]
 __se_sys_clone kernel/fork.c:2566 [inline]
 __x64_sys_clone+0x182/0x210 kernel/fork.c:2566
 do_syscall_64+0xb6/0x5a0 arch/x86/entry/common.c:294
 entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x7fb33d81138b
Code: db 45 85 f6 0f 85 95 01 00 00 64 4c 8b 04 25 10 00 00 00 31 d2 4d 8d 90 d0 02 00 00 31 f6 bf 11 00 20 01 b8 38 00 00 00 0f 05 <48> 3d 00 f0 ff ff 0f 87 de 00 00 00 85 c0 41 89 c5 0f 85 e5 00 00
RSP: 002b:00007ffcdbdc01b0 EFLAGS: 00000246 ORIG_RAX: 0000000000000038
RAX: ffffffffffffffda RBX: 00007ffcdbdc01b0 RCX: 00007fb33d81138b
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000001200011
RBP: 00007ffcdbdc0200 R08: 00007fb33e9c18c0 R09: 0000000000000210
R10: 00007fb33e9c1b90 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000020 R14: 0000000000000000 R15: 0000000000000000

Allocated by task 3361:
 save_stack+0x1b/0x80 mm/kasan/common.c:72
 set_track mm/kasan/common.c:80 [inline]
 __kasan_kmalloc mm/kasan/common.c:515 [inline]
 __kasan_kmalloc.constprop.0+0xbf/0xd0 mm/kasan/common.c:488
 kmalloc include/linux/slab.h:555 [inline]
 kzalloc include/linux/slab.h:669 [inline]
 usblp_probe+0xed/0x1200 drivers/usb/class/usblp.c:1104
 usb_probe_interface+0x310/0x800 drivers/usb/core/driver.c:374
 really_probe+0x290/0xac0 drivers/base/dd.c:551
 driver_probe_device+0x223/0x350 drivers/base/dd.c:724
 __device_attach_driver+0x1d1/0x290 drivers/base/dd.c:831
 bus_for_each_drv+0x162/0x1e0 drivers/base/bus.c:431
 __device_attach+0x217/0x390 drivers/base/dd.c:897
 bus_probe_device+0x1e4/0x290 drivers/base/bus.c:491
 device_add+0x1459/0x1bf0 drivers/base/core.c:2500
 usb_set_configuration+0xece/0x1840 drivers/usb/core/message.c:2025
 usb_generic_driver_probe+0x9d/0xe0 drivers/usb/core/generic.c:241
 usb_probe_device+0xd9/0x230 drivers/usb/core/driver.c:272
 really_probe+0x290/0xac0 drivers/base/dd.c:551
 driver_probe_device+0x223/0x350 drivers/base/dd.c:724
 __device_attach_driver+0x1d1/0x290 drivers/base/dd.c:831
 bus_for_each_drv+0x162/0x1e0 drivers/base/bus.c:431
 __device_attach+0x217/0x390 drivers/base/dd.c:897
 bus_probe_device+0x1e4/0x290 drivers/base/bus.c:491
 device_add+0x1459/0x1bf0 drivers/base/core.c:2500
 usb_new_device.cold+0x540/0xcd0 drivers/usb/core/hub.c:2548
 hub_port_connect drivers/usb/core/hub.c:5195 [inline]
 hub_port_connect_change drivers/usb/core/hub.c:5335 [inline]
 port_event drivers/usb/core/hub.c:5481 [inline]
 hub_event+0x21cb/0x4300 drivers/usb/core/hub.c:5563
 process_one_work+0x94b/0x1620 kernel/workqueue.c:2266
 worker_thread+0x96/0xe20 kernel/workqueue.c:2412
 kthread+0x318/0x420 kernel/kthread.c:255
 ret_from_fork+0x24/0x30 arch/x86/entry/entry_64.S:352

Freed by task 12266:
 save_stack+0x1b/0x80 mm/kasan/common.c:72
 set_track mm/kasan/common.c:80 [inline]
 kasan_set_free_info mm/kasan/common.c:337 [inline]
 __kasan_slab_free+0x117/0x160 mm/kasan/common.c:476
 slab_free_hook mm/slub.c:1444 [inline]
 slab_free_freelist_hook mm/slub.c:1477 [inline]
 slab_free mm/slub.c:3034 [inline]
 kfree+0xd5/0x300 mm/slub.c:3995
 usblp_disconnect.cold+0x24/0x29 drivers/usb/class/usblp.c:1380
 usb_unbind_interface+0x1bd/0x8a0 drivers/usb/core/driver.c:436
 __device_release_driver drivers/base/dd.c:1137 [inline]
 device_release_driver_internal+0x42f/0x500 drivers/base/dd.c:1168
 bus_remove_device+0x2eb/0x5a0 drivers/base/bus.c:533
 device_del+0x481/0xd30 drivers/base/core.c:2677
 usb_disable_device+0x23d/0x790 drivers/usb/core/message.c:1238
 usb_disconnect+0x293/0x900 drivers/usb/core/hub.c:2211
 hub_port_connect drivers/usb/core/hub.c:5046 [inline]
 hub_port_connect_change drivers/usb/core/hub.c:5335 [inline]
 port_event drivers/usb/core/hub.c:5481 [inline]
 hub_event+0x1a1d/0x4300 drivers/usb/core/hub.c:5563
 process_one_work+0x94b/0x1620 kernel/workqueue.c:2266
 worker_thread+0x96/0xe20 kernel/workqueue.c:2412
 kthread+0x318/0x420 kernel/kthread.c:255
 ret_from_fork+0x24/0x30 arch/x86/entry/entry_64.S:352

The buggy address belongs to the object at ffff8881c4563800
 which belongs to the cache kmalloc-1k of size 1024
The buggy address is located 288 bytes inside of
 1024-byte region [ffff8881c4563800, ffff8881c4563c00)
The buggy address belongs to the page:
page:ffffea0007115800 refcount:1 mapcount:0 mapping:ffff8881da002280 index:0x0 compound_mapcount: 0
flags: 0x200000000010200(slab|head)
raw: 0200000000010200 ffffea00074d3000 0000000400000004 ffff8881da002280
raw: 0000000000000000 0000000000100010 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
 ffff8881c4563800: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff8881c4563880: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff8881c4563900: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                               ^
 ffff8881c4563980: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff8881c4563a00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
