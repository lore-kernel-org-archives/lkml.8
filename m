Return-Path: <SRS0=3CHW=6C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE71EC2BB1D
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Apr 2020 01:41:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A95F1214D8
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Apr 2020 01:41:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725960AbgDRBlF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Apr 2020 21:41:05 -0400
Received: from mail-io1-f72.google.com ([209.85.166.72]:41548 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725768AbgDRBlE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Apr 2020 21:41:04 -0400
Received: by mail-io1-f72.google.com with SMTP id p20so3903524iob.8
        for <linux-kernel@vger.kernel.org>; Fri, 17 Apr 2020 18:41:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=mPOo1JI3KWPZ93PiPgN/qhSo1d3M5LaQhxjvUxd2NT0=;
        b=j/R/8ELpsxqqMBkBGpBvJRyL2D3rxqTDsXHwIgb4AbysW/QrlTaKfVVjmWpvm9py5G
         X99wTV8g7p0O0E3DVJCP4/xUM+UniW+MGqoGkscQD8o6r4/NEUqU3Gxri996n70xRhmO
         xow3+OdFB2HYVIFRQPHU1hcCXjg99Fuy/s7ZPW19xoTzI/avO9jT64JPlQwH2N+O7dJp
         0/MwMK+pVgBKi+KvfYfK19owP4oCRxoljML7I94wEtCcDY4vZTnFKo4e4+PHUMhurLCj
         LaZw7ZoAqVvaxxmZrzTPrAmfmsW5IPISg7MoKy6EWdQ8RJqCh2biq4X7n2xW51iRyYsU
         njdw==
X-Gm-Message-State: AGi0PuYAkx1tKqzKiTFYPgq3gc3CjDKr0IcdrAwsLfZu4TVIYO+j/C1U
        9LA8AAPP/yj879/pHzjjYzypHuxfflcIO3L4F9ZHnEYc+FU0
X-Google-Smtp-Source: APiQypIwfk4o74t8TMtn5puTlqy/a0ePArGBfGpoMTmMWRG+QUpWX1V8mlpTjc5GHOfqjdx59Rn4HNdDBgXkMpdEmViWWUfeLRrq
MIME-Version: 1.0
X-Received: by 2002:a02:cc91:: with SMTP id s17mr5780738jap.41.1587174063403;
 Fri, 17 Apr 2020 18:41:03 -0700 (PDT)
Date:   Fri, 17 Apr 2020 18:41:03 -0700
In-Reply-To: <Pine.LNX.4.44L0.2004172128290.23070-100000@netrider.rowland.org>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000003ef93005a386c2f9@google.com>
Subject: Re: KASAN: use-after-free Read in usbhid_close (3)
From:   syzbot <syzbot+7bf5a7b0f0a1f9446f4c@syzkaller.appspotmail.com>
To:     andreyknvl@google.com, gregkh@linuxfoundation.org,
        ingrassia@epigenesys.com, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, stern@rowland.harvard.edu,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch but the reproducer still triggered crash:
KASAN: use-after-free Read in __input_unregister_device

wacom 0003:056A:0061.0002: Unknown device_type for 'HID 056a:0061'. Assuming pen.
input: Wacom PenStation2 Pen as /devices/platform/dummy_hcd.1/usb2/2-1/2-1:0.0/0003:056A:0061.0002/input/input8
wacom 0003:056A:0061.0002: hidraw1: USB HID v0.00 Device [HID 056a:0061] on usb-dummy_hcd.1-1/input0
usb 6-1: USB disconnect, device number 2
==================================================================
BUG: KASAN: use-after-free in __input_unregister_device+0x4a6/0x4c0 drivers/input/input.c:2089
Read of size 4 at addr ffff8881cc1380e8 by task kworker/0:1/12

CPU: 0 PID: 12 Comm: kworker/0:1 Not tainted 5.6.0-rc7-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Workqueue: usb_hub_wq hub_event
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0xef/0x16e lib/dump_stack.c:118
 print_address_description.constprop.0.cold+0xd3/0x314 mm/kasan/report.c:374
 __kasan_report.cold+0x37/0x77 mm/kasan/report.c:506
 kasan_report+0xe/0x20 mm/kasan/common.c:641
 __input_unregister_device+0x4a6/0x4c0 drivers/input/input.c:2089
 release_nodes+0x499/0x910 drivers/base/devres.c:507
 devres_release_group+0x160/0x210 drivers/base/devres.c:678
 wacom_release_resources drivers/hid/wacom_sys.c:2238 [inline]
 wacom_remove+0x244/0x3b0 drivers/hid/wacom_sys.c:2786
 hid_device_remove+0xed/0x240 drivers/hid/hid-core.c:2296
 __device_release_driver drivers/base/dd.c:1135 [inline]
 device_release_driver_internal+0x231/0x500 drivers/base/dd.c:1168
 bus_remove_device+0x2eb/0x5a0 drivers/base/bus.c:533
 device_del+0x481/0xd30 drivers/base/core.c:2677
 hid_remove_device drivers/hid/hid-core.c:2467 [inline]
 hid_destroy_device+0xe1/0x150 drivers/hid/hid-core.c:2486
 usbhid_disconnect+0x9f/0xe0 drivers/hid/usbhid/hid-core.c:1419
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

Allocated by task 3265:
 save_stack+0x1b/0x80 mm/kasan/common.c:72
 set_track mm/kasan/common.c:80 [inline]
 __kasan_kmalloc mm/kasan/common.c:515 [inline]
 __kasan_kmalloc.constprop.0+0xbf/0xd0 mm/kasan/common.c:488
 slab_post_alloc_hook mm/slab.h:584 [inline]
 slab_alloc_node mm/slub.c:2786 [inline]
 slab_alloc mm/slub.c:2794 [inline]
 kmem_cache_alloc+0xd8/0x300 mm/slub.c:2799
 getname_flags fs/namei.c:138 [inline]
 getname_flags+0xd2/0x5b0 fs/namei.c:128
 user_path_at_empty+0x2a/0x50 fs/namei.c:2746
 user_path_at include/linux/namei.h:58 [inline]
 do_faccessat+0x248/0x7a0 fs/open.c:398
 do_syscall_64+0xb6/0x5a0 arch/x86/entry/common.c:294
 entry_SYSCALL_64_after_hwframe+0x49/0xbe

Freed by task 3265:
 save_stack+0x1b/0x80 mm/kasan/common.c:72
 set_track mm/kasan/common.c:80 [inline]
 kasan_set_free_info mm/kasan/common.c:337 [inline]
 __kasan_slab_free+0x117/0x160 mm/kasan/common.c:476
 slab_free_hook mm/slub.c:1444 [inline]
 slab_free_freelist_hook mm/slub.c:1477 [inline]
 slab_free mm/slub.c:3034 [inline]
 kmem_cache_free+0x9b/0x360 mm/slub.c:3050
 putname+0xe1/0x120 fs/namei.c:259
 filename_lookup+0x282/0x3e0 fs/namei.c:2475
 user_path_at include/linux/namei.h:58 [inline]
 do_faccessat+0x248/0x7a0 fs/open.c:398
 do_syscall_64+0xb6/0x5a0 arch/x86/entry/common.c:294
 entry_SYSCALL_64_after_hwframe+0x49/0xbe

The buggy address belongs to the object at ffff8881cc138000
 which belongs to the cache names_cache of size 4096
The buggy address is located 232 bytes inside of
 4096-byte region [ffff8881cc138000, ffff8881cc139000)
The buggy address belongs to the page:
page:ffffea0007304e00 refcount:1 mapcount:0 mapping:ffff8881da11c000 index:0x0 compound_mapcount: 0
flags: 0x200000000010200(slab|head)
raw: 0200000000010200 dead000000000100 dead000000000122 ffff8881da11c000
raw: 0000000000000000 0000000000070007 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
 ffff8881cc137f80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff8881cc138000: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff8881cc138080: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                                          ^
 ffff8881cc138100: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff8881cc138180: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================


Tested on:

commit:         0fa84af8 Merge tag 'usb-serial-5.7-rc1' of https://git.ker..
git tree:       https://github.com/google/kasan.git
console output: https://syzkaller.appspot.com/x/log.txt?x=169d38d7e00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6b9c154b0c23aecf
dashboard link: https://syzkaller.appspot.com/bug?extid=7bf5a7b0f0a1f9446f4c
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
patch:          https://syzkaller.appspot.com/x/patch.diff?x=17a95273e00000

