Return-Path: <SRS0=3CHW=6C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0510C3A5A0
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Apr 2020 20:32:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D405321D6C
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Apr 2020 20:32:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728306AbgDRUcF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Apr 2020 16:32:05 -0400
Received: from mail-io1-f72.google.com ([209.85.166.72]:52150 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726014AbgDRUcE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Apr 2020 16:32:04 -0400
Received: by mail-io1-f72.google.com with SMTP id k1so1863849iov.18
        for <linux-kernel@vger.kernel.org>; Sat, 18 Apr 2020 13:32:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=4j/wJyokYK44Hc42WMvLPDps1kfmpnB2q5d2vVNyVB0=;
        b=TeYYhyjsccvKHzf8Va7ntFdqHfyTJKmqd8FQTQ3q2Z9VIr5snO1WxnwNl2FyLNu70f
         I9liSzcwiGMAKmAECbZbNA9R1T8imF9GmeprNzY05DM2Ov87JWjbFr2wcJOyTDUoXgep
         OxiHaiZ/qaLNCVw6qH1c/DUCbkCxDrpNJeCfe30jb8rKp6yQqeSfIbfZ0lLsdvw5YzHv
         IG7dDI2IqK5SIlQzczpHouWld16w+sQD6PE/xEuaYyV/BlpS/G4gCV/V1E2Fc/7UZc33
         hJWgZPNv/7sWzUvSm6kZI0PCMI0/SXofAZTjuMorSUS/N5/8yK3GCoDrlaeqzWhG6zN+
         02FA==
X-Gm-Message-State: AGi0Pubzpu209tarbBxoXyifDzue/B7Dp00TsIFu1QnTEUVzjksfZFTx
        Jm48M/MU+5Qnju8E2Z7+AygjANaUmqO3TQ9UFFVSpuCFlV+V
X-Google-Smtp-Source: APiQypKmZr0v+MVv1ritSQQlOa8XWMx6+hUDY6HrhYam9jNU2H9aqh19amQrNahQHpXjxNaLolSD0hXAKwP9MoQk+cRbY0yNna8e
MIME-Version: 1.0
X-Received: by 2002:a02:7125:: with SMTP id n37mr8426289jac.69.1587241922366;
 Sat, 18 Apr 2020 13:32:02 -0700 (PDT)
Date:   Sat, 18 Apr 2020 13:32:02 -0700
In-Reply-To: <Pine.LNX.4.44L0.2004181618050.8036-100000@netrider.rowland.org>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f4957305a3968e84@google.com>
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
WARNING in usbhid_stop

usbhid 6-1:0.0: Stop: 1 1 0 0
------------[ cut here ]------------
usbhid 6-1:0.0: Stop while open = 1
WARNING: CPU: 0 PID: 12 at drivers/hid/usbhid/hid-core.c:1205 usbhid_stop.cold+0x1fb/0x5e6 drivers/hid/usbhid/hid-core.c:1205
Kernel panic - not syncing: panic_on_warn set ...
CPU: 0 PID: 12 Comm: kworker/0:1 Not tainted 5.6.0-rc7-syzkaller #0
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
RIP: 0010:usbhid_stop.cold+0x1fb/0x5e6 drivers/hid/usbhid/hid-core.c:1205
Code: 48 89 7c 24 08 e8 0b 5f bd fc 48 8b 7c 24 08 e8 31 2f f7 fd 48 8b 14 24 44 89 f1 48 c7 c7 20 4b 84 86 48 89 c6 e8 b3 ef 91 fc <0f> 0b e8 e4 5e bd fc 48 8d bb ac 1e 00 00 b8 ff ff 37 00 48 89 fa
RSP: 0018:ffff8881da227640 EFLAGS: 00010282
RAX: 0000000000000000 RBX: ffff8881cf7a8000 RCX: 0000000000000000
RDX: 0000000000000000 RSI: ffffffff812974dd RDI: ffffed103b444eba
RBP: ffff8881d1de4000 R08: ffff8881da211880 R09: ffffed103b64439f
R10: ffffed103b64439e R11: ffff8881db221cf3 R12: ffff8881d1de4008
R13: ffff8881c5ff4000 R14: 0000000000000001 R15: ffff8881cf7a9fd8
 wacom_remove+0x88/0x3b0 drivers/hid/wacom_sys.c:2773
 hid_device_remove+0xed/0x1d0 drivers/hid/hid-core.c:2298
 __device_release_driver drivers/base/dd.c:1135 [inline]
 device_release_driver_internal+0x231/0x500 drivers/base/dd.c:1168
 bus_remove_device+0x2eb/0x5a0 drivers/base/bus.c:533
 device_del+0x481/0xd30 drivers/base/core.c:2677
 hid_remove_device drivers/hid/hid-core.c:2469 [inline]
 hid_destroy_device+0xe1/0x150 drivers/hid/hid-core.c:2488
 usbhid_disconnect+0x9f/0xe0 drivers/hid/usbhid/hid-core.c:1420
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
Kernel Offset: disabled
Rebooting in 86400 seconds..


Tested on:

commit:         0fa84af8 Merge tag 'usb-serial-5.7-rc1' of https://git.ker..
git tree:       https://github.com/google/kasan.git
console output: https://syzkaller.appspot.com/x/log.txt?x=17f91227e00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6b9c154b0c23aecf
dashboard link: https://syzkaller.appspot.com/bug?extid=7bf5a7b0f0a1f9446f4c
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1216d073e00000

