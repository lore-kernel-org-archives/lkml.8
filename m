Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5E7FC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 16:56:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AD2EE20774
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 16:56:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732985AbgFWQ4V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 12:56:21 -0400
Received: from mail-io1-f72.google.com ([209.85.166.72]:36165 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732416AbgFWQ4T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 12:56:19 -0400
Received: by mail-io1-f72.google.com with SMTP id g17so6744360iob.3
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jun 2020 09:56:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=ROU0lx5jL4suhlbFQVzskyt8m5jF4lI6Zi/ObrujOXE=;
        b=gqSelUMqPngNXlqAcfD33zKDs0OP/2P/K04KnYOXli3CtX5bKOLWgFUrqyfV8sOw0D
         VewX0Gt1E8sx+2omtMvR1crqljNdt7ErZix7oWxKnp/PbXksqM8Gt4X8Wby2yffwFqAK
         3D6JZgWUA95HL8Qw8tclSCzz/pY3RfquAaVJRIDlUKpxTParPND/ygMhXTOlSrg8XxCR
         t/maTQyPKSBFAdxbAwnXVsiJdCFO2ppkmDx4u1gVNy714a4RtBPJLht7cDK7bqark+04
         PGIj8f7FlzpaWdIH5OlwTDhdGmAPBVPwBfPhItM1QsutYitX4oTvcIt/Jr1Ut6w+nFPp
         l/dQ==
X-Gm-Message-State: AOAM532TjMTfmfVMX5hJm91KMHsPgloBfOt+d2MB0oo/M5TzIZx2Grwq
        0u1hxaygfBTv5nXkMxQSGndMqXIUR/YVZMAW9qHA/ehnqL/Z
X-Google-Smtp-Source: ABdhPJy0mXObbN07j+2xhO4/4c/cJ+P4vMTRDDOu/lmXTaPquN5P+yd4PnYAVvBO9vyZnpsOY6+lAIAfRx09DBDrLtsdLrjAXI8W
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:128c:: with SMTP id y12mr19351210ilq.45.1592931378517;
 Tue, 23 Jun 2020 09:56:18 -0700 (PDT)
Date:   Tue, 23 Jun 2020 09:56:18 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f7e03b05a8c33c97@google.com>
Subject: KASAN: vmalloc-out-of-bounds Read in nl8NUM_dump_wpan_phy
From:   syzbot <syzbot+736bcbcb11b60d0c0792@syzkaller.appspotmail.com>
To:     alex.aring@gmail.com, davem@davemloft.net, kuba@kernel.org,
        linux-kernel@vger.kernel.org, linux-wpan@vger.kernel.org,
        netdev@vger.kernel.org, stefan@datenfreihafen.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    b835a71e usbnet: smsc95xx: Fix use-after-free after removal
git tree:       net
console output: https://syzkaller.appspot.com/x/log.txt?x=12e7fa19100000
kernel config:  https://syzkaller.appspot.com/x/.config?x=dcc6334acae363d4
dashboard link: https://syzkaller.appspot.com/bug?extid=736bcbcb11b60d0c0792
compiler:       gcc (GCC) 10.1.0-syz 20200507
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=106b4909100000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11a1bf8d100000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+736bcbcb11b60d0c0792@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: vmalloc-out-of-bounds in nla_get_u32 include/net/netlink.h:1541 [inline]
BUG: KASAN: vmalloc-out-of-bounds in nl802154_dump_wpan_phy_parse net/ieee802154/nl802154.c:563 [inline]
BUG: KASAN: vmalloc-out-of-bounds in nl802154_dump_wpan_phy+0x98e/0x9c0 net/ieee802154/nl802154.c:593
Read of size 4 at addr ffffc90005ea1018 by task syz-executor118/6820

CPU: 1 PID: 6820 Comm: syz-executor118 Not tainted 5.8.0-rc1-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x18f/0x20d lib/dump_stack.c:118
 print_address_description.constprop.0.cold+0x5/0x436 mm/kasan/report.c:383
 __kasan_report mm/kasan/report.c:513 [inline]
 kasan_report.cold+0x1f/0x37 mm/kasan/report.c:530
 nla_get_u32 include/net/netlink.h:1541 [inline]
 nl802154_dump_wpan_phy_parse net/ieee802154/nl802154.c:563 [inline]
 nl802154_dump_wpan_phy+0x98e/0x9c0 net/ieee802154/nl802154.c:593
 genl_lock_dumpit+0x7f/0xb0 net/netlink/genetlink.c:575
 netlink_dump+0x4cd/0xf60 net/netlink/af_netlink.c:2245
 __netlink_dump_start+0x643/0x900 net/netlink/af_netlink.c:2353
 genl_family_rcv_msg_dumpit+0x2ac/0x310 net/netlink/genetlink.c:638
 genl_family_rcv_msg net/netlink/genetlink.c:733 [inline]
 genl_rcv_msg+0x797/0x9e0 net/netlink/genetlink.c:753
 netlink_rcv_skb+0x15a/0x430 net/netlink/af_netlink.c:2469
 genl_rcv+0x24/0x40 net/netlink/genetlink.c:764
 netlink_unicast_kernel net/netlink/af_netlink.c:1303 [inline]
 netlink_unicast+0x533/0x7d0 net/netlink/af_netlink.c:1329
 netlink_sendmsg+0x856/0xd90 net/netlink/af_netlink.c:1918
 sock_sendmsg_nosec net/socket.c:652 [inline]
 sock_sendmsg+0xcf/0x120 net/socket.c:672
 ____sys_sendmsg+0x6e8/0x810 net/socket.c:2352
 ___sys_sendmsg+0xf3/0x170 net/socket.c:2406
 __sys_sendmsg+0xe5/0x1b0 net/socket.c:2439
 do_syscall_64+0x60/0xe0 arch/x86/entry/common.c:359
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x441319
Code: Bad RIP value.
RSP: 002b:00007fff95574ae8 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 0000000000441319
RDX: 0000000000000000 RSI: 0000000020000000 RDI: 0000000000000003
RBP: 00000000006cb018 R08: 00000000004002c8 R09: 00000000004002c8
R10: 0000000000000004 R11: 0000000000000246 R12: 0000000000402090
R13: 0000000000402120 R14: 0000000000000000 R15: 0000000000000000


Memory state around the buggy address:
 ffffc90005ea0f00: f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9
 ffffc90005ea0f80: f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9
>ffffc90005ea1000: f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9
                            ^
 ffffc90005ea1080: f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9
 ffffc90005ea1100: f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9
==================================================================


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
