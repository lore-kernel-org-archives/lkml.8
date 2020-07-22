Return-Path: <SRS0=5pK+=BB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1642DC433E3
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 20:32:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EE1DA20709
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 20:32:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732904AbgGVUcU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 16:32:20 -0400
Received: from mail-il1-f199.google.com ([209.85.166.199]:34812 "EHLO
        mail-il1-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732815AbgGVUcT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 16:32:19 -0400
Received: by mail-il1-f199.google.com with SMTP id y3so1942484ily.1
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jul 2020 13:32:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=7imZ4Va5q5kCA+NPHlvvdTkyX0X2t9Lf27NR58K8+rs=;
        b=NeBJ2V9MZsq0wKf2nUf6krt04G9EtX+g+86wkVHPVUWycSa4mlFcF6dQcKWYKzDrhH
         2i6RzupB4kSnl4Q6783RxsO4RT9opj6OHILolaXUXoC3W/vXn8F4Tdh8hyJJvSBb8g1b
         vZ81ZcrBvA+Boy1pvsbq+UHPQ1VccouPvPNZS38umgQZ/HsHKHe6au5WYhVI+RvfYz9o
         bZiZZEAv1QtEmXpaIZEm05mPgz+0mRl+HMRxdP5jtyrjiu2Gf8JYVLzsgIkcEwN8t84z
         hZge1yxebaoqdDmWfJDtv1ZrZSn12fNhJrNrJ7fvBA/9SQt/QGXDmXwzqSqWgSlt16fk
         fIqg==
X-Gm-Message-State: AOAM533mhBpNebRx4pxouu1ak8sSM2rgFeLltcPOkAuSEBjx9gcdhl9W
        fbumC2rvDHhMvuAeIaY02UZZps8DmLK0rfa+6hAy/d7Mex3b
X-Google-Smtp-Source: ABdhPJwmJ8eTmIZSagdPyWqMOzb+vlzW9sZ69rQeAKnlfwtsmTG9VL61AtBMI3IVVugjv9qSHv55VhavHB0yX+MqWCZITNiaZBNu
MIME-Version: 1.0
X-Received: by 2002:a92:494e:: with SMTP id w75mr1669514ila.115.1595449937975;
 Wed, 22 Jul 2020 13:32:17 -0700 (PDT)
Date:   Wed, 22 Jul 2020 13:32:17 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000cf606405ab0da28a@google.com>
Subject: memory leak in sctp_packet_transmit
From:   syzbot <syzbot+8bb053b5d63595ab47db@syzkaller.appspotmail.com>
To:     davem@davemloft.net, kuba@kernel.org, linux-kernel@vger.kernel.org,
        linux-sctp@vger.kernel.org, marcelo.leitner@gmail.com,
        netdev@vger.kernel.org, nhorman@tuxdriver.com,
        syzkaller-bugs@googlegroups.com, vyasevich@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    4fa640dc Merge tag 'vfio-v5.8-rc7' of git://github.com/awi..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=149e5e27100000
kernel config:  https://syzkaller.appspot.com/x/.config?x=61340c48ef4aedfb
dashboard link: https://syzkaller.appspot.com/bug?extid=8bb053b5d63595ab47db
compiler:       gcc (GCC) 10.1.0-syz 20200507
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=118d1793100000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14805758900000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+8bb053b5d63595ab47db@syzkaller.appspotmail.com

executing program
executing program
BUG: memory leak
unreferenced object 0xffff888118cb6f00 (size 224):
  comm "syz-executor698", pid 6423, jiffies 4294945994 (age 12.350s)
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    00 00 a2 2a 81 88 ff ff 40 e0 d0 24 81 88 ff ff  ...*....@..$....
  backtrace:
    [<00000000dbd8d389>] __alloc_skb+0x5e/0x250 net/core/skbuff.c:198
    [<000000002ecd4b45>] alloc_skb include/linux/skbuff.h:1083 [inline]
    [<000000002ecd4b45>] sctp_packet_transmit+0xdc/0xb30 net/sctp/output.c:572
    [<0000000005eef223>] sctp_outq_flush_transports net/sctp/outqueue.c:1147 [inline]
    [<0000000005eef223>] sctp_outq_flush+0xf6/0xa30 net/sctp/outqueue.c:1195
    [<000000007ad403b8>] sctp_cmd_interpreter net/sctp/sm_sideeffect.c:1770 [inline]
    [<000000007ad403b8>] sctp_side_effects net/sctp/sm_sideeffect.c:1185 [inline]
    [<000000007ad403b8>] sctp_do_sm+0x197b/0x1f00 net/sctp/sm_sideeffect.c:1156
    [<00000000696e5800>] sctp_assoc_bh_rcv+0x167/0x250 net/sctp/associola.c:1044
    [<00000000bad89a41>] sctp_inq_push+0x76/0xa0 net/sctp/inqueue.c:80
    [<0000000066ea2304>] sctp_backlog_rcv+0x83/0x370 net/sctp/input.c:344
    [<000000004f4c84bd>] sk_backlog_rcv include/net/sock.h:997 [inline]
    [<000000004f4c84bd>] __release_sock+0xa5/0x110 net/core/sock.c:2550
    [<000000001cfa318a>] release_sock+0x32/0xc0 net/core/sock.c:3066
    [<00000000538f7502>] sctp_wait_for_connect+0x11d/0x1e0 net/sctp/socket.c:9302
    [<00000000a983945d>] sctp_sendmsg_to_asoc+0xa95/0xab0 net/sctp/socket.c:1892
    [<00000000136d87b5>] sctp_sendmsg+0x704/0xbd0 net/sctp/socket.c:2038
    [<000000003d35bb02>] inet_sendmsg+0x39/0x60 net/ipv4/af_inet.c:814
    [<00000000109a76b3>] sock_sendmsg_nosec net/socket.c:652 [inline]
    [<00000000109a76b3>] sock_sendmsg+0x4c/0x60 net/socket.c:672
    [<00000000c68f9835>] __sys_sendto+0x11d/0x1c0 net/socket.c:1995
    [<00000000b6e006ac>] __do_sys_sendto net/socket.c:2007 [inline]
    [<00000000b6e006ac>] __se_sys_sendto net/socket.c:2003 [inline]
    [<00000000b6e006ac>] __x64_sys_sendto+0x26/0x30 net/socket.c:2003

BUG: memory leak
unreferenced object 0xffff888119797f00 (size 224):
  comm "syz-executor698", pid 6424, jiffies 4294946510 (age 7.190s)
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    00 00 a2 2a 81 88 ff ff 40 e0 d0 24 81 88 ff ff  ...*....@..$....
  backtrace:
    [<00000000dbd8d389>] __alloc_skb+0x5e/0x250 net/core/skbuff.c:198
    [<000000002ecd4b45>] alloc_skb include/linux/skbuff.h:1083 [inline]
    [<000000002ecd4b45>] sctp_packet_transmit+0xdc/0xb30 net/sctp/output.c:572
    [<0000000005eef223>] sctp_outq_flush_transports net/sctp/outqueue.c:1147 [inline]
    [<0000000005eef223>] sctp_outq_flush+0xf6/0xa30 net/sctp/outqueue.c:1195
    [<000000007ad403b8>] sctp_cmd_interpreter net/sctp/sm_sideeffect.c:1770 [inline]
    [<000000007ad403b8>] sctp_side_effects net/sctp/sm_sideeffect.c:1185 [inline]
    [<000000007ad403b8>] sctp_do_sm+0x197b/0x1f00 net/sctp/sm_sideeffect.c:1156
    [<00000000696e5800>] sctp_assoc_bh_rcv+0x167/0x250 net/sctp/associola.c:1044
    [<00000000bad89a41>] sctp_inq_push+0x76/0xa0 net/sctp/inqueue.c:80
    [<0000000066ea2304>] sctp_backlog_rcv+0x83/0x370 net/sctp/input.c:344
    [<000000004f4c84bd>] sk_backlog_rcv include/net/sock.h:997 [inline]
    [<000000004f4c84bd>] __release_sock+0xa5/0x110 net/core/sock.c:2550
    [<000000001cfa318a>] release_sock+0x32/0xc0 net/core/sock.c:3066
    [<00000000538f7502>] sctp_wait_for_connect+0x11d/0x1e0 net/sctp/socket.c:9302
    [<00000000a983945d>] sctp_sendmsg_to_asoc+0xa95/0xab0 net/sctp/socket.c:1892
    [<00000000136d87b5>] sctp_sendmsg+0x704/0xbd0 net/sctp/socket.c:2038
    [<000000003d35bb02>] inet_sendmsg+0x39/0x60 net/ipv4/af_inet.c:814
    [<00000000109a76b3>] sock_sendmsg_nosec net/socket.c:652 [inline]
    [<00000000109a76b3>] sock_sendmsg+0x4c/0x60 net/socket.c:672
    [<00000000c68f9835>] __sys_sendto+0x11d/0x1c0 net/socket.c:1995
    [<00000000b6e006ac>] __do_sys_sendto net/socket.c:2007 [inline]
    [<00000000b6e006ac>] __se_sys_sendto net/socket.c:2003 [inline]
    [<00000000b6e006ac>] __x64_sys_sendto+0x26/0x30 net/socket.c:2003



---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
