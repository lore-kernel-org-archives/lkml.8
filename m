Return-Path: <SRS0=3W8M=6B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20FD6C38A29
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 20:15:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F01D1206D9
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 20:15:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730997AbgDQUPG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Apr 2020 16:15:06 -0400
Received: from mail-io1-f69.google.com ([209.85.166.69]:34270 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730985AbgDQUPF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Apr 2020 16:15:05 -0400
Received: by mail-io1-f69.google.com with SMTP id n26so3226364iop.1
        for <linux-kernel@vger.kernel.org>; Fri, 17 Apr 2020 13:15:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=jF1h4LX0skx173PfeQ9Oun8slSBXlnVjMFWX9Tk/N9g=;
        b=ngAOMc1WZNZIjHFUMMAs8dkNoN3xJqJRfk37/S11eqY5y1qLfiqBdwqyizwjtfo0n1
         mTC3ZS9aKpOnJL9RTWpXwJUkM+jUxnArfMO5SPdrLM0+q7BrKGSTxP6/dwL+bPW+ChhU
         nLFTO3xRRXB/pdnUYoO6B4wskdj80G3YCQUr36pwfLwRARVULgWHgqYtOm4Fzp0QmAq/
         Q8piWNrXJcX/lUSNXT20bZfjICCozE9ElMwCy7wFcDeFLNl14HW5p0AP4ozQ4aN5G+3d
         mOMKCl0sAlr9ak6H2iPGngc2EsjmS0lodSne3yvM/oboFYlWjeqBTuD7KgH3Cyw7iLCQ
         t+Bw==
X-Gm-Message-State: AGi0PubvGDk07zxUBy3j4z+AHsQldYYNkwal5jaY4W/kxTWzwQpUlCjo
        3SnLJmx74WYxZ6F14a6c9AQ/pL6d/X920O+AGQtS8imCQEWy
X-Google-Smtp-Source: APiQypLaf2ti+QprOnCdJ08kPB8w0vQ+zVDEjjIO/WJHSR+tzJ7lVrzb89Zo0sGaOlsIUeJk8wfKLLIBOpyEJbcuMzBJhsDMTTQo
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:8b3:: with SMTP id a19mr4622872ilt.36.1587154503283;
 Fri, 17 Apr 2020 13:15:03 -0700 (PDT)
Date:   Fri, 17 Apr 2020 13:15:03 -0700
In-Reply-To: <Pine.LNX.4.44L0.2004171505170.25043-100000@netrider.rowland.org>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000005f3ae305a3823448@google.com>
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

usb 2-1: USB disconnect, device number 5
------------[ cut here ]------------
usbhid 2-1:0.0: Stop while open (alloc = 1)
WARNING: CPU: 0 PID: 12 at drivers/hid/usbhid/hid-core.c:1210 usbhid_stop+0x156/0x610 drivers/hid/usbhid/hid-core.c:1210
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
RIP: 0010:usbhid_stop+0x156/0x610 drivers/hid/usbhid/hid-core.c:1210
Code: 48 89 7c 24 08 e8 ea c4 bd fc 48 8b 7c 24 08 e8 10 95 f7 fd 48 8b 14 24 44 89 f9 48 c7 c7 80 45 84 86 48 89 c6 e8 92 55 92 fc <0f> 0b e8 c3 c4 bd fc 48 8d bd ac 1e 00 00 48 b8 00 00 00 00 00 fc
RSP: 0018:ffff8881da227640 EFLAGS: 00010282
RAX: 0000000000000000 RBX: ffff8881d8b48000 RCX: 0000000000000000
RDX: 0000000000000000 RSI: ffffffff812974dd RDI: ffffed103b444eba
RBP: ffff8881c7710000 R08: ffff8881da211880 R09: ffffed103b64439f
R10: ffffed103b64439e R11: ffff8881db221cf3 R12: ffff8881c54b0000
R13: ffff8881d8b4a9a8 R14: ffff8881c7711fd8 R15: 0000000000000001
 wacom_remove+0x88/0x3b0 drivers/hid/wacom_sys.c:2772
 hid_device_remove+0xed/0x240 drivers/hid/hid-core.c:2296
 __device_release_driver drivers/base/dd.c:1135 [inline]
 device_release_driver_internal+0x231/0x500 drivers/base/dd.c:1168
 bus_remove_device+0x2eb/0x5a0 drivers/base/bus.c:533
 device_del+0x481/0xd30 drivers/base/core.c:2677
 hid_remove_device drivers/hid/hid-core.c:2467 [inline]
 hid_destroy_device+0xe1/0x150 drivers/hid/hid-core.c:2486
 usbhid_disconnect+0x9f/0xe0 drivers/hid/usbhid/hid-core.c:1426
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
console output: https://syzkaller.appspot.com/x/log.txt?x=12dbb8f7e00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6b9c154b0c23aecf
dashboard link: https://syzkaller.appspot.com/bug?extid=7bf5a7b0f0a1f9446f4c
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
patch:          https://syzkaller.appspot.com/x/patch.diff?x=105bb8f7e00000

