Return-Path: <SRS0=/EmK=CQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.7 required=3.0 tests=BAYES_00,FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,LONGWORDS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E06B6C433E2
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 21:19:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A4FA621897
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 21:19:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728197AbgIGVTg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Sep 2020 17:19:36 -0400
Received: from mail-il1-f206.google.com ([209.85.166.206]:39001 "EHLO
        mail-il1-f206.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727007AbgIGVTQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 17:19:16 -0400
Received: by mail-il1-f206.google.com with SMTP id v17so3528874ilg.6
        for <linux-kernel@vger.kernel.org>; Mon, 07 Sep 2020 14:19:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=Y1HcDzDEp2AuwmzQtpHT6ari7YrwhHpomRXZ5gKlutc=;
        b=MKKiNeNIK3XjCzo3c4zSLybUG40pGsgbbgThZ/sZpZbSxrQaAiFLQRYMAJMMLYwnBI
         QeEGsOXtR48tjpFzJK3Y0D0+SEgalM4TABscLX+AWvJ6GSK2SyNFFOjwoxJfhweRvRWE
         PipYZquDjF+hp7OP4EW/4fWmTDhsJ5bvUcvy4OkoSqEL2ki76oQUCQtzMAVozc05tPXr
         tQuF3U+NPDcnABQm4b2Z6d0MwE17JAA9xilyKIW4UyggPvtlBUScg0TLms8cmDBDsyTY
         RrcFTIcf1Xp1bV+4tbTGxiAAG7VDKUNaZkKd7md1Y/DCLLFnbe2jQyoDExXVAI/cnRa5
         9Ebw==
X-Gm-Message-State: AOAM5319e4trLxcBtvNbrdrDmYs5iynaX7tybSDIEQkk+FklX9oaPT5L
        Scbxdsy0RL2VfM2RPTqCzKWLf6S+Esv5mf0/PnqhVtgVOpEV
X-Google-Smtp-Source: ABdhPJxjSNwEdKDIWU7kZISN3qVKDBhThAAn3f6Z6jsqj6uER75P7M7tAA69P2U4TeQjQqC4FVLQc6DN8YTHaysMpe4aWyDKBdJ1
MIME-Version: 1.0
X-Received: by 2002:a92:c8cd:: with SMTP id c13mr11023625ilq.96.1599513555424;
 Mon, 07 Sep 2020 14:19:15 -0700 (PDT)
Date:   Mon, 07 Sep 2020 14:19:15 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000048db9a05aebfc503@google.com>
Subject: memory leak in __team_options_register
From:   syzbot <syzbot+69b804437cfec30deac3@syzkaller.appspotmail.com>
To:     davem@davemloft.net, jiri@resnulli.us, kuba@kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    f4d51dff Linux 5.9-rc4
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=126a23e1900000
kernel config:  https://syzkaller.appspot.com/x/.config?x=7954285d6e960c0f
dashboard link: https://syzkaller.appspot.com/bug?extid=69b804437cfec30deac3
compiler:       gcc (GCC) 10.1.0-syz 20200507
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1627617d900000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=122e20dd900000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+69b804437cfec30deac3@syzkaller.appspotmail.com

BUG: memory leak
unreferenced object 0xffff8881197f4cc0 (size 64):
  comm "syz-executor772", pid 6506, jiffies 4294951766 (age 20.400s)
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    41 aa 0c 84 ff ff ff ff 01 00 00 00 00 00 00 00  A...............
  backtrace:
    [<000000000c781965>] kmemdup+0x23/0x50 mm/util.c:127
    [<00000000bdcac628>] kmemdup include/linux/string.h:479 [inline]
    [<00000000bdcac628>] __team_options_register+0xf7/0x2c0 drivers/net/team/team.c:269
    [<00000000d0decc27>] team_options_register drivers/net/team/team.c:340 [inline]
    [<00000000d0decc27>] team_init+0x1b2/0x2f0 drivers/net/team/team.c:1643
    [<00000000b2b1c890>] register_netdevice+0x143/0x760 net/core/dev.c:9760
    [<000000001344192b>] __rtnl_newlink+0x8f0/0xbc0 net/core/rtnetlink.c:3441
    [<00000000254132c3>] rtnl_newlink+0x49/0x70 net/core/rtnetlink.c:3500
    [<000000001566c9e7>] rtnetlink_rcv_msg+0x17e/0x460 net/core/rtnetlink.c:5563
    [<0000000017d9fa2a>] netlink_rcv_skb+0x5b/0x180 net/netlink/af_netlink.c:2470
    [<00000000c4f11d5e>] netlink_unicast_kernel net/netlink/af_netlink.c:1304 [inline]
    [<00000000c4f11d5e>] netlink_unicast+0x2b6/0x3c0 net/netlink/af_netlink.c:1330
    [<0000000066743465>] netlink_sendmsg+0x2ba/0x570 net/netlink/af_netlink.c:1919
    [<000000005d0b195e>] sock_sendmsg_nosec net/socket.c:651 [inline]
    [<000000005d0b195e>] sock_sendmsg+0x4c/0x60 net/socket.c:671
    [<0000000008f94e79>] ____sys_sendmsg+0x118/0x2f0 net/socket.c:2353
    [<00000000e00d63ed>] ___sys_sendmsg+0x81/0xc0 net/socket.c:2407
    [<000000005e9d5313>] __sys_sendmmsg+0xda/0x230 net/socket.c:2497
    [<000000002479ea72>] __do_sys_sendmmsg net/socket.c:2526 [inline]
    [<000000002479ea72>] __se_sys_sendmmsg net/socket.c:2523 [inline]
    [<000000002479ea72>] __x64_sys_sendmmsg+0x24/0x30 net/socket.c:2523
    [<0000000032159aee>] do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46

BUG: memory leak
unreferenced object 0xffff88811b4e0b80 (size 64):
  comm "syz-executor772", pid 6508, jiffies 4294951886 (age 19.210s)
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    41 aa 0c 84 ff ff ff ff 01 00 00 00 00 00 00 00  A...............
  backtrace:
    [<000000000c781965>] kmemdup+0x23/0x50 mm/util.c:127
    [<00000000bdcac628>] kmemdup include/linux/string.h:479 [inline]
    [<00000000bdcac628>] __team_options_register+0xf7/0x2c0 drivers/net/team/team.c:269
    [<00000000d0decc27>] team_options_register drivers/net/team/team.c:340 [inline]
    [<00000000d0decc27>] team_init+0x1b2/0x2f0 drivers/net/team/team.c:1643
    [<00000000b2b1c890>] register_netdevice+0x143/0x760 net/core/dev.c:9760
    [<000000001344192b>] __rtnl_newlink+0x8f0/0xbc0 net/core/rtnetlink.c:3441
    [<00000000254132c3>] rtnl_newlink+0x49/0x70 net/core/rtnetlink.c:3500
    [<000000001566c9e7>] rtnetlink_rcv_msg+0x17e/0x460 net/core/rtnetlink.c:5563
    [<0000000017d9fa2a>] netlink_rcv_skb+0x5b/0x180 net/netlink/af_netlink.c:2470
    [<00000000c4f11d5e>] netlink_unicast_kernel net/netlink/af_netlink.c:1304 [inline]
    [<00000000c4f11d5e>] netlink_unicast+0x2b6/0x3c0 net/netlink/af_netlink.c:1330
    [<0000000066743465>] netlink_sendmsg+0x2ba/0x570 net/netlink/af_netlink.c:1919
    [<000000005d0b195e>] sock_sendmsg_nosec net/socket.c:651 [inline]
    [<000000005d0b195e>] sock_sendmsg+0x4c/0x60 net/socket.c:671
    [<0000000008f94e79>] ____sys_sendmsg+0x118/0x2f0 net/socket.c:2353
    [<00000000e00d63ed>] ___sys_sendmsg+0x81/0xc0 net/socket.c:2407
    [<000000005e9d5313>] __sys_sendmmsg+0xda/0x230 net/socket.c:2497
    [<000000002479ea72>] __do_sys_sendmmsg net/socket.c:2526 [inline]
    [<000000002479ea72>] __se_sys_sendmmsg net/socket.c:2523 [inline]
    [<000000002479ea72>] __x64_sys_sendmmsg+0x24/0x30 net/socket.c:2523
    [<0000000032159aee>] do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46

BUG: memory leak
unreferenced object 0xffff88811b4e03c0 (size 64):
  comm "syz-executor772", pid 6518, jiffies 4294951923 (age 18.840s)
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    41 aa 0c 84 ff ff ff ff 01 00 00 00 00 00 00 00  A...............
  backtrace:
    [<000000000c781965>] kmemdup+0x23/0x50 mm/util.c:127
    [<00000000bdcac628>] kmemdup include/linux/string.h:479 [inline]
    [<00000000bdcac628>] __team_options_register+0xf7/0x2c0 drivers/net/team/team.c:269
    [<00000000d0decc27>] team_options_register drivers/net/team/team.c:340 [inline]
    [<00000000d0decc27>] team_init+0x1b2/0x2f0 drivers/net/team/team.c:1643
    [<00000000b2b1c890>] register_netdevice+0x143/0x760 net/core/dev.c:9760
    [<000000001344192b>] __rtnl_newlink+0x8f0/0xbc0 net/core/rtnetlink.c:3441
    [<00000000254132c3>] rtnl_newlink+0x49/0x70 net/core/rtnetlink.c:3500
    [<000000001566c9e7>] rtnetlink_rcv_msg+0x17e/0x460 net/core/rtnetlink.c:5563
    [<0000000017d9fa2a>] netlink_rcv_skb+0x5b/0x180 net/netlink/af_netlink.c:2470
    [<00000000c4f11d5e>] netlink_unicast_kernel net/netlink/af_netlink.c:1304 [inline]
    [<00000000c4f11d5e>] netlink_unicast+0x2b6/0x3c0 net/netlink/af_netlink.c:1330
    [<0000000066743465>] netlink_sendmsg+0x2ba/0x570 net/netlink/af_netlink.c:1919
    [<000000005d0b195e>] sock_sendmsg_nosec net/socket.c:651 [inline]
    [<000000005d0b195e>] sock_sendmsg+0x4c/0x60 net/socket.c:671
    [<0000000008f94e79>] ____sys_sendmsg+0x118/0x2f0 net/socket.c:2353
    [<00000000e00d63ed>] ___sys_sendmsg+0x81/0xc0 net/socket.c:2407
    [<000000005e9d5313>] __sys_sendmmsg+0xda/0x230 net/socket.c:2497
    [<000000002479ea72>] __do_sys_sendmmsg net/socket.c:2526 [inline]
    [<000000002479ea72>] __se_sys_sendmmsg net/socket.c:2523 [inline]
    [<000000002479ea72>] __x64_sys_sendmmsg+0x24/0x30 net/socket.c:2523
    [<0000000032159aee>] do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46

executing program
executing program
executing program
executing program
executing program
executing program
executing program


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
