Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BC73C433E4
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 08:38:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 169FB2176B
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 08:38:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726959AbgGTIiW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 04:38:22 -0400
Received: from mail-io1-f71.google.com ([209.85.166.71]:52677 "EHLO
        mail-io1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726015AbgGTIiV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 04:38:21 -0400
Received: by mail-io1-f71.google.com with SMTP id k12so10800978iom.19
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jul 2020 01:38:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=n7bPe0p0utQNhjB8dbhRxivB+fD0ji4K1KNrKXbVjXY=;
        b=r3yhLpJfPTWx7lcSfT6/tUavLC4zvflv3nf4n+WtdgL8TWAqYll9LdYXQeH1aKftgN
         /gJasZNX6T1814Y8nkF+zbg2GP6fJsxZi1otYLX+h0qCrI2LCCwwHzP6ajPZ87OFIx7o
         A5CxqWK7Me0qIcxKDLPPr5CCp0s0PQRkRuYtJF+XTYA6OlC/2Y3tF5eE8m1fwfBO/Alt
         nEx4l8u/O8aeFYew5CiahZsyIYEXl/gycth2KpMSI0sCU7jewwHca7as3J2NpvkIiPut
         8GGX6aV1q3jj2fKvya7OVgrGt6YrfgrZkq4MfODy1m1beTKz/FgcfyE5L7YemPCdFsTA
         jR9Q==
X-Gm-Message-State: AOAM533cuVzAzPdO90ITeuUjp+tj9j0myZmI7kFVzuReyb+IlR8F2tgC
        jOgi8EcQHWxlyMEkiEAyhP4aam4jGxNA8e69I1S9wur8S6li
X-Google-Smtp-Source: ABdhPJzvDGysBITFVFhuwkBkQ18wos4HANH/rRKyD9i8k6WsGRKP2WnsN8eaxabRX1X234TYIos/JpDtYv5t6z9rSNwcbn0Q1xfV
MIME-Version: 1.0
X-Received: by 2002:a02:7709:: with SMTP id g9mr24853158jac.118.1595234299967;
 Mon, 20 Jul 2020 01:38:19 -0700 (PDT)
Date:   Mon, 20 Jul 2020 01:38:19 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c87b7305aadb6dba@google.com>
Subject: KASAN: slab-out-of-bounds Read in __xfrm6_tunnel_spi_check
From:   syzbot <syzbot+7da3fdf292816554b942@syzkaller.appspotmail.com>
To:     davem@davemloft.net, herbert@gondor.apana.org.au, kuba@kernel.org,
        kuznet@ms2.inr.ac.ru, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, steffen.klassert@secunet.com,
        syzkaller-bugs@googlegroups.com, yoshfuji@linux-ipv6.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    4c43049f Add linux-next specific files for 20200716
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=12e58d7d100000
kernel config:  https://syzkaller.appspot.com/x/.config?x=2c76d72659687242
dashboard link: https://syzkaller.appspot.com/bug?extid=7da3fdf292816554b942
compiler:       gcc (GCC) 10.1.0-syz 20200507

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+7da3fdf292816554b942@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-out-of-bounds in __xfrm6_tunnel_spi_check+0x316/0x330 net/ipv6/xfrm6_tunnel.c:108
Read of size 8 at addr ffff8880a93a5e08 by task syz-executor.1/8482
CPU: 0 PID: 8482 Comm: syz-executor.1 Not tainted 5.8.0-rc5-next-20200716-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x18f/0x20d lib/dump_stack.c:118
 print_address_description.constprop.0.cold+0xae/0x497 mm/kasan/report.c:383
 __kasan_report mm/kasan/report.c:513 [inline]
 kasan_report.cold+0x1f/0x37 mm/kasan/report.c:530
 __xfrm6_tunnel_spi_check+0x316/0x330 net/ipv6/xfrm6_tunnel.c:108
 __xfrm6_tunnel_alloc_spi net/ipv6/xfrm6_tunnel.c:131 [inline]
 xfrm6_tunnel_alloc_spi+0x296/0x8a0 net/ipv6/xfrm6_tunnel.c:174
 ipcomp6_tunnel_create net/ipv6/ipcomp6.c:84 [inline]
 ipcomp6_tunnel_attach net/ipv6/ipcomp6.c:124 [inline]
 ipcomp6_init_state net/ipv6/ipcomp6.c:159 [inline]
 ipcomp6_init_state+0x2af/0x700 net/ipv6/ipcomp6.c:139
 __xfrm_init_state+0x9a6/0x14b0 net/xfrm/xfrm_state.c:2498
 xfrm_init_state+0x1a/0x70 net/xfrm/xfrm_state.c:2525
 pfkey_msg2xfrm_state net/key/af_key.c:1291 [inline]
 pfkey_add+0x1a10/0x2b70 net/key/af_key.c:1508
 pfkey_process+0x66d/0x7a0 net/key/af_key.c:2834
 pfkey_sendmsg+0x42d/0x800 net/key/af_key.c:3673
 sock_sendmsg_nosec net/socket.c:651 [inline]
 sock_sendmsg+0xcf/0x120 net/socket.c:671
 ____sys_sendmsg+0x331/0x810 net/socket.c:2362
 ___sys_sendmsg+0xf3/0x170 net/socket.c:2416
 __sys_sendmmsg+0x195/0x480 net/socket.c:2506
 __do_sys_sendmmsg net/socket.c:2535 [inline]
 __se_sys_sendmmsg net/socket.c:2532 [inline]
 __x64_sys_sendmmsg+0x99/0x100 net/socket.c:2532
 do_syscall_64+0x60/0xe0 arch/x86/entry/common.c:384
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x45c1d9
Code: Bad RIP value.
RSP: 002b:00007fe3fa739c78 EFLAGS: 00000246
 ORIG_RAX: 0000000000000133
RAX: ffffffffffffffda RBX: 0000000000025a40 RCX: 000000000045c1d9
RDX: 0400000000000282 RSI: 0000000020000180 RDI: 0000000000000003
RBP: 000000000078bf48 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 000000000078bf0c
R13: 00007fffec91896f R14: 00007fe3fa73a9c0 R15: 000000000078bf0c
Allocated by task 1:
 kasan_save_stack+0x1b/0x40 mm/kasan/common.c:48
 kasan_set_track mm/kasan/common.c:56 [inline]
 __kasan_kmalloc.constprop.0+0xbf/0xd0 mm/kasan/common.c:461
 kmem_cache_alloc_trace+0x16e/0x2c0 mm/slab.c:3550
 kmalloc include/linux/slab.h:554 [inline]
 kzalloc include/linux/slab.h:666 [inline]
 device_private_init drivers/base/core.c:2763 [inline]
 device_add+0x1008/0x1c40 drivers/base/core.c:2813
 netdev_register_kobject+0x17d/0x3b0 net/core/net-sysfs.c:1888
 register_netdevice+0xd29/0x1540 net/core/dev.c:9523
 register_netdev+0x2d/0x50 net/core/dev.c:9654
 ip6gre_init_net+0x3c4/0x5e0 net/ipv6/ip6_gre.c:1587
 ops_init+0xaf/0x470 net/core/net_namespace.c:151
 __register_pernet_operations net/core/net_namespace.c:1140 [inline]
 register_pernet_operations+0x35a/0x850 net/core/net_namespace.c:1217
 register_pernet_device+0x26/0x70 net/core/net_namespace.c:1304
 ip6gre_init+0x1f/0x132 net/ipv6/ip6_gre.c:2327
 do_one_initcall+0x10a/0x7b0 init/main.c:1201
 do_initcall_level init/main.c:1274 [inline]
 do_initcalls init/main.c:1290 [inline]
 do_basic_setup init/main.c:1310 [inline]
 kernel_init_freeable+0x4f4/0x5a3 init/main.c:1507
 kernel_init+0xd/0x1c0 init/main.c:1401
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:294
The buggy address belongs to the object at ffff8880a93a5c00
 which belongs to the cache kmalloc-512 of size 512
The buggy address is located 8 bytes to the right of
 512-byte region [ffff8880a93a5c00, ffff8880a93a5e00)
The buggy address belongs to the page:
page:0000000064ff38cf refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0xa93a5
flags: 0xfffe0000000200(slab)
raw: 00fffe0000000200 ffffea00028deec8 ffffea00027a5388 ffff8880aa000600
raw: 0000000000000000 ffff8880a93a5000 0000000100000004 0000000000000000
page dumped because: kasan: bad access detected
Memory state around the buggy address:
 ffff8880a93a5d00: 00 fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff8880a93a5d80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>ffff8880a93a5e00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
                      ^
 ffff8880a93a5e80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff8880a93a5f00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
