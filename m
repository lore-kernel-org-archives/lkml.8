Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30389C35679
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 08:28:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 066B620675
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 08:28:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727327AbgBXI2S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 03:28:18 -0500
Received: from mail-il1-f198.google.com ([209.85.166.198]:34292 "EHLO
        mail-il1-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727290AbgBXI2Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 03:28:16 -0500
Received: by mail-il1-f198.google.com with SMTP id l13so17084818ils.1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2020 00:28:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=vIr8nJYtkSIDBRrSoe4ExdWOaV6ukpSgeZOvoFewiik=;
        b=U0g3fdM4OQdkzmdelvG8CqcV+pGepf75SDdA+q7edT87jauIYi6BH9+Z9So23WPPCI
         tG1AzxJFFeulpLH1/dQ399WScQkffI8xVwN5nKRXONBWHlSxAHbX6Xa9eIfe69ckNDv1
         MAFbVRbWsuvtNFci1OZu7hQ3pFTdtYckvi/5glqGMvnhLwlAiZFaTtpjX5ahzWPAdJml
         YRQpXZyZCnL9DyRwCXjESqM6NqrCMXAH14mbcAMiCfRQZkKHLJULOq0Rluw+RM2WNslS
         Y7h6kyEB140eVBfhcQ/OBHsD3sKJNhAOlOQKNJSBrFoqkIHEqRB1P5MhQsJvs73sMtW6
         9P7w==
X-Gm-Message-State: APjAAAXeaGB762L3vJ9TVdBaRLXDiDan2lBiqG6Y1kZ1jg1Gz4f4EnrE
        7shEiJTwUiq6dnZu4UA47LgumI1Fpb+oxddYRKN5KkLJo60d
X-Google-Smtp-Source: APXvYqz6Dl+O/zUPHweusabUaTXYFRCVXNHMMm6d2eRzNjR6zt40sXIZNX4g6R3D/LevvNRZjCkHkhD6GjX3E/r9k8PpGfjbo4O2
MIME-Version: 1.0
X-Received: by 2002:a6b:5905:: with SMTP id n5mr49714675iob.242.1582532894287;
 Mon, 24 Feb 2020 00:28:14 -0800 (PST)
Date:   Mon, 24 Feb 2020 00:28:14 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000026ac5059f4e27f3@google.com>
Subject: WARNING: kobject bug in ib_register_device
From:   syzbot <syzbot+da615ac67d4dbea32cbc@syzkaller.appspotmail.com>
To:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        rafael@kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    d2eee258 Merge tag 'for-5.6-rc2-tag' of git://git.kernel.o..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1176f74ee00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3e57a6b450fb9883
dashboard link: https://syzkaller.appspot.com/bug?extid=da615ac67d4dbea32cbc
compiler:       clang version 10.0.0 (https://github.com/llvm/llvm-project/ c2443155a0fb245c8f17f2c1c72b6ea391e86e81)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1146d245e00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12e2fde9e00000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+da615ac67d4dbea32cbc@syzkaller.appspotmail.com

batman_adv: batadv0: Interface activated: batadv_slave_1
------------[ cut here ]------------
kobject: (000000005127ca6c): attempted to be registered with empty name!
WARNING: CPU: 0 PID: 8971 at lib/kobject.c:236 kobject_add_internal+0x12c/0xaa0 lib/kobject.c:234
Kernel panic - not syncing: panic_on_warn set ...
CPU: 0 PID: 8971 Comm: syz-executor318 Not tainted 5.6.0-rc2-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
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
RIP: 0010:kobject_add_internal+0x12c/0xaa0 lib/kobject.c:234
Code: 64 f9 41 be fe ff ff ff e9 59 06 00 00 e8 4c 63 64 f9 eb 05 e8 45 63 64 f9 48 c7 c7 83 8b 08 89 4c 89 ee 31 c0 e8 f4 28 36 f9 <0f> 0b 41 be ea ff ff ff e9 2f 06 00 00 48 89 45 b8 e8 1e 63 64 f9
RSP: 0018:ffffc900077e71b0 EFLAGS: 00010246
RAX: 5b8212945f64c000 RBX: 0000000000000000 RCX: ffff888091c3a2c0
RDX: 0000000000000000 RSI: 0000000080000000 RDI: 0000000000000000
RBP: ffffc900077e7230 R08: ffffffff81600324 R09: ffffed1015d46618
R10: ffffed1015d46618 R11: 0000000000000000 R12: dffffc0000000000
R13: ffff88809fb88668 R14: 1ffff11013f710cd R15: 0000000000000000
 kobject_add_varg lib/kobject.c:390 [inline]
 kobject_add+0xef/0x190 lib/kobject.c:442
 device_add+0x4b2/0x1ad0 drivers/base/core.c:2412
 ib_register_device+0x11df/0x15b0 drivers/infiniband/core/device.c:1371
 rxe_register_device+0x3f6/0x530 drivers/infiniband/sw/rxe/rxe_verbs.c:1231
 rxe_add+0x1373/0x14f0 drivers/infiniband/sw/rxe/rxe.c:302
 rxe_net_add+0x79/0xe0 drivers/infiniband/sw/rxe/rxe_net.c:539
 rxe_newlink+0x31/0x90 drivers/infiniband/sw/rxe/rxe.c:318
 nldev_newlink+0x403/0x4a0 drivers/infiniband/core/nldev.c:1538
 rdma_nl_rcv_msg drivers/infiniband/core/netlink.c:195 [inline]
 rdma_nl_rcv_skb drivers/infiniband/core/netlink.c:239 [inline]
 rdma_nl_rcv+0x701/0xa20 drivers/infiniband/core/netlink.c:259
 netlink_unicast_kernel net/netlink/af_netlink.c:1303 [inline]
 netlink_unicast+0x766/0x920 net/netlink/af_netlink.c:1329
 netlink_sendmsg+0xa2b/0xd40 net/netlink/af_netlink.c:1918
 sock_sendmsg_nosec net/socket.c:652 [inline]
 sock_sendmsg net/socket.c:672 [inline]
 ____sys_sendmsg+0x4f7/0x7f0 net/socket.c:2343
 ___sys_sendmsg net/socket.c:2397 [inline]
 __sys_sendmsg+0x1ed/0x290 net/socket.c:2430
 __do_sys_sendmsg net/socket.c:2439 [inline]
 __se_sys_sendmsg net/socket.c:2437 [inline]
 __x64_sys_sendmsg+0x7f/0x90 net/socket.c:2437
 do_syscall_64+0xf7/0x1c0 arch/x86/entry/common.c:294
 entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x4433f9
Code: 18 89 d0 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 0f 83 7b 10 fc ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007ffd5d50d798 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00000000004433f9
RDX: 0000000000000000 RSI: 0000000020000000 RDI: 0000000000000003
RBP: 00007ffd5d50d7b0 R08: 0000000001bbbbbb R09: 0000000001bbbbbb
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000404990 R14: 0000000000000000 R15: 0000000000000000
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
