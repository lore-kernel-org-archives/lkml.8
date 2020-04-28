Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D4C8C83004
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 04:55:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0245420661
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 04:55:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726338AbgD1EzT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 00:55:19 -0400
Received: from mail-il1-f200.google.com ([209.85.166.200]:49403 "EHLO
        mail-il1-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725792AbgD1EzS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 00:55:18 -0400
Received: by mail-il1-f200.google.com with SMTP id z18so21921976ilp.16
        for <linux-kernel@vger.kernel.org>; Mon, 27 Apr 2020 21:55:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=9lT/0KhJbhdFCWET24hPlWEPdDkGKOlKMSulFeVo/pc=;
        b=aE9DfucGVrn0lIxcSSw5/Jbjv0N59n6M3G/nQGLtMQMEppF92ea+5sFqp6BeOewIC+
         kMDrVnInOIajtuhHtBxIxUdWWil6tjzED3scbUTwT24w9K+iZsaPVr+zIWwHlp7Slb9F
         9J04Ear9OV1HOgJxu6u0+O8W4vwHznvLf/5w60zYcW0QXAP8RCTg7daunfEkb/NczlCg
         PXo9eoUMUtbok5OAWC3S5Q8Uj76pxeF8TPQCUgOzUPGjjopm+PEKjEls3q0nbCt5UUEK
         IiMtLlSwdC7HqUXiaQHxWzkxQvutwVFdMhUGMTjBzsNI6GDMRe4Yjs0PZfIg59p4MKlv
         xJsA==
X-Gm-Message-State: AGi0PuaO1ykA6qSjF/bjXgRpMhpxLgisU/zgCABQIXLnH7WwTuYomoh3
        9tpzQ02EqUV1W4Xk7Y8ODgDQyhGOVoAdqw4jWRoakYL7zkQe
X-Google-Smtp-Source: APiQypK/7QIDeHnrv4sVkoxXejYnJlgztxzRKQNReLR1VStIjXuplBygPaz6ebMuQqT8dGQGWUK3rjiXNGxFMlKN1r7JN44dZN84
MIME-Version: 1.0
X-Received: by 2002:a5d:9505:: with SMTP id d5mr24216054iom.185.1588049716016;
 Mon, 27 Apr 2020 21:55:16 -0700 (PDT)
Date:   Mon, 27 Apr 2020 21:55:16 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000357a2005a452a302@google.com>
Subject: stack segment fault in redraw_screen
From:   syzbot <syzbot+a2ae636def3ebbeae7c1@syzkaller.appspotmail.com>
To:     daniel.vetter@ffwll.ch, ebiggers@google.com,
        gregkh@linuxfoundation.org, jslaby@suse.com,
        linux-kernel@vger.kernel.org, sam@ravnborg.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    b2768df2 Merge branch 'for-linus' of git://git.kernel.org/..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=17bb4fc8100000
kernel config:  https://syzkaller.appspot.com/x/.config?x=78a7d8adda44b4b
dashboard link: https://syzkaller.appspot.com/bug?extid=a2ae636def3ebbeae7c1
compiler:       clang version 10.0.0 (https://github.com/llvm/llvm-project/ c2443155a0fb245c8f17f2c1c72b6ea391e86e81)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+a2ae636def3ebbeae7c1@syzkaller.appspotmail.com

stack segment: 0000 [#1] PREEMPT SMP KASAN
CPU: 0 PID: 5 Comm: kworker/0:0 Not tainted 5.7.0-rc2-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Workqueue: events console_callback
RIP: 0010:add_softcursor drivers/tty/vt/vt.c:865 [inline]
RIP: 0010:set_cursor drivers/tty/vt/vt.c:907 [inline]
RIP: 0010:redraw_screen+0xe44/0x16f0 drivers/tty/vt/vt.c:1025
Code: 00 48 89 d8 48 c1 e8 03 80 3c 28 00 74 08 48 89 df e8 e0 9c b6 fd 4c 8b 2b 4c 89 ed 48 c1 ed 03 48 bb 00 00 00 00 00 fc ff df <8a> 44 1d 00 84 c0 0f 85 90 07 00 00 45 0f b7 75 00 4c 89 64 24 18
RSP: 0018:ffffc90000cbfbc0 EFLAGS: 00010206
RAX: 1ffff1100860827e RBX: dffffc0000000000 RCX: ffff8880a99a4140
RDX: 0000000000000000 RSI: 00000000000000c0 RDI: ffff888043041000
RBP: 000000001fffffee R08: ffffffff83faa792 R09: ffffed10148b8a84
R10: ffffed10148b8a84 R11: 0000000000000000 R12: ffff888043041000
R13: 00000000ffffff70 R14: 1ffff1100860829a R15: 0000000000000001
FS:  0000000000000000(0000) GS:ffff8880ae800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00005633a6f64f08 CR3: 00000000a2ddc000 CR4: 00000000001406f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 complete_change_console+0xb1/0x720 drivers/tty/vt/vt_ioctl.c:1274
 console_callback+0x106/0x330 drivers/tty/vt/vt.c:2844
 process_one_work+0x76e/0xfd0 kernel/workqueue.c:2268
 worker_thread+0xa7f/0x1450 kernel/workqueue.c:2414
 kthread+0x353/0x380 kernel/kthread.c:268
 ret_from_fork+0x24/0x30 arch/x86/entry/entry_64.S:352
Modules linked in:
---[ end trace 2eb94778444607de ]---
RIP: 0010:add_softcursor drivers/tty/vt/vt.c:865 [inline]
RIP: 0010:set_cursor drivers/tty/vt/vt.c:907 [inline]
RIP: 0010:redraw_screen+0xe44/0x16f0 drivers/tty/vt/vt.c:1025
Code: 00 48 89 d8 48 c1 e8 03 80 3c 28 00 74 08 48 89 df e8 e0 9c b6 fd 4c 8b 2b 4c 89 ed 48 c1 ed 03 48 bb 00 00 00 00 00 fc ff df <8a> 44 1d 00 84 c0 0f 85 90 07 00 00 45 0f b7 75 00 4c 89 64 24 18
RSP: 0018:ffffc90000cbfbc0 EFLAGS: 00010206
RAX: 1ffff1100860827e RBX: dffffc0000000000 RCX: ffff8880a99a4140
RDX: 0000000000000000 RSI: 00000000000000c0 RDI: ffff888043041000
RBP: 000000001fffffee R08: ffffffff83faa792 R09: ffffed10148b8a84
R10: ffffed10148b8a84 R11: 0000000000000000 R12: ffff888043041000
R13: 00000000ffffff70 R14: 1ffff1100860829a R15: 0000000000000001
FS:  0000000000000000(0000) GS:ffff8880ae800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00005633a6f64f08 CR3: 00000000a2ddc000 CR4: 00000000001406f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
