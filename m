Return-Path: <SRS0=rtH4=AH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D22FC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 17:19:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E2F84207D8
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 17:19:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726682AbgFZRTW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jun 2020 13:19:22 -0400
Received: from mail-io1-f71.google.com ([209.85.166.71]:42562 "EHLO
        mail-io1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726349AbgFZRTS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 13:19:18 -0400
Received: by mail-io1-f71.google.com with SMTP id a16so6808777iow.9
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jun 2020 10:19:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=W/UznvDYTIROrW7qKMCS6XF22x9cUlWvYZzA47Ub1po=;
        b=LGvSA1mBPCPNgMmKthgYgXM3F9QW7iipxcJILARVm1nUhvJ+vjrZWwidLjvOSGuZJ8
         lgMItOZ4FKJn3IVO6oTbqlfhet8AfLKsuT6YGynPyhxQWS2R45KQSvjUNH+RYd5V4hLn
         3vMvy9T0cAzJ6D3DMLeHauN5jFGrOVpayru33s+m9DJC3msbsfcVMyYzatNALV9UhrHk
         ldZNEdGYg+kJCaa9oqgl0++amJfJ4saaHFr5WMR5d8VQglF6BaQ71QaoMhN7WBOtL7Al
         fH95x8V4AkTyQUGrm34iFOZfoECcPqdgSgFptUzJCq2PJ+nOtGNepYcrByWCgIEGAoYA
         284g==
X-Gm-Message-State: AOAM531XuUJVNt8ZauuVDX9W3E4KF+fcuKPfcz2SNV8XYNvQSpqLMHoc
        Nhtof3UIqv+pOeEtNbakmyzwCoFBfWI8WG+9ENCyLhOusU75
X-Google-Smtp-Source: ABdhPJyzqPJJVJbnJdUZWyOP6bO5phOFd/OmicKa6rR8pI+4cKmScjjy4GybN2QztvqeT7miYQzbW058zl/i8YhDmF8HOFwneGwf
MIME-Version: 1.0
X-Received: by 2002:a05:6602:2e81:: with SMTP id m1mr4460955iow.147.1593191957542;
 Fri, 26 Jun 2020 10:19:17 -0700 (PDT)
Date:   Fri, 26 Jun 2020 10:19:17 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b03d8405a8ffe81f@google.com>
Subject: KMSAN: uninit-value in __nla_validate_parse
From:   syzbot <syzbot+6c73a580c3aec0f65123@syzkaller.appspotmail.com>
To:     davem@davemloft.net, glider@google.com, jhs@mojatatu.com,
        jiri@resnulli.us, kuba@kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        xiyou.wangcong@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    f0d5ec90 kmsan: apply __no_sanitize_memory to dotraplinkag..
git tree:       https://github.com/google/kmsan.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=1314b629100000
kernel config:  https://syzkaller.appspot.com/x/.config?x=86e4f8af239686c6
dashboard link: https://syzkaller.appspot.com/bug?extid=6c73a580c3aec0f65123
compiler:       clang version 10.0.0 (https://github.com/llvm/llvm-project/ c2443155a0fb245c8f17f2c1c72b6ea391e86e81)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+6c73a580c3aec0f65123@syzkaller.appspotmail.com

netlink: 4 bytes leftover after parsing attributes in process `syz-executor.2'.
=====================================================
BUG: KMSAN: uninit-value in nla_ok include/net/netlink.h:1094 [inline]
BUG: KMSAN: uninit-value in __nla_validate_parse+0x422/0x3450 lib/nlattr.c:369
CPU: 1 PID: 28976 Comm: syz-executor.2 Not tainted 5.7.0-rc4-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x1c9/0x220 lib/dump_stack.c:118
 kmsan_report+0xf7/0x1e0 mm/kmsan/kmsan_report.c:121
 __msan_warning+0x58/0xa0 mm/kmsan/kmsan_instr.c:215
 nla_ok include/net/netlink.h:1094 [inline]
 __nla_validate_parse+0x422/0x3450 lib/nlattr.c:369
 __nla_parse+0x137/0x150 lib/nlattr.c:478
 nla_parse_nested include/net/netlink.h:1147 [inline]
 fl_set_erspan_opt+0x30e/0xd40 net/sched/cls_flower.c:1040
 fl_set_enc_opt net/sched/cls_flower.c:1198 [inline]
 fl_set_key+0x6322/0x8e10 net/sched/cls_flower.c:1471
 fl_set_parms net/sched/cls_flower.c:1707 [inline]
 fl_change+0x1202/0x7530 net/sched/cls_flower.c:1806
 tc_new_tfilter+0x31a8/0x4f40 net/sched/cls_api.c:2168
 rtnetlink_rcv_msg+0xcb7/0x1570 net/core/rtnetlink.c:5445
 netlink_rcv_skb+0x451/0x650 net/netlink/af_netlink.c:2469
 rtnetlink_rcv+0x50/0x60 net/core/rtnetlink.c:5472
 netlink_unicast_kernel net/netlink/af_netlink.c:1303 [inline]
 netlink_unicast+0xf9e/0x1100 net/netlink/af_netlink.c:1329
 netlink_sendmsg+0x1246/0x14d0 net/netlink/af_netlink.c:1918
 sock_sendmsg_nosec net/socket.c:652 [inline]
 sock_sendmsg net/socket.c:672 [inline]
 ____sys_sendmsg+0x12b6/0x1350 net/socket.c:2362
 ___sys_sendmsg net/socket.c:2416 [inline]
 __sys_sendmmsg+0x5fe/0xd60 net/socket.c:2506
 __do_sys_sendmmsg net/socket.c:2535 [inline]
 __se_sys_sendmmsg+0xbd/0xe0 net/socket.c:2532
 __x64_sys_sendmmsg+0x56/0x70 net/socket.c:2532
 do_syscall_64+0xb8/0x160 arch/x86/entry/common.c:297
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x45ca59
Code: 0d b7 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 0f 83 db b6 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007f1dee04dc78 EFLAGS: 00000246 ORIG_RAX: 0000000000000133
RAX: ffffffffffffffda RBX: 00000000004fd380 RCX: 000000000045ca59
RDX: 010efe10675dec16 RSI: 0000000020000200 RDI: 0000000000000003
RBP: 000000000078bfa0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000ffffffff
R13: 0000000000000900 R14: 00000000004cbcfa R15: 00007f1dee04e6d4

Uninit was created at:
 kmsan_save_stack_with_flags mm/kmsan/kmsan.c:144 [inline]
 kmsan_internal_poison_shadow+0x66/0xd0 mm/kmsan/kmsan.c:127
 kmsan_slab_alloc+0x8a/0xe0 mm/kmsan/kmsan_hooks.c:80
 slab_alloc_node mm/slub.c:2802 [inline]
 __kmalloc_node_track_caller+0xb40/0x1200 mm/slub.c:4436
 __kmalloc_reserve net/core/skbuff.c:142 [inline]
 __alloc_skb+0x2fd/0xac0 net/core/skbuff.c:210
 alloc_skb include/linux/skbuff.h:1083 [inline]
 netlink_alloc_large_skb net/netlink/af_netlink.c:1175 [inline]
 netlink_sendmsg+0x7d3/0x14d0 net/netlink/af_netlink.c:1893
 sock_sendmsg_nosec net/socket.c:652 [inline]
 sock_sendmsg net/socket.c:672 [inline]
 ____sys_sendmsg+0x12b6/0x1350 net/socket.c:2362
 ___sys_sendmsg net/socket.c:2416 [inline]
 __sys_sendmmsg+0x5fe/0xd60 net/socket.c:2506
 __do_sys_sendmmsg net/socket.c:2535 [inline]
 __se_sys_sendmmsg+0xbd/0xe0 net/socket.c:2532
 __x64_sys_sendmmsg+0x56/0x70 net/socket.c:2532
 do_syscall_64+0xb8/0x160 arch/x86/entry/common.c:297
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
=====================================================


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
