Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34EF5C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 21:05:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1687320786
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 21:05:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389951AbgF2VFr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 17:05:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731090AbgF2TMn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 15:12:43 -0400
Received: from mail-io1-xd48.google.com (mail-io1-xd48.google.com [IPv6:2607:f8b0:4864:20::d48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEDBFC030F2F
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 09:47:13 -0700 (PDT)
Received: by mail-io1-xd48.google.com with SMTP id h15so11345294ioj.11
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 09:47:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=J/R4XxZwQAT4xbXtFh8lwFtDA9cf+xMbyKu1eQl5jf8=;
        b=W+5wnZuHmNEChGgluER9MiMvAYhltzfliBNge2eRqvOTREPcQHf8eaTA8+g5Y+JSR/
         VE1uqLYPP8efsTm3s7dhNqUnsXseUNeE2PhQwqYcGUkn9BbYyvV6H9AO4Q/ZV4rSLJ3G
         2Q7s3Ogeblu47SqT3JKteqIwf8kUzm6IM1WbkLkmR7p4n+/O2xXnp+fTUtR44UB26tYk
         SZwx4ywSCcQi+E7PEPFFW/+O0WApq09PLir2AC2p0jBLIfO3++/DzbzOkW+IU2fZyo3x
         PC06GIkyskEyw2Xu6XFQMlg0XAYjjhUjqODNTbbTSBCWdYd0QYSG23maWLn4m4friPJO
         3zjg==
X-Gm-Message-State: AOAM533szcoVFBjSARjSCm3sjZz1UHJkdBkDJ1gLduk0fjs4P/ftehrr
        O4Z0oK/NsaqpppRmDehFNMU5JjrEwXGNRa17Gdro7bQ85C2d
X-Google-Smtp-Source: ABdhPJwcQ/lJpLQwMcD9q55uaUscxlk/L+5p87BCC5ifC21YduuXQuHTKGQwHLwBx816PHvGYKF/qAnd45+1oaXI7LcCJNVuh9yA
MIME-Version: 1.0
X-Received: by 2002:a02:270d:: with SMTP id g13mr17708126jaa.93.1593449233300;
 Mon, 29 Jun 2020 09:47:13 -0700 (PDT)
Date:   Mon, 29 Jun 2020 09:47:13 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000084cbe605a93bcf78@google.com>
Subject: KASAN: vmalloc-out-of-bounds Read in netdev_name_node_lookup_rcu
From:   syzbot <syzbot+1860d20cb6a6f52be167@syzkaller.appspotmail.com>
To:     Jason@zx2c4.com, davem@davemloft.net, kuba@kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, wireguard@lists.zx2c4.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    0574e200 enetc: Fix tx rings bitmap iteration range, irq h..
git tree:       net
console output: https://syzkaller.appspot.com/x/log.txt?x=15f95b4b100000
kernel config:  https://syzkaller.appspot.com/x/.config?x=bf3aec367b9ab569
dashboard link: https://syzkaller.appspot.com/bug?extid=1860d20cb6a6f52be167
compiler:       gcc (GCC) 10.1.0-syz 20200507

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+1860d20cb6a6f52be167@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: vmalloc-out-of-bounds in strnlen+0x64/0x70 lib/string.c:561
Read of size 1 at addr ffffc90016f09018 by task syz-executor.0/25244

CPU: 0 PID: 25244 Comm: syz-executor.0 Not tainted 5.8.0-rc2-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x18f/0x20d lib/dump_stack.c:118
 print_address_description.constprop.0.cold+0x5/0x436 mm/kasan/report.c:383
 __kasan_report mm/kasan/report.c:513 [inline]
 kasan_report.cold+0x1f/0x37 mm/kasan/report.c:530
 strnlen+0x64/0x70 lib/string.c:561
 strnlen include/linux/string.h:339 [inline]
 dev_name_hash net/core/dev.c:208 [inline]
 netdev_name_node_lookup_rcu+0x22/0x150 net/core/dev.c:290
 dev_get_by_name_rcu net/core/dev.c:883 [inline]
 dev_get_by_name+0x7b/0x1e0 net/core/dev.c:905
 lookup_interface drivers/net/wireguard/netlink.c:63 [inline]
 wg_get_device_start+0x2e4/0x3f0 drivers/net/wireguard/netlink.c:203
 genl_start+0x342/0x6e0 net/netlink/genetlink.c:556
 __netlink_dump_start+0x585/0x900 net/netlink/af_netlink.c:2343
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
 sock_no_sendpage+0xee/0x130 net/core/sock.c:2853
 kernel_sendpage net/socket.c:3642 [inline]
 sock_sendpage+0xe5/0x140 net/socket.c:945
 pipe_to_sendpage+0x2ad/0x380 fs/splice.c:448
 splice_from_pipe_feed fs/splice.c:502 [inline]
 __splice_from_pipe+0x3dc/0x830 fs/splice.c:626
 splice_from_pipe fs/splice.c:661 [inline]
 generic_splice_sendpage+0xd4/0x140 fs/splice.c:834
 do_splice_from fs/splice.c:846 [inline]
 direct_splice_actor+0x171/0x2f0 fs/splice.c:1016
 splice_direct_to_actor+0x38c/0x980 fs/splice.c:971
 do_splice_direct+0x1b3/0x280 fs/splice.c:1059
 do_sendfile+0x559/0xc30 fs/read_write.c:1521
 __do_sys_sendfile64 fs/read_write.c:1582 [inline]
 __se_sys_sendfile64 fs/read_write.c:1568 [inline]
 __x64_sys_sendfile64+0x1cc/0x210 fs/read_write.c:1568
 do_syscall_64+0x60/0xe0 arch/x86/entry/common.c:359
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x45cb19
Code: Bad RIP value.
RSP: 002b:00007f4e16337c78 EFLAGS: 00000246 ORIG_RAX: 0000000000000028
RAX: ffffffffffffffda RBX: 00000000004fd640 RCX: 000000000045cb19
RDX: 0000000000000000 RSI: 0000000000000004 RDI: 0000000000000005
RBP: 000000000078bf00 R08: 0000000000000000 R09: 0000000000000000
R10: 000000010000680d R11: 0000000000000246 R12: 00000000ffffffff
R13: 0000000000000901 R14: 00000000004cbddf R15: 00007f4e163386d4


Memory state around the buggy address:
 ffffc90016f08f00: f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9
 ffffc90016f08f80: f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9
>ffffc90016f09000: f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9
                            ^
 ffffc90016f09080: f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9
 ffffc90016f09100: f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9
==================================================================


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
