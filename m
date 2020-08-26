Return-Path: <SRS0=kGB5=CE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E52CC433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 14:37:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 83BD12177B
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 14:37:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726985AbgHZOhU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 10:37:20 -0400
Received: from mail-il1-f197.google.com ([209.85.166.197]:49045 "EHLO
        mail-il1-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726241AbgHZOhR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 10:37:17 -0400
Received: by mail-il1-f197.google.com with SMTP id w8so1694538ilg.15
        for <linux-kernel@vger.kernel.org>; Wed, 26 Aug 2020 07:37:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=tPgHYj8PZKWvkD+fLyWl0JZeWCh5qB38PFmBHicCB0A=;
        b=UdkhxbHAA0VdKA3/2kMPXvfgsgWzG2ZD5YSZ5TAtcrYVzClvOdu3Ax16X59BaJIeLc
         T4vfceXl4Fr5SBkyqlZM1wwhH/jXpbxk7BaueBPdBdkani9G+SyABSvntJqdZzSU1QnW
         fdpmNkB/20PmxzbdhQ3jKulDfySZL1HnXLX0v9ACqmm0831bbD4XwxFA/kXgtFrH79l9
         hNnvrGAcjH5UUrJmfM64KKLCAC0HPJPCXc9LXQ3taTbP3aUnsnc6D/W74NeFK+GW+h0w
         FGHpFp6Vqgl9JJWe4pSP55U5MjNgjw5cBpEWD4SouWom6vItsQGjN1WBVZT+wClDwU3L
         uvpg==
X-Gm-Message-State: AOAM531wdEPG2PsoBWcwCMjThPlX9k9fpNfnuaOOL1Q4H3H91FqI3riN
        xEfpvgimVRjmELWU1iGzoGh7YELXDyaCSUhH8eAJTjlVfel/
X-Google-Smtp-Source: ABdhPJxUjzo90/Jsjs+t2OOWB++rPv66DhGFI73p0X4mdAJY2si0xwGTZ9KfrH96hC0PHKK3Y6UPr/NzbIF7nxbs71OED6iXdjbs
MIME-Version: 1.0
X-Received: by 2002:a05:6602:14ca:: with SMTP id b10mr12897154iow.83.1598452636010;
 Wed, 26 Aug 2020 07:37:16 -0700 (PDT)
Date:   Wed, 26 Aug 2020 07:37:16 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000008f4cab05adc8c1ad@google.com>
Subject: WARNING: refcount bug in red_destroy
From:   syzbot <syzbot+e5ea5f8a3ecfd4427a1c@syzkaller.appspotmail.com>
To:     davem@davemloft.net, jhs@mojatatu.com, jiri@resnulli.us,
        kuba@kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, petrm@mellanox.com,
        syzkaller-bugs@googlegroups.com, xiyou.wangcong@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    6a9dc5fd lib: Revert use of fallthrough pseudo-keyword in ..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=15c685ee900000
kernel config:  https://syzkaller.appspot.com/x/.config?x=891ca5711a9f1650
dashboard link: https://syzkaller.appspot.com/bug?extid=e5ea5f8a3ecfd4427a1c
compiler:       clang version 10.0.0 (https://github.com/llvm/llvm-project/ c2443155a0fb245c8f17f2c1c72b6ea391e86e81)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15b28c96900000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=159160b6900000

The issue was bisected to:

commit aee9caa03fc3c8b02f8f31824354d85f30e562e0
Author: Petr Machata <petrm@mellanox.com>
Date:   Fri Jun 26 22:45:28 2020 +0000

    net: sched: sch_red: Add qevents "early_drop" and "mark"

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=14cec9a9900000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=16cec9a9900000
console output: https://syzkaller.appspot.com/x/log.txt?x=12cec9a9900000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+e5ea5f8a3ecfd4427a1c@syzkaller.appspotmail.com
Fixes: aee9caa03fc3 ("net: sched: sch_red: Add qevents "early_drop" and "mark"")

------------[ cut here ]------------
refcount_t: underflow; use-after-free.
WARNING: CPU: 0 PID: 6828 at lib/refcount.c:28 refcount_warn_saturate+0x15b/0x1a0 lib/refcount.c:28
Kernel panic - not syncing: panic_on_warn set ...
CPU: 0 PID: 6828 Comm: syz-executor300 Not tainted 5.9.0-rc2-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x1f0/0x31e lib/dump_stack.c:118
 panic+0x264/0x7a0 kernel/panic.c:231
 __warn+0x227/0x250 kernel/panic.c:600
 report_bug+0x1b1/0x2e0 lib/bug.c:198
 handle_bug+0x42/0x80 arch/x86/kernel/traps.c:234
 exc_invalid_op+0x16/0x40 arch/x86/kernel/traps.c:254
 asm_exc_invalid_op+0x12/0x20 arch/x86/include/asm/idtentry.h:536
RIP: 0010:refcount_warn_saturate+0x15b/0x1a0 lib/refcount.c:28
Code: c7 aa 91 15 89 31 c0 e8 93 3f a6 fd 0f 0b eb 85 e8 7a 9a d4 fd c6 05 53 93 ea 05 01 48 c7 c7 d6 91 15 89 31 c0 e8 75 3f a6 fd <0f> 0b e9 64 ff ff ff e8 59 9a d4 fd c6 05 33 93 ea 05 01 48 c7 c7
RSP: 0018:ffffc9000100f598 EFLAGS: 00010246
RAX: a0b905fb01115d00 RBX: 0000000000000003 RCX: ffff8880a80f83c0
RDX: 0000000000000000 RSI: 0000000080000000 RDI: 0000000000000000
RBP: 0000000000000003 R08: ffffffff815e2109 R09: ffffed1015d062c0
R10: ffffed1015d062c0 R11: 0000000000000000 R12: ffff8880a8a4a000
R13: ffff8880943cf478 R14: dffffc0000000000 R15: ffffc9000100f5b0
 red_destroy+0x1ed/0x2a0 net/sched/sch_red.c:221
 qdisc_create+0xfc4/0x1410 net/sched/sch_api.c:1312
 tc_modify_qdisc+0x962/0x1d90 net/sched/sch_api.c:1662
 rtnetlink_rcv_msg+0x889/0xd40 net/core/rtnetlink.c:5563
 netlink_rcv_skb+0x190/0x3a0 net/netlink/af_netlink.c:2470
 netlink_unicast_kernel net/netlink/af_netlink.c:1304 [inline]
 netlink_unicast+0x786/0x940 net/netlink/af_netlink.c:1330
 netlink_sendmsg+0xa57/0xd70 net/netlink/af_netlink.c:1919
 sock_sendmsg_nosec net/socket.c:651 [inline]
 sock_sendmsg net/socket.c:671 [inline]
 ____sys_sendmsg+0x519/0x800 net/socket.c:2353
 ___sys_sendmsg net/socket.c:2407 [inline]
 __sys_sendmsg+0x2b1/0x360 net/socket.c:2440
 do_syscall_64+0x31/0x70 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x4404a9
Code: 18 89 d0 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 0f 83 7b 13 fc ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007fff355f30b8 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00000000004002c8 RCX: 00000000004404a9
RDX: 0000000000000000 RSI: 0000000020000240 RDI: 0000000000000004
RBP: 00000000006ca018 R08: 00000000004002c8 R09: 00000000004002c8
R10: 00000000004002c8 R11: 0000000000000246 R12: 0000000000401cb0
R13: 0000000000401d40 R14: 0000000000000000 R15: 0000000000000000
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
