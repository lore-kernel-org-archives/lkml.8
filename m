Return-Path: <SRS0=rxDU=A5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C022C433E1
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jul 2020 11:51:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 85CA82074B
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jul 2020 11:51:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726846AbgGRLvR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Jul 2020 07:51:17 -0400
Received: from mail-il1-f199.google.com ([209.85.166.199]:56820 "EHLO
        mail-il1-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726775AbgGRLvQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jul 2020 07:51:16 -0400
Received: by mail-il1-f199.google.com with SMTP id w81so7149644ilk.23
        for <linux-kernel@vger.kernel.org>; Sat, 18 Jul 2020 04:51:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=z0LkxvZaWa7FCO6qQ25lxpzCVYJgsHN+PR2MXygFdtk=;
        b=nPPke7ziks3NDfHG4ZAhgHkrZyMVuWVOUpVIPFBJEpNMiWKCX061oRVpOFXm0QeEjd
         jG/yn2mbeskpJ1KpGv/KkTSU68qw22ZNgLn84eIOQ/QFZG+8irAzpRSCTzq9xjo0H/GR
         x2WcSPncs9//yHN/rDE17P+GK/ZzUHB3k8R1q8nvLAvuawNhQb8dlV+/e5iv6KL08WLR
         36hBztTYTWIm0mFOwTXUAxUKIVkoEzcTCSSRsMq7axbm3HWy3KROAmmUHOKfacwdbVgc
         4yTByOFkswSozpFuBzoCgT4y690J0rk0Vgq9M5zzi1n69Swkx9IjvaUp3X8nXAkEXlGB
         vZgw==
X-Gm-Message-State: AOAM531DHpZq5Mtn55pl7UGxvl/Q65DVx/bT3FTKz6lgj83FR2lLfSIw
        tB0eRVaPbcD2gENPc73vBMKrwgDor2WJco+0r7neWYIbVLcx
X-Google-Smtp-Source: ABdhPJzd5N31myVpwqLIDWSCzWam0gIdvy3K3WtgZ44K0a2++CHFcuLHlBw6nAM6ePiMIl1/vdQ5OucaxAgJH1KC3L4dw8j0IU1O
MIME-Version: 1.0
X-Received: by 2002:a02:5d49:: with SMTP id w70mr16049699jaa.16.1595073075244;
 Sat, 18 Jul 2020 04:51:15 -0700 (PDT)
Date:   Sat, 18 Jul 2020 04:51:15 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000000a730805aab5e470@google.com>
Subject: memory leak in veth_dev_init
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

Hello,

syzbot found the following issue on:

HEAD commit:    e9919e11 Merge branch 'for-linus' of git://git.kernel.org/..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=17058f57100000
kernel config:  https://syzkaller.appspot.com/x/.config?x=175942c28d9b8dd0
dashboard link: https://syzkaller.appspot.com/bug?extid=59ef240dd8f0ed7598a8
compiler:       gcc (GCC) 10.1.0-syz 20200507
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12f95700900000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+59ef240dd8f0ed7598a8@syzkaller.appspotmail.com

BUG: memory leak
unreferenced object 0xffff8881097d2400 (size 1024):
  comm "syz-executor.2", pid 6690, jiffies 4295037413 (age 16.990s)
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<00000000e43a1d47>] kmalloc_array include/linux/slab.h:597 [inline]
    [<00000000e43a1d47>] kcalloc include/linux/slab.h:608 [inline]
    [<00000000e43a1d47>] veth_alloc_queues drivers/net/veth.c:1018 [inline]
    [<00000000e43a1d47>] veth_dev_init+0x7b/0x120 drivers/net/veth.c:1045
    [<000000003f373d1e>] register_netdevice+0x143/0x760 net/core/dev.c:9444
    [<00000000b86f82c1>] veth_newlink+0x1d5/0x460 drivers/net/veth.c:1366
    [<000000008d2f627f>] __rtnl_newlink+0x8f3/0xbb0 net/core/rtnetlink.c:3339
    [<000000008e87c660>] rtnl_newlink+0x49/0x70 net/core/rtnetlink.c:3397
    [<000000002569c6f3>] rtnetlink_rcv_msg+0x17e/0x460 net/core/rtnetlink.c:5460
    [<00000000ea72628d>] netlink_rcv_skb+0x5b/0x180 net/netlink/af_netlink.c:2469
    [<0000000006d33309>] netlink_unicast_kernel net/netlink/af_netlink.c:1303 [inline]
    [<0000000006d33309>] netlink_unicast+0x2b6/0x3c0 net/netlink/af_netlink.c:1329
    [<000000002d1084c2>] netlink_sendmsg+0x2ba/0x570 net/netlink/af_netlink.c:1918
    [<000000002ba4c104>] sock_sendmsg_nosec net/socket.c:652 [inline]
    [<000000002ba4c104>] sock_sendmsg+0x4c/0x60 net/socket.c:672
    [<00000000c343726d>] __sys_sendto+0x11d/0x1c0 net/socket.c:1995
    [<00000000f1ad5dc1>] __do_sys_sendto net/socket.c:2007 [inline]
    [<00000000f1ad5dc1>] __se_sys_sendto net/socket.c:2003 [inline]
    [<00000000f1ad5dc1>] __x64_sys_sendto+0x26/0x30 net/socket.c:2003
    [<000000004ab49ca5>] do_syscall_64+0x4c/0xe0 arch/x86/entry/common.c:384
    [<00000000e04d67c2>] entry_SYSCALL_64_after_hwframe+0x44/0xa9



---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
