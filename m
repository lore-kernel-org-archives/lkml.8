Return-Path: <SRS0=z1XV=3D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78BFFC33CB2
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 13:04:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59B5F2467C
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 13:04:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729565AbgANNEM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jan 2020 08:04:12 -0500
Received: from mail-io1-f72.google.com ([209.85.166.72]:51856 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728841AbgANNEK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 08:04:10 -0500
Received: by mail-io1-f72.google.com with SMTP id t18so7869033iob.18
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jan 2020 05:04:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=PT0cBtZx5sf4C7sOZI0lYFDTazUj6f+DBHsk1defxRs=;
        b=UJZkQ662DG/Td6jmFCe9lx7ZRpSgblO/VYMeTpqSP0Zo+/ERKWdEFeAWA8bsr5/5SH
         XU8Cc5xcAcEDRJyDXY3SsPUNsIT78Jz3v8eqmLQgpIir5M3YxiYbWmmenmCaWZdA5bWd
         M2+VYYyaTunRrHm+Hrhb+SJXRe+DN2/QKRQ5jSQJYAhZGEgf14SNAj+oa6C8V8i0x/vC
         ogiKg+r7E50gofQxdNpwUSB7MVsOKPfTj3Y9NwnpeBHl/o4kiQ0oDtREdgf6J03rg81s
         wPOGyadvDKA+4AGC+RJ5+4c2mpGytiAcvOEafiteuLp9tBf7stoFE0EM3+38VgwdTTRU
         U6OQ==
X-Gm-Message-State: APjAAAVRbFXCB4kFcRAD8QiyWH7mumpHnTGyPlnyGBMqCpuJWJcXg0T6
        6dhM/ceiB07wHChn9Ba9WJd32Pq49v8uFaSTI2zlTHUAYZII
X-Google-Smtp-Source: APXvYqwKDbcpZiOzIXGLcCsm5MsfFdjM0n1mXm67eLDjUmyXgcZch0pdxWsANL2U16Dsy+LV25Q9WvhZtZQ/x+tgmWfa2pPBASJB
MIME-Version: 1.0
X-Received: by 2002:a92:d608:: with SMTP id w8mr2113372ilm.95.1579007049378;
 Tue, 14 Jan 2020 05:04:09 -0800 (PST)
Date:   Tue, 14 Jan 2020 05:04:09 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000046b2bf059c193afb@google.com>
Subject: WARNING in usbhid_raw_request/usb_submit_urb (3)
From:   syzbot <syzbot+db339689b2101f6f6071@syzkaller.appspotmail.com>
To:     andreyknvl@google.com, gregkh@linuxfoundation.org,
        ingrassia@epigenesys.com, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    5a67532c usb: gadget: add raw-gadget interface
git tree:       https://github.com/google/kasan.git usb-fuzzer
console output: https://syzkaller.appspot.com/x/log.txt?x=16e4bb25e00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=9ba75825443d54bd
dashboard link: https://syzkaller.appspot.com/bug?extid=db339689b2101f6f6071
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+db339689b2101f6f6071@syzkaller.appspotmail.com

------------[ cut here ]------------
usb 3-1: BOGUS urb xfer, pipe 2 != type 2
WARNING: CPU: 0 PID: 23154 at drivers/usb/core/urb.c:478  
usb_submit_urb+0x1188/0x1460 drivers/usb/core/urb.c:478
Kernel panic - not syncing: panic_on_warn set ...
CPU: 0 PID: 23154 Comm: syz-executor.2 Not tainted 5.5.0-rc6-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
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
Code: 4d 85 ed 74 46 e8 a8 1c e1 fd 4c 89 f7 e8 90 87 17 ff 41 89 d8 44 89  
e1 4c 89 ea 48 89 c6 48 c7 c7 60 27 3b 86 e8 30 03 b6 fd <0f> 0b e9 20 f4  
ff ff e8 7c 1c e1 fd 0f 1f 44 00 00 e8 72 1c e1 fd
RSP: 0018:ffff8881d4227b18 EFLAGS: 00010282
RAX: 0000000000000000 RBX: 0000000000000002 RCX: 0000000000000000
RDX: 0000000000004c45 RSI: ffffffff8129598d RDI: ffffed103a844f55
RBP: 0000000000000000 R08: ffff8881cdc30000 R09: fffffbfff1269cb7
R10: fffffbfff1269cb6 R11: ffffffff8934e5b7 R12: 0000000000000002
R13: ffff8881caf26ab0 R14: ffff8881d40040a0 R15: ffff8881c6936d00
  usb_start_wait_urb+0x108/0x4c0 drivers/usb/core/message.c:57
  usb_internal_control_msg drivers/usb/core/message.c:101 [inline]
  usb_control_msg+0x31c/0x4a0 drivers/usb/core/message.c:152
  usbhid_set_raw_report drivers/hid/usbhid/hid-core.c:917 [inline]
  usbhid_raw_request+0x21f/0x640 drivers/hid/usbhid/hid-core.c:1265
  hid_hw_raw_request include/linux/hid.h:1079 [inline]
  hidraw_send_report+0x296/0x500 drivers/hid/hidraw.c:151
  hidraw_write+0x34/0x50 drivers/hid/hidraw.c:164
  __vfs_write+0x76/0x100 fs/read_write.c:494
  vfs_write+0x262/0x5c0 fs/read_write.c:558
  ksys_write+0x127/0x250 fs/read_write.c:611
  do_syscall_64+0xb6/0x5a0 arch/x86/entry/common.c:294
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x45af49
Code: ad b6 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 7b b6 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007f0d8bc69c78 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 000000000045af49
RDX: 000000000000000b RSI: 00000000200000c0 RDI: 0000000000000006
RBP: 000000000075bfc8 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f0d8bc6a6d4
R13: 00000000004ccfde R14: 00000000004e8570 R15: 00000000ffffffff
Kernel Offset: disabled
Rebooting in 86400 seconds..


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
