Return-Path: <SRS0=QqoS=AI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDF63C433E0
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jun 2020 07:18:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B32D22080C
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jun 2020 07:18:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726209AbgF0HSP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Jun 2020 03:18:15 -0400
Received: from mail-il1-f198.google.com ([209.85.166.198]:50792 "EHLO
        mail-il1-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725900AbgF0HSN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Jun 2020 03:18:13 -0400
Received: by mail-il1-f198.google.com with SMTP id l17so8052203ilj.17
        for <linux-kernel@vger.kernel.org>; Sat, 27 Jun 2020 00:18:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=NpmgWhWDWqZRxtggc0PGsmPYy4RDj6z7UbjPEip7q2k=;
        b=ivJLGCXaY7P/tiE9tb9kMufaDqOB751X0Ha/NDeudoscYV/XaConDTABTEdH0vmcPr
         p2xEHc+41P6Qb/8oO9vbmP/D5cs3MG3nDBLV2KXJUB1y/50mlSn8zOk6GFnCHBh6sJYt
         v7qab5f7AJQPMXupfKVtIGW+5b66UKob7gmYuMwN3FaYWmVZ3hm6DtuVp51/bqvZKBXP
         jNZ8+6BdviQeKKE7LvhdzOMiszQ6bvCKWaaqEVwxvnpm9JE/MoSTHweLvYYWw4b+ZpdN
         9CRjZbtbAS1vOTDWAtatjAem+yX9teKbT3b0CxCnj2u95srd0Z/WB0GCXHZ6r7lyXM5C
         G1JA==
X-Gm-Message-State: AOAM533s3TINVy5RdVBwwf1VlUmtgNcl61ddVlTtXuJIxtXfPmGMblRx
        c0A8FqTuOOscQkD6+n+LEQSQvm1XwmOw/ccbownnth1XNyu+
X-Google-Smtp-Source: ABdhPJyt0CkYD6D8p3fNcZlUQDSfjIc2RD6ROx5N5e2wDLBdOwEDZZhWqPTxSFdYB/M7bXHPT0TyDmK5HEYdN//DwZBNTMdknH/X
MIME-Version: 1.0
X-Received: by 2002:a6b:8f09:: with SMTP id r9mr7251035iod.168.1593242292311;
 Sat, 27 Jun 2020 00:18:12 -0700 (PDT)
Date:   Sat, 27 Jun 2020 00:18:12 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000dfdbe905a90ba06d@google.com>
Subject: KASAN: vmalloc-out-of-bounds Read in __nla_validate_parse
From:   syzbot <syzbot+314cd606fbedf9d5d0b2@syzkaller.appspotmail.com>
To:     davem@davemloft.net, jmaloy@redhat.com, kuba@kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        syzkaller-bugs@googlegroups.com,
        tipc-discussion@lists.sourceforge.net, ying.xue@windriver.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    4e15507f libbpf: Forward-declare bpf_stats_type for system..
git tree:       bpf
console output: https://syzkaller.appspot.com/x/log.txt?x=12805f53100000
kernel config:  https://syzkaller.appspot.com/x/.config?x=dcc6334acae363d4
dashboard link: https://syzkaller.appspot.com/bug?extid=314cd606fbedf9d5d0b2
compiler:       gcc (GCC) 10.1.0-syz 20200507

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+314cd606fbedf9d5d0b2@syzkaller.appspotmail.com

netlink: 'syz-executor.3': attribute type 2 has an invalid length.
==================================================================
BUG: KASAN: vmalloc-out-of-bounds in nla_next include/net/netlink.h:1160 [inline]
BUG: KASAN: vmalloc-out-of-bounds in __nla_validate_parse+0x1ebc/0x21a0 lib/nlattr.c:521
Read of size 2 at addr ffffc900019f9018 by task syz-executor.3/6260

CPU: 0 PID: 6260 Comm: syz-executor.3 Not tainted 5.8.0-rc1-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x18f/0x20d lib/dump_stack.c:118
 print_address_description.constprop.0.cold+0x5/0x436 mm/kasan/report.c:383
 __kasan_report mm/kasan/report.c:513 [inline]
 kasan_report.cold+0x1f/0x37 mm/kasan/report.c:530
 nla_next include/net/netlink.h:1160 [inline]
 __nla_validate_parse+0x1ebc/0x21a0 lib/nlattr.c:521
 __nla_parse+0x3d/0x4a lib/nlattr.c:630
 nla_parse_nested_deprecated include/net/netlink.h:1218 [inline]
 tipc_nl_publ_dump+0x239/0xce0 net/tipc/socket.c:3766
 genl_lock_dumpit+0x7f/0xb0 net/netlink/genetlink.c:575
 netlink_dump+0x4cd/0xf60 net/netlink/af_netlink.c:2245
 __netlink_dump_start+0x643/0x900 net/netlink/af_netlink.c:2353
 genl_family_rcv_msg_dumpit+0x2ac/0x310 net/netlink/genetlink.c:638
 genl_family_rcv_msg net/netlink/genetlink.c:733 [inline]
 genl_rcv_msg+0x797/0x9e0 net/netlink/genetlink.c:753
 netlink_rcv_skb+0x15a/0x430 net/netlink/af_netlink.c:2469
 genl_rcv+0x24/0x40 net/netlink/genetlink.c:764
 netlink_unicast_kernel net/netlink/af_netlink.c:1303 [inline]
 netlink_unicast+0x533/0x7d0 net/netlink/af_netlink.c:1329
 netlink_sendmsg+0x856/0xd90 net/netlink/af_netlink.c:1918
 sock_sendmsg_nosec net/socket.c:652 [inline]
 sock_sendmsg+0xcf/0x120 net/socket.c:672
 ____sys_sendmsg+0x6e8/0x810 net/socket.c:2352
 ___sys_sendmsg+0xf3/0x170 net/socket.c:2406
 __sys_sendmsg+0xe5/0x1b0 net/socket.c:2439
 do_syscall_64+0x60/0xe0 arch/x86/entry/common.c:359
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x45ca59
Code: Bad RIP value.
RSP: 002b:00007f14b9253c78 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 0000000000501e40 RCX: 000000000045ca59
RDX: 0000000000000000 RSI: 0000000020000000 RDI: 0000000000000003
RBP: 000000000078bfa0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000ffffffff
R13: 0000000000000a2b R14: 00000000004cd0f1 R15: 00007f14b92546d4


Memory state around the buggy address:
 ffffc900019f8f00: f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9
 ffffc900019f8f80: f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9
>ffffc900019f9000: f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9
                            ^
 ffffc900019f9080: f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9
 ffffc900019f9100: f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9
==================================================================


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
