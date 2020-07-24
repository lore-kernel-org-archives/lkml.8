Return-Path: <SRS0=4orP=BD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6214C433E3
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 00:47:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C549C20737
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 00:47:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728427AbgGXArS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jul 2020 20:47:18 -0400
Received: from mail-io1-f72.google.com ([209.85.166.72]:39608 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728385AbgGXArQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 20:47:16 -0400
Received: by mail-io1-f72.google.com with SMTP id m26so4051392ioc.6
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jul 2020 17:47:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=BNZWFIG+mhHqzyvESfY+ZRyDftcwSaoYvJcMAf54kFo=;
        b=Akzn8wX4pjwrI8vE4goABi4Sn6zE08g0ymIowa6KaqOyrtvDRYZzLspaGcSRvUbQeM
         Kd8E2jAth2nWtjHSWfMCj6v6tGVV80WJrJflW2vr3zki3oEN5spl6diN9Kejwt7hZsQI
         Yc+IMB7F4AMuYn3/nhz4WTSbshqzQRyj1e0KnsbVLetl7cFdGlVluWLBws2cr9EssMt7
         RfAvlYI3SY0KoKJ9NOkdYhfth4DjUQjHTTXiJmxnQduxStMVcEz4Sm7fLioZskhJOM5Z
         erhMAzGgA6FSy1At9BhiXIduHXZWLY4MMsr4DKrWGpGAe0verKZciMOK9ux0FRpzmkbW
         pJiQ==
X-Gm-Message-State: AOAM530R46ik5MkLMcPwiJb8+mjdgiFm8ki58wfn9Ji9A/JrsZlYCJvD
        bWLxF1SBRrY1Ew02SbXPE+J7hT8R+c4JWsQyR2v11PjRhRjD
X-Google-Smtp-Source: ABdhPJzWyLJSNW/Mt0wdgB2csu8hpv3eWZ6rnnpIntP4GG4OBM/43v4fRJm25pHgfTasHfNEJp+KC9KJCMRdCbRiuhSfGj18e4nR
MIME-Version: 1.0
X-Received: by 2002:a5e:8d15:: with SMTP id m21mr7894473ioj.60.1595551634488;
 Thu, 23 Jul 2020 17:47:14 -0700 (PDT)
Date:   Thu, 23 Jul 2020 17:47:14 -0700
In-Reply-To: <0000000000003df98d05ab06aac6@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000065017c05ab255072@google.com>
Subject: Re: KASAN: use-after-free Read in linkwatch_fire_event
From:   syzbot <syzbot+987da0fff3a594532ce1@syzkaller.appspotmail.com>
To:     andrew@lunn.ch, davem@davemloft.net, kuba@kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has found a reproducer for the following issue on:

HEAD commit:    4f5baedd Add linux-next specific files for 20200723
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=12e497b4900000
kernel config:  https://syzkaller.appspot.com/x/.config?x=785eb1cc9c75f625
dashboard link: https://syzkaller.appspot.com/bug?extid=987da0fff3a594532ce1
compiler:       gcc (GCC) 10.1.0-syz 20200507
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11043454900000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16579f78900000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+987da0fff3a594532ce1@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: use-after-free in __list_add_valid+0x93/0xa0 lib/list_debug.c:26
Read of size 8 at addr ffff888065294570 by task syz-executor076/31793
CPU: 1 PID: 31793 Comm: syz-executor076 Not tainted 5.8.0-rc6-next-20200723-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x18f/0x20d lib/dump_stack.c:118
 print_address_description.constprop.0.cold+0xae/0x497 mm/kasan/report.c:383
 __kasan_report mm/kasan/report.c:513 [inline]
 kasan_report.cold+0x1f/0x37 mm/kasan/report.c:530
 __list_add_valid+0x93/0xa0 lib/list_debug.c:26
 __list_add include/linux/list.h:67 [inline]
 list_add_tail include/linux/list.h:100 [inline]
 linkwatch_add_event net/core/link_watch.c:111 [inline]
 linkwatch_fire_event+0xea/0x1d0 net/core/link_watch.c:261
 netif_carrier_off net/sched/sch_generic.c:513 [inline]
 netif_carrier_off+0x96/0xb0 net/sched/sch_generic.c:507
 bond_newlink drivers/net/bonding/bond_netlink.c:460 [inline]
 bond_newlink+0x52/0xa0 drivers/net/bonding/bond_netlink.c:448
 __rtnl_newlink+0x1090/0x1750 net/core/rtnetlink.c:3339
 rtnl_newlink+0x64/0xa0 net/core/rtnetlink.c:3398
 rtnetlink_rcv_msg+0x44e/0xad0 net/core/rtnetlink.c:5461
 netlink_rcv_skb+0x15a/0x430 net/netlink/af_netlink.c:2470
 netlink_unicast_kernel net/netlink/af_netlink.c:1304 [inline]
 netlink_unicast+0x533/0x7d0 net/netlink/af_netlink.c:1330
 netlink_sendmsg+0x856/0xd90 net/netlink/af_netlink.c:1919
 sock_sendmsg_nosec net/socket.c:651 [inline]
 sock_sendmsg+0xcf/0x120 net/socket.c:671
 ____sys_sendmsg+0x6e8/0x810 net/socket.c:2363
 ___sys_sendmsg+0xf3/0x170 net/socket.c:2417
 __sys_sendmsg+0xe5/0x1b0 net/socket.c:2450
 do_syscall_64+0x60/0xe0 arch/x86/entry/common.c:384
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x44a979
Code: Bad RIP value.
RSP: 002b:00007f1740ffbd98 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00000000006e69e8 RCX: 000000000044a979
RDX: 0000000000000000 RSI: 0000000020000040 RDI: 0000000000000004
RBP: 00000000006e69e0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000006e69ec
R13: 0000000000000000 R14: 0000000000000000 R15: 068500100000003c
Allocated by task 31587:
 kasan_save_stack+0x1b/0x40 mm/kasan/common.c:48
 kasan_set_track mm/kasan/common.c:56 [inline]
 __kasan_kmalloc.constprop.0+0xbf/0xd0 mm/kasan/common.c:461
 kmalloc_node include/linux/slab.h:577 [inline]
 kvmalloc_node+0xb4/0xf0 mm/util.c:574
 kvmalloc include/linux/mm.h:760 [inline]
 kvzalloc include/linux/mm.h:768 [inline]
 alloc_netdev_mqs+0x97/0xdc0 net/core/dev.c:9961
 rtnl_create_link+0x219/0xad0 net/core/rtnetlink.c:3067
 __rtnl_newlink+0xfa0/0x1750 net/core/rtnetlink.c:3329
 rtnl_newlink+0x64/0xa0 net/core/rtnetlink.c:3398
 rtnetlink_rcv_msg+0x44e/0xad0 net/core/rtnetlink.c:5461
 netlink_rcv_skb+0x15a/0x430 net/netlink/af_netlink.c:2470
 netlink_unicast_kernel net/netlink/af_netlink.c:1304 [inline]
 netlink_unicast+0x533/0x7d0 net/netlink/af_netlink.c:1330
 netlink_sendmsg+0x856/0xd90 net/netlink/af_netlink.c:1919
 sock_sendmsg_nosec net/socket.c:651 [inline]
 sock_sendmsg+0xcf/0x120 net/socket.c:671
 ____sys_sendmsg+0x6e8/0x810 net/socket.c:2363
 ___sys_sendmsg+0xf3/0x170 net/socket.c:2417
 __sys_sendmsg+0xe5/0x1b0 net/socket.c:2450
 do_syscall_64+0x60/0xe0 arch/x86/entry/common.c:384
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
Freed by task 31587:
 kasan_save_stack+0x1b/0x40 mm/kasan/common.c:48
 kasan_set_track+0x1c/0x30 mm/kasan/common.c:56
 kasan_set_free_info+0x1b/0x30 mm/kasan/generic.c:355
 __kasan_slab_free+0xd8/0x120 mm/kasan/common.c:422
 __cache_free mm/slab.c:3418 [inline]
 kfree+0x103/0x2c0 mm/slab.c:3756
 kvfree+0x42/0x50 mm/util.c:603
 device_release+0x71/0x200 drivers/base/core.c:1791
 kobject_cleanup lib/kobject.c:704 [inline]
 kobject_release lib/kobject.c:735 [inline]
 kref_put include/linux/kref.h:65 [inline]
 kobject_put+0x171/0x270 lib/kobject.c:752
 put_device+0x1b/0x30 drivers/base/core.c:3020
 free_netdev+0x35d/0x480 net/core/dev.c:10077
 __rtnl_newlink+0x14d8/0x1750 net/core/rtnetlink.c:3354
 rtnl_newlink+0x64/0xa0 net/core/rtnetlink.c:3398
 rtnetlink_rcv_msg+0x44e/0xad0 net/core/rtnetlink.c:5461
 netlink_rcv_skb+0x15a/0x430 net/netlink/af_netlink.c:2470
 netlink_unicast_kernel net/netlink/af_netlink.c:1304 [inline]
 netlink_unicast+0x533/0x7d0 net/netlink/af_netlink.c:1330
 netlink_sendmsg+0x856/0xd90 net/netlink/af_netlink.c:1919
 sock_sendmsg_nosec net/socket.c:651 [inline]
 sock_sendmsg+0xcf/0x120 net/socket.c:671
 ____sys_sendmsg+0x6e8/0x810 net/socket.c:2363
 ___sys_sendmsg+0xf3/0x170 net/socket.c:2417
 __sys_sendmsg+0xe5/0x1b0 net/socket.c:2450
 do_syscall_64+0x60/0xe0 arch/x86/entry/common.c:384
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
The buggy address belongs to the object at ffff888065294000
 which belongs to the cache kmalloc-8k of size 8192
The buggy address is located 1392 bytes inside of
 8192-byte region [ffff888065294000, ffff888065296000)
The buggy address belongs to the page:
page:00000000d305b100 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x65294
head:00000000d305b100 order:2 compound_mapcount:0 compound_pincount:0
flags: 0xfffe0000010200(slab|head)
raw: 00fffe0000010200 ffffea000194b708 ffffea00019eb908 ffff8880aa000a00
raw: 0000000000000000 ffff888065294000 0000000100000001 0000000000000000
page dumped because: kasan: bad access detected
Memory state around the buggy address:
 ffff888065294400: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff888065294480: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff888065294500: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                                             ^
 ffff888065294580: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff888065294600: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================

