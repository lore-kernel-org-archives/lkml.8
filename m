Return-Path: <SRS0=ltrd=5B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81AF0C0044D
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 12:07:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B3CC20663
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 12:07:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730962AbgCPMHT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Mar 2020 08:07:19 -0400
Received: from mail-il1-f199.google.com ([209.85.166.199]:47522 "EHLO
        mail-il1-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730634AbgCPMHS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Mar 2020 08:07:18 -0400
Received: by mail-il1-f199.google.com with SMTP id a4so13629221ili.14
        for <linux-kernel@vger.kernel.org>; Mon, 16 Mar 2020 05:07:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=dRuqccKYr033rQt5jB/H6KmefDtJ3tGCzo6NLcwlFdA=;
        b=qqCjWCvKsfcuGSzG8F6wi33hQnpO8+f3Om2jsIFwy3pbERd73K/18OyWiG24/jJ0dH
         K3GJaqDHVtEqEReScQaI+m924fFLsPGxCzvFW94ZWBIggkDAEYLrZKgj1jJhkIpZWbTx
         s93VyovR5HVLBsbcsP4Hb4BkU7IP6bCSPxKwLe6bcz4lUrUOvrWPOGZvOxp3zdZqyOTb
         12pfNQ4I2U/vfS3MLZnlT2Vrtz/Z9YXGFfPmGir/NcILMuV0cK87HKuTuib1L6D5+5di
         MRNkcipEiX4hzdO1NJQnh1JwVdBo7yeocZs/7dNkvxmYZJXaXznEnaqfTu0KaGfo7eNn
         Rrmg==
X-Gm-Message-State: ANhLgQ2HUk4gm8uiOZxNlslUS2Sfqt2xCBTht25+Eby4Lwl6VhCNe03F
        JbWs7Dx6u+7vkS0vi1zarrdkOr6WrNyLagzMQESulPsdKZQi
X-Google-Smtp-Source: ADFU+vvJ7MrJO6zKelgCy/yLDXEtl1ZLfzgbTwCw4EuKnm75HJZ7/58hc1b76a+cQmC4APff5EElWsOfxvIY++jkFEyE599EvYjp
MIME-Version: 1.0
X-Received: by 2002:a92:9c54:: with SMTP id h81mr27320885ili.109.1584360435869;
 Mon, 16 Mar 2020 05:07:15 -0700 (PDT)
Date:   Mon, 16 Mar 2020 05:07:15 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f9ebab05a0f7a8db@google.com>
Subject: WARNING in hwarc_neep_init/usb_submit_urb
From:   syzbot <syzbot+cd4331d896a0c66f1e47@syzkaller.appspotmail.com>
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

HEAD commit:    d6ff8147 usb: gadget: add raw-gadget interface
git tree:       https://github.com/google/kasan.git usb-fuzzer
console output: https://syzkaller.appspot.com/x/log.txt?x=1525f753e00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=90a3d9bed5648419
dashboard link: https://syzkaller.appspot.com/bug?extid=cd4331d896a0c66f1e47
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17cf45e3e00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=140b7dc3e00000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+cd4331d896a0c66f1e47@syzkaller.appspotmail.com

usb 1-1: New USB device strings: Mfr=1, Product=2, SerialNumber=3
usb 1-1: Product: syz
usb 1-1: Manufacturer: syz
usb 1-1: SerialNumber: syz
usb 1-1: config 0 descriptor??
------------[ cut here ]------------
usb 1-1: BOGUS urb xfer, pipe 1 != type 3
WARNING: CPU: 1 PID: 102 at drivers/usb/core/urb.c:478 usb_submit_urb+0x1188/0x1460 drivers/usb/core/urb.c:478
Kernel panic - not syncing: panic_on_warn set ...
CPU: 1 PID: 102 Comm: kworker/1:2 Not tainted 5.6.0-rc3-syzkaller #0
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
Code: 4d 85 ed 74 46 e8 18 ce dd fd 4c 89 f7 e8 d0 5c 17 ff 41 89 d8 44 89 e1 4c 89 ea 48 89 c6 48 c7 c7 e0 e7 3b 86 e8 a0 5f b2 fd <0f> 0b e9 20 f4 ff ff e8 ec cd dd fd 0f 1f 44 00 00 e8 e2 cd dd fd
RSP: 0018:ffff8881d4ed7068 EFLAGS: 00010286
RAX: 0000000000000000 RBX: 0000000000000003 RCX: 0000000000000000
RDX: 0000000000000000 RSI: ffffffff812977dd RDI: ffffed103a9dadff
RBP: ffff8881cfa0a080 R08: ffff8881d52a3100 R09: fffffbfff1266c8f
R10: fffffbfff1266c8e R11: ffffffff89336477 R12: 0000000000000001
R13: ffff8881d4f2c1b0 R14: ffff8881cdcf10a0 R15: ffff8881d4f1ab00
 hwarc_neep_init+0x427/0x5e0 drivers/staging/uwb/hwa-rc.c:693
 uwb_rc_add+0x224/0x42f drivers/staging/uwb/lc-rc.c:347
 hwarc_probe+0x3ce/0xb40 drivers/staging/uwb/hwa-rc.c:843
 usb_probe_interface+0x310/0x800 drivers/usb/core/driver.c:374
 really_probe+0x290/0xac0 drivers/base/dd.c:551
 driver_probe_device+0x223/0x350 drivers/base/dd.c:724
 __device_attach_driver+0x1d1/0x290 drivers/base/dd.c:831
 bus_for_each_drv+0x162/0x1e0 drivers/base/bus.c:431
 __device_attach+0x217/0x390 drivers/base/dd.c:897
 bus_probe_device+0x1e4/0x290 drivers/base/bus.c:491
 device_add+0x1459/0x1bf0 drivers/base/core.c:2487
 usb_set_configuration+0xe47/0x17d0 drivers/usb/core/message.c:2023
 usb_generic_driver_probe+0x9d/0xe0 drivers/usb/core/generic.c:241
 usb_probe_device+0xd9/0x230 drivers/usb/core/driver.c:272
 really_probe+0x290/0xac0 drivers/base/dd.c:551
 driver_probe_device+0x223/0x350 drivers/base/dd.c:724
 __device_attach_driver+0x1d1/0x290 drivers/base/dd.c:831
 bus_for_each_drv+0x162/0x1e0 drivers/base/bus.c:431
 __device_attach+0x217/0x390 drivers/base/dd.c:897
 bus_probe_device+0x1e4/0x290 drivers/base/bus.c:491
 device_add+0x1459/0x1bf0 drivers/base/core.c:2487
 usb_new_device.cold+0x540/0xcd0 drivers/usb/core/hub.c:2544
 hub_port_connect drivers/usb/core/hub.c:5191 [inline]
 hub_port_connect_change drivers/usb/core/hub.c:5331 [inline]
 port_event drivers/usb/core/hub.c:5477 [inline]
 hub_event+0x21cb/0x4300 drivers/usb/core/hub.c:5559
 process_one_work+0x94b/0x1620 kernel/workqueue.c:2264
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
