Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,FROM_LOCAL_DIGITS,
	FROM_LOCAL_HEX,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E015EC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 06:27:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BE3C4221E7
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 06:27:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726617AbgGNG1W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 02:27:22 -0400
Received: from mail-io1-f69.google.com ([209.85.166.69]:43512 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725788AbgGNG1V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 02:27:21 -0400
Received: by mail-io1-f69.google.com with SMTP id f13so9770330iok.10
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jul 2020 23:27:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=FLVAbxi1esskEQ5kfl7eEQXpSY8yr8b12Vi9jQkuAYY=;
        b=i8vV+MP+34633yUXDNxJrekE67R4jTyjYJf0Dv0zvOfZA1xzmwdaSBLtQ7VlCatQt4
         TGu7dsBvSXqnWu4GVD3I3AOQVXT8kjK+TuFw5tHOiTdq8FzSV1Q8yrLEcCmFVze48CF0
         3fNesv5lduQbS3TwhFXza2lsMrzc2p+Gy3TwnLsRj6tRq9AlSh+FHvOR9Z9r6RV/gSEA
         RtpW3lgNnvSrEpZ7S010HoCd6bIxNcaWX2goytj8ACRlSD0qaVT9tvuAjs3llbvetWjg
         vbuA9RtHx/tDgUth2kySfTQWNjjopojMDp13oUF+ePzFpMi2Gmq+jxnrxhZV+cA73J6B
         cMFA==
X-Gm-Message-State: AOAM532CyTbk97deeJXQfSGSMI8GNpCaQftfUKqCCipChMXnaAiWplha
        51KDEZzj9bR2SxCZUQZ2rPUfUP0hrgty63GZ69TfQjAp/N03
X-Google-Smtp-Source: ABdhPJxIX0yB/poBDHpHgkPp4hBEFkcgSXkd3/58wbOFsb5OFmP5v5sDo6fgzrEilmPGC01ECbCeX65uLAsvi4FJyux8xMmBkkEL
MIME-Version: 1.0
X-Received: by 2002:a02:878b:: with SMTP id t11mr4343107jai.106.1594708040706;
 Mon, 13 Jul 2020 23:27:20 -0700 (PDT)
Date:   Mon, 13 Jul 2020 23:27:20 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000049705905aa60e63e@google.com>
Subject: KASAN: global-out-of-bounds Read in __xfrm6_tunnel_spi_lookup
From:   syzbot <syzbot+cd59712012813594d659@syzkaller.appspotmail.com>
To:     davem@davemloft.net, herbert@gondor.apana.org.au, kuba@kernel.org,
        kuznet@ms2.inr.ac.ru, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, steffen.klassert@secunet.com,
        syzkaller-bugs@googlegroups.com, yoshfuji@linux-ipv6.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    be978f8f Add linux-next specific files for 20200713
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=11e79167100000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3fe4fccb94cbc1a6
dashboard link: https://syzkaller.appspot.com/bug?extid=cd59712012813594d659
compiler:       gcc (GCC) 10.1.0-syz 20200507
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1430914f100000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1203e95d100000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+cd59712012813594d659@syzkaller.appspotmail.com

IPVS: ftp: loaded support on port[0] = 21
==================================================================
BUG: KASAN: global-out-of-bounds in ipv6_addr_equal include/net/ipv6.h:579 [inline]
BUG: KASAN: global-out-of-bounds in xfrm6_addr_equal include/net/xfrm.h:1699 [inline]
BUG: KASAN: global-out-of-bounds in __xfrm6_tunnel_spi_lookup+0x367/0x3b0 net/ipv6/xfrm6_tunnel.c:82
Read of size 8 at addr ffffffff884ba1e0 by task syz-executor372/6812
CPU: 0 PID: 6812 Comm: syz-executor372 Not tainted 5.8.0-rc4-next-20200713-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x18f/0x20d lib/dump_stack.c:118
 print_address_description.constprop.0.cold+0x5/0x497 mm/kasan/report.c:383
 __kasan_report mm/kasan/report.c:513 [inline]
 kasan_report.cold+0x1f/0x37 mm/kasan/report.c:530
 ipv6_addr_equal include/net/ipv6.h:579 [inline]
 xfrm6_addr_equal include/net/xfrm.h:1699 [inline]
 __xfrm6_tunnel_spi_lookup+0x367/0x3b0 net/ipv6/xfrm6_tunnel.c:82
 xfrm6_tunnel_spi_lookup+0x8a/0x1d0 net/ipv6/xfrm6_tunnel.c:95
 xfrmi6_rcv_tunnel+0xb9/0x100 net/xfrm/xfrm_interface.c:810
 tunnel6_rcv+0xef/0x2b0 net/ipv6/tunnel6.c:148
 ip6_protocol_deliver_rcu+0x2e8/0x1670 net/ipv6/ip6_input.c:433
 ip6_input_finish+0x7f/0x160 net/ipv6/ip6_input.c:474
 NF_HOOK include/linux/netfilter.h:307 [inline]
 NF_HOOK include/linux/netfilter.h:301 [inline]
 ip6_input+0x9c/0xd0 net/ipv6/ip6_input.c:483
 ip6_mc_input+0x411/0xea0 net/ipv6/ip6_input.c:577
 dst_input include/net/dst.h:449 [inline]
 ip6_rcv_finish net/ipv6/ip6_input.c:76 [inline]
 NF_HOOK include/linux/netfilter.h:307 [inline]
 NF_HOOK include/linux/netfilter.h:301 [inline]
 ipv6_rcv+0x28e/0x3c0 net/ipv6/ip6_input.c:307
 __netif_receive_skb_one_core+0x114/0x180 net/core/dev.c:5287
 __netif_receive_skb+0x27/0x1c0 net/core/dev.c:5401
 netif_receive_skb_internal net/core/dev.c:5503 [inline]
 netif_receive_skb+0x159/0x990 net/core/dev.c:5562
 tun_rx_batched.isra.0+0x460/0x720 drivers/net/tun.c:1518
 tun_get_user+0x23b2/0x35b0 drivers/net/tun.c:1972
 tun_chr_write_iter+0xba/0x151 drivers/net/tun.c:2001
 call_write_iter include/linux/fs.h:1879 [inline]
 new_sync_write+0x422/0x650 fs/read_write.c:515
 vfs_write+0x59d/0x6b0 fs/read_write.c:595
 ksys_write+0x12d/0x250 fs/read_write.c:648
 do_syscall_64+0x60/0xe0 arch/x86/entry/common.c:384
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x4013a0
Code: Bad RIP value.
RSP: 002b:00007ffdf3de1d98 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00000000004013a0
RDX: 000000000000005e RSI: 0000000020000ac0 RDI: 00000000000000f0
RBP: 00007ffdf3de1db0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
The buggy address belongs to the variable:
 psi_io_proc_ops+0xa0/0x4fe0
Memory state around the buggy address:
 ffffffff884ba080: 00 00 00 00 f9 f9 f9 f9 00 00 00 00 00 00 00 00
 ffffffff884ba100: 00 00 00 00 f9 f9 f9 f9 00 00 00 00 00 00 00 00
>ffffffff884ba180: 00 00 00 00 f9 f9 f9 f9 00 00 01 f9 f9 f9 f9 f9
                                                       ^
 ffffffff884ba200: 00 00 00 07 f9 f9 f9 f9 00 00 00 f9 f9 f9 f9 f9
 ffffffff884ba280: 00 00 07 f9 f9 f9 f9 f9 00 00 00 02 f9 f9 f9 f9
==================================================================


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
