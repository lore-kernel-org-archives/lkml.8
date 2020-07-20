Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36AE7C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 08:38:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1BA9C21775
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 08:38:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727883AbgGTIiW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 04:38:22 -0400
Received: from mail-il1-f199.google.com ([209.85.166.199]:42129 "EHLO
        mail-il1-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727044AbgGTIiV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 04:38:21 -0400
Received: by mail-il1-f199.google.com with SMTP id d3so10578769ilq.9
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jul 2020 01:38:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=/pOe/UkZvEbGdAr/dvElx60N9w3UN5J6FPFhS9jd4kw=;
        b=b8DQgRtjdxSdiI8XKqbKMpdavAOygdzOKXxj8pdTIbFuhwwgP4FqTaCBw7FHKuYjgl
         5oBmIPBi46LIDRvNXH6XoAjeds1nfFJpLxvhGIOLtlh6qdBj1ctdLy4vvVM8MDUoTaeW
         5QVvCEOrqQ/4af6fTYCkw28H1+09pAeVDT2NE+gJ5rac6WguDgVNJA5NldKSOCHWScko
         mDfyeqAr0Hui6MtdLr+r8A5ZxVOxrWA3vJnBOShgXeASHSE4u9GB64TeOwXdB/f1wpp2
         ygdeIGlM/sHS63nEm1AuZmrJPnl6PK5pV8MvINgdhFyIZ4+Tgz0hKtvkqX7sDNUcipKa
         uppw==
X-Gm-Message-State: AOAM532YXmYVZCPeLcrq1dX38C2bcHwqQPI0sLMBAZ9uj8Z3MDKwfYL+
        uqi/TLDnKBA3qCwNfyCyyoPotrM4dxSnHx0nkG7oURip3wIB
X-Google-Smtp-Source: ABdhPJwnov5TdEhruF9H8/3cc9pPFy7sHqEeJyx5tApwl0rCBv55Mu9kWxW0CC1ay4unneBlIl+JTwxC+/vGYsVMxLrVry4yK6wL
MIME-Version: 1.0
X-Received: by 2002:a6b:4409:: with SMTP id r9mr21589476ioa.158.1595234300358;
 Mon, 20 Jul 2020 01:38:20 -0700 (PDT)
Date:   Mon, 20 Jul 2020 01:38:20 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ce768d05aadb6da0@google.com>
Subject: KASAN: use-after-free Read in xfrm6_tunnel_alloc_spi
From:   syzbot <syzbot+12f1afb7271ae16d5d9e@syzkaller.appspotmail.com>
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
console output: https://syzkaller.appspot.com/x/log.txt?x=15243307100000
kernel config:  https://syzkaller.appspot.com/x/.config?x=2c76d72659687242
dashboard link: https://syzkaller.appspot.com/bug?extid=12f1afb7271ae16d5d9e
compiler:       gcc (GCC) 10.1.0-syz 20200507

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+12f1afb7271ae16d5d9e@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: use-after-free in __xfrm6_tunnel_alloc_spi net/ipv6/xfrm6_tunnel.c:124 [inline]
BUG: KASAN: use-after-free in xfrm6_tunnel_alloc_spi+0x779/0x8a0 net/ipv6/xfrm6_tunnel.c:174
Read of size 4 at addr ffff88808b7da400 by task syz-executor.4/8451
CPU: 0 PID: 8451 Comm: syz-executor.4 Not tainted 5.8.0-rc5-next-20200716-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x18f/0x20d lib/dump_stack.c:118
 print_address_description.constprop.0.cold+0xae/0x497 mm/kasan/report.c:383
 __kasan_report mm/kasan/report.c:513 [inline]
 kasan_report.cold+0x1f/0x37 mm/kasan/report.c:530
 __xfrm6_tunnel_alloc_spi net/ipv6/xfrm6_tunnel.c:124 [inline]
 xfrm6_tunnel_alloc_spi+0x779/0x8a0 net/ipv6/xfrm6_tunnel.c:174
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
RSP: 002b:00007f09fcf03c78 EFLAGS: 00000246 ORIG_RAX: 0000000000000133
RAX: ffffffffffffffda RBX: 0000000000025a40 RCX: 000000000045c1d9
RDX: 0400000000000282 RSI: 0000000020000180 RDI: 0000000000000003
RBP: 000000000078bf48 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 000000000078bf0c
R13: 00007ffc814f8eff R14: 00007f09fcf049c0 R15: 000000000078bf0c
The buggy address belongs to the page:
page:00000000166c48c0 refcount:0 mapcount:-128 mapping:0000000000000000 index:0x0 pfn:0x8b7da
flags: 0xfffe0000000000()
raw: 00fffe0000000000 ffffea00029cc808 ffffea00029b8b88 0000000000000000
raw: 0000000000000000 0000000000000000 00000000ffffff7f 0000000000000000
page dumped because: kasan: bad access detected
Memory state around the buggy address:
 ffff88808b7da300: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
 ffff88808b7da380: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
>ffff88808b7da400: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
                   ^
 ffff88808b7da480: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
 ffff88808b7da500: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
