Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6205BC433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 21:58:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3A50C206D5
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 21:58:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728347AbgFIV6Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jun 2020 17:58:24 -0400
Received: from mail-il1-f199.google.com ([209.85.166.199]:36265 "EHLO
        mail-il1-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728183AbgFIV6O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 17:58:14 -0400
Received: by mail-il1-f199.google.com with SMTP id p11so99504iln.3
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jun 2020 14:58:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=is3mYXvfsr8aZ3qMnGeuXO0CoeZIoQo4k3FctA0HRyE=;
        b=Ol0BGl2az7TMskAU/yHF8jml5+iMPYlDG16vip+hKO+oNK97HNYfhfhWU0UOlvpv19
         YhFpqZr2oQ0unDbMG9VjivEgq+DK2M9qQn4OoFpUXr8N9encmBjNc+torbfiiKuRqbg5
         BjvKQlhWZ6G/FquoxZIV2DbAKxtirsnIagFxDrJIgYal7F2ORn3Mp5gD4Q8Kcml/9YWN
         3FFntQj0TuCKk0eBuqg3aDo8pE//WDYKkV8YzgkNT6NwMyQ8/GW+H3LwRKJ3Onhe+dcq
         B5BjuGiA2+QdEQlKIaFwkF/UZmU1pOy7vnlZMiEieF1GYpOYHJrgGniNc4nTFoCS+5R2
         Lajg==
X-Gm-Message-State: AOAM533WGTzK2Iznjxx+zRAIEQ3zww6/ciMtZ9VFoGSj0oDQWF99k6IX
        UfIhDdebzp225swqHV8h1Gn4FGaUCLB3V16LWESNXyKfMa8h
X-Google-Smtp-Source: ABdhPJw/82TPa1XeCOKkpmVno/WmIk8WcRmqHcdCILzMZK6LifwgFRho/qtOA2H4sjM4sHA2CvI9A0QlZoHSd4A63OiluVzQpNuy
MIME-Version: 1.0
X-Received: by 2002:a05:6602:164f:: with SMTP id y15mr199028iow.210.1591739892356;
 Tue, 09 Jun 2020 14:58:12 -0700 (PDT)
Date:   Tue, 09 Jun 2020 14:58:12 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000dbe05b05a7add269@google.com>
Subject: memory leak in nf_tables_parse_netdev_hooks (3)
From:   syzbot <syzbot+eb9d5924c51d6d59e094@syzkaller.appspotmail.com>
To:     coreteam@netfilter.org, davem@davemloft.net, fw@strlen.de,
        kadlec@netfilter.org, kuba@kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        netfilter-devel@vger.kernel.org, pablo@netfilter.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    7ae77150 Merge tag 'powerpc-5.8-1' of git://git.kernel.org..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1741f5f2100000
kernel config:  https://syzkaller.appspot.com/x/.config?x=9a1aa05456dfd557
dashboard link: https://syzkaller.appspot.com/bug?extid=eb9d5924c51d6d59e094
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=126f5446100000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=177f16fe100000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+eb9d5924c51d6d59e094@syzkaller.appspotmail.com

executing program
BUG: memory leak
unreferenced object 0xffff88811589cd80 (size 96):
  comm "syz-executor337", pid 6663, jiffies 4294942418 (age 13.980s)
  hex dump (first 32 bytes):
    00 c9 89 15 81 88 ff ff 68 f9 ff 00 00 c9 ff ff  ........h.......
    00 cd 89 15 81 88 ff ff 60 52 c5 82 ff ff ff ff  ........`R......
  backtrace:
    [<00000000104a1f01>] kmalloc include/linux/slab.h:555 [inline]
    [<00000000104a1f01>] nft_netdev_hook_alloc+0x3b/0xd0 net/netfilter/nf_tables_api.c:1659
    [<000000003bc42f25>] nf_tables_parse_netdev_hooks+0x94/0x210 net/netfilter/nf_tables_api.c:1709
    [<000000004b6a9590>] nft_flowtable_parse_hook+0x101/0x1d0 net/netfilter/nf_tables_api.c:6243
    [<000000004204916e>] nft_delflowtable_hook net/netfilter/nf_tables_api.c:6562 [inline]
    [<000000004204916e>] nf_tables_delflowtable+0x249/0x4a0 net/netfilter/nf_tables_api.c:6640
    [<00000000fa0bd6d2>] nfnetlink_rcv_batch+0x2f3/0x810 net/netfilter/nfnetlink.c:433
    [<000000004d4e8df7>] nfnetlink_rcv_skb_batch net/netfilter/nfnetlink.c:543 [inline]
    [<000000004d4e8df7>] nfnetlink_rcv+0x183/0x1b0 net/netfilter/nfnetlink.c:561
    [<000000001710060c>] netlink_unicast_kernel net/netlink/af_netlink.c:1303 [inline]
    [<000000001710060c>] netlink_unicast+0x20a/0x2f0 net/netlink/af_netlink.c:1329
    [<00000000bb814b80>] netlink_sendmsg+0x2b5/0x560 net/netlink/af_netlink.c:1918
    [<00000000eb7a00fe>] sock_sendmsg_nosec net/socket.c:652 [inline]
    [<00000000eb7a00fe>] sock_sendmsg+0x4c/0x60 net/socket.c:672
    [<000000008cc37c52>] ____sys_sendmsg+0x2c4/0x2f0 net/socket.c:2352
    [<00000000b882e46e>] ___sys_sendmsg+0x8a/0xd0 net/socket.c:2406
    [<00000000870e7750>] __sys_sendmsg+0x77/0xe0 net/socket.c:2439
    [<000000002b222e75>] do_syscall_64+0x6e/0x220 arch/x86/entry/common.c:295
    [<00000000356e1a8a>] entry_SYSCALL_64_after_hwframe+0x44/0xa9

BUG: memory leak
unreferenced object 0xffff88811589c900 (size 96):
  comm "syz-executor337", pid 6663, jiffies 4294942418 (age 13.980s)
  hex dump (first 32 bytes):
    68 f9 ff 00 00 c9 ff ff 80 cd 89 15 81 88 ff ff  h...............
    00 00 00 00 00 00 00 00 60 52 c5 82 ff ff ff ff  ........`R......
  backtrace:
    [<00000000104a1f01>] kmalloc include/linux/slab.h:555 [inline]
    [<00000000104a1f01>] nft_netdev_hook_alloc+0x3b/0xd0 net/netfilter/nf_tables_api.c:1659
    [<000000003bc42f25>] nf_tables_parse_netdev_hooks+0x94/0x210 net/netfilter/nf_tables_api.c:1709
    [<000000004b6a9590>] nft_flowtable_parse_hook+0x101/0x1d0 net/netfilter/nf_tables_api.c:6243
    [<000000004204916e>] nft_delflowtable_hook net/netfilter/nf_tables_api.c:6562 [inline]
    [<000000004204916e>] nf_tables_delflowtable+0x249/0x4a0 net/netfilter/nf_tables_api.c:6640
    [<00000000fa0bd6d2>] nfnetlink_rcv_batch+0x2f3/0x810 net/netfilter/nfnetlink.c:433
    [<000000004d4e8df7>] nfnetlink_rcv_skb_batch net/netfilter/nfnetlink.c:543 [inline]
    [<000000004d4e8df7>] nfnetlink_rcv+0x183/0x1b0 net/netfilter/nfnetlink.c:561
    [<000000001710060c>] netlink_unicast_kernel net/netlink/af_netlink.c:1303 [inline]
    [<000000001710060c>] netlink_unicast+0x20a/0x2f0 net/netlink/af_netlink.c:1329
    [<00000000bb814b80>] netlink_sendmsg+0x2b5/0x560 net/netlink/af_netlink.c:1918
    [<00000000eb7a00fe>] sock_sendmsg_nosec net/socket.c:652 [inline]
    [<00000000eb7a00fe>] sock_sendmsg+0x4c/0x60 net/socket.c:672
    [<000000008cc37c52>] ____sys_sendmsg+0x2c4/0x2f0 net/socket.c:2352
    [<00000000b882e46e>] ___sys_sendmsg+0x8a/0xd0 net/socket.c:2406
    [<00000000870e7750>] __sys_sendmsg+0x77/0xe0 net/socket.c:2439
    [<000000002b222e75>] do_syscall_64+0x6e/0x220 arch/x86/entry/common.c:295
    [<00000000356e1a8a>] entry_SYSCALL_64_after_hwframe+0x44/0xa9

BUG: memory leak
unreferenced object 0xffff888115961800 (size 96):
  comm "syz-executor337", pid 6664, jiffies 4294943010 (age 8.060s)
  hex dump (first 32 bytes):
    00 19 96 15 81 88 ff ff 68 f9 ff 00 00 c9 ff ff  ........h.......
    00 00 00 00 00 00 00 00 60 52 c5 82 ff ff ff ff  ........`R......
  backtrace:
    [<00000000104a1f01>] kmalloc include/linux/slab.h:555 [inline]
    [<00000000104a1f01>] nft_netdev_hook_alloc+0x3b/0xd0 net/netfilter/nf_tables_api.c:1659
    [<000000003bc42f25>] nf_tables_parse_netdev_hooks+0x94/0x210 net/netfilter/nf_tables_api.c:1709
    [<000000004b6a9590>] nft_flowtable_parse_hook+0x101/0x1d0 net/netfilter/nf_tables_api.c:6243
    [<000000004204916e>] nft_delflowtable_hook net/netfilter/nf_tables_api.c:6562 [inline]
    [<000000004204916e>] nf_tables_delflowtable+0x249/0x4a0 net/netfilter/nf_tables_api.c:6640
    [<00000000fa0bd6d2>] nfnetlink_rcv_batch+0x2f3/0x810 net/netfilter/nfnetlink.c:433
    [<000000004d4e8df7>] nfnetlink_rcv_skb_batch net/netfilter/nfnetlink.c:543 [inline]
    [<000000004d4e8df7>] nfnetlink_rcv+0x183/0x1b0 net/netfilter/nfnetlink.c:561
    [<000000001710060c>] netlink_unicast_kernel net/netlink/af_netlink.c:1303 [inline]
    [<000000001710060c>] netlink_unicast+0x20a/0x2f0 net/netlink/af_netlink.c:1329
    [<00000000bb814b80>] netlink_sendmsg+0x2b5/0x560 net/netlink/af_netlink.c:1918
    [<00000000eb7a00fe>] sock_sendmsg_nosec net/socket.c:652 [inline]
    [<00000000eb7a00fe>] sock_sendmsg+0x4c/0x60 net/socket.c:672
    [<000000008cc37c52>] ____sys_sendmsg+0x2c4/0x2f0 net/socket.c:2352
    [<00000000b882e46e>] ___sys_sendmsg+0x8a/0xd0 net/socket.c:2406
    [<00000000870e7750>] __sys_sendmsg+0x77/0xe0 net/socket.c:2439
    [<000000002b222e75>] do_syscall_64+0x6e/0x220 arch/x86/entry/common.c:295
    [<00000000356e1a8a>] entry_SYSCALL_64_after_hwframe+0x44/0xa9



---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
