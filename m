Return-Path: <SRS0=HA/2=BM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 448ACC433E1
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Aug 2020 15:19:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 263B120759
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Aug 2020 15:19:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726948AbgHBPTX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Aug 2020 11:19:23 -0400
Received: from mail-io1-f69.google.com ([209.85.166.69]:42520 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726773AbgHBPTW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Aug 2020 11:19:22 -0400
Received: by mail-io1-f69.google.com with SMTP id l18so24843648ion.9
        for <linux-kernel@vger.kernel.org>; Sun, 02 Aug 2020 08:19:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=Doj0mz+51ihkaX67p3nnSBbI9p/ZjghvSf52SnU2SAw=;
        b=GC9ZNXPZeLZ/VKUCDy74c3XS9RlC0EsXiN+h/weIdQd2Ot0Y3vyvIC7jV2zjn4+Jr8
         y1YmCxv1lySdv1rRUdbPhbe6D8q9pEInagOqyr/9dlbYkaeEXuFuHzIVkqyQSSpg3KZP
         ShjAbD3HFCK3nwHw/CGMSrRLuFJWmHIm+ZBZIUr7umu4flgTbPSDCjtrVl42i3s7Xo1V
         sywWFlf5mw1wohocGfuhIt+glW9mZDkEJbsJPYgiueWv8MOuqDPbO3Ot+DkRd6JVeGlt
         RRaug9rw1IkLi7eKoRxpGOCo+t/KGXV9nAWo8OLcJfzedJtaKwtvrMjUW8Uln3iBB67a
         yeag==
X-Gm-Message-State: AOAM530Af5wgd1cXxlu9BB9IrsM37SLHHV9AlKcMB/N4pTnXGhz0SqWI
        bAvsaRj9guKUJY3V7afAWVyErtnmRv6eNMYIujDHlfVZCMtB
X-Google-Smtp-Source: ABdhPJznBtamlaxrIT+5F9Ju/bbX/8NmLCAc5FuDcy6t6eLf9GG3KEPK5cUAQ0OtLi4HrVRM+qtYG8q40P2r1AEHpBMRIj+8EAe+
MIME-Version: 1.0
X-Received: by 2002:a02:3502:: with SMTP id k2mr5860691jaa.129.1596381561363;
 Sun, 02 Aug 2020 08:19:21 -0700 (PDT)
Date:   Sun, 02 Aug 2020 08:19:21 -0700
In-Reply-To: <0000000000000a730805aab5e470@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e4239105abe68bf1@google.com>
Subject: Re: memory leak in veth_dev_init
From:   syzbot <syzbot+59ef240dd8f0ed7598a8@syzkaller.appspotmail.com>
To:     andriin@fb.com, ast@kernel.org, bpf@vger.kernel.org,
        daniel@iogearbox.net, davem@davemloft.net, hawk@kernel.org,
        john.fastabend@gmail.com, kafai@fb.com, kpsingh@chromium.org,
        kuba@kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, songliubraving@fb.com,
        syzkaller-bugs@googlegroups.com, yhs@fb.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has found a reproducer for the following issue on:

HEAD commit:    ac3a0c84 Merge git://git.kernel.org/pub/scm/linux/kernel/g..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=156db214900000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a1b8ff4a33e73cad
dashboard link: https://syzkaller.appspot.com/bug?extid=59ef240dd8f0ed7598a8
compiler:       gcc (GCC) 10.1.0-syz 20200507
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=100102a4900000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=172fcacc900000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+59ef240dd8f0ed7598a8@syzkaller.appspotmail.com

executing program
executing program
executing program
BUG: memory leak
unreferenced object 0xffff888128d25800 (size 1024):
  comm "syz-executor493", pid 6464, jiffies 4294944570 (age 14.450s)
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<00000000ee9fd51f>] kmalloc_array include/linux/slab.h:597 [inline]
    [<00000000ee9fd51f>] kcalloc include/linux/slab.h:608 [inline]
    [<00000000ee9fd51f>] veth_alloc_queues drivers/net/veth.c:1018 [inline]
    [<00000000ee9fd51f>] veth_dev_init+0x7b/0x120 drivers/net/veth.c:1045
    [<00000000ea2b9ca8>] register_netdevice+0x143/0x760 net/core/dev.c:9444
    [<0000000054f736e0>] veth_newlink+0x282/0x460 drivers/net/veth.c:1393
    [<0000000048b625cf>] __rtnl_newlink+0x8f0/0xbc0 net/core/rtnetlink.c:3339
    [<00000000c7111fa7>] rtnl_newlink+0x49/0x70 net/core/rtnetlink.c:3398
    [<000000003c581d51>] rtnetlink_rcv_msg+0x17e/0x460 net/core/rtnetlink.c:5461
    [<0000000044c6a9c9>] netlink_rcv_skb+0x5b/0x180 net/netlink/af_netlink.c:2469
    [<00000000c5e8a749>] netlink_unicast_kernel net/netlink/af_netlink.c:1303 [inline]
    [<00000000c5e8a749>] netlink_unicast+0x2b6/0x3c0 net/netlink/af_netlink.c:1329
    [<000000000417c80d>] netlink_sendmsg+0x2ba/0x570 net/netlink/af_netlink.c:1918
    [<000000000bc3c36b>] sock_sendmsg_nosec net/socket.c:652 [inline]
    [<000000000bc3c36b>] sock_sendmsg+0x4c/0x60 net/socket.c:672
    [<0000000041ecdda4>] ____sys_sendmsg+0x2c4/0x2f0 net/socket.c:2352
    [<0000000013875e8e>] ___sys_sendmsg+0x81/0xc0 net/socket.c:2406
    [<00000000ab05eaa1>] __sys_sendmsg+0x77/0xe0 net/socket.c:2439
    [<00000000475b439b>] do_syscall_64+0x4c/0xe0 arch/x86/entry/common.c:384
    [<00000000dbda4b6d>] entry_SYSCALL_64_after_hwframe+0x44/0xa9

BUG: memory leak
unreferenced object 0xffff888119669c00 (size 1024):
  comm "syz-executor493", pid 6496, jiffies 4294945171 (age 8.440s)
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<00000000ee9fd51f>] kmalloc_array include/linux/slab.h:597 [inline]
    [<00000000ee9fd51f>] kcalloc include/linux/slab.h:608 [inline]
    [<00000000ee9fd51f>] veth_alloc_queues drivers/net/veth.c:1018 [inline]
    [<00000000ee9fd51f>] veth_dev_init+0x7b/0x120 drivers/net/veth.c:1045
    [<00000000ea2b9ca8>] register_netdevice+0x143/0x760 net/core/dev.c:9444
    [<0000000054f736e0>] veth_newlink+0x282/0x460 drivers/net/veth.c:1393
    [<0000000048b625cf>] __rtnl_newlink+0x8f0/0xbc0 net/core/rtnetlink.c:3339
    [<00000000c7111fa7>] rtnl_newlink+0x49/0x70 net/core/rtnetlink.c:3398
    [<000000003c581d51>] rtnetlink_rcv_msg+0x17e/0x460 net/core/rtnetlink.c:5461
    [<0000000044c6a9c9>] netlink_rcv_skb+0x5b/0x180 net/netlink/af_netlink.c:2469
    [<00000000c5e8a749>] netlink_unicast_kernel net/netlink/af_netlink.c:1303 [inline]
    [<00000000c5e8a749>] netlink_unicast+0x2b6/0x3c0 net/netlink/af_netlink.c:1329
    [<000000000417c80d>] netlink_sendmsg+0x2ba/0x570 net/netlink/af_netlink.c:1918
    [<000000000bc3c36b>] sock_sendmsg_nosec net/socket.c:652 [inline]
    [<000000000bc3c36b>] sock_sendmsg+0x4c/0x60 net/socket.c:672
    [<0000000041ecdda4>] ____sys_sendmsg+0x2c4/0x2f0 net/socket.c:2352
    [<0000000013875e8e>] ___sys_sendmsg+0x81/0xc0 net/socket.c:2406
    [<00000000ab05eaa1>] __sys_sendmsg+0x77/0xe0 net/socket.c:2439
    [<00000000475b439b>] do_syscall_64+0x4c/0xe0 arch/x86/entry/common.c:384
    [<00000000dbda4b6d>] entry_SYSCALL_64_after_hwframe+0x44/0xa9


