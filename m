Return-Path: <SRS0=iO2y=4R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4D43C3F2CE
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Feb 2020 09:01:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C45BC2469C
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Feb 2020 09:01:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726975AbgB2JBN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Feb 2020 04:01:13 -0500
Received: from mail-il1-f199.google.com ([209.85.166.199]:52236 "EHLO
        mail-il1-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726946AbgB2JBM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Feb 2020 04:01:12 -0500
Received: by mail-il1-f199.google.com with SMTP id n7so3546394ilm.19
        for <linux-kernel@vger.kernel.org>; Sat, 29 Feb 2020 01:01:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=ioHk1UP6YRjV8uw5D48y+e2vf5I7mB1YV19AJTXHHO4=;
        b=pD5fQVRMRhPuZzWai8+US6tIhUM7YkSEzrTtAHC7FteiLn9Xo1FsmhaX0z9n5XY8Z5
         LQriNKIOYqEdASe4NSNPAmezb2ES5mX4jqRGLRzZ85isSV39F5bR1IO3CpPjZBa+3b0F
         KLIH4lcQuedEEzjgxMg0rmA04O8K+S5XnUmc5AROSJ2fTyE80d8fsaQJiWitPs2XIISJ
         dC9J5oWJPq58c67Xo/hyY55NgR8nsEYMU0JNcLHXVYfa6paQ9tZFWtZegkNiWX3+U4Nh
         e2jrVQw0+leJ47d96+oKFcWwBEkPPInfEZHwTSynLMR+dPnRkBT6PTlL3GIbjFTwctro
         e7HA==
X-Gm-Message-State: APjAAAVloBgOditYrvc32Z4lsfEmMEb0DxTl9jrfKA/r/9uxhQxbXgY4
        DtdPx35qujWsKIKe/BExSL0OcHXHeM02Qt87yyfVALc+W1ot
X-Google-Smtp-Source: APXvYqzyaRKW6se62z7GnKLo9dn60+RZU/QK1eTzeeY2eBJuBRQdxj1LGORN0sIOT7VFBcGQu40j1dH9TrhI7/5+rKvDt9bcfmJF
MIME-Version: 1.0
X-Received: by 2002:a92:4448:: with SMTP id a8mr8129718ilm.256.1582966871334;
 Sat, 29 Feb 2020 01:01:11 -0800 (PST)
Date:   Sat, 29 Feb 2020 01:01:11 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000000ea4b4059fb33201@google.com>
Subject: WARNING in geneve_exit_batch_net (2)
From:   syzbot <syzbot+68a8ed58e3d17c700de5@syzkaller.appspotmail.com>
To:     davem@davemloft.net, jbenc@redhat.com,
        linux-kernel@vger.kernel.org, moshe@mellanox.com,
        netdev@vger.kernel.org, sd@queasysnail.net,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    f8788d86 Linux 5.6-rc3
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=138dd22de00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5d2e033af114153f
dashboard link: https://syzkaller.appspot.com/bug?extid=68a8ed58e3d17c700de5
compiler:       clang version 10.0.0 (https://github.com/llvm/llvm-project/ c2443155a0fb245c8f17f2c1c72b6ea391e86e81)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16601d31e00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14fdf8f9e00000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+68a8ed58e3d17c700de5@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 0 PID: 304 at drivers/net/geneve.c:1849 geneve_destroy_tunnels drivers/net/geneve.c:1849 [inline]
WARNING: CPU: 0 PID: 304 at drivers/net/geneve.c:1849 geneve_exit_batch_net+0x2b1/0x300 drivers/net/geneve.c:1859
Kernel panic - not syncing: panic_on_warn set ...
CPU: 0 PID: 304 Comm: kworker/u4:4 Not tainted 5.6.0-rc3-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Workqueue: netns cleanup_net
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x1fb/0x318 lib/dump_stack.c:118
 panic+0x264/0x7a9 kernel/panic.c:221
 __warn+0x209/0x210 kernel/panic.c:582
 report_bug+0x1b6/0x2f0 lib/bug.c:195
 fixup_bug arch/x86/kernel/traps.c:174 [inline]
 do_error_trap+0xcf/0x1c0 arch/x86/kernel/traps.c:267
 do_invalid_op+0x36/0x40 arch/x86/kernel/traps.c:286
 invalid_op+0x23/0x30 arch/x86/entry/entry_64.S:1027
RIP: 0010:geneve_destroy_tunnels drivers/net/geneve.c:1849 [inline]
RIP: 0010:geneve_exit_batch_net+0x2b1/0x300 drivers/net/geneve.c:1859
Code: 48 c1 e8 03 42 80 3c 28 00 74 08 48 89 df e8 46 aa d1 fc 48 8b 1b 4c 39 fb 74 13 e8 c9 80 94 fc e9 f4 fd ff ff e8 bf 80 94 fc <0f> 0b eb cf e8 b6 80 94 fc eb 05 e8 af 80 94 fc 48 8d 7d c0 e8 c6
RSP: 0018:ffffc90001917c08 EFLAGS: 00010293
RAX: ffffffff84e288c1 RBX: ffff8880a7bc6120 RCX: ffff8880a88304c0
RDX: 0000000000000000 RSI: ffffc90001917c28 RDI: ffff8880a47da068
RBP: ffffc90001917c68 R08: ffffffff866be459 R09: fffffbfff12b21a9
R10: fffffbfff12b21a9 R11: 0000000000000000 R12: ffffc90001917c28
R13: dffffc0000000000 R14: ffff8880a1ca0dd0 R15: ffffc90001917c98
 ops_exit_list net/core/net_namespace.c:175 [inline]
 cleanup_net+0x78b/0xb80 net/core/net_namespace.c:589
 process_one_work+0x7f5/0x10f0 kernel/workqueue.c:2264
 worker_thread+0xbbc/0x1630 kernel/workqueue.c:2410
 kthread+0x332/0x350 kernel/kthread.c:255
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
