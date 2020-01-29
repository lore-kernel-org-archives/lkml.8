Return-Path: <SRS0=xNW4=3S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0733FC35240
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 12:27:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB66020702
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 12:27:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726650AbgA2M1L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jan 2020 07:27:11 -0500
Received: from mail-io1-f70.google.com ([209.85.166.70]:53877 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726142AbgA2M1K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jan 2020 07:27:10 -0500
Received: by mail-io1-f70.google.com with SMTP id q24so6534669iot.20
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jan 2020 04:27:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=1LU7cT1NM4zJrmEpKD8Xx8DzjfpEkyjd7mAueUGcFA4=;
        b=cKkZNus8attjqA5agCC9rRZ+oknQiQ3oJLL9XROoJS48sCfNtAF1Eo+MJdgbXlZRMx
         80gzEIe9vLZV91452QGBUxfcy6Nk+exyyKsjTLoquuALeNJ2sZEHv1rlR8rMCo346Qtj
         cZ2uBzIXQSnmnMXUTU30BWiEjXwE9mqFUja2SvW0BgXZz1fwPZTu7IdyWSLt0dH9casT
         dZU2HCo6ZH2fDYeGH9clVcJ2YX/Tm8icaH6VIT+eS2kxTv5qYOiBgV9BT4dzX6/6OG+A
         6dzUK3ubfTXZqfljpQBdk2bXIcuJ4O0SvsG/QcaeUnNSclVGqSm2oq5P2vdUyI0V66nf
         c97w==
X-Gm-Message-State: APjAAAV52Q+IxTiyuV4Z1YztoSqcubyibOa6BG63CTXBLm3KWiyepRxM
        nQWNdX+aTsuMTzn66BF9hLtHdL56OZf5gw+nbMUvxkrZVXYZ
X-Google-Smtp-Source: APXvYqyNNrRfVc3UyNQSHPkK7stFmdv/ZckLWKDUYrA32R2im2tl3cGAMvD4/gIXTVOHZxoxgKtB42vprg8vDW7+E4Q2MgUMWssJ
MIME-Version: 1.0
X-Received: by 2002:a02:5206:: with SMTP id d6mr3952937jab.8.1580300829579;
 Wed, 29 Jan 2020 04:27:09 -0800 (PST)
Date:   Wed, 29 Jan 2020 04:27:09 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000095e1d8059d4675ac@google.com>
Subject: WARNING in ar5523_cmd/usb_submit_urb
From:   syzbot <syzbot+1bc2c2afd44f820a669f@syzkaller.appspotmail.com>
To:     andreyknvl@google.com, gregkh@linuxfoundation.org,
        ingrassia@epigenesys.com, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    cd234325 usb: gadget: add raw-gadget interface
git tree:       https://github.com/google/kasan.git usb-fuzzer
console output: https://syzkaller.appspot.com/x/log.txt?x=146bf3c9e00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=bb745005307bc641
dashboard link: https://syzkaller.appspot.com/bug?extid=1bc2c2afd44f820a669f
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1646cf35e00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11017735e00000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+1bc2c2afd44f820a669f@syzkaller.appspotmail.com

usb 1-1: New USB device strings: Mfr=1, Product=2, SerialNumber=3
usb 1-1: Product: syz
usb 1-1: Manufacturer: syz
usb 1-1: SerialNumber: syz
------------[ cut here ]------------
usb 1-1: BOGUS urb xfer, pipe 3 != type 1
WARNING: CPU: 0 PID: 95 at drivers/usb/core/urb.c:478 usb_submit_urb+0x1188/0x1460 drivers/usb/core/urb.c:478
Kernel panic - not syncing: panic_on_warn set ...
CPU: 0 PID: 95 Comm: kworker/0:2 Not tainted 5.5.0-rc7-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Workqueue: usb_hub_wq hub_event
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0xef/0x16e lib/dump_stack.c:118
 panic+0x2aa/0x6e1 kernel/panic.c:221
 __warn.cold+0x2f/0x30 kernel/panic.c:582
 report_bug+0x27b/0x2f0 lib/bug.c:195
 fixup_bug arch/x86/kernel/traps.c:174 [inline]
 fixup_bug arch/x86/kernel/traps.c:169 [inline]
 do_error_trap+0x12b/0x1e0 arch/x86/kernel/traps.c:267
 do_invalid_op+0x32/0x40 arch/x86/kernel/traps.c:286
 invalid_op+0x23/0x30 arch/x86/entry/entry_64.S:1027
RIP: 0010:usb_submit_urb+0x1188/0x1460 drivers/usb/core/urb.c:478
Code: 4d 85 ed 74 46 e8 28 2d e1 fd 4c 89 f7 e8 d0 87 17 ff 41 89 d8 44 89 e1 4c 89 ea 48 89 c6 48 c7 c7 a0 2b 3b 86 e8 20 13 b6 fd <0f> 0b e9 20 f4 ff ff e8 fc 2c e1 fd 0f 1f 44 00 00 e8 f2 2c e1 fd
RSP: 0018:ffff8881d58cf0d8 EFLAGS: 00010286
RAX: 0000000000000000 RBX: 0000000000000001 RCX: 0000000000000000
RDX: 0000000000000000 RSI: ffffffff81295a0d RDI: ffffed103ab19e0d
RBP: ffff8881cd478050 R08: ffff8881d71ac980 R09: fffffbfff1269cae
R10: fffffbfff1269cad R11: ffffffff8934e56f R12: 0000000000000003
R13: ffff8881d098eee8 R14: ffff8881cda730a0 R15: ffff8881d5583b00
 ar5523_cmd+0x438/0x7a0 drivers/net/wireless/ath/ar5523/ar5523.c:271
 ar5523_cmd_read drivers/net/wireless/ath/ar5523/ar5523.c:298 [inline]
 ar5523_host_available drivers/net/wireless/ath/ar5523/ar5523.c:1372 [inline]
 ar5523_probe+0xc11/0x1ad0 drivers/net/wireless/ath/ar5523/ar5523.c:1652
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
 usb_new_device.cold+0x540/0xcd0 drivers/usb/core/hub.c:2538
 hub_port_connect drivers/usb/core/hub.c:5185 [inline]
 hub_port_connect_change drivers/usb/core/hub.c:5325 [inline]
 port_event drivers/usb/core/hub.c:5471 [inline]
 hub_event+0x21cb/0x4300 drivers/usb/core/hub.c:5553
 process_one_work+0x945/0x15c0 kernel/workqueue.c:2264
 worker_thread+0x96/0xe20 kernel/workqueue.c:2410
 kthread+0x318/0x420 kernel/kthread.c:255
 ret_from_fork+0x24/0x30 arch/x86/entry/entry_64.S:352
Kernel Offset: disabled
Rebooting in 86400 seconds..


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
