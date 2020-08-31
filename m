Return-Path: <SRS0=8grS=CJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADC90C433E2
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 16:47:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 93BB020936
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 16:47:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726204AbgHaQr1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Aug 2020 12:47:27 -0400
Received: from mail-il1-f197.google.com ([209.85.166.197]:41012 "EHLO
        mail-il1-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726946AbgHaQrV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 12:47:21 -0400
Received: by mail-il1-f197.google.com with SMTP id e23so5521581ill.8
        for <linux-kernel@vger.kernel.org>; Mon, 31 Aug 2020 09:47:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=ptposISBabJU+0UJWvS9jomfWUAW0h4nJ0MphyriG80=;
        b=JicgyNtAFgh4TrAU0bALTwIKe1Rw01YsNozcgx24uLhs4WoktkWX9RcL7MYGZAHC8F
         sl97wlR7uwMLFUTWftyC6vjw4MrMy8pS1jxF0wbs4/NDBlOZ3HOP+xsKJpdj39FSx46M
         KUAYtIFBfsf1dBqt1aeV+AW3pEyJhRbk5xjsyRqxKATXXTj1OKShsC5d/GRIPZkfWFg3
         RYfhBxAFZzZKvYgLoLMae1m1NF+3pGjHq5R4hHbH33z6r0zbcM6LAlOSRHc6L5dRnTx3
         BXoJgPUZBTPcaeQclfhdg9r44umgi9sHzMgq1/82mEzql4DfRrHPhriWNmdrnsAsKq0h
         oR2A==
X-Gm-Message-State: AOAM533Cp02PBzNY1REgy5UQb8imHulNtUS5nQeKkQGfPr9iJXc6JROj
        9sNP2w1rAHYIaFyRAAHKPz+H739EB9Yzr59oq7sIREnXckRs
X-Google-Smtp-Source: ABdhPJwbrhYo/UOtEzaf2bomCwl2z82/Rj/d1ECpd3KbTEeUdDOu6FLxX6fptS+lhHNNe4iZJh7pmbBEx+nEuYRPRMUAaRxhSynT
MIME-Version: 1.0
X-Received: by 2002:a92:85ce:: with SMTP id f197mr1970896ilh.298.1598892440186;
 Mon, 31 Aug 2020 09:47:20 -0700 (PDT)
Date:   Mon, 31 Aug 2020 09:47:20 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ee7d1a05ae2f2720@google.com>
Subject: WARNING in nla_get_range_unsigned
From:   syzbot <syzbot+353df1490da781637624@syzkaller.appspotmail.com>
To:     davem@davemloft.net, johannes.berg@intel.com, kuba@kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    0f091e43 netlabel: remove unused param from audit_log_form..
git tree:       net-next
console output: https://syzkaller.appspot.com/x/log.txt?x=14865df2900000
kernel config:  https://syzkaller.appspot.com/x/.config?x=61025c6fd3261bb1
dashboard link: https://syzkaller.appspot.com/bug?extid=353df1490da781637624
compiler:       gcc (GCC) 10.1.0-syz 20200507
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12d7b769900000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14e7aa56900000

The issue was bisected to:

commit 8aa26c575fb343ebde810b30dad0cba7d8121efb
Author: Johannes Berg <johannes.berg@intel.com>
Date:   Tue Aug 18 08:17:33 2020 +0000

    netlink: make NLA_BINARY validation more flexible

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=104486c1900000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=124486c1900000
console output: https://syzkaller.appspot.com/x/log.txt?x=144486c1900000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+353df1490da781637624@syzkaller.appspotmail.com
Fixes: 8aa26c575fb3 ("netlink: make NLA_BINARY validation more flexible")

------------[ cut here ]------------
WARNING: CPU: 0 PID: 6854 at lib/nlattr.c:117 nla_get_range_unsigned+0x157/0x530 lib/nlattr.c:117
Kernel panic - not syncing: panic_on_warn set ...
CPU: 0 PID: 6854 Comm: syz-executor416 Not tainted 5.9.0-rc1-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x18f/0x20d lib/dump_stack.c:118
 panic+0x2e3/0x75c kernel/panic.c:231
 __warn.cold+0x20/0x4a kernel/panic.c:600
 report_bug+0x1bd/0x210 lib/bug.c:198
 handle_bug+0x38/0x90 arch/x86/kernel/traps.c:234
 exc_invalid_op+0x14/0x40 arch/x86/kernel/traps.c:254
 asm_exc_invalid_op+0x12/0x20 arch/x86/include/asm/idtentry.h:536
RIP: 0010:nla_get_range_unsigned+0x157/0x530 lib/nlattr.c:117
Code: 2a 03 00 00 44 0f b6 3b 48 c7 c6 40 9f 96 88 4c 89 ff e8 3c 34 c4 fd 41 80 ff 0b 77 11 42 ff 24 fd 60 99 96 88 e8 69 37 c4 fd <0f> 0b eb 8f e8 60 37 c4 fd 0f 0b 5b 41 5c 41 5d 41 5e 41 5f 5d e9
RSP: 0018:ffffc90000f17190 EFLAGS: 00010293
RAX: 0000000000000000 RBX: ffffffff89180640 RCX: ffffffff83b006e8
RDX: ffff8880a79a8300 RSI: ffffffff83b007a7 RDI: 0000000000000003
RBP: ffffc90000f171b8 R08: 0000000000000000 R09: ffff8880972a4370
R10: 0000000000000000 R11: 0000000000000000 R12: ffffc90000f17278
R13: ffffffff89180641 R14: 0000000000008c60 R15: ffffffff89180640
 netlink_policy_dump_write+0x2ae/0xea0 net/netlink/policy.c:270
 ctrl_dumppolicy+0x4a8/0x900 net/netlink/genetlink.c:1099
 genl_lock_dumpit+0x7f/0xb0 net/netlink/genetlink.c:553
 netlink_dump+0x4cd/0xf60 net/netlink/af_netlink.c:2246
 __netlink_dump_start+0x643/0x900 net/netlink/af_netlink.c:2354
 genl_family_rcv_msg_dumpit+0x2ac/0x310 net/netlink/genetlink.c:616
 genl_family_rcv_msg net/netlink/genetlink.c:711 [inline]
 genl_rcv_msg+0x75f/0x980 net/netlink/genetlink.c:731
 netlink_rcv_skb+0x15a/0x430 net/netlink/af_netlink.c:2470
 genl_rcv+0x24/0x40 net/netlink/genetlink.c:742
 netlink_unicast_kernel net/netlink/af_netlink.c:1304 [inline]
 netlink_unicast+0x533/0x7d0 net/netlink/af_netlink.c:1330
 netlink_sendmsg+0x856/0xd90 net/netlink/af_netlink.c:1919
 sock_sendmsg_nosec net/socket.c:651 [inline]
 sock_sendmsg+0xcf/0x120 net/socket.c:671
 ____sys_sendmsg+0x6e8/0x810 net/socket.c:2353
 ___sys_sendmsg+0xf3/0x170 net/socket.c:2407
 __sys_sendmsg+0xe5/0x1b0 net/socket.c:2440
 do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x4402a9
Code: 18 89 d0 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 0f 83 7b 13 fc ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007ffd2f689438 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00000000004002c8 RCX: 00000000004402a9
RDX: 0000000000000000 RSI: 0000000020000000 RDI: 0000000000000003
RBP: 00000000006ca018 R08: 0000000000000000 R09: 00000000004002c8
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000401ab0
R13: 0000000000401b40 R14: 0000000000000000 R15: 0000000000000000
Kernel Offset: disabled
Rebooting in 86400 seconds..


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
