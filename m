Return-Path: <SRS0=vy7l=5K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 615DDC18E5B
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 08:58:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B8142073E
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 08:58:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727505AbgCYI6F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Mar 2020 04:58:05 -0400
Received: from mail-il1-f199.google.com ([209.85.166.199]:46936 "EHLO
        mail-il1-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727299AbgCYI6E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 04:58:04 -0400
Received: by mail-il1-f199.google.com with SMTP id n18so738111ilp.13
        for <linux-kernel@vger.kernel.org>; Wed, 25 Mar 2020 01:58:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=L8Gp4fpKlw1ZgWGVTY2L+Q5uD4JZwYfHNmiSYM07d7E=;
        b=LyTrJhHiFPWEdP/eQTz1NfB2x5YjORWCQFonLdgD+SMRe2CpvqLdvWamXRDCF5UA4X
         eTBE4wIAaOG10MXnEPF/999/SYBVxcW+oEM904nEzWswlrn4KlML5t03N9+P8QhTqk94
         jkooIjbwYguaICYyI8whC0mVNUWbIVsymM6tnjVyx7G7pr/DJJN7Z9Y0HwEZbPEN194H
         88xUWjie0pZVPIOqRpsG1bMQqlY1Bvse6k/JFn1Ibtx6g8D1AyH634V+ooeBfUvNNhuO
         yBGaSdlZvofbjP0XKfohxtPQpijRZsND5AxiciMrfjc3e8ex7HweXL2iN1daIwOIohNV
         dGWA==
X-Gm-Message-State: ANhLgQ21FDBXuS+IMxIa4iO5TBabag7HqcR2AvjD5UZIj4m3qphmGBot
        shmTx6BvycNQgEld19pL0ZeyAuhfqhZtqjgv+Pw/CvaSPngK
X-Google-Smtp-Source: ADFU+vtO46K96oh6iAF5/nW+TnSTMpQIm222n1vIjw6fQPpcq6B6J1HHaV2owk/wfCd5JOKDw5z685u6KRGOsS/UuyxT6CNq6QjC
MIME-Version: 1.0
X-Received: by 2002:a92:5b17:: with SMTP id p23mr2450155ilb.121.1585126683260;
 Wed, 25 Mar 2020 01:58:03 -0700 (PDT)
Date:   Wed, 25 Mar 2020 01:58:03 -0700
In-Reply-To: <CADG63jANt9w4rFWKg6cw_S4jvB+Q-2hyOp9Mm0WD3oyQofY6UA@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e13e1b05a1aa10f9@google.com>
Subject: Re: KASAN: slab-out-of-bounds Read in hfa384x_usbin_callback
From:   syzbot <syzbot+7d42d68643a35f71ac8a@syzkaller.appspotmail.com>
To:     andreyknvl@google.com, anenbupt@gmail.com,
        devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        nishkadg.linux@gmail.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch but the reproducer still triggered crash:
KASAN: use-after-free Read in hfa384x_usbin_callback

==================================================================
BUG: KASAN: use-after-free in memcpy include/linux/string.h:381 [inline]
BUG: KASAN: use-after-free in skb_put_data include/linux/skbuff.h:2284 [inline]
BUG: KASAN: use-after-free in hfa384x_int_rxmonitor drivers/staging/wlan-ng/hfa384x_usb.c:3412 [inline]
BUG: KASAN: use-after-free in hfa384x_usbin_rx drivers/staging/wlan-ng/hfa384x_usb.c:3312 [inline]
BUG: KASAN: use-after-free in hfa384x_usbin_callback+0x1993/0x2360 drivers/staging/wlan-ng/hfa384x_usb.c:3026
Read of size 19671 at addr ffff8881cda7b33c by task kworker/1:2/95

CPU: 1 PID: 95 Comm: kworker/1:2 Not tainted 5.6.0-rc5-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Workqueue: usb_hub_wq hub_event
Call Trace:
 <IRQ>
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0xef/0x16e lib/dump_stack.c:118
 print_address_description.constprop.0.cold+0xd3/0x314 mm/kasan/report.c:374
 __kasan_report.cold+0x37/0x77 mm/kasan/report.c:506
 kasan_report+0xe/0x20 mm/kasan/common.c:641
 check_memory_region_inline mm/kasan/generic.c:185 [inline]
 check_memory_region+0x152/0x1c0 mm/kasan/generic.c:192
 memcpy+0x20/0x50 mm/kasan/common.c:127
 memcpy include/linux/string.h:381 [inline]
 skb_put_data include/linux/skbuff.h:2284 [inline]
 hfa384x_int_rxmonitor drivers/staging/wlan-ng/hfa384x_usb.c:3412 [inline]
 hfa384x_usbin_rx drivers/staging/wlan-ng/hfa384x_usb.c:3312 [inline]
 hfa384x_usbin_callback+0x1993/0x2360 drivers/staging/wlan-ng/hfa384x_usb.c:3026
 __usb_hcd_giveback_urb+0x29a/0x550 drivers/usb/core/hcd.c:1650
 usb_hcd_giveback_urb+0x368/0x420 drivers/usb/core/hcd.c:1716
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
RIP: 0010:arch_local_irq_restore arch/x86/include/asm/irqflags.h:85 [inline]
RIP: 0010:__raw_spin_unlock_irqrestore include/linux/spinlock_api_smp.h:160 [inline]
RIP: 0010:_raw_spin_unlock_irqrestore+0x3b/0x40 kernel/locking/spinlock.c:191
Code: e8 2a e8 96 fb 48 89 ef e8 f2 c9 97 fb f6 c7 02 75 11 53 9d e8 16 50 b5 fb 65 ff 0d f7 bd 72 7a 5b 5d c3 e8 07 4e b5 fb 53 9d <eb> ed 0f 1f 00 55 48 89 fd 65 ff 05 dd bd 72 7a 45 31 c9 41 b8 01
RSP: 0018:ffff8881d56b6f40 EFLAGS: 00000293 ORIG_RAX: ffffffffffffff13
RAX: 0000000000000007 RBX: 0000000000000293 RCX: 0000000000000006
RDX: 0000000000000000 RSI: ffff8881d56a88f0 RDI: ffff8881d56a884c
RBP: ffff8881c0c64b80 R08: ffff8881d56a8000 R09: fffffbfff1266e8f
R10: fffffbfff1266e8e R11: ffffffff89337477 R12: 0000000000000000
R13: ffff8881c0c64bb8 R14: ffff8881c0c64b80 R15: ffff8881c0c64bb8
 hfa384x_usbctlx_submit+0x1cb/0x260 drivers/staging/wlan-ng/hfa384x_usb.c:3834
 hfa384x_docmd drivers/staging/wlan-ng/hfa384x_usb.c:1233 [inline]
 hfa384x_cmd_initialize+0x290/0x4f0 drivers/staging/wlan-ng/hfa384x_usb.c:846
 hfa384x_drvr_start+0x1f1/0x480 drivers/staging/wlan-ng/hfa384x_usb.c:2380
 prism2sta_ifstate+0x24e/0x510 drivers/staging/wlan-ng/prism2sta.c:471
 prism2sta_probe_usb.cold+0x1c8/0x49e drivers/staging/wlan-ng/prism2usb.c:112
 usb_probe_interface+0x310/0x800 drivers/usb/core/driver.c:374
 really_probe+0x290/0xac0 drivers/base/dd.c:551
 driver_probe_device+0x223/0x350 drivers/base/dd.c:724
 __device_attach_driver+0x1d1/0x290 drivers/base/dd.c:831
 bus_for_each_drv+0x162/0x1e0 drivers/base/bus.c:431
 __device_attach+0x217/0x390 drivers/base/dd.c:897
 bus_probe_device+0x1e4/0x290 drivers/base/bus.c:491
 device_add+0x1459/0x1bf0 drivers/base/core.c:2500
 usb_set_configuration+0xe47/0x17d0 drivers/usb/core/message.c:2023
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
 process_one_work+0x94b/0x1620 kernel/workqueue.c:2264
 worker_thread+0x96/0xe20 kernel/workqueue.c:2410
 kthread+0x318/0x420 kernel/kthread.c:255
 ret_from_fork+0x24/0x30 arch/x86/entry/entry_64.S:352

The buggy address belongs to the page:
page:ffffea0007369e00 refcount:32737 mapcount:0 mapping:0000000000000000 index:0x0 compound_mapcount: 0
flags: 0x200000000010000(head)
raw: 0200000000010000 dead000000000100 dead000000000122 0000000000000000
raw: 0000000000000000 0000000000000000 00007fe1ffffffff 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
 ffff8881cda7ff00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ffff8881cda7ff80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>ffff8881cda80000: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                   ^
 ffff8881cda80080: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff8881cda80100: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================


Tested on:

commit:         e17994d1 usb: core: kcov: collect coverage from usb comple..
git tree:       https://github.com/google/kasan.git
console output: https://syzkaller.appspot.com/x/log.txt?x=139ea05be00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5d64370c438bc60
dashboard link: https://syzkaller.appspot.com/bug?extid=7d42d68643a35f71ac8a
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
patch:          https://syzkaller.appspot.com/x/patch.diff?x=16d52b19e00000

