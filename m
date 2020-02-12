Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE12CC352A4
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 20:07:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C625521734
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 20:07:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729074AbgBLUHL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 15:07:11 -0500
Received: from mail-il1-f200.google.com ([209.85.166.200]:52151 "EHLO
        mail-il1-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728226AbgBLUHK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 15:07:10 -0500
Received: by mail-il1-f200.google.com with SMTP id c12so2598056ilr.18
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2020 12:07:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=Co8lYCnMNWbIOoFwBwNevLnEaupm4wQuaFmfZ70UHoc=;
        b=CxOJJnDL2ekQugj63qA9xZ0eQvfZMlnDU6vEHlIMEzPuk8Z1+xkzRgzq8dx8m0qhOy
         Ca1zA6uTUMldHOhiPEwdGt6HLY974K1NocmCg0vpMTcinDzcwWcnZMf8VTvdFmCpEtB2
         cFgCpqRN8E6O1coKXj3x3ziqAN9JJCkSslTRuDu7Gq7WUoiKXuYi2xYopQrbiFv/UMTo
         L/WGoclapbmAmG7yp36Bxskt7rKCXcGPxJWQ65KDLKfORfI+ffmTAQMHns5aTE76QR2i
         b6Up9VrPIwbjjof/2xOPplyPKZz5WZbjUctzFJ46VCwJg8bqrPQggNHKNnfVIDybtWhF
         IbwA==
X-Gm-Message-State: APjAAAUEIU/6ULMNdsNhKkReY+gJsXVMlj/faErkAxx/JkrqSZoL9tLb
        WdjYWXKY7+ny187zy4pYpYDzwBOW0pL8ttjhgPZfxOUTkPpK
X-Google-Smtp-Source: APXvYqxN1xgoOdBqreIIiflzMcbePxougWNMY9WnyU+8s6P4MynybcE32RWCk4rH9/dCpZ3j8H7J85xtN/KmYzaiVQpGDbbFjVk/
MIME-Version: 1.0
X-Received: by 2002:a05:6638:34e:: with SMTP id x14mr20904842jap.38.1581538029931;
 Wed, 12 Feb 2020 12:07:09 -0800 (PST)
Date:   Wed, 12 Feb 2020 12:07:09 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000791270059e668493@google.com>
Subject: general protection fault in redraw_screen
From:   syzbot <syzbot+4a5a3604a566ede699b9@syzkaller.appspotmail.com>
To:     daniel.vetter@ffwll.ch, ghalat@redhat.com,
        gregkh@linuxfoundation.org, jslaby@suse.com,
        linux-kernel@vger.kernel.org, lukas@wunner.de,
        maarten.lankhorst@linux.intel.com, nico@fluxnic.net,
        sam@ravnborg.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    359c92c0 Merge tag 'dax-fixes-5.6-rc1' of git://git.kernel..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=15a432a1e00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6780df5a5f208964
dashboard link: https://syzkaller.appspot.com/bug?extid=4a5a3604a566ede699b9
compiler:       clang version 10.0.0 (https://github.com/llvm/llvm-project/ c2443155a0fb245c8f17f2c1c72b6ea391e86e81)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16d2e2a1e00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11ff82e6e00000

Bisection is inconclusive: the bug happens on the oldest tested release.

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1701cfa5e00000
final crash:    https://syzkaller.appspot.com/x/report.txt?x=1481cfa5e00000
console output: https://syzkaller.appspot.com/x/log.txt?x=1081cfa5e00000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+4a5a3604a566ede699b9@syzkaller.appspotmail.com

general protection fault, probably for non-canonical address 0xdffffc0020000001: 0000 [#1] PREEMPT SMP KASAN
KASAN: probably user-memory-access in range [0x0000000100000008-0x000000010000000f]
CPU: 1 PID: 2936 Comm: kworker/1:49 Not tainted 5.6.0-rc1-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Workqueue: events console_callback
RIP: 0010:add_softcursor drivers/tty/vt/vt.c:865 [inline]
RIP: 0010:set_cursor drivers/tty/vt/vt.c:906 [inline]
RIP: 0010:redraw_screen+0xf1c/0x1830 drivers/tty/vt/vt.c:1013
Code: 00 00 00 00 00 fc ff df 80 3c 10 00 74 12 48 89 df e8 68 2f b5 fd 48 ba 00 00 00 00 00 fc ff df 4c 8b 2b 4d 89 ec 49 c1 ec 03 <41> 8a 04 14 84 c0 0f 85 ef 07 00 00 45 0f b7 75 00 48 8b 45 a0 48
RSP: 0018:ffffc900085b7b38 EFLAGS: 00010203
RAX: 1ffff110127e0c74 RBX: ffff888093f063a0 RCX: ffff88809e516640
RDX: dffffc0000000000 RSI: 00000000000000c0 RDI: 0000000000000000
RBP: ffffc900085b7bc0 R08: ffffffff83fef5be R09: ffffed10431c9484
R10: ffffed10431c9484 R11: 0000000000000000 R12: 0000000020000001
R13: 000000010000000c R14: 000000000000001f R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff8880aeb00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000455300 CR3: 000000008c51f000 CR4: 00000000001406e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 complete_change_console+0xb9/0x750 drivers/tty/vt/vt_ioctl.c:1264
 change_console+0x2d8/0x450 drivers/tty/vt/vt_ioctl.c:1389
 console_callback+0x104/0x330 drivers/tty/vt/vt.c:2824
 process_one_work+0x7f5/0x10f0 kernel/workqueue.c:2264
 worker_thread+0xbbc/0x1630 kernel/workqueue.c:2410
 kthread+0x332/0x350 kernel/kthread.c:255
 ret_from_fork+0x24/0x30 arch/x86/entry/entry_64.S:352
Modules linked in:
---[ end trace f61ede7c24462fc9 ]---
RIP: 0010:add_softcursor drivers/tty/vt/vt.c:865 [inline]
RIP: 0010:set_cursor drivers/tty/vt/vt.c:906 [inline]
RIP: 0010:redraw_screen+0xf1c/0x1830 drivers/tty/vt/vt.c:1013
Code: 00 00 00 00 00 fc ff df 80 3c 10 00 74 12 48 89 df e8 68 2f b5 fd 48 ba 00 00 00 00 00 fc ff df 4c 8b 2b 4d 89 ec 49 c1 ec 03 <41> 8a 04 14 84 c0 0f 85 ef 07 00 00 45 0f b7 75 00 48 8b 45 a0 48
RSP: 0018:ffffc900085b7b38 EFLAGS: 00010203
RAX: 1ffff110127e0c74 RBX: ffff888093f063a0 RCX: ffff88809e516640
RDX: dffffc0000000000 RSI: 00000000000000c0 RDI: 0000000000000000
RBP: ffffc900085b7bc0 R08: ffffffff83fef5be R09: ffffed10431c9484
R10: ffffed10431c9484 R11: 0000000000000000 R12: 0000000020000001
R13: 000000010000000c R14: 000000000000001f R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff8880aeb00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000455300 CR3: 000000008c51f000 CR4: 00000000001406e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
