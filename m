Return-Path: <SRS0=+W6S=BJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 064CDC433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 12:04:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DDAD320829
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 12:04:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728052AbgG3MEW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jul 2020 08:04:22 -0400
Received: from mail-io1-f69.google.com ([209.85.166.69]:43506 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728005AbgG3MEW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jul 2020 08:04:22 -0400
Received: by mail-io1-f69.google.com with SMTP id j3so4441132iow.10
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jul 2020 05:04:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=x8fTGN2S40SBWm2lcpVulyPJJuE5KMy0EtqvEYCFbDM=;
        b=UtTHNKWD9iqelm7JbW7MGfHzLtkAP8DAtSbHT3RAH3Joc08vkwNbHT0hGlupbI394j
         EbzAQU0t4mH23Mnfnp7FjZZUFOB4G7t/fu/kNx1ynD/6h3XEsKEUizTBqlBQOGDalQee
         zZty94JsT4GJ3+zDv/NbXOzKIxgWylVhqZbZlrI85Te1WZ0NZbEdLALTVyEbfvF1vTOT
         X87oLY3UjKm+QfHd/isog8TfjvTjAAJ5N+R/6rJtb0ZWz4Fdktdn7TWMKCDHTV1TzGre
         0yf/3Uu6Qo2NT1KZC8uEhW+78s14q7PcZW8yxY+zC4lnAKWaK/yixg+hGEk5YnKC3nXB
         rAvg==
X-Gm-Message-State: AOAM532Jj/PxkWkRq1v7SbShRchgQw22LhVS9GaeEeoAyweJ9Xhl01+/
        8OfBCF/8BufCK52jOdyPgnqI51OIzWj2BNXhoUXJFnwttwnG
X-Google-Smtp-Source: ABdhPJwO5NqUL3iG5JTgIODiHOHoScQdNH+f5dTo2C/5YzPHOhEsqK/klfnhJo0EfU1l9bwNWHmj/28GEanv295Uz0qxCSlZPf4s
MIME-Version: 1.0
X-Received: by 2002:a92:1805:: with SMTP id 5mr36331345ily.127.1596110660538;
 Thu, 30 Jul 2020 05:04:20 -0700 (PDT)
Date:   Thu, 30 Jul 2020 05:04:20 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f1976205aba77811@google.com>
Subject: KASAN: slab-out-of-bounds Read in prism2sta_probe_usb
From:   syzbot <syzbot+22794221ab96b0bab53a@syzkaller.appspotmail.com>
To:     andreyknvl@google.com, devel@driverdev.osuosl.org,
        gregkh@linuxfoundation.org, hqjagain@gmail.com,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        osdevtc@gmail.com, rkovhaev@gmail.com,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    e3ee0e74 usb: common: usb-conn-gpio: Register charger
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git usb-testing
console output: https://syzkaller.appspot.com/x/log.txt?x=14ff1524900000
kernel config:  https://syzkaller.appspot.com/x/.config?x=fb6677a3d4f11788
dashboard link: https://syzkaller.appspot.com/bug?extid=22794221ab96b0bab53a
compiler:       gcc (GCC) 10.1.0-syz 20200507
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11319e6c900000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10ae8712900000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+22794221ab96b0bab53a@syzkaller.appspotmail.com

usb 1-1: New USB device strings: Mfr=0, Product=0, SerialNumber=0
usb 1-1: config 0 descriptor??
==================================================================
BUG: KASAN: slab-out-of-bounds in usb_endpoint_xfer_bulk include/uapi/linux/usb/ch9.h:518 [inline]
BUG: KASAN: slab-out-of-bounds in usb_endpoint_is_bulk_out include/uapi/linux/usb/ch9.h:586 [inline]
BUG: KASAN: slab-out-of-bounds in prism2sta_probe_usb+0x26c/0x810 drivers/staging/wlan-ng/prism2usb.c:80
Read of size 1 at addr ffff8881cc0c85a3 by task kworker/0:3/138

CPU: 0 PID: 138 Comm: kworker/0:3 Not tainted 5.8.0-rc7-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Workqueue: usb_hub_wq hub_event
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0xf6/0x16e lib/dump_stack.c:118
 print_address_description.constprop.0+0x1a/0x210 mm/kasan/report.c:383
 __kasan_report mm/kasan/report.c:513 [inline]
 kasan_report.cold+0x37/0x7c mm/kasan/report.c:530
 usb_endpoint_xfer_bulk include/uapi/linux/usb/ch9.h:518 [inline]
 usb_endpoint_is_bulk_out include/uapi/linux/usb/ch9.h:586 [inline]
 prism2sta_probe_usb+0x26c/0x810 drivers/staging/wlan-ng/prism2usb.c:80
 usb_probe_interface+0x315/0x7f0 drivers/usb/core/driver.c:374
 really_probe+0x291/0xc90 drivers/base/dd.c:520
 driver_probe_device+0x26b/0x3d0 drivers/base/dd.c:696
 __device_attach_driver+0x1d1/0x290 drivers/base/dd.c:802
 bus_for_each_drv+0x15f/0x1e0 drivers/base/bus.c:431
 __device_attach+0x28d/0x430 drivers/base/dd.c:868
 bus_probe_device+0x1e4/0x290 drivers/base/bus.c:491
 device_add+0xb09/0x1c10 drivers/base/core.c:2700
 usb_set_configuration+0xf05/0x18a0 drivers/usb/core/message.c:2032
 usb_generic_driver_probe+0xba/0xf2 drivers/usb/core/generic.c:239
 usb_probe_device+0xd9/0x250 drivers/usb/core/driver.c:272
 really_probe+0x291/0xc90 drivers/base/dd.c:520
 driver_probe_device+0x26b/0x3d0 drivers/base/dd.c:696
 __device_attach_driver+0x1d1/0x290 drivers/base/dd.c:802
 bus_for_each_drv+0x15f/0x1e0 drivers/base/bus.c:431
 __device_attach+0x28d/0x430 drivers/base/dd.c:868
 bus_probe_device+0x1e4/0x290 drivers/base/bus.c:491
 device_add+0xb09/0x1c10 drivers/base/core.c:2700
 usb_new_device.cold+0x71d/0xfd4 drivers/usb/core/hub.c:2554
 hub_port_connect drivers/usb/core/hub.c:5208 [inline]
 hub_port_connect_change drivers/usb/core/hub.c:5348 [inline]
 port_event drivers/usb/core/hub.c:5494 [inline]
 hub_event+0x2361/0x4390 drivers/usb/core/hub.c:5576
 process_one_work+0x94c/0x15f0 kernel/workqueue.c:2269
 worker_thread+0x64c/0x1120 kernel/workqueue.c:2415
 kthread+0x392/0x470 kernel/kthread.c:291
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:293

Allocated by task 138:
 save_stack+0x1b/0x40 mm/kasan/common.c:48
 set_track mm/kasan/common.c:56 [inline]
 __kasan_kmalloc.constprop.0+0xc2/0xd0 mm/kasan/common.c:494
 kmalloc include/linux/slab.h:560 [inline]
 kzalloc include/linux/slab.h:669 [inline]
 usb_parse_interface drivers/usb/core/config.c:571 [inline]
 usb_parse_configuration drivers/usb/core/config.c:795 [inline]
 usb_get_configuration+0x13d7/0x3a50 drivers/usb/core/config.c:944
 usb_enumerate_device drivers/usb/core/hub.c:2387 [inline]
 usb_new_device+0x42c/0x7a0 drivers/usb/core/hub.c:2523
 hub_port_connect drivers/usb/core/hub.c:5208 [inline]
 hub_port_connect_change drivers/usb/core/hub.c:5348 [inline]
 port_event drivers/usb/core/hub.c:5494 [inline]
 hub_event+0x2361/0x4390 drivers/usb/core/hub.c:5576
 process_one_work+0x94c/0x15f0 kernel/workqueue.c:2269
 worker_thread+0x64c/0x1120 kernel/workqueue.c:2415
 kthread+0x392/0x470 kernel/kthread.c:291
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:293

Freed by task 16:
 save_stack+0x1b/0x40 mm/kasan/common.c:48
 set_track mm/kasan/common.c:56 [inline]
 kasan_set_free_info mm/kasan/common.c:316 [inline]
 __kasan_slab_free+0x116/0x160 mm/kasan/common.c:455
 slab_free_hook mm/slub.c:1474 [inline]
 slab_free_freelist_hook+0x53/0x140 mm/slub.c:1507
 slab_free mm/slub.c:3072 [inline]
 kfree+0xbc/0x2c0 mm/slub.c:4052
 seccomp_filter_free kernel/seccomp.c:573 [inline]
 seccomp_filter_free kernel/seccomp.c:569 [inline]
 __put_seccomp_filter+0xb3/0xf0 kernel/seccomp.c:583
 free_task+0x76/0x110 kernel/fork.c:476
 __put_task_struct+0x21c/0x3a0 kernel/fork.c:756
 put_task_struct include/linux/sched/task.h:126 [inline]
 delayed_put_task_struct+0x21c/0x360 kernel/exit.c:172
 rcu_do_batch kernel/rcu/tree.c:2414 [inline]
 rcu_core+0x506/0x1840 kernel/rcu/tree.c:2641
 __do_softirq+0x222/0x95b kernel/softirq.c:292

The buggy address belongs to the object at ffff8881cc0c8500
 which belongs to the cache kmalloc-192 of size 192
The buggy address is located 163 bytes inside of
 192-byte region [ffff8881cc0c8500, ffff8881cc0c85c0)
The buggy address belongs to the page:
page:ffffea0007303200 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0
flags: 0x200000000000200(slab)
raw: 0200000000000200 ffffea00073e28c0 0000000400000004 ffff8881da002a00
raw: 0000000000000000 0000000080100010 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
 ffff8881cc0c8480: fb fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
 ffff8881cc0c8500: 00 00 00 00 00 


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
