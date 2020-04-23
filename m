Return-Path: <SRS0=rw9U=6H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7D19C55185
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 01:36:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B160920787
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 01:36:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726513AbgDWBgG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 21:36:06 -0400
Received: from mail-il1-f200.google.com ([209.85.166.200]:37050 "EHLO
        mail-il1-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726454AbgDWBgE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 21:36:04 -0400
Received: by mail-il1-f200.google.com with SMTP id v9so3917661iln.4
        for <linux-kernel@vger.kernel.org>; Wed, 22 Apr 2020 18:36:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=FurOsJafTUjOU7htoinTVNM+xvVe0P4gX8irUYQlJoI=;
        b=ih4sjuJ8d5IpSeozgAVjKqeNKaW4nMrYhWFcMEESLTK5mSfT00uNIFx99mFsMEMW83
         abZZSS5UXsst9qNP0Ggpq0mRL81j4KwT1+FLL2Ks6OALF4cArL/4vEO7FXxQUOgroAKG
         YacQuU3924sXaLmc5Rip5OpvxQS/VKEB4y/ZRhbZEoHWyqMrw+GzAZ7L747tkbMLjeCl
         +6yikEHWdVBV9I7+CKlmElKnemwviz/MXaGgVLSipuBLBoBOb8Ib33e2VwSehTQ2seY0
         tPqk4yxTRKUNmIV8sdDxr1NXtcJjPv965WycC68VG9gPr1b6dkh8AsmjTKMUYK+SdN3b
         1bJQ==
X-Gm-Message-State: AGi0PuZIxXOnifwgF3GM9ZSoKqiqscN2Y0Mf8MWB2AOQKCUt6uCW5a8V
        mlLs8D/j1qKQfMJE6Y5x79CbGKavosRdeQAL8DtZN5BbxvEh
X-Google-Smtp-Source: APiQypLxwT9vIB8z1xbpNZFZYJtukGXqrgEPUjrPuRJFkBzGiQ0BPObrAusrWakDQBgEMUE0AvWRr3C89uTip5icnivgbFUMyGN9
MIME-Version: 1.0
X-Received: by 2002:a6b:5109:: with SMTP id f9mr1539650iob.125.1587605763890;
 Wed, 22 Apr 2020 18:36:03 -0700 (PDT)
Date:   Wed, 22 Apr 2020 18:36:03 -0700
In-Reply-To: <Pine.LNX.4.44L0.2004222111060.7643-100000@netrider.rowland.org>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000099a4f005a3eb458b@google.com>
Subject: Re: WARNING in usbhid_raw_request/usb_submit_urb (3)
From:   syzbot <syzbot+db339689b2101f6f6071@syzkaller.appspotmail.com>
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
WARNING in usbhid_raw_request/usb_submit_urb

usb 5-1: Ep 0 disabled: 2 0
------------[ cut here ]------------
usb 5-1: BOGUS urb xfer, pipe 2 != type 2
WARNING: CPU: 0 PID: 6371 at drivers/usb/core/urb.c:482 usb_submit_urb+0xa41/0x1390 drivers/usb/core/urb.c:482
Kernel panic - not syncing: panic_on_warn set ...
CPU: 0 PID: 6371 Comm: syz-executor.4 Not tainted 5.6.0-rc7-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
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
RIP: 0010:usb_submit_urb+0xa41/0x1390 drivers/usb/core/urb.c:482
Code: 84 49 04 00 00 e8 7f 89 dd fd 4c 89 ef e8 87 59 17 ff 41 89 d8 44 89 e1 4c 89 f2 48 89 c6 48 c7 c7 c0 dd 3b 86 e8 27 1a b2 fd <0f> 0b e8 58 89 dd fd 0f b6 6c 24 08 bb 86 03 00 00 48 c7 c6 20 df
RSP: 0018:ffff8881be9afb30 EFLAGS: 00010282
RAX: 0000000000000000 RBX: 0000000000000002 RCX: 0000000000000000
RDX: 0000000000000000 RSI: ffffffff812974dd RDI: ffffed1037d35f58
RBP: 0000000000000000 R08: ffff8881d41fe200 R09: ffffed103b64439f
R10: ffffed103b64439e R11: ffff8881db221cf3 R12: 0000000000000002
R13: ffff8881cf1390a8 R14: ffff8881d8fb8e88 R15: ffff8881d89b8e00
 usb_start_wait_urb+0x108/0x4c0 drivers/usb/core/message.c:58
 usb_internal_control_msg drivers/usb/core/message.c:102 [inline]
 usb_control_msg+0x31c/0x4a0 drivers/usb/core/message.c:153
 usbhid_set_raw_report drivers/hid/usbhid/hid-core.c:917 [inline]
 usbhid_raw_request+0x225/0x620 drivers/hid/usbhid/hid-core.c:1265
 hid_hw_raw_request include/linux/hid.h:1079 [inline]
 hidraw_send_report+0x296/0x500 drivers/hid/hidraw.c:151
 hidraw_ioctl+0x620/0xaf0 drivers/hid/hidraw.c:422
 vfs_ioctl fs/ioctl.c:47 [inline]
 ksys_ioctl+0x11a/0x180 fs/ioctl.c:763
 __do_sys_ioctl fs/ioctl.c:772 [inline]
 __se_sys_ioctl fs/ioctl.c:770 [inline]
 __x64_sys_ioctl+0x6f/0xb0 fs/ioctl.c:770
 do_syscall_64+0xb6/0x5a0 arch/x86/entry/common.c:294
 entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x45c849
Code: ad b6 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 0f 83 7b b6 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007fa679711c78 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007fa6797126d4 RCX: 000000000045c849
RDX: 00000000200000c0 RSI: 0000000080404806 RDI: 0000000000000006
RBP: 000000000076bfa0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000ffffffff
R13: 0000000000000335 R14: 00000000004c59df R15: 000000000076bfac
Kernel Offset: disabled
Rebooting in 86400 seconds..


Tested on:

commit:         0fa84af8 Merge tag 'usb-serial-5.7-rc1' of https://git.ker..
git tree:       https://github.com/google/kasan.git
console output: https://syzkaller.appspot.com/x/log.txt?x=1120236fe00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6b9c154b0c23aecf
dashboard link: https://syzkaller.appspot.com/bug?extid=db339689b2101f6f6071
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1799b3bfe00000

