Return-Path: <SRS0=n6RB=27=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66DECC33CA4
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 15:34:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4128F2082E
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 15:34:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728356AbgAJPeL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jan 2020 10:34:11 -0500
Received: from mail-io1-f72.google.com ([209.85.166.72]:53021 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728245AbgAJPeL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jan 2020 10:34:11 -0500
Received: by mail-io1-f72.google.com with SMTP id d10so1742075iod.19
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jan 2020 07:34:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=2ea2up5FZ7JrvzSTMNWcmN3V3y0b3ZmC4Yl/SGBJfhg=;
        b=iZF41FeWHTBcJ9aXaT5gIbdtxZ7MRDo6Xs4NvJp/YChojIuwq9IT93NJP8b5fJE0nJ
         Pnstb/NspdyK8ZeI1tzx4fUrjVEY6l0aya2qHpw3zex+108vbwQw+iiM6fGIYa01yllt
         pRSKbfXfsQgcsKfXeJwhj9Wvgu2EZsnT4t1MEmRzUWOgibKc/yeNgHk0MuGYTKa6jhgg
         rbW+lWg7HYo7/4KA+tkRqrHiA5wwNINttWPHi56GjHWE3fQimymGFgxeqmAQRKAJsh6F
         Xsaxmm8zS59LI/AfotHXzWyYuS51hrP4omQMKX09NIRErLWqLlgp0Uis9GRK2mjcjz9Q
         Dhlg==
X-Gm-Message-State: APjAAAUr6mwW+K7ho/6VWm6GAsiboZ6Hz1/aSWlxQxMGnE4PA0He/zn7
        EphxObJURd6KJcwHUnx+jjjuRhoM95tMFFOgOENYZo+xkTU4
X-Google-Smtp-Source: APXvYqz3Zp2Gwdr+APsQqeHj+XwtDCbIIU6J62AH2UZ96EDUcisgHOQnMyY3XeFQODP5PAnOLsZdSX5ZPkBpRX9uGXbObUGiOGSl
MIME-Version: 1.0
X-Received: by 2002:a05:6638:24f:: with SMTP id w15mr3611426jaq.130.1578670449846;
 Fri, 10 Jan 2020 07:34:09 -0800 (PST)
Date:   Fri, 10 Jan 2020 07:34:09 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000617449059bcadbd1@google.com>
Subject: BUG: corrupted list in uvc_scan_chain_forward
From:   syzbot <syzbot+636c17630dbe1250025a@syzkaller.appspotmail.com>
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
console output: https://syzkaller.appspot.com/x/log.txt?x=168765c6e00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4b345df402514029
dashboard link: https://syzkaller.appspot.com/bug?extid=636c17630dbe1250025a
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12b316aee00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13332d49e00000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+636c17630dbe1250025a@syzkaller.appspotmail.com

usb 1-1: New USB device strings: Mfr=1, Product=2, SerialNumber=3
usb 1-1: Product: syz
usb 1-1: Manufacturer: syz
usb 1-1: SerialNumber: syz
usb 1-1: config 0 descriptor??
uvcvideo: Found UVC 0.00 device syz (18cd:cafe)
list_add double add: new=ffff8881cdea0010, prev=ffff8881cdea0010,  
next=ffff8881d718f218.
------------[ cut here ]------------
kernel BUG at lib/list_debug.c:29!
invalid opcode: 0000 [#1] SMP KASAN
CPU: 0 PID: 95 Comm: kworker/0:2 Not tainted 5.5.0-rc3-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Workqueue: usb_hub_wq hub_event
RIP: 0010:__list_add_valid.cold+0x26/0x3c lib/list_debug.c:29
Code: 57 ff ff ff 4c 89 e1 48 c7 c7 c0 fa fb 85 e8 4b 20 40 ff 0f 0b 48 89  
f2 4c 89 e1 48 89 ee 48 c7 c7 00 fc fb 85 e8 34 20 40 ff <0f> 0b 48 89 f1  
48 c7 c7 80 fb fb 85 4c 89 e6 e8 20 20 40 ff 0f 0b
RSP: 0018:ffff8881d5d8f080 EFLAGS: 00010286
RAX: 0000000000000058 RBX: ffff8881cdea0010 RCX: 0000000000000000
RDX: 0000000000000000 RSI: ffffffff812959ad RDI: ffffed103abb1e02
RBP: ffff8881cdea0010 R08: 0000000000000058 R09: fffffbfff1269aae
R10: fffffbfff1269aad R11: ffffffff8934d56f R12: ffff8881d718f218
R13: ffff8881cdea0000 R14: dffffc0000000000 R15: ffff8881d718f218
FS:  0000000000000000(0000) GS:ffff8881db200000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f514c22d000 CR3: 00000001c6507000 CR4: 00000000001406f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
  __list_add include/linux/list.h:60 [inline]
  list_add_tail include/linux/list.h:93 [inline]
  uvc_scan_chain_forward.isra.0+0x4df/0x637  
drivers/media/usb/uvc/uvc_driver.c:1526
  uvc_scan_chain drivers/media/usb/uvc/uvc_driver.c:1640 [inline]
  uvc_scan_device drivers/media/usb/uvc/uvc_driver.c:1824 [inline]
  uvc_probe.cold+0x1aee/0x29de drivers/media/usb/uvc/uvc_driver.c:2197
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
Modules linked in:
---[ end trace 8c363b461f6a7f0a ]---
RIP: 0010:__list_add_valid.cold+0x26/0x3c lib/list_debug.c:29
Code: 57 ff ff ff 4c 89 e1 48 c7 c7 c0 fa fb 85 e8 4b 20 40 ff 0f 0b 48 89  
f2 4c 89 e1 48 89 ee 48 c7 c7 00 fc fb 85 e8 34 20 40 ff <0f> 0b 48 89 f1  
48 c7 c7 80 fb fb 85 4c 89 e6 e8 20 20 40 ff 0f 0b
RSP: 0018:ffff8881d5d8f080 EFLAGS: 00010286


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
