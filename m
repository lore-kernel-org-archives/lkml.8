Return-Path: <SRS0=Q7wL=5E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E978FC4332D
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 13:37:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BEE7820789
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 13:37:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728595AbgCSNhV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Mar 2020 09:37:21 -0400
Received: from mail-io1-f71.google.com ([209.85.166.71]:44289 "EHLO
        mail-io1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728547AbgCSNhP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Mar 2020 09:37:15 -0400
Received: by mail-io1-f71.google.com with SMTP id h4so1744520ior.11
        for <linux-kernel@vger.kernel.org>; Thu, 19 Mar 2020 06:37:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=bRmXmfSUS/flYxvkt9gXYNz1kAipByr60l1Cie4nM/E=;
        b=aloiyjLtISjR14rqH2+JKH6bo/8raAuk9jkgbwaCdeSoD80Em4EMrfuRv7zQLBWh75
         CWwIXCaKPmVM1R99KRcNb8Y9yQsDQM7aRxPJ4EdWT3TjJZeOIoG9aE8IPgQUn4lVmfA2
         pkT1qkAxcLxFmTxMbTCiDxo6/iESVmsZUSs5mRGhh+4J5zIbGDx91gxWg5oODX9gKWC3
         SwN5kMQ5ZqIrSjWAivktDnLaIAjuYBQflSxH8CJ0FQP4tgNl0CHM8tpt4JMA1c9tyQ76
         E3ki0dBnELROQqMLYx9Yj6/j2HBUz/f14Yp4NbT+P3ewBYiayqyTetz8W5BG1GY411mn
         WwrA==
X-Gm-Message-State: ANhLgQ0cl6QuO7CtQswZdcXvypQRor9wfUImGDvnRk5OH1ge0JFnw5Uc
        +LiYY9ccN4tONVHq973pA3a0lisepDviLOzXIwADJBA52G+E
X-Google-Smtp-Source: ADFU+vtEwjBrpgB/CYEKm+1AYUqUSTKjn9G7g9I7y1kH3PTwt4VhFEn6UCA1ZxjddTwLVKgShcXn4W9E0RLbm1dsjA/krKHnS3DF
MIME-Version: 1.0
X-Received: by 2002:a5e:930a:: with SMTP id k10mr2696452iom.132.1584625032305;
 Thu, 19 Mar 2020 06:37:12 -0700 (PDT)
Date:   Thu, 19 Mar 2020 06:37:12 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000027204705a1354443@google.com>
Subject: general protection fault in ethnl_parse_header
From:   syzbot <syzbot+258a9089477493cea67b@syzkaller.appspotmail.com>
To:     andrew@lunn.ch, dan.carpenter@oracle.com, davem@davemloft.net,
        f.fainelli@gmail.com, kuba@kernel.org,
        linux-kernel@vger.kernel.org, mkubecek@suse.cz,
        netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    2de9780f net: core: dev.c: fix a documentation warning
git tree:       net
console output: https://syzkaller.appspot.com/x/log.txt?x=131b4023e00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c2e311dba9a02ba9
dashboard link: https://syzkaller.appspot.com/bug?extid=258a9089477493cea67b
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15a3a7c3e00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1661ab55e00000

The bug was bisected to:

commit 2363d73a2f3e92787f336721c40918ba2eb0c74c
Author: Michal Kubecek <mkubecek@suse.cz>
Date:   Sun Mar 15 17:17:53 2020 +0000

    ethtool: reject unrecognized request flags

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1778561de00000
final crash:    https://syzkaller.appspot.com/x/report.txt?x=14f8561de00000
console output: https://syzkaller.appspot.com/x/log.txt?x=10f8561de00000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+258a9089477493cea67b@syzkaller.appspotmail.com
Fixes: 2363d73a2f3e ("ethtool: reject unrecognized request flags")

general protection fault, probably for non-canonical address 0xdffffc0000000002: 0000 [#1] PREEMPT SMP KASAN
KASAN: null-ptr-deref in range [0x0000000000000010-0x0000000000000017]
CPU: 1 PID: 9619 Comm: syz-executor891 Not tainted 5.6.0-rc5-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:ethnl_parse_header+0x522/0x840 include/linux/string.h:381
Code: ea 03 80 3c 02 00 0f 85 1d 03 00 00 4d 89 7d 08 e8 d3 70 2d fb 49 8d 7d 10 48 ba 00 00 00 00 00 fc ff df 48 89 f8 48 c1 e8 03 <0f> b6 0c 10 49 8d 45 13 48 89 c6 48 c1 ee 03 0f b6 14 16 48 89 fe
RSP: 0018:ffffc90001f8f4d8 EFLAGS: 00010202
RAX: 0000000000000002 RBX: ffff8880a2593048 RCX: ffffffff8644a170
RDX: dffffc0000000000 RSI: ffffffff8644a4ed RDI: 0000000000000010
RBP: ffff8880a4436980 R08: ffff88809e586500 R09: ffffc90001f8f510
R10: fffff520003f1ea5 R11: ffffc90001f8f52f R12: 1ffff920003f1e9e
R13: 0000000000000000 R14: ffffffff8a343040 R15: ffff8880a259304c
FS:  000000000251d880(0000) GS:ffff8880ae700000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000000043eaf0 CR3: 00000000a23d2000 CR4: 00000000001406e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 ethnl_default_parse+0x1c1/0x300 net/ethtool/netlink.c:264
 ethnl_default_start+0x1ed/0x4d0 net/ethtool/netlink.c:492
 __netlink_dump_start+0x58a/0x910 net/netlink/af_netlink.c:2343
 genl_family_rcv_msg_dumpit net/netlink/genetlink.c:630 [inline]
 genl_family_rcv_msg net/netlink/genetlink.c:715 [inline]
 genl_rcv_msg+0xa32/0xdf0 net/netlink/genetlink.c:735
 netlink_rcv_skb+0x15a/0x410 net/netlink/af_netlink.c:2469
 genl_rcv+0x24/0x40 net/netlink/genetlink.c:746
 netlink_unicast_kernel net/netlink/af_netlink.c:1303 [inline]
 netlink_unicast+0x537/0x740 net/netlink/af_netlink.c:1329
 netlink_sendmsg+0x882/0xe10 net/netlink/af_netlink.c:1918
 sock_sendmsg_nosec net/socket.c:652 [inline]
 sock_sendmsg+0xcf/0x120 net/socket.c:672
 ____sys_sendmsg+0x6b9/0x7d0 net/socket.c:2343
 ___sys_sendmsg+0x100/0x170 net/socket.c:2397
 __sys_sendmsg+0xec/0x1b0 net/socket.c:2430
 do_syscall_64+0xf6/0x7d0 arch/x86/entry/common.c:294
 entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x444319
Code: 18 89 d0 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 0f 83 1b d8 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007ffc9883dca8 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00000000004002e0 RCX: 0000000000444319
RDX: 0000000000000000 RSI: 0000000020006440 RDI: 0000000000000003
RBP: 00000000006ce018 R08: 0000000000000008 R09: 00000000004002e0
R10: 000000000000000c R11: 0000000000000246 R12: 0000000000401fc0
R13: 0000000000402050 R14: 0000000000000000 R15: 0000000000000000
Modules linked in:
---[ end trace e7c6f01e7d795112 ]---
RIP: 0010:ethnl_parse_header+0x522/0x840 include/linux/string.h:381
Code: ea 03 80 3c 02 00 0f 85 1d 03 00 00 4d 89 7d 08 e8 d3 70 2d fb 49 8d 7d 10 48 ba 00 00 00 00 00 fc ff df 48 89 f8 48 c1 e8 03 <0f> b6 0c 10 49 8d 45 13 48 89 c6 48 c1 ee 03 0f b6 14 16 48 89 fe
RSP: 0018:ffffc90001f8f4d8 EFLAGS: 00010202
RAX: 0000000000000002 RBX: ffff8880a2593048 RCX: ffffffff8644a170
RDX: dffffc0000000000 RSI: ffffffff8644a4ed RDI: 0000000000000010
RBP: ffff8880a4436980 R08: ffff88809e586500 R09: ffffc90001f8f510
R10: fffff520003f1ea5 R11: ffffc90001f8f52f R12: 1ffff920003f1e9e
R13: 0000000000000000 R14: ffffffff8a343040 R15: ffff8880a259304c
FS:  000000000251d880(0000) GS:ffff8880ae700000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000000043eaf0 CR3: 00000000a23d2000 CR4: 00000000001406e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
