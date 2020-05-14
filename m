Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB51AC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 20:18:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 913C02065F
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 20:18:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727899AbgENUSP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 16:18:15 -0400
Received: from mail-il1-f199.google.com ([209.85.166.199]:42910 "EHLO
        mail-il1-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726035AbgENUSM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 16:18:12 -0400
Received: by mail-il1-f199.google.com with SMTP id a13so4361687ila.9
        for <linux-kernel@vger.kernel.org>; Thu, 14 May 2020 13:18:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=DeXjDYHmOwesipnsIKPMEZ1+4ozFBXqUZp0fQq+0Nyw=;
        b=trRJJso1GF1IbvOcyy8e0mv+dC/OL9bJPEaOpTjH6zF4yv/BxXQzYxE3Ln6vDIJMuW
         7iLOzDW4CamlrdeZTCFuLgb2mpnVxi1xn3ko2bdCq7Wtb6AhrsnnMoNJotnIMAaUNiza
         s5Dt1LYE+WNqmWqJTEG3sC1crwdCQeLrTiBwxkcQ6dE23nHmOEx9wMBpnP6ge1T1rckX
         kNjestrFX9VmyBqNqHezYn0wgHtkwhk19fuPc9lxTDvkAwFcOdmMNp8ZgnmRxPOtcPya
         Kp8WJPZDGHmwGDnlHJPuGRN0LuMmlxw/VT5PCJWJN6LlMjlIiqSlY+suzzGl+LR35zG6
         waOg==
X-Gm-Message-State: AOAM5314lmoQHh5EI9vXaoNhzzMo8hNggGWVNYXHp2oPmJT7PSNO1mth
        6Lt7zLrx2uQfTM8hiQKgwIDRd//9UzdPxavOqQNCFrtnjxWZ
X-Google-Smtp-Source: ABdhPJx18/IHJI1GPEwb9TPDpxaTVnV4BHV7LzVRW6V0NgBXx6yTbmdMW2gzQY115FVFY9VQKnYEmhFRym2Z5EhIejWsKtPOk3gl
MIME-Version: 1.0
X-Received: by 2002:a6b:38c6:: with SMTP id f189mr5690237ioa.81.1589487491460;
 Thu, 14 May 2020 13:18:11 -0700 (PDT)
Date:   Thu, 14 May 2020 13:18:11 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000004dbaa505a5a165f7@google.com>
Subject: WARNING in carl9170_usb_submit_cmd_urb/usb_submit_urb
From:   syzbot <syzbot+9468df99cb63a4a4c4e1@syzkaller.appspotmail.com>
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

HEAD commit:    059e7e0f usb: raw-gadget: fix typo in uapi headers
git tree:       https://github.com/google/kasan.git usb-fuzzer
console output: https://syzkaller.appspot.com/x/log.txt?x=179bc3c2100000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b484a6e53b2b06ad
dashboard link: https://syzkaller.appspot.com/bug?extid=9468df99cb63a4a4c4e1
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=177d01c6100000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13052f48100000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+9468df99cb63a4a4c4e1@syzkaller.appspotmail.com

usb 1-1: reset full-speed USB device number 2 using dummy_hcd
------------[ cut here ]------------
usb 1-1: BOGUS urb xfer, pipe 1 != type 3
WARNING: CPU: 1 PID: 17 at drivers/usb/core/urb.c:478 usb_submit_urb+0x1188/0x1460 drivers/usb/core/urb.c:478
Kernel panic - not syncing: panic_on_warn set ...
CPU: 1 PID: 17 Comm: kworker/1:0 Not tainted 5.7.0-rc1-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Workqueue: usb_hub_wq hub_event
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0xef/0x16e lib/dump_stack.c:118
 panic+0x2aa/0x6e1 kernel/panic.c:221
 __warn.cold+0x2f/0x30 kernel/panic.c:582
 report_bug+0x27b/0x2f0 lib/bug.c:195
 fixup_bug arch/x86/kernel/traps.c:175 [inline]
 fixup_bug arch/x86/kernel/traps.c:170 [inline]
 do_error_trap+0x12b/0x1e0 arch/x86/kernel/traps.c:267
 do_invalid_op+0x32/0x40 arch/x86/kernel/traps.c:286
 invalid_op+0x23/0x30 arch/x86/entry/entry_64.S:1027
RIP: 0010:usb_submit_urb+0x1188/0x1460 drivers/usb/core/urb.c:478
Code: 4d 85 ed 74 46 e8 38 c2 d2 fd 4c 89 f7 e8 70 ac 16 ff 41 89 d8 44 89 e1 4c 89 ea 48 89 c6 48 c7 c7 00 52 3d 86 e8 40 96 a6 fd <0f> 0b e9 20 f4 ff ff e8 0c c2 d2 fd 0f 1f 44 00 00 e8 02 c2 d2 fd
RSP: 0018:ffff8881da25ef40 EFLAGS: 00010282
RAX: 0000000000000000 RBX: 0000000000000003 RCX: 0000000000000000
RDX: 0000000000000000 RSI: ffffffff812a2d8d RDI: ffffed103b44bdda
RBP: ffff8881d9846050 R08: ffff8881da243180 R09: ffffed103b666292
R10: ffff8881db33148f R11: ffffed103b666291 R12: 0000000000000001
R13: ffff8881d8c365e8 R14: ffff8881cd6940a0 R15: ffff8881cfb0a100
 carl9170_usb_submit_cmd_urb+0xa5/0x120 drivers/net/wireless/ath/carl9170/usb.c:229
 __carl9170_exec_cmd+0x313/0x5c0 drivers/net/wireless/ath/carl9170/usb.c:643
 carl9170_reboot+0xaf/0xf0 drivers/net/wireless/ath/carl9170/cmd.c:141
 carl9170_usb_disconnect+0xee/0x130 drivers/net/wireless/ath/carl9170/usb.c:1117
 usb_unbind_interface+0x1bd/0x8a0 drivers/usb/core/driver.c:436
 __device_release_driver drivers/base/dd.c:1114 [inline]
 device_release_driver_internal+0x432/0x500 drivers/base/dd.c:1145
 usb_driver_release_interface+0x102/0x180 drivers/usb/core/driver.c:609
 usb_forced_unbind_intf+0x50/0xb0 drivers/usb/core/driver.c:1057
 usb_reset_device+0x39d/0x960 drivers/usb/core/hub.c:5933
 carl9170_usb_probe+0x48/0xd40 drivers/net/wireless/ath/carl9170/usb.c:1044
 usb_probe_interface+0x310/0x800 drivers/usb/core/driver.c:374
 really_probe+0x290/0xac0 drivers/base/dd.c:527
 driver_probe_device+0x223/0x350 drivers/base/dd.c:701
 __device_attach_driver+0x1d1/0x290 drivers/base/dd.c:808
 bus_for_each_drv+0x162/0x1e0 drivers/base/bus.c:431
 __device_attach+0x21a/0x390 drivers/base/dd.c:874
 bus_probe_device+0x1e4/0x290 drivers/base/bus.c:491
 device_add+0x1367/0x1c20 drivers/base/core.c:2533
 usb_set_configuration+0xed4/0x1850 drivers/usb/core/message.c:2025
 usb_generic_driver_probe+0x9d/0xe0 drivers/usb/core/generic.c:241
 usb_probe_device+0xd9/0x230 drivers/usb/core/driver.c:272
 really_probe+0x290/0xac0 drivers/base/dd.c:527
 driver_probe_device+0x223/0x350 drivers/base/dd.c:701
 __device_attach_driver+0x1d1/0x290 drivers/base/dd.c:808
 bus_for_each_drv+0x162/0x1e0 drivers/base/bus.c:431
 __device_attach+0x21a/0x390 drivers/base/dd.c:874
 bus_probe_device+0x1e4/0x290 drivers/base/bus.c:491
 device_add+0x1367/0x1c20 drivers/base/core.c:2533
 usb_new_device.cold+0x552/0xf6e drivers/usb/core/hub.c:2548
 hub_port_connect drivers/usb/core/hub.c:5195 [inline]
 hub_port_connect_change drivers/usb/core/hub.c:5335 [inline]
 port_event drivers/usb/core/hub.c:5481 [inline]
 hub_event+0x226d/0x43c0 drivers/usb/core/hub.c:5563
 process_one_work+0x965/0x1630 kernel/workqueue.c:2268
 worker_thread+0x96/0xe20 kernel/workqueue.c:2414
 kthread+0x326/0x430 kernel/kthread.c:268
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
