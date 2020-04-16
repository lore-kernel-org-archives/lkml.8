Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 053B4C3815B
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 12:43:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E40B4217D8
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 12:43:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2636052AbgDPMnk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 08:43:40 -0400
Received: from mail-il1-f198.google.com ([209.85.166.198]:37931 "EHLO
        mail-il1-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2635998AbgDPMnP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 08:43:15 -0400
Received: by mail-il1-f198.google.com with SMTP id c16so8837483ilh.5
        for <linux-kernel@vger.kernel.org>; Thu, 16 Apr 2020 05:43:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=v779y82BJy6MKZS+0kJTYe+V/6NgiP+kTl/bmTEDrfc=;
        b=dM+dww7js6YZ1plvgx92WW7lFXv6SlefazsDjWaQD/d8FNC4e95GUxOg8QcjRttWex
         7p5FbpnWCrgavyoLSwyBlGOJVN3H5A0T/yFLNxdt5o8HybIx0FG+1SvK/WBywc/CkyFG
         omRhA+S//XUu3ZbvyWuXeTGoSSRQXaKuLhpDifRFWzMgXCF69Jk2kB9aTJuJ8yFqNPNO
         79zF2FHCRSApJEUdIBlaEMIAmuBXLDpzVP+rxhBMNHrF4LqYM4j9WJSsB20Pd/TjiZik
         TZr6ZFMqU7IRknlv2KyxUnmli+RybZJrmfr+nfHRno8VjCEEAP3VSMiEaPZt7kU2WZ5M
         tijA==
X-Gm-Message-State: AGi0PuYRq+gLBEc4nUZ4FJ/OUCKAqWFHIcnmm/jVsWpyHkOlwqjeUws2
        dmOk6aK0ixtnGNn3+rpZIkCR6+937MX2M01v8m905B2MbGV1
X-Google-Smtp-Source: APiQypKMnYxPxaGGAl2cOD7eeEOXoMXsFbWYPyW/ZxxwTU6g7/qemE6/IycCIRdOSdAIACf+ehAkYyrhfCZKrCrjeNAeOKwjcr2S
MIME-Version: 1.0
X-Received: by 2002:a92:750f:: with SMTP id q15mr10663775ilc.146.1587040993304;
 Thu, 16 Apr 2020 05:43:13 -0700 (PDT)
Date:   Thu, 16 Apr 2020 05:43:13 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a6661c05a367c669@google.com>
Subject: WARNING in fib6_add (4)
From:   syzbot <syzbot+5f122ebd258b7e43e492@syzkaller.appspotmail.com>
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

HEAD commit:    1a323ea5 x86: get rid of 'errret' argument to __get_user_x..
git tree:       bpf-next
console output: https://syzkaller.appspot.com/x/log.txt?x=143443b3e00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8c1e98458335a7d1
dashboard link: https://syzkaller.appspot.com/bug?extid=5f122ebd258b7e43e492
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+5f122ebd258b7e43e492@syzkaller.appspotmail.com

IPv6: NLM_F_REPLACE set, but no existing node found!
------------[ cut here ]------------
WARNING: CPU: 0 PID: 31420 at net/ipv6/ip6_fib.c:1501 fib6_add+0x3405/0x3df0 net/ipv6/ip6_fib.c:1501
Kernel panic - not syncing: panic_on_warn set ...
CPU: 0 PID: 31420 Comm: syz-executor.4 Not tainted 5.6.0-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x188/0x20d lib/dump_stack.c:118
 panic+0x2e3/0x75c kernel/panic.c:221
 __warn.cold+0x2f/0x35 kernel/panic.c:582
 report_bug+0x27b/0x2f0 lib/bug.c:195
 fixup_bug arch/x86/kernel/traps.c:175 [inline]
 fixup_bug arch/x86/kernel/traps.c:170 [inline]
 do_error_trap+0x12b/0x220 arch/x86/kernel/traps.c:267
 do_invalid_op+0x32/0x40 arch/x86/kernel/traps.c:286
 invalid_op+0x23/0x30 arch/x86/entry/entry_64.S:1027
RIP: 0010:fib6_add+0x3405/0x3df0 net/ipv6/ip6_fib.c:1501
Code: df 48 8d bb d0 09 00 00 48 89 fa 48 c1 ea 03 80 3c 02 00 0f 85 7b 08 00 00 48 8b 9b d0 09 00 00 e9 45 f6 ff ff e8 6b 67 b2 fa <0f> 0b 48 b8 00 00 00 00 00 fc ff df 48 8b 54 24 20 48 c1 ea 03 80
RSP: 0018:ffffc90015df7488 EFLAGS: 00010202
RAX: 0000000000040000 RBX: 0000000000000000 RCX: ffffc90011987000
RDX: 00000000000069f0 RSI: ffffffff86c081f5 RDI: ffff88809a03e3a0
RBP: ffff8880952fb3a0 R08: ffff8880643820c0 R09: ffffed1013edef06
R10: ffffed1013edef05 R11: ffff88809f6f782f R12: 00000000fffffffe
R13: 0000000000000000 R14: ffff8880952fb380 R15: 0000000000000000
 __ip6_ins_rt+0x4f/0x70 net/ipv6/route.c:1313
 ip6_route_add+0x58/0x120 net/ipv6/route.c:3705
 inet6_rtm_newroute+0x152/0x160 net/ipv6/route.c:5330
 rtnetlink_rcv_msg+0x44e/0xad0 net/core/rtnetlink.c:5454
 netlink_rcv_skb+0x15a/0x410 net/netlink/af_netlink.c:2469
 netlink_unicast_kernel net/netlink/af_netlink.c:1303 [inline]
 netlink_unicast+0x537/0x740 net/netlink/af_netlink.c:1329
 netlink_sendmsg+0x882/0xe10 net/netlink/af_netlink.c:1918
 sock_sendmsg_nosec net/socket.c:652 [inline]
 sock_sendmsg+0xcf/0x120 net/socket.c:672
 ____sys_sendmsg+0x6bf/0x7e0 net/socket.c:2362
 ___sys_sendmsg+0x100/0x170 net/socket.c:2416
 __sys_sendmsg+0xec/0x1b0 net/socket.c:2449
 do_syscall_64+0xf6/0x7d0 arch/x86/entry/common.c:295
 entry_SYSCALL_64_after_hwframe+0x49/0xb3
RIP: 0033:0x45c889
Code: ad b6 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 0f 83 7b b6 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007f1f04409c78 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00007f1f0440a6d4 RCX: 000000000045c889
RDX: 0000000000000000 RSI: 0000000020000000 RDI: 0000000000000003
RBP: 000000000076bf00 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000ffffffff
R13: 00000000000009f5 R14: 00000000004ccb09 R15: 000000000076bf0c
Kernel Offset: disabled
Rebooting in 86400 seconds..


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
