Return-Path: <SRS0=WByN=3C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80CC2C33CAD
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 12:24:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 511D22084D
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 12:24:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728680AbgAMMYM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jan 2020 07:24:12 -0500
Received: from mail-io1-f69.google.com ([209.85.166.69]:36378 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726277AbgAMMYL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jan 2020 07:24:11 -0500
Received: by mail-io1-f69.google.com with SMTP id 144so5704455iou.3
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jan 2020 04:24:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=ZuZRhQ+jPRZsTrygyPZS020fG6PnWHGjylEin+kRBcw=;
        b=Fkt4ZVZQkjtVbeVzsLFjVAWAVF+hjUoZ2/6cKcFDTXLZVVq3FfO5c291Gcwz6oohSu
         W/7axXl4F+8EMSxFkyScumjzTe6A8RoD1xRI/Lu4vZjJxRqADKAOgA9soRlXicvdnVnu
         LWkp6sY7z+drlm2uSPDc26vdhBHZa+AajDF7IqcBAKLGl2mZG/RdpptfrFZBvHf8HwIp
         UbVHoM1YENCVGWbH3y+1qAomtcWxHASRH59BAB4YsDgU11u5aUtnawohdxV9IOaHCvEP
         hYwaOJBlcRBGLGS8WLv5vXfLH36BOveiS5P2xVOWUegjeuy/dSiR+q29idJ9yCwuu7fm
         aaJg==
X-Gm-Message-State: APjAAAU8m5USmruIrIb3ip2GZlJI5dxgfggXr/fLGM89QQ5A9cb4dwcT
        tFoNZGrkC6xWLD3P4xJ83u5RgDaNlTNMc0irh3i1jSBqZgTy
X-Google-Smtp-Source: APXvYqx1EwJ3DiSlzRJzQV8GGofGcpkpYo31yVBIPnc8AL5HZO2LokysvBczZEsW1mPeY9dM0wEt78oIY2atH+hmLkbuhw9lQZaB
MIME-Version: 1.0
X-Received: by 2002:a5e:8345:: with SMTP id y5mr11788158iom.122.1578918250807;
 Mon, 13 Jan 2020 04:24:10 -0800 (PST)
Date:   Mon, 13 Jan 2020 04:24:10 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000780999059c048dfc@google.com>
Subject: KASAN: use-after-free Read in uvc_probe
From:   syzbot <syzbot+9a48339b077c5a80b869@syzkaller.appspotmail.com>
To:     andreyknvl@google.com, laurent.pinchart@ideasonboard.com,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linux-usb@vger.kernel.org, mchehab@kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    ae179410 usb: gadget: add raw-gadget interface
git tree:       https://github.com/google/kasan.git usb-fuzzer
console output: https://syzkaller.appspot.com/x/log.txt?x=132223fee00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ad1d751a3a72ae57
dashboard link: https://syzkaller.appspot.com/bug?extid=9a48339b077c5a80b869
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16857325e00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=142e069ee00000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+9a48339b077c5a80b869@syzkaller.appspotmail.com

usb 1-1: New USB device found, idVendor=0bd3, idProduct=0555,  
bcdDevice=69.6a
usb 1-1: New USB device strings: Mfr=0, Product=0, SerialNumber=0
usb 1-1: config 0 descriptor??
usb 1-1: string descriptor 0 read error: -71
uvcvideo: Found UVC 0.00 device <unnamed> (0bd3:0555)
==================================================================
BUG: KASAN: use-after-free in uvc_register_terms  
drivers/media/usb/uvc/uvc_driver.c:2038 [inline]
BUG: KASAN: use-after-free in uvc_register_chains  
drivers/media/usb/uvc/uvc_driver.c:2070 [inline]
BUG: KASAN: use-after-free in uvc_probe.cold+0x2193/0x29de  
drivers/media/usb/uvc/uvc_driver.c:2201
Read of size 2 at addr ffff8881d4f1bc2e by task kworker/1:2/94

CPU: 1 PID: 94 Comm: kworker/1:2 Not tainted 5.5.0-rc3-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Workqueue: usb_hub_wq hub_event
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0xef/0x16e lib/dump_stack.c:118
  print_address_description.constprop.0.cold+0xd3/0x314 mm/kasan/report.c:374
  __kasan_report.cold+0x37/0x85 mm/kasan/report.c:506
  kasan_report+0xe/0x20 mm/kasan/common.c:639
  uvc_register_terms drivers/media/usb/uvc/uvc_driver.c:2038 [inline]
  uvc_register_chains drivers/media/usb/uvc/uvc_driver.c:2070 [inline]
  uvc_probe.cold+0x2193/0x29de drivers/media/usb/uvc/uvc_driver.c:2201
  usb_probe_interface+0x310/0x800 drivers/usb/core/driver.c:361
  really_probe+0x290/0xad0 drivers/base/dd.c:548
  driver_probe_device+0x223/0x350 drivers/base/dd.c:721
  __device_attach_driver+0x1d1/0x290 drivers/base/dd.c:828
  bus_for_each_drv+0x162/0x1e0 drivers/base/bus.c:430
  __device_attach+0x217/0x390 drivers/base/dd.c:894
  bus_probe_device+0x1e4/0x290 drivers/base/bus.c:490
  device_add+0x1459/0x1bf0 drivers/base/core.c:2487
  usb_set_configuration+0xe47/0x17d0 drivers/usb/core/message.c:2023
  generic_probe+0x9d/0xd5 drivers/usb/core/generic.c:210
  usb_probe_device+0xaf/0x140 drivers/usb/core/driver.c:266
  really_probe+0x290/0xad0 drivers/base/dd.c:548
  driver_probe_device+0x223/0x350 drivers/base/dd.c:721
  __device_attach_driver+0x1d1/0x290 drivers/base/dd.c:828
  bus_for_each_drv+0x162/0x1e0 drivers/base/bus.c:430
  __device_attach+0x217/0x390 drivers/base/dd.c:894
  bus_probe_device+0x1e4/0x290 drivers/base/bus.c:490
  device_add+0x1459/0x1bf0 drivers/base/core.c:2487
  usb_new_device.cold+0x540/0xcd0 drivers/usb/core/hub.c:2537
  hub_port_connect drivers/usb/core/hub.c:5184 [inline]
  hub_port_connect_change drivers/usb/core/hub.c:5324 [inline]
  port_event drivers/usb/core/hub.c:5470 [inline]
  hub_event+0x21cb/0x4300 drivers/usb/core/hub.c:5552
  process_one_work+0x945/0x15c0 kernel/workqueue.c:2264
  worker_thread+0x96/0xe20 kernel/workqueue.c:2410
  kthread+0x318/0x420 kernel/kthread.c:255
  ret_from_fork+0x24/0x30 arch/x86/entry/entry_64.S:352

Allocated by task 94:
  save_stack+0x1b/0x80 mm/kasan/common.c:72
  set_track mm/kasan/common.c:80 [inline]
  __kasan_kmalloc mm/kasan/common.c:513 [inline]
  __kasan_kmalloc.constprop.0+0xbf/0xd0 mm/kasan/common.c:486
  kmalloc include/linux/slab.h:556 [inline]
  kzalloc include/linux/slab.h:670 [inline]
  uvc_alloc_chain+0x48/0xfa drivers/media/usb/uvc/uvc_driver.c:1692
  uvc_scan_device drivers/media/usb/uvc/uvc_driver.c:1818 [inline]
  uvc_probe.cold+0x15f0/0x29de drivers/media/usb/uvc/uvc_driver.c:2197
  usb_probe_interface+0x310/0x800 drivers/usb/core/driver.c:361
  really_probe+0x290/0xad0 drivers/base/dd.c:548
  driver_probe_device+0x223/0x350 drivers/base/dd.c:721
  __device_attach_driver+0x1d1/0x290 drivers/base/dd.c:828
  bus_for_each_drv+0x162/0x1e0 drivers/base/bus.c:430
  __device_attach+0x217/0x390 drivers/base/dd.c:894
  bus_probe_device+0x1e4/0x290 drivers/base/bus.c:490
  device_add+0x1459/0x1bf0 drivers/base/core.c:2487
  usb_set_configuration+0xe47/0x17d0 drivers/usb/core/message.c:2023
  generic_probe+0x9d/0xd5 drivers/usb/core/generic.c:210
  usb_probe_device+0xaf/0x140 drivers/usb/core/driver.c:266
  really_probe+0x290/0xad0 drivers/base/dd.c:548
  driver_probe_device+0x223/0x350 drivers/base/dd.c:721
  __device_attach_driver+0x1d1/0x290 drivers/base/dd.c:828
  bus_for_each_drv+0x162/0x1e0 drivers/base/bus.c:430
  __device_attach+0x217/0x390 drivers/base/dd.c:894
  bus_probe_device+0x1e4/0x290 drivers/base/bus.c:490
  device_add+0x1459/0x1bf0 drivers/base/core.c:2487
  usb_new_device.cold+0x540/0xcd0 drivers/usb/core/hub.c:2537
  hub_port_connect drivers/usb/core/hub.c:5184 [inline]
  hub_port_connect_change drivers/usb/core/hub.c:5324 [inline]
  port_event drivers/usb/core/hub.c:5470 [inline]
  hub_event+0x21cb/0x4300 drivers/usb/core/hub.c:5552
  process_one_work+0x945/0x15c0 kernel/workqueue.c:2264
  worker_thread+0x96/0xe20 kernel/workqueue.c:2410
  kthread+0x318/0x420 kernel/kthread.c:255
  ret_from_fork+0x24/0x30 arch/x86/entry/entry_64.S:352

Freed by task 94:
  save_stack+0x1b/0x80 mm/kasan/common.c:72
  set_track mm/kasan/common.c:80 [inline]
  kasan_set_free_info mm/kasan/common.c:335 [inline]
  __kasan_slab_free+0x117/0x160 mm/kasan/common.c:474
  slab_free_hook mm/slub.c:1425 [inline]
  slab_free_freelist_hook mm/slub.c:1458 [inline]
  slab_free mm/slub.c:3005 [inline]
  kfree+0xd5/0x300 mm/slub.c:3957
  uvc_scan_device drivers/media/usb/uvc/uvc_driver.c:1825 [inline]
  uvc_probe.cold+0x16fd/0x29de drivers/media/usb/uvc/uvc_driver.c:2197
  usb_probe_interface+0x310/0x800 drivers/usb/core/driver.c:361
  really_probe+0x290/0xad0 drivers/base/dd.c:548
  driver_probe_device+0x223/0x350 drivers/base/dd.c:721
  __device_attach_driver+0x1d1/0x290 drivers/base/dd.c:828
  bus_for_each_drv+0x162/0x1e0 drivers/base/bus.c:430
  __device_attach+0x217/0x390 drivers/base/dd.c:894
  bus_probe_device+0x1e4/0x290 drivers/base/bus.c:490
  device_add+0x1459/0x1bf0 drivers/base/core.c:2487
  usb_set_configuration+0xe47/0x17d0 drivers/usb/core/message.c:2023
  generic_probe+0x9d/0xd5 drivers/usb/core/generic.c:210
  usb_probe_device+0xaf/0x140 drivers/usb/core/driver.c:266
  really_probe+0x290/0xad0 drivers/base/dd.c:548
  driver_probe_device+0x223/0x350 drivers/base/dd.c:721
  __device_attach_driver+0x1d1/0x290 drivers/base/dd.c:828
  bus_for_each_drv+0x162/0x1e0 drivers/base/bus.c:430
  __device_attach+0x217/0x390 drivers/base/dd.c:894
  bus_probe_device+0x1e4/0x290 drivers/base/bus.c:490
  device_add+0x1459/0x1bf0 drivers/base/core.c:2487
  usb_new_device.cold+0x540/0xcd0 drivers/usb/core/hub.c:2537
  hub_port_connect drivers/usb/core/hub.c:5184 [inline]
  hub_port_connect_change drivers/usb/core/hub.c:5324 [inline]
  port_event drivers/usb/core/hub.c:5470 [inline]
  hub_event+0x21cb/0x4300 drivers/usb/core/hub.c:5552
  process_one_work+0x945/0x15c0 kernel/workqueue.c:2264
  worker_thread+0x96/0xe20 kernel/workqueue.c:2410
  kthread+0x318/0x420 kernel/kthread.c:255
  ret_from_fork+0x24/0x30 arch/x86/entry/entry_64.S:352

The buggy address belongs to the object at ffff8881d4f1bc00
  which belongs to the cache kmalloc-256 of size 256
The buggy address is located 46 bytes inside of
  256-byte region [ffff8881d4f1bc00, ffff8881d4f1bd00)
The buggy address belongs to the page:
page:ffffea000753c680 refcount:1 mapcount:0 mapping:ffff8881da002780  
index:0x0 compound_mapcount: 0
raw: 0200000000010200 ffffea000753c600 0000000300000003 ffff8881da002780
raw: 0000000000000000 0000000080100010 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
  ffff8881d4f1bb00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
  ffff8881d4f1bb80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
> ffff8881d4f1bc00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                   ^
  ffff8881d4f1bc80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
  ffff8881d4f1bd00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
==================================================================


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
