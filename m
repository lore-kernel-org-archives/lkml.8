Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B46B5C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 04:04:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9905E217A0
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 04:04:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726918AbgFREER (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jun 2020 00:04:17 -0400
Received: from mail-il1-f198.google.com ([209.85.166.198]:55264 "EHLO
        mail-il1-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725813AbgFREEN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 00:04:13 -0400
Received: by mail-il1-f198.google.com with SMTP id y16so3133020ilm.21
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jun 2020 21:04:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=rTEVJVzhYF0+asDXTaiqCwuTOUiOzz8nPDu9h9e0Uw0=;
        b=bKvy5mGCWYMloNu3H/HuZMsaMiAPNOshNDXsDMVlKn1zatzPcgu0UFxwI0F6CRvZmQ
         xaqmd0FqI7nKMLDA77pl+ydJc5LBCf5AJCQA0++0uLnKqwcOnX3+czSn9RAgyfrKC2Fq
         hwOJkmEtb6SWZDi/+D8ToFfJsqwPOg5OWfhqNS4ahY74YOGkaROigMwwg+dzNRyZnupo
         y+io4mNTSrE6kfV4HcCAPwf7VxKvF1TY+a00uckt1TjcxPAmSD+AhS8gkGPnoSjx6RZ3
         Kl8sqO5vCKfh7BUni6na3QLsPLzXvJeZ+RHhkE1supwWDEV3iB8h9PPckhl6ZidUcvbz
         +HOQ==
X-Gm-Message-State: AOAM530syhQ/DzmtOy29+4ijr4uATmPaGyN6xtBEDx1X7XsOKCh8IYY2
        PoE0sYtbgNNvziZ8IQmqfZNQb4NNXXhm1D26a+LMhKeb+DNG
X-Google-Smtp-Source: ABdhPJzjMT+p4vZMWKN/uSdJKfqwwpC0gk8pe+u64+iDYWQHU5ayTgv6UccLWL/l+v6SDo9JcYQM7nS8kKdyQ7I5H7ALjgErTwbM
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:d09:: with SMTP id g9mr2342684ilj.300.1592453052295;
 Wed, 17 Jun 2020 21:04:12 -0700 (PDT)
Date:   Wed, 17 Jun 2020 21:04:12 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000080f43805a853de9a@google.com>
Subject: memory leak in macvlan_hash_add_source
From:   syzbot <syzbot+62100d232f618b7da606@syzkaller.appspotmail.com>
To:     davem@davemloft.net, kuba@kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    7ae77150 Merge tag 'powerpc-5.8-1' of git://git.kernel.org..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=11fbb456100000
kernel config:  https://syzkaller.appspot.com/x/.config?x=9a1aa05456dfd557
dashboard link: https://syzkaller.appspot.com/bug?extid=62100d232f618b7da606
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=163092a9100000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12caed7a100000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+62100d232f618b7da606@syzkaller.appspotmail.com

BUG: memory leak
unreferenced object 0xffff888115ac4080 (size 64):
  comm "syz-executor882", pid 6646, jiffies 4294954688 (age 14.840s)
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 20 ee 41 15 81 88 ff ff  ........ .A.....
    00 09 92 15 81 88 ff ff aa aa aa aa aa 23 00 00  .............#..
  backtrace:
    [<00000000fe90004e>] kmalloc include/linux/slab.h:555 [inline]
    [<00000000fe90004e>] macvlan_hash_add_source+0x52/0xe0 drivers/net/macvlan.c:161
    [<000000005aee7a07>] macvlan_changelink_sources+0x8a/0x1f0 drivers/net/macvlan.c:1355
    [<00000000e0e074d6>] macvlan_common_newlink+0x21a/0x570 drivers/net/macvlan.c:1463
    [<00000000c89166a4>] __rtnl_newlink+0x843/0xb10 net/core/rtnetlink.c:3340
    [<000000009677515c>] rtnl_newlink+0x49/0x70 net/core/rtnetlink.c:3398
    [<00000000fab710c9>] rtnetlink_rcv_msg+0x173/0x4b0 net/core/rtnetlink.c:5461
    [<00000000d3f45a45>] netlink_rcv_skb+0x5a/0x180 net/netlink/af_netlink.c:2469
    [<00000000b9db6049>] netlink_unicast_kernel net/netlink/af_netlink.c:1303 [inline]
    [<00000000b9db6049>] netlink_unicast+0x20a/0x2f0 net/netlink/af_netlink.c:1329
    [<000000006a00463c>] netlink_sendmsg+0x2b5/0x560 net/netlink/af_netlink.c:1918
    [<00000000a31e18a9>] sock_sendmsg_nosec net/socket.c:652 [inline]
    [<00000000a31e18a9>] sock_sendmsg+0x4c/0x60 net/socket.c:672
    [<000000000ca330a5>] ____sys_sendmsg+0x118/0x2f0 net/socket.c:2352
    [<000000006a5fc310>] ___sys_sendmsg+0x8a/0xd0 net/socket.c:2406
    [<000000004d3b2570>] __sys_sendmmsg+0xda/0x230 net/socket.c:2496
    [<00000000a524412c>] __do_sys_sendmmsg net/socket.c:2525 [inline]
    [<00000000a524412c>] __se_sys_sendmmsg net/socket.c:2522 [inline]
    [<00000000a524412c>] __x64_sys_sendmmsg+0x24/0x30 net/socket.c:2522
    [<00000000333adef2>] do_syscall_64+0x6e/0x220 arch/x86/entry/common.c:295
    [<00000000df7893d8>] entry_SYSCALL_64_after_hwframe+0x44/0xa9



---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
