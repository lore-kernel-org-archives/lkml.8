Return-Path: <SRS0=3tRb=3K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD7C9C2D0CE
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 19:27:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DA122073A
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 19:27:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729008AbgAUT1L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jan 2020 14:27:11 -0500
Received: from mail-io1-f72.google.com ([209.85.166.72]:45821 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727360AbgAUT1L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jan 2020 14:27:11 -0500
Received: by mail-io1-f72.google.com with SMTP id c23so2401812ioi.12
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jan 2020 11:27:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=6/mWzoQ86Fz03Edx8euNWgcBpzefOxUyUkGzVoZMKAA=;
        b=oxlWw4H+EiMUAI0lkizCqp3CXQHUi6xG/fkKMLNrC2bwxqj9m4sebY1MHrHmncVuDD
         wJfJaci0iTHwCHN6ZF0CYvnwXokWIgX6lZ6y+5i24dgLB4n4XMWaYNuSf8YHdWpt3eso
         voHcddINeGzQhXKCKrBIFMENs/Zs96ZdhXbmMcpFalwQEVaEkdWxvlM9rXWuPGvUtiFw
         yM2+mvyxLjCegonvQIHnprbWaam+Zof4OYBLCWLnMhvxQYIEm+hsJkEkBc30MsuqGkT+
         XmNCin/i2JaMervUlNPru9NMjoL7PhhmkKz/y63PRRc9R3uBz+vnp0d4dI60zWX0Fv5r
         NvFA==
X-Gm-Message-State: APjAAAXATaQ+a7BPO4KfmGdqKa949lEmaS6Rl/iAtY16yMn3aEeDQuOr
        N6fGAhAquYBtYwV8IBeGk2ADwBVlEfgw3uScqQqObKZsnwbU
X-Google-Smtp-Source: APXvYqztUkxtfoNFV2y1EkqvsTloZ7oiC2jQMqnjeLX3fhfpItWgaKxP0Io5hhlXKkGvjkyKWQYwW8A3LNhZMzBxE91HjZjstuiC
MIME-Version: 1.0
X-Received: by 2002:a5d:8146:: with SMTP id f6mr4134212ioo.93.1579634830562;
 Tue, 21 Jan 2020 11:27:10 -0800 (PST)
Date:   Tue, 21 Jan 2020 11:27:10 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f35c6a059cab64c5@google.com>
Subject: memory leak in mrp_request_join
From:   syzbot <syzbot+5cfab121b54dff775399@syzkaller.appspotmail.com>
To:     allison@lohutok.net, davem@davemloft.net, keescook@chromium.org,
        kstewart@linuxfoundation.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, pankaj.laxminarayan.bharadiya@intel.com,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    d96d875e Merge tag 'fixes_for_v5.5-rc8' of git://git.kerne..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=14cd8185e00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=15478c61c836a72e
dashboard link: https://syzkaller.appspot.com/bug?extid=5cfab121b54dff775399
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14dbe201e00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13e03cf1e00000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+5cfab121b54dff775399@syzkaller.appspotmail.com

executing program
BUG: memory leak
unreferenced object 0xffff888120b85c40 (size 64):
  comm "syz-executor783", pid 7302, jiffies 4294942613 (age 14.030s)
  hex dump (first 32 bytes):
    01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    00 00 00 00 00 00 00 00 01 00 00 00 01 02 00 00  ................
  backtrace:
    [<000000000312cb0f>] kmemleak_alloc_recursive include/linux/kmemleak.h:43 [inline]
    [<000000000312cb0f>] slab_post_alloc_hook mm/slab.h:586 [inline]
    [<000000000312cb0f>] slab_alloc mm/slab.c:3320 [inline]
    [<000000000312cb0f>] __do_kmalloc mm/slab.c:3654 [inline]
    [<000000000312cb0f>] __kmalloc+0x169/0x300 mm/slab.c:3665
    [<0000000011736472>] kmalloc include/linux/slab.h:561 [inline]
    [<0000000011736472>] mrp_attr_create net/802/mrp.c:276 [inline]
    [<0000000011736472>] mrp_request_join+0x13d/0x220 net/802/mrp.c:530
    [<000000003ff9bf8f>] vlan_mvrp_request_join+0x86/0x90 net/8021q/vlan_mvrp.c:40
    [<0000000020a13a26>] vlan_dev_open+0x154/0x290 net/8021q/vlan_dev.c:293
    [<0000000010d96d5d>] __dev_open+0x109/0x1b0 net/core/dev.c:1431
    [<00000000e9578876>] __dev_change_flags+0x246/0x2c0 net/core/dev.c:8103
    [<000000002c92e0e1>] rtnl_configure_link+0x57/0x100 net/core/rtnetlink.c:2996
    [<000000000504898e>] __rtnl_newlink+0x8b9/0xb80 net/core/rtnetlink.c:3323
    [<00000000eb645fa3>] rtnl_newlink+0x4e/0x80 net/core/rtnetlink.c:3363
    [<0000000034f28a5d>] rtnetlink_rcv_msg+0x178/0x4b0 net/core/rtnetlink.c:5424
    [<00000000dc499e73>] netlink_rcv_skb+0x61/0x170 net/netlink/af_netlink.c:2477
    [<00000000b6cd4d73>] rtnetlink_rcv+0x1d/0x30 net/core/rtnetlink.c:5442
    [<0000000092a30a6a>] netlink_unicast_kernel net/netlink/af_netlink.c:1302 [inline]
    [<0000000092a30a6a>] netlink_unicast+0x223/0x310 net/netlink/af_netlink.c:1328
    [<0000000006ceb85b>] netlink_sendmsg+0x2c0/0x570 net/netlink/af_netlink.c:1917
    [<000000009199ec36>] sock_sendmsg_nosec net/socket.c:639 [inline]
    [<000000009199ec36>] sock_sendmsg+0x54/0x70 net/socket.c:659
    [<000000002acd085e>] ____sys_sendmsg+0x2d0/0x300 net/socket.c:2330



---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
