Return-Path: <SRS0=8dav=5Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FE78C2D0EA
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 14:19:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72E532074F
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 14:19:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728554AbgDHOTa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Apr 2020 10:19:30 -0400
Received: from mail-il1-f198.google.com ([209.85.166.198]:56861 "EHLO
        mail-il1-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728501AbgDHOT3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Apr 2020 10:19:29 -0400
Received: by mail-il1-f198.google.com with SMTP id 191so5382896ilb.23
        for <linux-kernel@vger.kernel.org>; Wed, 08 Apr 2020 07:19:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=TzJl2eJqrV3NniGq9stMLFP0KwjNMjKGdek8VWiJ/5k=;
        b=Tpf70aLE/xA94eBF7o9FrPtEtMmWW4N9Dr0Ar+4PyZx9CQjljgcWQ1z/7Me29S3TXH
         agkK6JnLht5D/oHe1+2qzr2ZPAbNWKC3PqpcZrW+psGcoo+oVmxYw4qNwQRwovQnQ9Wc
         p2yUBud7Wgi4hOU6SfXnpxLYZfIceLcTpdiwtPDaAN3CpE13HL5pLcHZd19Dv7r37LyD
         SsjzSST7DASVmNWTSSldZXw1TqkjdoUZhfYJbwvws//8WDJemXP2tO8ErM2bkBLdeLlw
         U+wT4WToevJ5dvMPjRN0oQ/TLoClmfpo+jkbsKjFzuacRi8uRXcdtSbyzVFP29mb3LCa
         n/1w==
X-Gm-Message-State: AGi0PuaEneR/30GmjtanVAIPfp74/5Zsl9l75RJPmLB6vZZjUTQb8V/V
        /64aFQXqnuk+Q0kizBRPeBEffHK8pLvqUMwsMHTbOI8CvfAH
X-Google-Smtp-Source: APiQypJ5M4QzifR5kK5EiWmHZMEcNQDf3HpM5eWbMzy1VlqJDgANrcGrlmXWa+iJkv6kqCxdjVbiVI/agGiQdJw6WIddA1IbhRe0
MIME-Version: 1.0
X-Received: by 2002:a92:7eda:: with SMTP id q87mr7658504ill.179.1586355566701;
 Wed, 08 Apr 2020 07:19:26 -0700 (PDT)
Date:   Wed, 08 Apr 2020 07:19:16 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000000a9f7d05a2c8305a@google.com>
Subject: WARNING in gtco_input_open/usb_submit_urb (2)
From:   syzbot <syzbot+ab2a85d89a155440320b@syzkaller.appspotmail.com>
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

HEAD commit:    0fa84af8 Merge tag 'usb-serial-5.7-rc1' of https://git.ker..
git tree:       https://github.com/google/kasan.git usb-fuzzer
console output: https://syzkaller.appspot.com/x/log.txt?x=17a84c3be00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6b9c154b0c23aecf
dashboard link: https://syzkaller.appspot.com/bug?extid=ab2a85d89a155440320b
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12340e1be00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1112d61be00000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+ab2a85d89a155440320b@syzkaller.appspotmail.com

------------[ cut here ]------------
usb 1-1: BOGUS urb xfer, pipe 1 != type 3
WARNING: CPU: 0 PID: 367 at drivers/usb/core/urb.c:478 usb_submit_urb+0x1188/0x1460 drivers/usb/core/urb.c:478
Kernel panic - not syncing: panic_on_warn set ...
CPU: 0 PID: 367 Comm: systemd-udevd Not tainted 5.6.0-rc7-syzkaller #0
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
RIP: 0010:usb_submit_urb+0x1188/0x1460 drivers/usb/core/urb.c:478
Code: 4d 85 ed 74 46 e8 68 87 dd fd 4c 89 f7 e8 90 57 17 ff 41 89 d8 44 89 e1 4c 89 ea 48 89 c6 48 c7 c7 80 dd 3b 86 e8 10 18 b2 fd <0f> 0b e9 20 f4 ff ff e8 3c 87 dd fd 0f 1f 44 00 00 e8 32 87 dd fd
RSP: 0018:ffff8881cd36f7e0 EFLAGS: 00010286
RAX: 0000000000000000 RBX: 0000000000000003 RCX: 0000000000000000
RDX: 0000000000000000 RSI: ffffffff812974dd RDI: ffffed1039a6deee
RBP: ffff8881d4311180 R08: ffff8881d2760000 R09: ffffed103b646248
R10: ffffed103b646247 R11: ffff8881db23123f R12: 0000000000000001
R13: ffff8881da2a3e58 R14: ffff8881cd6fd0a0 R15: ffff8881d06bbf00
 gtco_input_open+0xd5/0x130 drivers/input/tablet/gtco.c:560
 input_open_device+0x16c/0x2c0 drivers/input/input.c:623
 evdev_open_device drivers/input/evdev.c:414 [inline]
 evdev_open+0x3dc/0x4f0 drivers/input/evdev.c:496
 chrdev_open+0x219/0x5c0 fs/char_dev.c:414
 do_dentry_open+0x494/0x1120 fs/open.c:797
 do_last fs/namei.c:3490 [inline]
 path_openat+0x1222/0x32a0 fs/namei.c:3607
 do_filp_open+0x192/0x260 fs/namei.c:3637
 do_sys_openat2+0x54c/0x740 fs/open.c:1146
 do_sys_open+0xc3/0x140 fs/open.c:1162
 do_syscall_64+0xb6/0x5a0 arch/x86/entry/common.c:294
 entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x7fa58f493840
Code: 73 01 c3 48 8b 0d 68 77 20 00 f7 d8 64 89 01 48 83 c8 ff c3 66 0f 1f 44 00 00 83 3d 89 bb 20 00 00 75 10 b8 02 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 31 c3 48 83 ec 08 e8 1e f6 ff ff 48 89 04 24
RSP: 002b:00007ffdd9e70518 EFLAGS: 00000246 ORIG_RAX: 0000000000000002
RAX: ffffffffffffffda RBX: 00005577299fd7e0 RCX: 00007fa58f493840
RDX: 0000000000000000 RSI: 0000000000080000 RDI: 00005577299eaa00
RBP: 00005577299eaa00 R08: 000055772884c670 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000020
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
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
