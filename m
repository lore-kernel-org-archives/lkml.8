Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0DEEC2BA19
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 09:20:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C3CCE20771
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 09:20:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405350AbgDOJUk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 05:20:40 -0400
Received: from mail-il1-f198.google.com ([209.85.166.198]:54349 "EHLO
        mail-il1-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2895331AbgDOJUQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 05:20:16 -0400
Received: by mail-il1-f198.google.com with SMTP id m2so3285497ilb.21
        for <linux-kernel@vger.kernel.org>; Wed, 15 Apr 2020 02:20:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=xd9FG5EnS3ZB/2yZROcLKUcGKhAcYFKk/cfgDfazjdQ=;
        b=nKODTojtVlwjhvHx93J0/NxqUTATM+UFv4OeispLiOdB0KSvnflbsJDpVpkguc5zdu
         a+oVb5daEWiNfFiM+k5/9z9RaUZvSDwB+Ck64UNhMZm8t6CmuRiWGOGd+yyS04Y8kzl/
         NOjC1o7XF7EazCnGXS4e0wyak3OiDpPjKnXnRsuzGHKopG4xrNhE2vrzhZB9g6rfBhj0
         MTHB1QGg4rUgLVEcJTeiqQZLdGayUXRk7Y5SLxk4wjmdD617laSuHCJPFrygeSwxBAQn
         4CT3ZyFHfaUlGflbgMsVYMRfIRdIaRim9E5NBaJ2k0brrNEa0Iy5dNg2Ii6Ph0END0fj
         8tvw==
X-Gm-Message-State: AGi0PubGIR1NwbQyHI9LTaaJ32Tkr9aBzcZXsCqTX+6dc1Wk7cjcYpXH
        VVAxqqY6ZotDK6tUeBwulQAwCxdUxiykPOx11yCuceSXhMYc
X-Google-Smtp-Source: APiQypJJSpD1Ep7fXJWHOTtFqck51Pumm5G+CBorKaCAHU9IFP/0Ymvq4fh6L55Ml+A66kLYB8dSmpIA2iAxcPO6mdctjblDZQxw
MIME-Version: 1.0
X-Received: by 2002:a02:205:: with SMTP id 5mr23601798jau.78.1586942414839;
 Wed, 15 Apr 2020 02:20:14 -0700 (PDT)
Date:   Wed, 15 Apr 2020 02:20:14 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ea641705a350d2ee@google.com>
Subject: WARNING: proc registration bug in snmp6_register_dev
From:   syzbot <syzbot+1d51c8b74efa4c44adeb@syzkaller.appspotmail.com>
To:     davem@davemloft.net, kuba@kernel.org, kuznet@ms2.inr.ac.ru,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, yoshfuji@linux-ipv6.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    ab6f762f printk: queue wake_up_klogd irq_work only if per-..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1395613fe00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3010ccb0f380f660
dashboard link: https://syzkaller.appspot.com/bug?extid=1d51c8b74efa4c44adeb
compiler:       clang version 10.0.0 (https://github.com/llvm/llvm-project/ c2443155a0fb245c8f17f2c1c72b6ea391e86e81)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+1d51c8b74efa4c44adeb@syzkaller.appspotmail.com

------------[ cut here ]------------
proc_dir_entry 'dev_snmp6/hsr1' already registered
WARNING: CPU: 0 PID: 22141 at fs/proc/generic.c:363 proc_register+0x2bc/0x4e0 fs/proc/generic.c:362
Kernel panic - not syncing: panic_on_warn set ...
CPU: 0 PID: 22141 Comm: syz-executor.2 Not tainted 5.6.0-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x1e9/0x30e lib/dump_stack.c:118
 panic+0x264/0x7a0 kernel/panic.c:221
 __warn+0x209/0x210 kernel/panic.c:582
 report_bug+0x1ac/0x2d0 lib/bug.c:195
 fixup_bug arch/x86/kernel/traps.c:175 [inline]
 do_error_trap+0xca/0x1c0 arch/x86/kernel/traps.c:267
 do_invalid_op+0x32/0x40 arch/x86/kernel/traps.c:286
 invalid_op+0x23/0x30 arch/x86/entry/entry_64.S:1027
RIP: 0010:proc_register+0x2bc/0x4e0 fs/proc/generic.c:362
Code: 08 4c 8b 74 24 28 48 8b 6c 24 20 74 08 48 89 ef e8 99 29 d1 ff 48 8b 55 00 48 c7 c7 24 4e e9 88 48 89 de 31 c0 e8 e4 7c 65 ff <0f> 0b 48 c7 c7 20 e6 32 89 e8 66 41 2a 06 48 8b 44 24 30 42 8a 04
RSP: 0000:ffffc900088feec0 EFLAGS: 00010246
RAX: f20851673ab1bb00 RBX: ffff8880908a5264 RCX: 0000000000040000
RDX: ffffc9000df22000 RSI: 00000000000150b4 RDI: 00000000000150b5
RBP: ffff88808981bc18 R08: ffffffff815cac69 R09: ffffed1015d06660
R10: ffffed1015d06660 R11: 0000000000000000 R12: dffffc0000000000
R13: 0000000000000004 R14: ffff88808981bbd4 R15: ffff88808981bb40
 proc_create_single_data+0x18e/0x1e0 fs/proc/generic.c:631
 snmp6_register_dev+0xa1/0x110 net/ipv6/proc.c:254
 ipv6_add_dev+0x509/0x1430 net/ipv6/addrconf.c:408
 addrconf_notify+0x5f8/0x3ad0 net/ipv6/addrconf.c:3503
 notifier_call_chain kernel/notifier.c:83 [inline]
 __raw_notifier_call_chain kernel/notifier.c:361 [inline]
 raw_notifier_call_chain+0xd4/0x170 kernel/notifier.c:368
 call_netdevice_notifiers_info net/core/dev.c:1948 [inline]
 call_netdevice_notifiers_extack net/core/dev.c:1960 [inline]
 call_netdevice_notifiers net/core/dev.c:1974 [inline]
 register_netdevice+0x14a4/0x1a50 net/core/dev.c:9421
 hsr_dev_finalize+0x425/0x6d0 net/hsr/hsr_device.c:486
 hsr_newlink+0x3b5/0x460 net/hsr/hsr_netlink.c:77
 __rtnl_newlink net/core/rtnetlink.c:3333 [inline]
 rtnl_newlink+0x143e/0x1c00 net/core/rtnetlink.c:3391
 rtnetlink_rcv_msg+0x889/0xd40 net/core/rtnetlink.c:5454
 netlink_rcv_skb+0x190/0x3a0 net/netlink/af_netlink.c:2469
 netlink_unicast_kernel net/netlink/af_netlink.c:1303 [inline]
 netlink_unicast+0x786/0x940 net/netlink/af_netlink.c:1329
 netlink_sendmsg+0xa57/0xd70 net/netlink/af_netlink.c:1918
 sock_sendmsg_nosec net/socket.c:652 [inline]
 sock_sendmsg net/socket.c:672 [inline]
 ____sys_sendmsg+0x4f9/0x7c0 net/socket.c:2362
 ___sys_sendmsg net/socket.c:2416 [inline]
 __sys_sendmsg+0x2a6/0x360 net/socket.c:2449
 do_syscall_64+0xf3/0x1b0 arch/x86/entry/common.c:295
 entry_SYSCALL_64_after_hwframe+0x49/0xb3
RIP: 0033:0x45c889
Code: ad b6 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 0f 83 7b b6 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007f007299ac78 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00007f007299b6d4 RCX: 000000000045c889
RDX: 0000000000000000 RSI: 00000000200000c0 RDI: 0000000000000006
RBP: 000000000076c180 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000ffffffff
R13: 00000000000009fc R14: 00000000004ccb7c R15: 000000000076c18c
Kernel Offset: disabled
Rebooting in 86400 seconds..


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
