Return-Path: <SRS0=QqoS=AI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3534C433E2
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jun 2020 02:59:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CCE97208C9
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jun 2020 02:59:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725882AbgF0CzQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jun 2020 22:55:16 -0400
Received: from mail-il1-f199.google.com ([209.85.166.199]:50858 "EHLO
        mail-il1-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725781AbgF0CzP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 22:55:15 -0400
Received: by mail-il1-f199.google.com with SMTP id l17so7757719ilj.17
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jun 2020 19:55:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=rQlIfEWzOqXAPiQvq9J83xQmyCx1O/uoaraUr4XXD/k=;
        b=fiDCm8TQXH4ZtgumbC2HSN6pXmWHyuYSEksKGCR3rk1/lJCd9VRQopSJk7Y9W2xt22
         8cy56X3bkhQrqvSKbiH+gqDKd8pgxdipJWk0x21IQ4MF/OaaI2P84fCWOYNig2dq/8Fj
         jwvNLshAeBiRIbIvKas0HYk//1tkOG5JFPPh+lOqfNcHvxeELFGZGTwhN0UMZg1lTKmY
         EJrWLK8QjQgtpD9UCOC5p31VfmGeDfpY4ztp74gZt+vQ5/IEJ8H7PeliB5YeJy5kNeTE
         pxpAOjv39PjkMOBHyKVC7egDwlMsIcG6cWdcJKqgM8yQiqfP7iZDoI+cB3rbhtEQb/FM
         9yaA==
X-Gm-Message-State: AOAM532Hv++DoCkHBAtKuFuEbul4Lhrnf0YYMbEN/Uoj1zX2L8aQo8pu
        ++7s7WM/zpd7QCE8YFE7I5g0ceaxG3Y9sObq7CnkNC6w3gkS
X-Google-Smtp-Source: ABdhPJwJ8ewJazwy5qseAEfqZYpdG2OW1bXNNdqa3tJM9z6tI05tkIGZuPTgBfPsBEklPeRjh7ty4pX/lyKRID/80G79kIoBi3mn
MIME-Version: 1.0
X-Received: by 2002:a02:69d3:: with SMTP id e202mr6405093jac.15.1593226513990;
 Fri, 26 Jun 2020 19:55:13 -0700 (PDT)
Date:   Fri, 26 Jun 2020 19:55:13 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000069c84c05a907f415@google.com>
Subject: KASAN: use-after-free Read in tipc_nl_node_dump_monitor_peer (2)
From:   syzbot <syzbot+c96e4dfb32f8987fdeed@syzkaller.appspotmail.com>
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

HEAD commit:    4a21185c Merge git://git.kernel.org/pub/scm/linux/kernel/g..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1364f2e5100000
kernel config:  https://syzkaller.appspot.com/x/.config?x=20c907630cbdbe5
dashboard link: https://syzkaller.appspot.com/bug?extid=c96e4dfb32f8987fdeed
compiler:       clang version 10.0.0 (https://github.com/llvm/llvm-project/ c2443155a0fb245c8f17f2c1c72b6ea391e86e81)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16802239100000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1410b223100000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+c96e4dfb32f8987fdeed@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: use-after-free in nla_len include/net/netlink.h:1135 [inline]
BUG: KASAN: use-after-free in nla_parse_nested_deprecated include/net/netlink.h:1218 [inline]
BUG: KASAN: use-after-free in tipc_nl_node_dump_monitor_peer+0x566/0x590 net/tipc/node.c:2788
Read of size 2 at addr ffff8880a4b0a814 by task syz-executor823/6893

CPU: 0 PID: 6893 Comm: syz-executor823 Not tainted 5.8.0-rc2-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x1f0/0x31e lib/dump_stack.c:118
 print_address_description+0x66/0x5a0 mm/kasan/report.c:383
 __kasan_report mm/kasan/report.c:513 [inline]
 kasan_report+0x132/0x1d0 mm/kasan/report.c:530
 nla_len include/net/netlink.h:1135 [inline]
 nla_parse_nested_deprecated include/net/netlink.h:1218 [inline]
 tipc_nl_node_dump_monitor_peer+0x566/0x590 net/tipc/node.c:2788
 genl_lock_dumpit+0x86/0xa0 net/netlink/genetlink.c:575
 netlink_dump+0x4be/0x10d0 net/netlink/af_netlink.c:2245
 __netlink_dump_start+0x538/0x700 net/netlink/af_netlink.c:2353
 genl_family_rcv_msg_dumpit net/netlink/genetlink.c:638 [inline]
 genl_family_rcv_msg net/netlink/genetlink.c:733 [inline]
 genl_rcv_msg+0xb03/0xe00 net/netlink/genetlink.c:753
 netlink_rcv_skb+0x190/0x3a0 net/netlink/af_netlink.c:2469
 genl_rcv+0x24/0x40 net/netlink/genetlink.c:764
 netlink_unicast_kernel net/netlink/af_netlink.c:1303 [inline]
 netlink_unicast+0x786/0x940 net/netlink/af_netlink.c:1329
 netlink_sendmsg+0xa57/0xd70 net/netlink/af_netlink.c:1918
 sock_sendmsg_nosec net/socket.c:652 [inline]
 sock_sendmsg net/socket.c:672 [inline]
 ____sys_sendmsg+0x519/0x800 net/socket.c:2352
 ___sys_sendmsg net/socket.c:2406 [inline]
 __sys_sendmsg+0x2b1/0x360 net/socket.c:2439
 do_syscall_64+0x73/0xe0 arch/x86/entry/common.c:359
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x4452a9
Code: Bad RIP value.
RSP: 002b:00007fff822c3fa8 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00000000004452a9
RDX: 0000000000000000 RSI: 00000000200000c0 RDI: 0000000000000003
RBP: 00000000000134d3 R08: 00000000004002e0 R09: 00000000004002e0
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000402440
R13: 00000000004024d0 R14: 0000000000000000 R15: 0000000000000000

Allocated by task 6892:
 save_stack mm/kasan/common.c:48 [inline]
 set_track mm/kasan/common.c:56 [inline]
 __kasan_kmalloc+0x103/0x140 mm/kasan/common.c:494
 __kmalloc_reserve net/core/skbuff.c:142 [inline]
 __alloc_skb+0xde/0x4f0 net/core/skbuff.c:210
 alloc_skb include/linux/skbuff.h:1083 [inline]
 netlink_alloc_large_skb net/netlink/af_netlink.c:1175 [inline]
 netlink_sendmsg+0x7b2/0xd70 net/netlink/af_netlink.c:1893
 sock_sendmsg_nosec net/socket.c:652 [inline]
 sock_sendmsg net/socket.c:672 [inline]
 ____sys_sendmsg+0x519/0x800 net/socket.c:2352
 ___sys_sendmsg net/socket.c:2406 [inline]
 __sys_sendmsg+0x2b1/0x360 net/socket.c:2439
 do_syscall_64+0x73/0xe0 arch/x86/entry/common.c:359
 entry_SYSCALL_64_after_hwframe+0x44/0xa9

Freed by task 6892:
 save_stack mm/kasan/common.c:48 [inline]
 set_track mm/kasan/common.c:56 [inline]
 kasan_set_free_info mm/kasan/common.c:316 [inline]
 __kasan_slab_free+0x114/0x170 mm/kasan/common.c:455
 __cache_free mm/slab.c:3426 [inline]
 kfree+0x10a/0x220 mm/slab.c:3757
 skb_release_all net/core/skbuff.c:664 [inline]
 __kfree_skb+0x56/0x1c0 net/core/skbuff.c:678
 netlink_unicast_kernel net/netlink/af_netlink.c:1304 [inline]
 netlink_unicast+0x78e/0x940 net/netlink/af_netlink.c:1329
 netlink_sendmsg+0xa57/0xd70 net/netlink/af_netlink.c:1918
 sock_sendmsg_nosec net/socket.c:652 [inline]
 sock_sendmsg net/socket.c:672 [inline]
 ____sys_sendmsg+0x519/0x800 net/socket.c:2352
 ___sys_sendmsg net/socket.c:2406 [inline]
 __sys_sendmsg+0x2b1/0x360 net/socket.c:2439
 do_syscall_64+0x73/0xe0 arch/x86/entry/common.c:359
 entry_SYSCALL_64_after_hwframe+0x44/0xa9

The buggy address belongs to the object at ffff8880a4b0a800
 which belongs to the cache kmalloc-512 of size 512
The buggy address is located 20 bytes inside of
 512-byte region [ffff8880a4b0a800, ffff8880a4b0aa00)
The buggy address belongs to the page:
page:ffffea000292c280 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0
flags: 0xfffe0000000200(slab)
raw: 00fffe0000000200 ffffea00027f8d08 ffffea00029ebe88 ffff8880aa400a80
raw: 0000000000000000 ffff8880a4b0a000 0000000100000004 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
 ffff8880a4b0a700: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff8880a4b0a780: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>ffff8880a4b0a800: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                         ^
 ffff8880a4b0a880: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff8880a4b0a900: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
