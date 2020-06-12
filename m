Return-Path: <SRS0=ixK5=7Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E88ADC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 12:04:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CA092207D8
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 12:04:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726296AbgFLMEP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jun 2020 08:04:15 -0400
Received: from mail-io1-f69.google.com ([209.85.166.69]:44074 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725886AbgFLMEO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jun 2020 08:04:14 -0400
Received: by mail-io1-f69.google.com with SMTP id v14so5932501iob.11
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jun 2020 05:04:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=IkHmIMUWMarD7vGen6l4PRhP59HL7lvb5Tbsm+A67uU=;
        b=VaboiShORIxvUnqNHSHOdv69pd7QRkaQUT4+5wB9CKY8itPx5J3ajl2qJ/0+dNse0d
         Uf+ru//K11rC66VBHgCnlSNPC84Vk8TlhqN8W2c4RGCNx+vPGIM3EFIRmcFBhkbZaFMh
         vUKvdtfo07VZqdNQTtOaVeUF4wpyZ8C2d1xD01fRZkJ5cML+9L9XIt4HIC8Gh/CRTxju
         6pMRO791lRr8XHzBUZa4rmq/S4wnHRNCn0F8e54tE9VtiqjY4iprSOQJ0pxJb3JdxT3n
         4WuJQxsCQegArsMXWW3j/526KkFv+ynyTi9lE2IEEo7DikOaYeJCeIWx/LIMKA6mqmo0
         AeJw==
X-Gm-Message-State: AOAM533eml0ksKwxkOSgQgxwonmSWGAsC7Lry6qMClcFPTiyhnjcHi2h
        n+cCOCbbNCzL9kpiqdsMgzariMUK3Ph4cyrB5Dl/NjckaWf5
X-Google-Smtp-Source: ABdhPJy212/T4MKm22Wz7/crkIu2MrbbmEL2fHGVtV5FCoO89jUr0s0+aG2iq3Yn4+UEJZPi8Oy+1gowNjZZZ+GrKx4Pvw8V2uTA
MIME-Version: 1.0
X-Received: by 2002:a05:6638:d08:: with SMTP id q8mr7640983jaj.77.1591963452207;
 Fri, 12 Jun 2020 05:04:12 -0700 (PDT)
Date:   Fri, 12 Jun 2020 05:04:12 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000107efa05a7e1e06c@google.com>
Subject: WARNING in pegasus_open/usb_submit_urb
From:   syzbot <syzbot+04ee0cb4caccaed12d78@syzkaller.appspotmail.com>
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

HEAD commit:    2089c6ed usb: core: kcov: collect coverage from usb comple..
git tree:       https://github.com/google/kasan.git usb-fuzzer
console output: https://syzkaller.appspot.com/x/log.txt?x=139b2e71100000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b7479d3935864b1b
dashboard link: https://syzkaller.appspot.com/bug?extid=04ee0cb4caccaed12d78
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=141cc89e100000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10ca168e100000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+04ee0cb4caccaed12d78@syzkaller.appspotmail.com

------------[ cut here ]------------
usb 1-1: BOGUS urb xfer, pipe 1 != type 3
WARNING: CPU: 0 PID: 370 at drivers/usb/core/urb.c:478 usb_submit_urb+0x1188/0x1460 drivers/usb/core/urb.c:478
Kernel panic - not syncing: panic_on_warn set ...
CPU: 0 PID: 370 Comm: systemd-udevd Not tainted 5.7.0-rc6-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
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
Code: 4d 85 ed 74 46 e8 98 af d2 fd 4c 89 f7 e8 d0 a3 16 ff 41 89 d8 44 89 e1 4c 89 ea 48 89 c6 48 c7 c7 00 56 3d 86 e8 80 85 a6 fd <0f> 0b e9 20 f4 ff ff e8 6c af d2 fd 0f 1f 44 00 00 e8 62 af d2 fd
RSP: 0018:ffff8881cc58f770 EFLAGS: 00010286
RAX: 0000000000000000 RBX: 0000000000000003 RCX: 0000000000000000
RDX: 0000000000000000 RSI: ffffffff812a339d RDI: ffffed10398b1ee0
RBP: ffff8881cf6fcd00 R08: ffff8881cc7098c0 R09: ffffed103b64629a
R10: ffff8881db2314cf R11: ffffed103b646299 R12: 0000000000000001
R13: ffff8881c6a24510 R14: ffff8881cc96a0a0 R15: ffff8881cf92fb00
 pegasus_open+0x192/0x2f0 drivers/input/tablet/pegasus_notetaker.c:228
 input_open_device+0x16c/0x2c0 drivers/input/input.c:624
 evdev_open_device drivers/input/evdev.c:414 [inline]
 evdev_open+0x3e1/0x500 drivers/input/evdev.c:496
 chrdev_open+0x219/0x5c0 fs/char_dev.c:414
 do_dentry_open+0x4ac/0x1160 fs/open.c:797
 do_open fs/namei.c:3229 [inline]
 path_openat+0x1a0b/0x2740 fs/namei.c:3346
 do_filp_open+0x192/0x260 fs/namei.c:3373
 do_sys_openat2+0x585/0x7d0 fs/open.c:1148
 do_sys_open+0xc3/0x140 fs/open.c:1164
 do_syscall_64+0xb6/0x5a0 arch/x86/entry/common.c:295
 entry_SYSCALL_64_after_hwframe+0x49/0xb3
RIP: 0033:0x7f0b5e166840
Code: 73 01 c3 48 8b 0d 68 77 20 00 f7 d8 64 89 01 48 83 c8 ff c3 66 0f 1f 44 00 00 83 3d 89 bb 20 00 00 75 10 b8 02 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 31 c3 48 83 ec 08 e8 1e f6 ff ff 48 89 04 24
RSP: 002b:00007fff4c5536e8 EFLAGS: 00000246 ORIG_RAX: 0000000000000002
RAX: ffffffffffffffda RBX: 000055d7ce74c400 RCX: 00007f0b5e166840
RDX: 0000000000000000 RSI: 0000000000080000 RDI: 000055d7ce747d50
RBP: 000055d7ce747d50 R08: 000055d7ccf12670 R09: 0000000000000078
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000020
R13: 0000000000000000 R14: 0000000000000001 R15: 0000000000000000
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
