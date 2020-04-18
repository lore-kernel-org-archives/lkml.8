Return-Path: <SRS0=3CHW=6C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BA90C3A5A0
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Apr 2020 19:52:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 85DE922209
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Apr 2020 19:52:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728167AbgDRTwF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Apr 2020 15:52:05 -0400
Received: from mail-io1-f69.google.com ([209.85.166.69]:35204 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727951AbgDRTwE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Apr 2020 15:52:04 -0400
Received: by mail-io1-f69.google.com with SMTP id s26so6295237ioj.2
        for <linux-kernel@vger.kernel.org>; Sat, 18 Apr 2020 12:52:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=ProVAMl309G59qhkJMXmyS5J+8UD+08yaC3s25cSjaA=;
        b=A9eBMbrgh7PSzfox4gSgayZvkX/epn9GE+WXolck5zRnR+AU6UPPHDtQ+HdGKURge3
         kBEisYV33oBF5+7+h8yPGB4m9Q7FL88nUG2a2bC6d3aBgAlpoJhYfpmHDsynn5lGWhAA
         GBa+J5466lcY0mnwXW7q0zzNEPqqAW6BEJLN/an4iTpJhNXZ5uO+wh9BaaF+mRrPLFLg
         yy9u0liGl7eIBCAmlqoeQX6Q1b4vm/Byf6dBHFFPXbExvX3PEUMy88JSTLiKQkVVAhIP
         STw9tHL7jGgDD009SeweesndxrligBLj8/2aSSpUkrd4Azpu1rAuYoKZg7PK7wK2Emoh
         U38w==
X-Gm-Message-State: AGi0PuYvCpi9X6VSndW05P2dCpsrQ7LZRyzOOAMhGb0XuxsgeGyLnFNk
        v1PRevvHIM4SuFRGCs/e6AYeuBeNTzhXvnwqO/3+lOwIu5WF
X-Google-Smtp-Source: APiQypIU4FMsUnj2gDoJUQ6nmrUZTSsET23b6mk2As9QAEz4lSJG0e+/u5CRnkfl6tNHtK5xksGQ4X4tBBL0i3+4p/asCplORPcQ
MIME-Version: 1.0
X-Received: by 2002:a5d:96ca:: with SMTP id r10mr9035169iol.19.1587239523505;
 Sat, 18 Apr 2020 12:52:03 -0700 (PDT)
Date:   Sat, 18 Apr 2020 12:52:03 -0700
In-Reply-To: <Pine.LNX.4.44L0.2004181530500.8036-100000@netrider.rowland.org>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f8e27205a395ff6e@google.com>
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

usb 6-1: USB disconnect, device number 2
usbhid 6-1:0.0: Stop: 0 0 0
------------[ cut here ]------------
usbhid 6-1:0.0: Stop while open = 1
WARNING: CPU: 1 PID: 17 at drivers/hid/usbhid/hid-core.c:1205 usbhid_stop.cold+0x1c7/0x5a6 drivers/hid/usbhid/hid-core.c:1205
Kernel panic - not syncing: panic_on_warn set ...
CPU: 1 PID: 17 Comm: kworker/1:0 Not tainted 5.6.0-rc7-syzkaller #0
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
RIP: 0010:usbhid_stop.cold+0x1c7/0x5a6 drivers/hid/usbhid/hid-core.c:1205
Code: 48 89 7c 24 08 e8 9f 5e bd fc 48 8b 7c 24 08 e8 c5 2e f7 fd 48 8b 14 24 44 89 f9 48 c7 c7 20 4b 84 86 48 89 c6 e8 47 ef 91 fc <0f> 0b e8 78 5e bd fc 48 8d bb ac 1e 00 00 b8 ff ff 37 00 48 89 fa
RSP: 0018:ffff8881da267640 EFLAGS: 00010282
RAX: 0000000000000000 RBX: ffff8881cd788000 RCX: 0000000000000000
RDX: 0000000000000000 RSI: ffffffff812974dd RDI: ffffed103b44ceba
RBP: ffff8881cd22c000 R08: ffff8881da24b100 R09: ffffed103b66439f
R10: ffffed103b66439e R11: ffff8881db321cf3 R12: ffff8881cd789fd8
R13: ffff8881cd22c008 R14: ffff8881d6c41000 R15: 0000000000000001
 wacom_remove+0x88/0x3b0 drivers/hid/wacom_sys.c:2773
 hid_device_remove+0xed/0x240 drivers/hid/hid-core.c:2296
 __device_release_driver drivers/base/dd.c:1135 [inline]
 device_release_driver_internal+0x231/0x500 drivers/base/dd.c:1168
 bus_remove_device+0x2eb/0x5a0 drivers/base/bus.c:533
 device_del+0x481/0xd30 drivers/base/core.c:2677
 hid_remove_device drivers/hid/hid-core.c:2467 [inline]
 hid_destroy_device+0xe1/0x150 drivers/hid/hid-core.c:2486
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
console output: https://syzkaller.appspot.com/x/log.txt?x=165078f7e00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6b9c154b0c23aecf
dashboard link: https://syzkaller.appspot.com/bug?extid=7bf5a7b0f0a1f9446f4c
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
patch:          https://syzkaller.appspot.com/x/patch.diff?x=15cef627e00000

