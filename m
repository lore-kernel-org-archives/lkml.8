Return-Path: <SRS0=rtH4=AH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FEC6C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 17:18:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 289152081A
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 17:18:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726093AbgFZRSP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jun 2020 13:18:15 -0400
Received: from mail-io1-f69.google.com ([209.85.166.69]:38878 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725946AbgFZRSO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 13:18:14 -0400
Received: by mail-io1-f69.google.com with SMTP id l13so6781061ioj.5
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jun 2020 10:18:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=XDsD8VGfQrwL4wLDIKulpQ+nGoyRxtA2mOOFe6kT0Cc=;
        b=RyTQ5TbP0QmfvL3RA3vcMLdfKck832nQAJiaw6Tg/JH80qrzz4sndEZmiqVyA8lkYe
         37zBp7UfKd3YSi3njstCVZpW8jJ51Qoi7omeXDqt86qb9Xd+OuMUklY0eY1kfxbOIvuQ
         f9tClOPMlKcEaCLiLq1LSgO+aZ0trE8WfIHZ8+Q/UrroMdi1AX0CAslAyj/Fr21i3TsZ
         QS9+blQtGFk+acwwdbKrLOXGR04m16gcWUGXj30mK4hvweIx8Y+Pusd4yypkPY7cNPdr
         WcdA7fdyR+DwiLam6p1uTzATq6JidXBvgxAM5mNiJ29JeJVMcmKzpKQN2rY+XkgyqDH4
         h1QQ==
X-Gm-Message-State: AOAM531aGXinm7CT/Vf5/CYE+vbZ0QV6amsezboIa6TxlfE4WqheQQz7
        4E1TU2v6y0GfSw7ws8fIAbvX4tdjkjC4xk9WivzfhrIkDbk9
X-Google-Smtp-Source: ABdhPJx1pzo5c34f21ce3s30kHwtQeQCwexQzWRvLcxsmq5waEZ5uSOShO8Mhxds1QWhJKcz+el10RzCwUe66B/Tr2eg/DE3V9Y0
MIME-Version: 1.0
X-Received: by 2002:a05:6602:2fcb:: with SMTP id v11mr4505040iow.121.1593191892797;
 Fri, 26 Jun 2020 10:18:12 -0700 (PDT)
Date:   Fri, 26 Jun 2020 10:18:12 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d44c6d05a8ffe488@google.com>
Subject: KASAN: use-after-free Read in line6_submit_audio_in_all_urbs
From:   syzbot <syzbot+145012a46658ac00fc9e@syzkaller.appspotmail.com>
To:     alsa-devel@alsa-project.org, andreyknvl@google.com,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        perex@perex.cz, syzkaller-bugs@googlegroups.com, tiwai@suse.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    fb574682 usbip: tools: fix module name in man page
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git usb-testing
console output: https://syzkaller.appspot.com/x/log.txt?x=156560b1100000
kernel config:  https://syzkaller.appspot.com/x/.config?x=63b40b2ae167bad6
dashboard link: https://syzkaller.appspot.com/bug?extid=145012a46658ac00fc9e
compiler:       gcc (GCC) 10.1.0-syz 20200507

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+145012a46658ac00fc9e@syzkaller.appspotmail.com

snd_usb_toneport 5-1:0.0: URB in #0 submission failed (-19)
snd_usb_toneport 5-1:0.0: URB in #0 submission failed (-19)
snd_usb_toneport 5-1:0.0: URB in #0 submission failed (-19)
snd_usb_toneport 5-1:0.0: URB in #0 submission failed (-19)
==================================================================
BUG: KASAN: use-after-free in line6_submit_audio_in_all_urbs+0x10b/0x120 sound/usb/line6/capture.c:72
Read of size 8 at addr ffff8881cffb1800 by task kworker/1:5/3257

CPU: 1 PID: 3257 Comm: kworker/1:5 Not tainted 5.8.0-rc1-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Workqueue: events line6_startup_work
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0xf6/0x16e lib/dump_stack.c:118
 print_address_description.constprop.0+0x1a/0x210 mm/kasan/report.c:383
 __kasan_report mm/kasan/report.c:513 [inline]
 kasan_report.cold+0x37/0x7c mm/kasan/report.c:530
 line6_submit_audio_in_all_urbs+0x10b/0x120 sound/usb/line6/capture.c:72
 line6_stream_start+0x207/0x230 sound/usb/line6/pcm.c:197
 line6_pcm_acquire+0x161/0x210 sound/usb/line6/pcm.c:318
 line6_startup_work+0x42/0x50 sound/usb/line6/driver.c:734
 process_one_work+0x94c/0x15f0 kernel/workqueue.c:2269
 worker_thread+0x64c/0x1120 kernel/workqueue.c:2415
 kthread+0x392/0x470 kernel/kthread.c:291
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:293

Allocated by task 76:
 save_stack+0x1b/0x40 mm/kasan/common.c:48
 set_track mm/kasan/common.c:56 [inline]
 __kasan_kmalloc.constprop.0+0xc2/0xd0 mm/kasan/common.c:494
 kmalloc include/linux/slab.h:555 [inline]
 kzalloc include/linux/slab.h:669 [inline]
 line6_init_pcm+0x2a7/0x9e0 sound/usb/line6/pcm.c:533
 toneport_init+0xdd/0x6b0 sound/usb/line6/toneport.c:419
 line6_probe+0xaa0/0x1330 sound/usb/line6/driver.c:809
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

Freed by task 3044:
 save_stack+0x1b/0x40 mm/kasan/common.c:48
 set_track mm/kasan/common.c:56 [inline]
 kasan_set_free_info mm/kasan/common.c:316 [inline]
 __kasan_slab_free+0x116/0x160 mm/kasan/common.c:455
 slab_free_hook mm/slub.c:1474 [inline]
 slab_free_freelist_hook+0x53/0x140 mm/slub.c:1507
 slab_free mm/slub.c:3072 [inline]
 kfree+0xbc/0x2c0 mm/slub.c:4063
 snd_pcm_free sound/core/pcm.c:865 [inline]
 snd_pcm_dev_free+0x67/0xb0 sound/core/pcm.c:876
 __snd_device_free+0x19f/0x300 sound/core/device.c:76
 snd_device_free_all+0xef/0x20d sound/core/device.c:233
 snd_card_do_free sound/core/init.c:472 [inline]
 release_card_device+0x1b/0xd0 sound/core/init.c:140
 device_release+0x71/0x200 drivers/base/core.c:1559
 kobject_cleanup lib/kobject.c:693 [inline]
 kobject_release lib/kobject.c:722 [inline]
 kref_put include/linux/kref.h:65 [inline]
 kobject_put+0x245/0x540 lib/kobject.c:739
 put_device+0x1b/0x30 drivers/base/core.c:2779
 snd_card_free_when_closed+0x35/0x50 sound/core/init.c:499
 line6_disconnect.cold+0xa4/0xbd sound/usb/line6/driver.c:860
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

The buggy address belongs to the object at ffff8881cffb1800
 which belongs to the cache kmalloc-1k of size 1024
The buggy address is located 0 bytes inside of
 1024-byte region [ffff8881cffb1800, ffff8881cffb1c00)
The buggy address belongs to the page:
page:ffffea00073fec00 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 head:ffffea00073fec00 order:3 compound_mapcount:0 compound_pincount:0
flags: 0x200000000010200(slab|head)
raw: 0200000000010200 ffffea00074f0c00 0000000300000003 ffff8881da002280
raw: 0000000000000000 0000000000100010 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
 ffff8881cffb1700: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff8881cffb1780: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>ffff8881cffb1800: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                   ^
 ffff8881cffb1880: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff8881cffb1900: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
