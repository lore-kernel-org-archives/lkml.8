Return-Path: <SRS0=5bHT=BN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEB12C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 14:41:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D1F9D2076E
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 14:41:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727940AbgHCOlX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 10:41:23 -0400
Received: from mail-il1-f197.google.com ([209.85.166.197]:35056 "EHLO
        mail-il1-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727863AbgHCOlX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 10:41:23 -0400
Received: by mail-il1-f197.google.com with SMTP id g6so12717313iln.2
        for <linux-kernel@vger.kernel.org>; Mon, 03 Aug 2020 07:41:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=b+AIlwHdWKaVk2//u11VgGwlGAYtZ+URjN4AzvlvYdE=;
        b=ISiil3JwWuoGhIIsEphzRHE75QlRKIGEkS1oGCsCSyocAOn0HIeV2tBzqQzduCxGgv
         4bOCedZgxT3e2kF6uttjrFzIYYTfsmF6VA0darhAFbB5x0n2YBCYXqc9F6Df9HEgI5dL
         rlPEn+r0qLGdxzJ4LPjkLwkFDZFnZXgmAz5InEO9mxoYrfW1UgfvZ/9ZJwLIx1CHWg+v
         XR8Dw/cOcPuEjHasoBNylEY1v/eqap9UQVKUJj6HwjLRJohNdYEti9U8xLO/0yE7hsE6
         3bFPUVaWNyzun4lgTnbiyt81KYPAF+xhzcZnSmTnN7ypnfzAsq1KK6ENKdbT5zbsTPHc
         1lRg==
X-Gm-Message-State: AOAM533MITRkxmOzPlKkj1T75CbIV/bwJJpCtZkitEFjsqxpmyrEkG50
        b9GYUerL9D3agbJVAeXUbkm9GLjGXrusMKel6GLi4dFdhOtb
X-Google-Smtp-Source: ABdhPJyF4eLpGymvlaM3gOSL3NphfFxMkX89wASbDpgyVENK7/7rZt2utmM2bXQcdX0KB/wY5roLduSCeJHl8DyJDc7fHFQO49/0
MIME-Version: 1.0
X-Received: by 2002:a05:6602:2549:: with SMTP id j9mr151937ioe.89.1596465681724;
 Mon, 03 Aug 2020 07:41:21 -0700 (PDT)
Date:   Mon, 03 Aug 2020 07:41:21 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000dafa8405abfa211a@google.com>
Subject: KASAN: slab-out-of-bounds Read in usb_destroy_configuration
From:   syzbot <syzbot+aafdc32825a345214a76@syzkaller.appspotmail.com>
To:     andreyknvl@google.com, gregkh@linuxfoundation.org,
        johan@kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, stern@rowland.harvard.edu,
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
console output: https://syzkaller.appspot.com/x/log.txt?x=175a3e0c900000
kernel config:  https://syzkaller.appspot.com/x/.config?x=fb6677a3d4f11788
dashboard link: https://syzkaller.appspot.com/bug?extid=aafdc32825a345214a76
compiler:       gcc (GCC) 10.1.0-syz 20200507

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+aafdc32825a345214a76@syzkaller.appspotmail.com

usb 1-1: USB disconnect, device number 72
==================================================================
BUG: KASAN: slab-out-of-bounds in usb_destroy_configuration+0x636/0x6d0 drivers/usb/core/config.c:834
Read of size 8 at addr ffff8881c7e3c758 by task kworker/1:7/3434

CPU: 1 PID: 3434 Comm: kworker/1:7 Not tainted 5.8.0-rc7-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Workqueue: usb_hub_wq hub_event
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0xf6/0x16e lib/dump_stack.c:118
 print_address_description.constprop.0+0x1a/0x210 mm/kasan/report.c:383
 __kasan_report mm/kasan/report.c:513 [inline]
 kasan_report.cold+0x37/0x7c mm/kasan/report.c:530
 usb_destroy_configuration+0x636/0x6d0 drivers/usb/core/config.c:834
 usb_release_dev+0x3e/0x100 drivers/usb/core/usb.c:417
 device_release+0x71/0x200 drivers/base/core.c:1579
 kobject_cleanup lib/kobject.c:693 [inline]
 kobject_release lib/kobject.c:722 [inline]
 kref_put include/linux/kref.h:65 [inline]
 kobject_put+0x245/0x540 lib/kobject.c:739
 put_device+0x1b/0x30 drivers/base/core.c:2799
 hub_port_connect drivers/usb/core/hub.c:5059 [inline]
 hub_port_connect_change drivers/usb/core/hub.c:5348 [inline]
 port_event drivers/usb/core/hub.c:5494 [inline]
 hub_event+0x1c93/0x4390 drivers/usb/core/hub.c:5576
 process_one_work+0x94c/0x15f0 kernel/workqueue.c:2269
 worker_thread+0x64c/0x1120 kernel/workqueue.c:2415
 kthread+0x392/0x470 kernel/kthread.c:291
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:293

Allocated by task 13775:
 save_stack+0x1b/0x40 mm/kasan/common.c:48
 set_track mm/kasan/common.c:56 [inline]
 __kasan_kmalloc.constprop.0+0xc2/0xd0 mm/kasan/common.c:494
 kmalloc include/linux/slab.h:560 [inline]
 kzalloc include/linux/slab.h:669 [inline]
 usb_get_configuration+0x186/0x3a50 drivers/usb/core/config.c:887
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

Freed by task 3070:
 save_stack+0x1b/0x40 mm/kasan/common.c:48
 set_track mm/kasan/common.c:56 [inline]
 kasan_set_free_info mm/kasan/common.c:316 [inline]
 __kasan_slab_free+0x116/0x160 mm/kasan/common.c:455
 slab_free_hook mm/slub.c:1474 [inline]
 slab_free_freelist_hook+0x53/0x140 mm/slub.c:1507
 slab_free mm/slub.c:3072 [inline]
 kfree+0xbc/0x2c0 mm/slub.c:4052
 kfree_const+0x51/0x60 mm/util.c:40
 kobject_cleanup lib/kobject.c:699 [inline]
 kobject_release lib/kobject.c:722 [inline]
 kref_put include/linux/kref.h:65 [inline]
 kobject_put+0x26f/0x540 lib/kobject.c:739
 put_device drivers/base/core.c:2799 [inline]
 device_unregister+0x34/0xc0 drivers/base/core.c:2910
 usb_remove_ep_devs+0x3e/0x80 drivers/usb/core/endpoint.c:215
 remove_intf_ep_devs drivers/usb/core/message.c:1120 [inline]
 usb_disable_device+0x335/0x930 drivers/usb/core/message.c:1244
 usb_disconnect.cold+0x27d/0x780 drivers/usb/core/hub.c:2217
 hub_port_connect drivers/usb/core/hub.c:5059 [inline]
 hub_port_connect_change drivers/usb/core/hub.c:5348 [inline]
 port_event drivers/usb/core/hub.c:5494 [inline]
 hub_event+0x1c93/0x4390 drivers/usb/core/hub.c:5576
 process_one_work+0x94c/0x15f0 kernel/workqueue.c:2269
 worker_thread+0x64c/0x1120 kernel/workqueue.c:2415
 kthread+0x392/0x470 kernel/kthread.c:291
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:293

The buggy address belongs to the object at ffff8881c7e3c750
 which belongs to the cache kmalloc-8 of size 8
The buggy address is located 0 bytes to the right of
 8-byte region [ffff8881c7e3c750, ffff8881c7e3c758)
The buggy address belongs to the page:
page:ffffea00071f8f00 refcount:1 mapcount:0 mapping:0000000000000000 index:0xffff8881c7e3c7b0
flags: 0x200000000000200(slab)
raw: 0200000000000200 ffffea00071ffac0 0000000b0000000b ffff8881da003900
raw: ffff8881c7e3c7b0 0000000080aa00a8 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
 ffff8881c7e3c600: 00 fc fc 00 fc fc fb fc fc fb fc fc 00 fc fc fb
 ffff8881c7e3c680: fc fc fb fc fc fb fc fc fb fc fc fb fc fc fb fc
>ffff8881c7e3c700: fc fb fc fc 00 fc fc fb fc fc 00 fc fc fb fc fc
                                                    ^
 ffff8881c7e3c780: 00 fc fc fb fc fc fb fc fc 00 fc fc fb fc fc 00
 ffff8881c7e3c800: fc fc 00 fc fc fb fc fc fb fc fc 00 fc fc 00 fc
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
