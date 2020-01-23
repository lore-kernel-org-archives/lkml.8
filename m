Return-Path: <SRS0=EowN=3M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4D7BC35240
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 23:27:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F0E6218AC
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 23:27:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729814AbgAWX1L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jan 2020 18:27:11 -0500
Received: from mail-io1-f69.google.com ([209.85.166.69]:47021 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729085AbgAWX1K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jan 2020 18:27:10 -0500
Received: by mail-io1-f69.google.com with SMTP id r74so151815iod.13
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jan 2020 15:27:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=IqqkeRa+RqLvK6yK4eykJOM8Dbd7jyvjYI3z++mnrlY=;
        b=B1qnMwTu2cg+friwUxl47hqsjtV6W0ozjHGyNY20GWc/eJD4wK+26EX+OyeRVMw1KA
         fimAT9TfvYDxgq9eNLZ6d09CZFmv7MkmQ7KZAP079OVKbGh3Z3zp6IowPfzYUIJ56jbg
         +wjs87AR6tCUDDQRy/wkq2aymXmx44Bh3Dgul4eYt1qsOHKw14boWSi6X717MZ5lcVKB
         5aEZsODKg35CbY4CYK3+n7HnZfq9ZRfQG7rMzXEOm7NDfxHddDxT2KnDe3NE1KJRxVa5
         l7WWZKxcb6l9tmfih9H4umOGJK+4yJMsKFOiUVxT/fkptBY5Snr/CLpBr5U6UDWcRZV8
         BRkA==
X-Gm-Message-State: APjAAAVmluJBcFAkTJd3VNWJgARwy3uoKY0SlHWeuj9ffnqk4a8Y7r22
        9WrfgvPp83asbhId8RUlvxE4chbn8Ae2gHf8ufk8uhALPhRp
X-Google-Smtp-Source: APXvYqzs0IyVNnjClEpWlSEvkKNjsHG0M/o1mgS8Q4Dxicd/ntYEw7iNcaibwAb99vqzSId8YX9WRJsv2D/iumnjeCcn2/GgK1ZO
MIME-Version: 1.0
X-Received: by 2002:a92:d18a:: with SMTP id z10mr735912ilz.48.1579822029297;
 Thu, 23 Jan 2020 15:27:09 -0800 (PST)
Date:   Thu, 23 Jan 2020 15:27:09 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000dd5dba059cd6facc@google.com>
Subject: KASAN: slab-out-of-bounds Read in tcf_exts_destroy
From:   syzbot <syzbot+35d4dea36c387813ed31@syzkaller.appspotmail.com>
To:     adobriyan@gmail.com, davem@davemloft.net, dsahern@gmail.com,
        ja@ssi.bg, jhs@mojatatu.com, jiri@resnulli.us,
        johannes@sipsolutions.net, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        tgraf@suug.ch, xiyou.wangcong@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    569aad4f net: ag71xx: fix mdio subnode support
git tree:       net
console output: https://syzkaller.appspot.com/x/log.txt?x=1591b415600000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6ffbfa7e4a36190f
dashboard link: https://syzkaller.appspot.com/bug?extid=35d4dea36c387813ed31
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=120c47f5600000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11d58ceb600000

The bug was bisected to:

commit 6e237d099fac1f73a7b6d7287bb9191f29585a4e
Author: David Ahern <dsahern@gmail.com>
Date:   Thu Dec 7 04:09:12 2017 +0000

    netlink: Relax attr validation for fixed length types

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=152f5e43600000
final crash:    https://syzkaller.appspot.com/x/report.txt?x=172f5e43600000
console output: https://syzkaller.appspot.com/x/log.txt?x=132f5e43600000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+35d4dea36c387813ed31@syzkaller.appspotmail.com
Fixes: 6e237d099fac ("netlink: Relax attr validation for fixed length types")

netlink: 'syz-executor879': attribute type 2 has an invalid length.
netlink: 'syz-executor879': attribute type 2 has an invalid length.
==================================================================
BUG: KASAN: slab-out-of-bounds in tcf_exts_destroy+0xb3/0xd0 net/sched/cls_api.c:2897
Read of size 8 at addr ffff8880a1463790 by task syz-executor879/9050

CPU: 0 PID: 9050 Comm: syz-executor879 Not tainted 5.3.0+ #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x172/0x1f0 lib/dump_stack.c:113
 print_address_description.constprop.0.cold+0xd4/0x30b mm/kasan/report.c:374
 __kasan_report.cold+0x1b/0x41 mm/kasan/report.c:506
 kasan_report+0x12/0x20 mm/kasan/common.c:634
 __asan_report_load8_noabort+0x14/0x20 mm/kasan/generic_report.c:132
 tcf_exts_destroy+0xb3/0xd0 net/sched/cls_api.c:2897
 tcindex_free_perfect_hash.isra.0+0xb3/0x150 net/sched/cls_tcindex.c:273
 tcindex_set_parms+0x1107/0x1e50 net/sched/cls_tcindex.c:484
 tcindex_change+0x230/0x320 net/sched/cls_tcindex.c:519
 tc_new_tfilter+0xa4b/0x1c70 net/sched/cls_api.c:2019
 rtnetlink_rcv_msg+0x838/0xb00 net/core/rtnetlink.c:5214
 netlink_rcv_skb+0x177/0x450 net/netlink/af_netlink.c:2477
 rtnetlink_rcv+0x1d/0x30 net/core/rtnetlink.c:5241
 netlink_unicast_kernel net/netlink/af_netlink.c:1302 [inline]
 netlink_unicast+0x531/0x710 net/netlink/af_netlink.c:1328
 netlink_sendmsg+0x8a5/0xd60 net/netlink/af_netlink.c:1917
 sock_sendmsg_nosec net/socket.c:637 [inline]
 sock_sendmsg+0xd7/0x130 net/socket.c:657
 ___sys_sendmsg+0x3e2/0x920 net/socket.c:2311
 __sys_sendmmsg+0x1bf/0x4d0 net/socket.c:2413
 __do_sys_sendmmsg net/socket.c:2442 [inline]
 __se_sys_sendmmsg net/socket.c:2439 [inline]
 __x64_sys_sendmmsg+0x9d/0x100 net/socket.c:2439
 do_syscall_64+0xfa/0x760 arch/x86/entry/common.c:290
 entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x443299
Code: e8 9c 07 03 00 48 83 c4 18 c3 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 0f 83 3b 0a fc ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007ffde8f54e48 EFLAGS: 00000246 ORIG_RAX: 0000000000000133
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 0000000000443299
RDX: 0000000000000332 RSI: 0000000020000140 RDI: 0000000000000008
RBP: 000000000000000c R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0030766461746162
R13: 00000000004041f0 R14: 0000000000000000 R15: 0000000000000000

Allocated by task 9050:
 save_stack+0x23/0x90 mm/kasan/common.c:69
 set_track mm/kasan/common.c:77 [inline]
 __kasan_kmalloc mm/kasan/common.c:510 [inline]
 __kasan_kmalloc.constprop.0+0xcf/0xe0 mm/kasan/common.c:483
 kasan_kmalloc+0x9/0x10 mm/kasan/common.c:524
 __do_kmalloc mm/slab.c:3655 [inline]
 __kmalloc+0x163/0x770 mm/slab.c:3664
 kmalloc_array include/linux/slab.h:614 [inline]
 kcalloc include/linux/slab.h:625 [inline]
 tcindex_alloc_perfect_hash+0x5a/0x320 net/sched/cls_tcindex.c:281
 tcindex_set_parms+0x454/0x1e50 net/sched/cls_tcindex.c:339
 tcindex_change+0x230/0x320 net/sched/cls_tcindex.c:519
 tc_new_tfilter+0xa4b/0x1c70 net/sched/cls_api.c:2019
 rtnetlink_rcv_msg+0x838/0xb00 net/core/rtnetlink.c:5214
 netlink_rcv_skb+0x177/0x450 net/netlink/af_netlink.c:2477
 rtnetlink_rcv+0x1d/0x30 net/core/rtnetlink.c:5241
 netlink_unicast_kernel net/netlink/af_netlink.c:1302 [inline]
 netlink_unicast+0x531/0x710 net/netlink/af_netlink.c:1328
 netlink_sendmsg+0x8a5/0xd60 net/netlink/af_netlink.c:1917
 sock_sendmsg_nosec net/socket.c:637 [inline]
 sock_sendmsg+0xd7/0x130 net/socket.c:657
 ___sys_sendmsg+0x3e2/0x920 net/socket.c:2311
 __sys_sendmmsg+0x1bf/0x4d0 net/socket.c:2413
 __do_sys_sendmmsg net/socket.c:2442 [inline]
 __se_sys_sendmmsg net/socket.c:2439 [inline]
 __x64_sys_sendmmsg+0x9d/0x100 net/socket.c:2439
 do_syscall_64+0xfa/0x760 arch/x86/entry/common.c:290
 entry_SYSCALL_64_after_hwframe+0x49/0xbe

Freed by task 2660:
 save_stack+0x23/0x90 mm/kasan/common.c:69
 set_track mm/kasan/common.c:77 [inline]
 kasan_set_free_info mm/kasan/common.c:332 [inline]
 __kasan_slab_free+0x102/0x150 mm/kasan/common.c:471
 kasan_slab_free+0xe/0x10 mm/kasan/common.c:480
 __cache_free mm/slab.c:3425 [inline]
 kfree+0x10a/0x2c0 mm/slab.c:3756
 call_usermodehelper_freeinfo kernel/umh.c:48 [inline]
 umh_complete kernel/umh.c:62 [inline]
 umh_complete+0x8d/0xa0 kernel/umh.c:51
 call_usermodehelper_exec_async+0x46c/0x730 kernel/umh.c:122
 ret_from_fork+0x24/0x30 arch/x86/entry/entry_64.S:352

The buggy address belongs to the object at ffff8880a1463700
 which belongs to the cache kmalloc-192 of size 192
The buggy address is located 144 bytes inside of
 192-byte region [ffff8880a1463700, ffff8880a14637c0)
The buggy address belongs to the page:
page:ffffea00028518c0 refcount:1 mapcount:0 mapping:ffff8880aa400000 index:0x0
flags: 0x1fffc0000000200(slab)
raw: 01fffc0000000200 ffffea000287e608 ffffea000286ff48 ffff8880aa400000
raw: 0000000000000000 ffff8880a1463000 0000000100000010 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
 ffff8880a1463680: fb fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
 ffff8880a1463700: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>ffff8880a1463780: 00 fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
                         ^
 ffff8880a1463800: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff8880a1463880: fb fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
==================================================================


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
