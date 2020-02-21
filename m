Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDCF3C35646
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 16:28:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B892020578
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 16:28:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727469AbgBUQ2O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 11:28:14 -0500
Received: from mail-il1-f200.google.com ([209.85.166.200]:47035 "EHLO
        mail-il1-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726562AbgBUQ2N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 11:28:13 -0500
Received: by mail-il1-f200.google.com with SMTP id a2so3083067ill.13
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2020 08:28:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=clMuMR1V6dPqJJgttVDjf+CRSehGwrdG14coctzN2nA=;
        b=rshZ53dapKQ0rjFz4P8+PlZbaVrt0aKqd0kPJkXsSp3PSeNII1r/fBzjSpmaSyIZhk
         g1NIjAv6EskWTwm04KtAXuizbS/kfqoKOwk5uaCbUJVcpV3VOXOdTAOqt97r1K77p8gH
         pWVf4us1TTeLOCK0duD4VigapYwHButv5k8Sqi2fzMtlSuQvbijhAqQ8seF51BAPyK14
         cPwr2Bd3RL38+J843xsS/Bi0JC2TI3YVFg1XIOrj3wy1+uTPHumo5xr/m8nUnvc29l7E
         tjJF9xVum9nSVJlT8EVleSIk0t7kl1t1ifnU1MC7ksfiRbfAuyrg896Hp/xJ7ketxp0I
         Ilzg==
X-Gm-Message-State: APjAAAXL3JGSP72PtDd49Q47AzeSCZ5tuEA8OdgDw+7x/PU2lcU3gDqi
        5Qhr0/v2ybqqL+WJiGrBIdmELyJ9B1X9AagOzUwsnmxWkMJX
X-Google-Smtp-Source: APXvYqxeAN2Stw2KSkWN7JtuTAFv/VmE/7chW5sxDvwiFbTW38qELfJNf+bPw2kVxobx1ZwtWm0zJipQcQqkLd1/ulBSZx9ymVzQ
MIME-Version: 1.0
X-Received: by 2002:a02:84ee:: with SMTP id f101mr33988890jai.7.1582302492982;
 Fri, 21 Feb 2020 08:28:12 -0800 (PST)
Date:   Fri, 21 Feb 2020 08:28:12 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000058a87059f1882b9@google.com>
Subject: WARNING in dummy_free_request
From:   syzbot <syzbot+55ae006e0a1feae5aeab@syzkaller.appspotmail.com>
To:     andreyknvl@google.com, balbi@kernel.org, chunfeng.yun@mediatek.com,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, stern@rowland.harvard.edu,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    7f0cd6c7 usb: gadget: add raw-gadget interface
git tree:       https://github.com/google/kasan.git usb-fuzzer
console output: https://syzkaller.appspot.com/x/log.txt?x=17b58e5ee00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f10b12ae04e03319
dashboard link: https://syzkaller.appspot.com/bug?extid=55ae006e0a1feae5aeab
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+55ae006e0a1feae5aeab@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 1 PID: 19332 at drivers/usb/gadget/udc/dummy_hcd.c:679 dummy_free_request+0x6c/0x80 drivers/usb/gadget/udc/dummy_hcd.c:679
Kernel panic - not syncing: panic_on_warn set ...
CPU: 1 PID: 19332 Comm: syz-executor.5 Not tainted 5.6.0-rc1-syzkaller #0
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
RIP: 0010:dummy_free_request+0x6c/0x80 drivers/usb/gadget/udc/dummy_hcd.c:679
Code: c5 75 22 e8 26 06 96 fd 48 89 ef e8 3e 54 be fd 5b 5d e9 17 06 96 fd e8 12 06 96 fd 0f 0b 5b 5d e9 09 06 96 fd e8 04 06 96 fd <0f> 0b eb d5 48 89 ef e8 08 ae be fd eb c2 66 0f 1f 44 00 00 41 56
RSP: 0018:ffff8881c9eafdd8 EFLAGS: 00010016
RAX: 0000000000040000 RBX: ffff8881d0d5aa10 RCX: ffffc900012a0000
RDX: 000000000000012f RSI: ffffffff83a95c1c RDI: ffff8881d4d501c8
RBP: ffff8881d0d5aa00 R08: ffff8881d0f9b100 R09: ffffed103b666a84
R10: ffffed103b666a83 R11: ffff8881db33541b R12: 0000000000000212
R13: ffff8881ca832008 R14: 0000000000000000 R15: ffff8881ca832180
 raw_ioctl_ep_disable drivers/usb/gadget/legacy/raw_gadget.c:814 [inline]
 raw_ioctl+0x1281/0x19e0 drivers/usb/gadget/legacy/raw_gadget.c:1031
 vfs_ioctl fs/ioctl.c:47 [inline]
 ksys_ioctl+0x11a/0x180 fs/ioctl.c:763
 __do_sys_ioctl fs/ioctl.c:772 [inline]
 __se_sys_ioctl fs/ioctl.c:770 [inline]
 __x64_sys_ioctl+0x6f/0xb0 fs/ioctl.c:770
 do_syscall_64+0xb6/0x5a0 arch/x86/entry/common.c:294
 entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x45c537
Code: 48 83 c4 08 48 89 d8 5b 5d c3 66 0f 1f 84 00 00 00 00 00 48 89 e8 48 f7 d8 48 39 c3 0f 92 c0 eb 92 66 90 b8 10 00 00 00 0f 05 <48> 3d 01 f0 ff ff 0f 83 0d b8 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007f5040518388 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 0000000000000001 RCX: 000000000045c537
RDX: 0000000000000000 RSI: 0000000040045506 RDI: 0000000000000006
RBP: 0000000000000006 R08: 0000000000405f0f R09: 0000000000000001
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000c80508
R13: 00000000000004e8 R14: 0000000000000002 R15: 0000000000000000
Shutting down cpus with NMI
Kernel Offset: disabled
Rebooting in 86400 seconds..


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
