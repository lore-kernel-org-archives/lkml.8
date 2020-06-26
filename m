Return-Path: <SRS0=rtH4=AH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B37F6C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 17:09:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9226F207FC
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 17:09:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728248AbgFZRJR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jun 2020 13:09:17 -0400
Received: from mail-il1-f198.google.com ([209.85.166.198]:54533 "EHLO
        mail-il1-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727088AbgFZRJQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 13:09:16 -0400
Received: by mail-il1-f198.google.com with SMTP id d18so6885232ill.21
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jun 2020 10:09:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=tltGYsgQUKf9DV4wiRpq3i9PnnU4cL2cQ+SYqK6BGYs=;
        b=hHeJhtLvQ8BnPWibiu4T/oYqWl1Oek/jKLnji3/yjIm1Lcs33/D2alep+bLoS5YL23
         ae6df0yodpNVN61gtK0088Vv3zCkoW7EK0sD3z/0HCH83nWcUo1tuhuJgYSeJP3Yz5Js
         lP/+8+SNpZ/6WGo06rDGBQgQf16Ry2ZgYq+ZEY8GNghRgZAMb9HFho7YxDz7MaJcqtAQ
         Ta8EvM+kBSWG3podJKus82DLkntNXhxFDE0EdfNZNa7ABSgb0r3k2eNYLJdf5zsQFVzC
         abUD3opChJ1opDYr9Soemi7401yAF+FAQuFc31B4ntTX2MU7FQ7G8Y3pgh0FPhdu4gV9
         0Y0Q==
X-Gm-Message-State: AOAM532GK4oZcWn/Zdm2Dkjo8dEWd9x7bq7ENGmR+rvOJTfqBAmBopi8
        7JDaBuOS34Jv1I5MgykE7Sc1kqUBw+hSiU9Xf+/BrUqByFWh
X-Google-Smtp-Source: ABdhPJz0Z0RwMYxsFUYGJEv8frP3yRdS7U08CQ2tZ8K2sswACm1qgpk1fjMvXmD5gQt/iKgC/FMc8AYzH/m+iG3Chdv3On4J/ioX
MIME-Version: 1.0
X-Received: by 2002:a6b:ba8b:: with SMTP id k133mr4468020iof.204.1593191355078;
 Fri, 26 Jun 2020 10:09:15 -0700 (PDT)
Date:   Fri, 26 Jun 2020 10:09:15 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c760af05a8ffc49a@google.com>
Subject: KASAN: vmalloc-out-of-bounds Read in tipc_nl_publ_dump
From:   syzbot <syzbot+24902249a963936dfe80@syzkaller.appspotmail.com>
To:     davem@davemloft.net, jmaloy@redhat.com, kuba@kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        syzkaller-bugs@googlegroups.com,
        tipc-discussion@lists.sourceforge.net, ying.xue@windriver.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    b835a71e usbnet: smsc95xx: Fix use-after-free after removal
git tree:       net
console output: https://syzkaller.appspot.com/x/log.txt?x=14aa2576100000
kernel config:  https://syzkaller.appspot.com/x/.config?x=dcc6334acae363d4
dashboard link: https://syzkaller.appspot.com/bug?extid=24902249a963936dfe80
compiler:       gcc (GCC) 10.1.0-syz 20200507
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=126ff61d100000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=148dc3a5100000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+24902249a963936dfe80@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: vmalloc-out-of-bounds in nla_len include/net/netlink.h:1135 [inline]
BUG: KASAN: vmalloc-out-of-bounds in nla_parse_nested_deprecated include/net/netlink.h:1218 [inline]
BUG: KASAN: vmalloc-out-of-bounds in tipc_nl_publ_dump+0xae0/0xce0 net/tipc/socket.c:3766
Read of size 2 at addr ffffc90004de5014 by task syz-executor205/6873

CPU: 1 PID: 6873 Comm: syz-executor205 Not tainted 5.8.0-rc1-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x18f/0x20d lib/dump_stack.c:118
 print_address_description.constprop.0.cold+0x5/0x436 mm/kasan/report.c:383
 __kasan_report mm/kasan/report.c:513 [inline]
 kasan_report.cold+0x1f/0x37 mm/kasan/report.c:530
 nla_len include/net/netlink.h:1135 [inline]
 nla_parse_nested_deprecated include/net/netlink.h:1218 [inline]
 tipc_nl_publ_dump+0xae0/0xce0 net/tipc/socket.c:3766
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
RSP: 002b:00007ffcbfda8448 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 0000000000441319
RDX: 0000000000000000 RSI: 0000000020000000 RDI: 0000000000000003
RBP: 000000000000ee24 R08: 00000000004002c8 R09: 00000000004002c8
R10: 0000000000000004 R11: 0000000000000246 R12: 0000000000402090
R13: 0000000000402120 R14: 0000000000000000 R15: 0000000000000000


Memory state around the buggy address:
 ffffc90004de4f00: f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9
 ffffc90004de4f80: f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9
>ffffc90004de5000: f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9
                         ^
 ffffc90004de5080: f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9
 ffffc90004de5100: f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9
==================================================================


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
