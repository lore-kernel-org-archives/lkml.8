Return-Path: <SRS0=3W8M=6B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70E40C352BE
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 03:45:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5AACF217D8
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 03:45:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727782AbgDQDpL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 23:45:11 -0400
Received: from mail-il1-f200.google.com ([209.85.166.200]:51389 "EHLO
        mail-il1-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726473AbgDQDpL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 23:45:11 -0400
Received: by mail-il1-f200.google.com with SMTP id p12so1187862iln.18
        for <linux-kernel@vger.kernel.org>; Thu, 16 Apr 2020 20:45:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=hOnKfvz92d+3vQbiWu1IoCbVPw/u5sRXIPxJWHDs3S8=;
        b=jXLO0zbc4U5bL8CQNMD9yhHtbqS5V5qPOZADvLONqyCtaeNZDJC5tzJ2YV2b0nrzKO
         DmEwM3XBn6vT3FgP1Z31KkDfussWSkhO0GYA/GyC589wq+xngBpwqFbKf/VjUyZkmO1n
         6xeHG0WZb1+JmBsWlc/a0pqrG747H9XUSwYkx887PhCC1Kcz2+LDfGJoDELIcy+SmFO0
         KH3Iw0Zwrl8pvK9ZWqLgAJkzksj/tr2KNqs1gm8Ux0yr4PhSz6pW1wMy9C/3Gn257zlw
         BOxP78icyNVYTOUnaGl2SoiUsnnbsal2BXBZfxRNwut2cmyDhW/1PdzCKZFuYz31AhRr
         eOpw==
X-Gm-Message-State: AGi0PuYmSgW6Pa46o4YeLR7Ecfbf6vOhI5sv8wE0wjTgmkn71MUb0b2w
        5hTVlracNHpoj2czU3Z9NbiSBypwvP8ablMMmzeemwyO+Q/G
X-Google-Smtp-Source: APiQypJEkeg0NpTLEnkdy9odmuVK2S3aDkvJmnDn2mOUeSJm2gQyAUXL2O60uCFOaNh/H/lg3aNMDYWJS0FYxbq2cArScOe1DD55
MIME-Version: 1.0
X-Received: by 2002:a05:6602:13d4:: with SMTP id o20mr1236860iov.104.1587095110119;
 Thu, 16 Apr 2020 20:45:10 -0700 (PDT)
Date:   Thu, 16 Apr 2020 20:45:10 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000004373bc05a37460df@google.com>
Subject: memory leak in sctp_stream_init_ext (2)
From:   syzbot <syzbot+96e916d6f6f7617bc9fc@syzkaller.appspotmail.com>
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

syzbot found the following crash on:

HEAD commit:    00086336 Merge tag 'efi-urgent-2020-04-15' of git://git.ke..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=12996107e00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=efff978b972fb2c
dashboard link: https://syzkaller.appspot.com/bug?extid=96e916d6f6f7617bc9fc
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=137ddf3fe00000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+96e916d6f6f7617bc9fc@syzkaller.appspotmail.com

BUG: memory leak
unreferenced object 0xffff888103ba4580 (size 96):
  comm "syz-executor.1", pid 8335, jiffies 4294953411 (age 14.410s)
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<00000000b06f3e80>] kmalloc include/linux/slab.h:555 [inline]
    [<00000000b06f3e80>] kzalloc include/linux/slab.h:669 [inline]
    [<00000000b06f3e80>] sctp_stream_init_ext+0x28/0xe0 net/sctp/stream.c:162
    [<00000000aff2ecba>] sctp_sendmsg_to_asoc+0x9af/0xab0 net/sctp/socket.c:1811
    [<00000000d5d5eb76>] sctp_sendmsg+0x2a6/0xc60 net/sctp/socket.c:2031
    [<0000000023cdbfa3>] inet_sendmsg+0x39/0x60 net/ipv4/af_inet.c:807
    [<00000000885878ef>] sock_sendmsg_nosec net/socket.c:652 [inline]
    [<00000000885878ef>] sock_sendmsg+0x4c/0x60 net/socket.c:672
    [<0000000009d727e5>] __sys_sendto+0x11d/0x1c0 net/socket.c:2000
    [<0000000066974477>] __do_sys_sendto net/socket.c:2012 [inline]
    [<0000000066974477>] __se_sys_sendto net/socket.c:2008 [inline]
    [<0000000066974477>] __x64_sys_sendto+0x26/0x30 net/socket.c:2008
    [<00000000ecc1fea9>] do_syscall_64+0x6e/0x220 arch/x86/entry/common.c:295
    [<00000000605d798b>] entry_SYSCALL_64_after_hwframe+0x44/0xa9



---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
