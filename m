Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BBEEC3567B
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 08:18:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D3C220658
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 08:18:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727276AbgBXISQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 03:18:16 -0500
Received: from mail-il1-f197.google.com ([209.85.166.197]:51535 "EHLO
        mail-il1-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726452AbgBXISQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 03:18:16 -0500
Received: by mail-il1-f197.google.com with SMTP id c12so16882586ilr.18
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2020 00:18:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=FsNWyF8SgwfIXC0WUBYHcHMlv2/lUMvY9fiX4dlbpeQ=;
        b=Yxe+FAP0iuonD5zuAYk2CLfUjXMOM/p/eGcquXRkzEC5Fe1+tBZQC8i17nuHM1Yb3y
         aFRnkyYkXEg0JiOFybhGWDuXR5AosZzdwnkDFAoybKeYyURSHgsS2pnOrRnUHTHIW45O
         nzSQ9YY/8kv50mZXjGP77yX5jvX6D+yttyEErtezmeklIA/p+L5WK+s2wTuFKZCtyvPb
         hNoXD/rGVfsgg/Mm9mBw5dmYgKddot9cE5uTpetft4RRFnYXcEJ7e2One5bIOMOvsq0K
         x434XNDaRzylaKSaSPg5FleLgr0qQddHCXeRTV59ULYQU/pwzlmbh+P7KtskSA3dtnIU
         00sQ==
X-Gm-Message-State: APjAAAUtXkyKgorBFPjpVuk5RGIgohAplFUpPmRGBPpaeA2aYr2ddj34
        exLGBMmRJfQkPJxWVTezabyJMO1h/JI/fiTRJB2mYRlQfbVq
X-Google-Smtp-Source: APXvYqw7v6LwcrY8hQt9SyX0LsdrCEgrm7QDbjGm7XPl9gB33GqYrZsWDZOBUvk5YjUOR4Vc3DmTRlN6cDUFF0gJtJXBRUUOXQg9
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:80c:: with SMTP id u12mr59585701ilm.273.1582532293849;
 Mon, 24 Feb 2020 00:18:13 -0800 (PST)
Date:   Mon, 24 Feb 2020 00:18:13 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000387920059f4e0351@google.com>
Subject: KMSAN: kernel-infoleak in tty_compat_ioctl
From:   syzbot <syzbot+8da9175e28eadcb203ce@syzkaller.appspotmail.com>
To:     glider@google.com, gregkh@linuxfoundation.org, jslaby@suse.com,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    8bbbc5cf kmsan: don't compile memmove
git tree:       https://github.com/google/kmsan.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=1280ea7ee00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=cd0e9a6b0e555cc3
dashboard link: https://syzkaller.appspot.com/bug?extid=8da9175e28eadcb203ce
compiler:       clang version 10.0.0 (https://github.com/llvm/llvm-project/ c2443155a0fb245c8f17f2c1c72b6ea391e86e81)
userspace arch: i386
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1722a3d9e00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1071e265e00000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+8da9175e28eadcb203ce@syzkaller.appspotmail.com

=====================================================
BUG: KMSAN: kernel-infoleak in kmsan_copy_to_user+0x81/0x90 mm/kmsan/kmsan_hooks.c:253
CPU: 1 PID: 11476 Comm: syz-executor814 Not tainted 5.6.0-rc2-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x1c9/0x220 lib/dump_stack.c:118
 kmsan_report+0xf7/0x1e0 mm/kmsan/kmsan_report.c:118
 kmsan_internal_check_memory+0x238/0x3d0 mm/kmsan/kmsan.c:423
 kmsan_copy_to_user+0x81/0x90 mm/kmsan/kmsan_hooks.c:253
 _copy_to_user+0x15a/0x1f0 lib/usercopy.c:33
 copy_to_user include/linux/uaccess.h:174 [inline]
 compat_tty_tiocgserial drivers/tty/tty_io.c:2748 [inline]
 tty_compat_ioctl+0x1482/0x1850 drivers/tty/tty_io.c:2846
 __do_compat_sys_ioctl fs/ioctl.c:857 [inline]
 __se_compat_sys_ioctl+0x57c/0xed0 fs/ioctl.c:808
 __ia32_compat_sys_ioctl+0xd9/0x110 fs/ioctl.c:808
 do_syscall_32_irqs_on arch/x86/entry/common.c:339 [inline]
 do_fast_syscall_32+0x3c7/0x6e0 arch/x86/entry/common.c:410
 entry_SYSENTER_compat+0x68/0x77 arch/x86/entry/entry_64_compat.S:139
RIP: 0023:0xf7ff7d99
Code: 90 e8 0b 00 00 00 f3 90 0f ae e8 eb f9 8d 74 26 00 89 3c 24 c3 90 90 90 90 90 90 90 90 90 90 90 90 51 52 55 89 e5 0f 34 cd 80 <5d> 5a 59 c3 90 90 90 90 eb 0d 90 90 90 90 90 90 90 90 90 90 90 90
RSP: 002b:00000000ff97b20c EFLAGS: 00000213 ORIG_RAX: 0000000000000036
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 000000000000541e
RDX: 0000000020000300 RSI: 00000000080ea078 RDI: 00000000ff97b260
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000

Local variable ----v32.i105@tty_compat_ioctl created at:
 compat_tty_tiocgserial drivers/tty/tty_io.c:2735 [inline]
 tty_compat_ioctl+0xf12/0x1850 drivers/tty/tty_io.c:2846
 compat_tty_tiocgserial drivers/tty/tty_io.c:2735 [inline]
 tty_compat_ioctl+0xf12/0x1850 drivers/tty/tty_io.c:2846

Bytes 50-51 of 60 are uninitialized
Memory access of size 60 starts at ffffb50b0158fce0
Data copied to user address 0000000020000300
=====================================================


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
