Return-Path: <SRS0=3tRb=3K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01021C2D0CE
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 12:37:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7238217F4
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 12:37:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729397AbgAUMhK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jan 2020 07:37:10 -0500
Received: from mail-il1-f200.google.com ([209.85.166.200]:39879 "EHLO
        mail-il1-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728794AbgAUMhJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jan 2020 07:37:09 -0500
Received: by mail-il1-f200.google.com with SMTP id n6so2011055ile.6
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jan 2020 04:37:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=Rw9xaBkd0xQvvdYC3NqAsCsIs+iEDGD6CLdubAFODHg=;
        b=AfkxixX2jxcxhBzKEF0i9tumvjQelshYgEy/mRF1hZLc2JE27tOsLThSgc8H98FqQ7
         LolL4uThB+Rt51975PcriA10Nfm68TyhzEB8RHF9z3Wm27WnMS84ra/Fdf89YK1gcKxQ
         L9i8Ol9Qf5j+sTlH+HEONti/FQMX1ZOgJm3/y1Q1LSHDEItv2o5m/ofHercYAURDU4Ha
         eOZSmvWkT/a0U9WPDNkcyrKi3Z3f8c4p12yLnQXvecII4toN8TQc8u8nTYYORZYwvEuE
         YaPM3nnKuAyoGfL6c2vOfcTHX4kByyydCcCygzL2vYP0sSPF36TaJyA1QsOD8N0SeIHA
         uUgg==
X-Gm-Message-State: APjAAAXy5nruR31GZgrCUbaUaHpuKNc1HYm7S5FiBoIfiu221fCTPwRC
        IExI7bL9tYOE7REp812rIkMtZvNyBUBrwuw7wSZzzvIZQgUj
X-Google-Smtp-Source: APXvYqznUuW1kpUcB5jVBbfWfUPxqB3lfTK6SeYTTRFrQYYuiLVL6sgLaK4PM4twzO909GnmsmQrHi8c3QYG2Euh039Bz73XQWaC
MIME-Version: 1.0
X-Received: by 2002:a92:d781:: with SMTP id d1mr3336749iln.30.1579610229029;
 Tue, 21 Jan 2020 04:37:09 -0800 (PST)
Date:   Tue, 21 Jan 2020 04:37:09 -0800
In-Reply-To: <000000000000367175059c90b6bf@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000095c2ce059ca5aa97@google.com>
Subject: Re: KASAN: use-after-free Read in __nf_tables_abort
From:   syzbot <syzbot+29125d208b3dae9a7019@syzkaller.appspotmail.com>
To:     coreteam@netfilter.org, dan.carpenter@oracle.com,
        davem@davemloft.net, fw@strlen.de, kadlec@netfilter.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        netfilter-devel@vger.kernel.org, pablo@netfilter.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has found a reproducer for the following crash on:

HEAD commit:    d96d875e Merge tag 'fixes_for_v5.5-rc8' of git://git.kerne..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=10cd81c9e00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=83c00afca9cf5153
dashboard link: https://syzkaller.appspot.com/bug?extid=29125d208b3dae9a7019
compiler:       clang version 10.0.0 (https://github.com/llvm/llvm-project/ c2443155a0fb245c8f17f2c1c72b6ea391e86e81)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1203f521e00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10a706a5e00000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+29125d208b3dae9a7019@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: use-after-free in __list_del_entry_valid+0x2f/0x100 lib/list_debug.c:42
Read of size 8 at addr ffff888097973008 by task syz-executor694/8782

CPU: 1 PID: 8782 Comm: syz-executor694 Not tainted 5.5.0-rc7-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x1fb/0x318 lib/dump_stack.c:118
 print_address_description+0x74/0x5c0 mm/kasan/report.c:374
 __kasan_report+0x149/0x1c0 mm/kasan/report.c:506
 kasan_report+0x26/0x50 mm/kasan/common.c:639
 __asan_report_load8_noabort+0x14/0x20 mm/kasan/generic_report.c:135
 __list_del_entry_valid+0x2f/0x100 lib/list_debug.c:42
 __list_del_entry include/linux/list.h:131 [inline]
 list_del_rcu include/linux/rculist.h:148 [inline]
 __nf_tables_abort+0x16d2/0x2e80 net/netfilter/nf_tables_api.c:7258
 nf_tables_abort+0x15/0x30 net/netfilter/nf_tables_api.c:7373
 nfnetlink_rcv_batch net/netfilter/nfnetlink.c:494 [inline]
 nfnetlink_rcv_skb_batch net/netfilter/nfnetlink.c:543 [inline]
 nfnetlink_rcv+0x1a88/0x1e50 net/netfilter/nfnetlink.c:561
 netlink_unicast_kernel net/netlink/af_netlink.c:1302 [inline]
 netlink_unicast+0x767/0x920 net/netlink/af_netlink.c:1328
 netlink_sendmsg+0xa2c/0xd50 net/netlink/af_netlink.c:1917
 sock_sendmsg_nosec net/socket.c:639 [inline]
 sock_sendmsg net/socket.c:659 [inline]
 ____sys_sendmsg+0x4f7/0x7f0 net/socket.c:2330
 ___sys_sendmsg net/socket.c:2384 [inline]
 __sys_sendmsg+0x1ed/0x290 net/socket.c:2417
 __do_sys_sendmsg net/socket.c:2426 [inline]
 __se_sys_sendmsg net/socket.c:2424 [inline]
 __x64_sys_sendmsg+0x7f/0x90 net/socket.c:2424
 do_syscall_64+0xf7/0x1c0 arch/x86/entry/common.c:294
 entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x4470c9
Code: e8 dc e6 ff ff 48 83 c4 18 c3 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 0f 83 2b 06 fc ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007ffb4f1fad98 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00000000006dcc28 RCX: 00000000004470c9
RDX: 0000000000000000 RSI: 0000000020000280 RDI: 0000000000000003
RBP: 00000000006dcc20 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000006dcc2c
R13: 00000000200002c0 R14: 00000000004af6c8 R15: 0000000000000000

Allocated by task 8782:
 save_stack mm/kasan/common.c:72 [inline]
 set_track mm/kasan/common.c:80 [inline]
 __kasan_kmalloc+0x118/0x1c0 mm/kasan/common.c:513
 kasan_kmalloc+0x9/0x10 mm/kasan/common.c:527
 kmem_cache_alloc_trace+0x221/0x2f0 mm/slab.c:3551
 kmalloc include/linux/slab.h:556 [inline]
 kzalloc include/linux/slab.h:670 [inline]
 nf_tables_newtable+0x350/0x1b10 net/netfilter/nf_tables_api.c:981
 nfnetlink_rcv_batch net/netfilter/nfnetlink.c:433 [inline]
 nfnetlink_rcv_skb_batch net/netfilter/nfnetlink.c:543 [inline]
 nfnetlink_rcv+0xecf/0x1e50 net/netfilter/nfnetlink.c:561
 netlink_unicast_kernel net/netlink/af_netlink.c:1302 [inline]
 netlink_unicast+0x767/0x920 net/netlink/af_netlink.c:1328
 netlink_sendmsg+0xa2c/0xd50 net/netlink/af_netlink.c:1917
 sock_sendmsg_nosec net/socket.c:639 [inline]
 sock_sendmsg net/socket.c:659 [inline]
 ____sys_sendmsg+0x4f7/0x7f0 net/socket.c:2330
 ___sys_sendmsg net/socket.c:2384 [inline]
 __sys_sendmsg+0x1ed/0x290 net/socket.c:2417
 __do_sys_sendmsg net/socket.c:2426 [inline]
 __se_sys_sendmsg net/socket.c:2424 [inline]
 __x64_sys_sendmsg+0x7f/0x90 net/socket.c:2424
 do_syscall_64+0xf7/0x1c0 arch/x86/entry/common.c:294
 entry_SYSCALL_64_after_hwframe+0x49/0xbe

Freed by task 2679:
 save_stack mm/kasan/common.c:72 [inline]
 set_track mm/kasan/common.c:80 [inline]
 kasan_set_free_info mm/kasan/common.c:335 [inline]
 __kasan_slab_free+0x12e/0x1e0 mm/kasan/common.c:474
 kasan_slab_free+0xe/0x10 mm/kasan/common.c:483
 __cache_free mm/slab.c:3426 [inline]
 kfree+0x10d/0x220 mm/slab.c:3757
 nft_commit_release net/netfilter/nf_tables_api.c:2496 [inline]
 nf_tables_trans_destroy_work+0x9b8/0xbb0 net/netfilter/nf_tables_api.c:6860
 process_one_work+0x7f5/0x10d0 kernel/workqueue.c:2264
 worker_thread+0xbbc/0x1630 kernel/workqueue.c:2410
 kthread+0x332/0x350 kernel/kthread.c:255
 ret_from_fork+0x24/0x30 arch/x86/entry/entry_64.S:352

The buggy address belongs to the object at ffff888097973000
 which belongs to the cache kmalloc-512 of size 512
The buggy address is located 8 bytes inside of
 512-byte region [ffff888097973000, ffff888097973200)
The buggy address belongs to the page:
page:ffffea00025e5cc0 refcount:1 mapcount:0 mapping:ffff8880aa800a80 index:0x0
raw: 00fffe0000000200 ffffea0002a53ac8 ffffea0002806848 ffff8880aa800a80
raw: 0000000000000000 ffff888097973000 0000000100000004 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
 ffff888097972f00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff888097972f80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>ffff888097973000: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                      ^
 ffff888097973080: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff888097973100: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================

