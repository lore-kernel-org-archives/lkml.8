Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60247C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 11:32:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 40CB52067C
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 11:32:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728593AbgHQLc2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 07:32:28 -0400
Received: from mail-il1-f198.google.com ([209.85.166.198]:34368 "EHLO
        mail-il1-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728582AbgHQLcQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 07:32:16 -0400
Received: by mail-il1-f198.google.com with SMTP id w86so11074667ilk.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Aug 2020 04:32:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=ZakdSAPE5T4FwrgSAUta2TlD1gJfj04Y9UqSeil88K0=;
        b=jrF2DBPc2CYNBHXpXuGE2DZumKKWm0C8zwhzrSfRugS6KtFNbZz3RMUAmQC6zFuIz9
         eC6qFewkIWXU0MQX0NSXUD09KScFQnHzQj+UU7mHyh1GaBYNZcGQrqXZF/VQXartFNvF
         OJKFQ56qSX1qUpa7yPf0N+Jl3C0NUDWM9lyH16G69yOJhTfHtgevqCO/4us/wCtsU/rS
         luZxV3E2724FIrB8PE8ahF8CURy/x1MbOros+VuBwxNfCcwR41gHP/8d+WkfS3+HnZti
         vdNH7dMIjofl50diHg1OXRZNlMNYAgVnvsddfCXutmR6S9wPrVsGEMnuwC6dUNGw5q7D
         xmhw==
X-Gm-Message-State: AOAM531JCkiyx7daUfq9k8bxwPdpkUjRQruO8pwTLCr96u9DR+YyK6XA
        QEFBQu62yaU9dOWLKFZQIiBROa69V1CB5J4Tjw7qylAke1MB
X-Google-Smtp-Source: ABdhPJyagLnu2Z/o5/G5cfTd61mC2KgjV/smFi2kUR9c+aWb9hQv8ITsgGeV9cq1e30llEuIzNaH2cKJrRhR61KqjhJx0rCSd+vo
MIME-Version: 1.0
X-Received: by 2002:a5d:9d11:: with SMTP id j17mr12293387ioj.140.1597663935346;
 Mon, 17 Aug 2020 04:32:15 -0700 (PDT)
Date:   Mon, 17 Aug 2020 04:32:15 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000005642a205ad111fc3@google.com>
Subject: KASAN: invalid-free in klist_children_put
From:   syzbot <syzbot+d448b63291df9f64b6bc@syzkaller.appspotmail.com>
To:     andreyknvl@google.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        rafael@kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    9123e3a7 Linux 5.9-rc1
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git usb-testing
console output: https://syzkaller.appspot.com/x/log.txt?x=106d03f6900000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ccafc70ac3d5f49c
dashboard link: https://syzkaller.appspot.com/bug?extid=d448b63291df9f64b6bc
compiler:       gcc (GCC) 10.1.0-syz 20200507
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10915731900000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=151a6f6e900000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+d448b63291df9f64b6bc@syzkaller.appspotmail.com

usb 1-1: New USB device found, idVendor=093a, idProduct=8001, bcdDevice= 0.00
usb 1-1: New USB device strings: Mfr=0, Product=0, SerialNumber=0
usb 1-1: config 0 descriptor??
usb 1-1: USB disconnect, device number 2
==================================================================
BUG: KASAN: double-free or invalid-free in slab_free mm/slub.c:3142 [inline]
BUG: KASAN: double-free or invalid-free in kfree+0xbe/0x470 mm/slub.c:4123

CPU: 1 PID: 21 Comm: kworker/1:1 Not tainted 5.9.0-rc1-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Workqueue: usb_hub_wq hub_event
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0xf6/0x16e lib/dump_stack.c:118
 print_address_description.constprop.0+0x1c/0x210 mm/kasan/report.c:383
 kasan_report_invalid_free+0x51/0x80 mm/kasan/report.c:477
 __kasan_slab_free+0x122/0x130 mm/kasan/common.c:401
 slab_free_hook mm/slub.c:1548 [inline]
 slab_free_freelist_hook+0x53/0x140 mm/slub.c:1581
 slab_free mm/slub.c:3142 [inline]
 kfree+0xbe/0x470 mm/slub.c:4123
 platform_device_release+0x64/0xf0 drivers/base/platform.c:426
 device_release+0x71/0x200 drivers/base/core.c:1800
 kobject_cleanup lib/kobject.c:704 [inline]
 kobject_release lib/kobject.c:735 [inline]
 kref_put include/linux/kref.h:65 [inline]
 kobject_put+0x1c8/0x540 lib/kobject.c:752
 put_device drivers/base/core.c:3029 [inline]
 klist_children_put+0x41/0x50 drivers/base/core.c:2382
 klist_prev+0x2a2/0x510 lib/klist.c:362
 prev_device drivers/base/core.c:3146 [inline]
 device_for_each_child_reverse+0xc0/0x180 drivers/base/core.c:3268
 mfd_remove_devices+0x75/0xa0 drivers/mfd/mfd-core.c:391
 sensor_hub_remove+0x1d6/0x270 drivers/hid/hid-sensor-hub.c:744
 hid_device_remove+0xed/0x240 drivers/hid/hid-core.c:2296
 __device_release_driver+0x3c6/0x6f0 drivers/base/dd.c:1153
 device_release_driver_internal drivers/base/dd.c:1184 [inline]
 device_release_driver+0x26/0x40 drivers/base/dd.c:1207
 bus_remove_device+0x2eb/0x5a0 drivers/base/bus.c:533
 device_del+0x481/0xd90 drivers/base/core.c:3107
 hid_remove_device drivers/hid/hid-core.c:2467 [inline]
 hid_destroy_device+0xe1/0x150 drivers/hid/hid-core.c:2486
 usbhid_disconnect+0x9f/0xe0 drivers/hid/usbhid/hid-core.c:1439
 usb_unbind_interface+0x1d8/0x8d0 drivers/usb/core/driver.c:436
 __device_release_driver+0x3c6/0x6f0 drivers/base/dd.c:1153
 device_release_driver_internal drivers/base/dd.c:1184 [inline]
 device_release_driver+0x26/0x40 drivers/base/dd.c:1207
 bus_remove_device+0x2eb/0x5a0 drivers/base/bus.c:533
 device_del+0x481/0xd90 drivers/base/core.c:3107
 usb_disable_device+0x387/0x930 drivers/usb/core/message.c:1245
 usb_disconnect.cold+0x27d/0x780 drivers/usb/core/hub.c:2217
 hub_port_connect drivers/usb/core/hub.c:5059 [inline]
 hub_port_connect_change drivers/usb/core/hub.c:5348 [inline]
 port_event drivers/usb/core/hub.c:5494 [inline]
 hub_event+0x1c93/0x4390 drivers/usb/core/hub.c:5576
 process_one_work+0x94c/0x15f0 kernel/workqueue.c:2269
 worker_thread+0x64c/0x1120 kernel/workqueue.c:2415
 kthread+0x392/0x470 kernel/kthread.c:292
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:294

Allocated by task 21:
 kasan_save_stack+0x1b/0x40 mm/kasan/common.c:48
 kasan_set_track mm/kasan/common.c:56 [inline]
 __kasan_kmalloc.constprop.0+0xc2/0xd0 mm/kasan/common.c:461
 slab_post_alloc_hook mm/slab.h:518 [inline]
 slab_alloc_node mm/slub.c:2892 [inline]
 slab_alloc mm/slub.c:2900 [inline]
 __kmalloc_track_caller+0xf6/0x270 mm/slub.c:4463
 kmemdup+0x23/0x50 mm/util.c:127
 kmemdup include/linux/string.h:479 [inline]
 mfd_add_device+0x112/0x1190 drivers/mfd/mfd-core.c:191
 mfd_add_devices+0xdb/0x170 drivers/mfd/mfd-core.c:339
 mfd_add_hotplug_devices include/linux/mfd/core.h:152 [inline]
 sensor_hub_probe+0xa93/0xdc0 drivers/hid/hid-sensor-hub.c:713
 hid_device_probe+0x2bd/0x3f0 drivers/hid/hid-core.c:2263
 really_probe+0x291/0xde0 drivers/base/dd.c:553
 driver_probe_device+0x26b/0x3d0 drivers/base/dd.c:738
 __device_attach_driver+0x1d1/0x290 drivers/base/dd.c:844
 bus_for_each_drv+0x15f/0x1e0 drivers/base/bus.c:431
 __device_attach+0x228/0x4a0 drivers/base/dd.c:912
 bus_probe_device+0x1e4/0x290 drivers/base/bus.c:491
 device_add+0xb51/0x1c70 drivers/base/core.c:2930
 hid_add_device+0x344/0x9b0 drivers/hid/hid-core.c:2419
 usbhid_probe+0xaae/0xfc0 drivers/hid/usbhid/hid-core.c:1412
 usb_probe_interface+0x315/0x7f0 drivers/usb/core/driver.c:374
 really_probe+0x291/0xde0 drivers/base/dd.c:553
 driver_probe_device+0x26b/0x3d0 drivers/base/dd.c:738
 __device_attach_driver+0x1d1/0x290 drivers/base/dd.c:844
 bus_for_each_drv+0x15f/0x1e0 drivers/base/bus.c:431
 __device_attach+0x228/0x4a0 drivers/base/dd.c:912
 bus_probe_device+0x1e4/0x290 drivers/base/bus.c:491
 device_add+0xb51/0x1c70 drivers/base/core.c:2930
 usb_set_configuration+0xf05/0x18a0 drivers/usb/core/message.c:2032
 usb_generic_driver_probe+0xba/0xf2 drivers/usb/core/generic.c:239
 usb_probe_device+0xd9/0x250 drivers/usb/core/driver.c:272
 really_probe+0x291/0xde0 drivers/base/dd.c:553
 driver_probe_device+0x26b/0x3d0 drivers/base/dd.c:738
 __device_attach_driver+0x1d1/0x290 drivers/base/dd.c:844
 bus_for_each_drv+0x15f/0x1e0 drivers/base/bus.c:431
 __device_attach+0x228/0x4a0 drivers/base/dd.c:912
 bus_probe_device+0x1e4/0x290 drivers/base/bus.c:491
 device_add+0xb51/0x1c70 drivers/base/core.c:2930
 usb_new_device.cold+0x71d/0xfd4 drivers/usb/core/hub.c:2554
 hub_port_connect drivers/usb/core/hub.c:5208 [inline]
 hub_port_connect_change drivers/usb/core/hub.c:5348 [inline]
 port_event drivers/usb/core/hub.c:5494 [inline]
 hub_event+0x2361/0x4390 drivers/usb/core/hub.c:5576
 process_one_work+0x94c/0x15f0 kernel/workqueue.c:2269
 worker_thread+0x64c/0x1120 kernel/workqueue.c:2415
 kthread+0x392/0x470 kernel/kthread.c:292
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:294

Freed by task 21:
 kasan_save_stack+0x1b/0x40 mm/kasan/common.c:48
 kasan_set_track+0x1c/0x30 mm/kasan/common.c:56
 kasan_set_free_info+0x1b/0x30 mm/kasan/generic.c:355
 __kasan_slab_free+0xf3/0x130 mm/kasan/common.c:422
 slab_free_hook mm/slub.c:1548 [inline]
 slab_free_freelist_hook+0x53/0x140 mm/slub.c:1581
 slab_free mm/slub.c:3142 [inline]
 kfree+0xbe/0x470 mm/slub.c:4123
 mfd_remove_devices_fn drivers/mfd/mfd-core.c:373 [inline]
 mfd_remove_devices_fn+0xf9/0x140 drivers/mfd/mfd-core.c:355
 device_for_each_child_reverse+0x110/0x180 drivers/base/core.c:3269
 mfd_remove_devices+0x75/0xa0 drivers/mfd/mfd-core.c:391
 sensor_hub_remove+0x1d6/0x270 drivers/hid/hid-sensor-hub.c:744
 hid_device_remove+0xed/0x240 drivers/hid/hid-core.c:2296
 __device_release_driver+0x3c6/0x6f0 drivers/base/dd.c:1153
 device_release_driver_internal drivers/base/dd.c:1184 [inline]
 device_release_driver+0x26/0x40 drivers/base/dd.c:1207
 bus_remove_device+0x2eb/0x5a0 drivers/base/bus.c:533
 device_del+0x481/0xd90 drivers/base/core.c:3107
 hid_remove_device drivers/hid/hid-core.c:2467 [inline]
 hid_destroy_device+0xe1/0x150 drivers/hid/hid-core.c:2486
 usbhid_disconnect+0x9f/0xe0 drivers/hid/usbhid/hid-core.c:1439
 usb_unbind_interface+0x1d8/0x8d0 drivers/usb/core/driver.c:436
 __device_release_driver+0x3c6/0x6f0 drivers/base/dd.c:1153
 device_release_driver_internal drivers/base/dd.c:1184 [inline]
 device_release_driver+0x26/0x40 drivers/base/dd.c:1207
 bus_remove_device+0x2eb/0x5a0 drivers/base/bus.c:533
 device_del+0x481/0xd90 drivers/base/core.c:3107
 usb_disable_device+0x387/0x930 drivers/usb/core/message.c:1245
 usb_disconnect.cold+0x27d/0x780 drivers/usb/core/hub.c:2217
 hub_port_connect drivers/usb/core/hub.c:5059 [inline]
 hub_port_connect_change drivers/usb/core/hub.c:5348 [inline]
 port_event drivers/usb/core/hub.c:5494 [inline]
 hub_event+0x1c93/0x4390 drivers/usb/core/hub.c:5576
 process_one_work+0x94c/0x15f0 kernel/workqueue.c:2269
 worker_thread+0x64c/0x1120 kernel/workqueue.c:2415
 kthread+0x392/0x470 kernel/kthread.c:292
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:294

The buggy address belongs to the object at ffff8881d519fc00
 which belongs to the cache kmalloc-192 of size 192
The buggy address is located 0 bytes inside of
 192-byte region [ffff8881d519fc00, ffff8881d519fcc0)
The buggy address belongs to the page:
page:000000000c30de42 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x1d519f
flags: 0x200000000000200(slab)
raw: 0200000000000200 ffffea00074f1880 0000000700000007 ffff8881da041500
raw: 0000000000000000 0000000080100010 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
 ffff8881d519fb00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff8881d519fb80: fb fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
>ffff8881d519fc00: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                   ^
 ffff8881d519fc80: fb fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
 ffff8881d519fd00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
