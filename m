Return-Path: <SRS0=gGKB=AY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA9EFC433E2
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 22:05:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A37842089D
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 22:05:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726856AbgGMWFV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jul 2020 18:05:21 -0400
Received: from mail-il1-f200.google.com ([209.85.166.200]:34277 "EHLO
        mail-il1-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726534AbgGMWFV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 18:05:21 -0400
Received: by mail-il1-f200.google.com with SMTP id y3so10641215ily.1
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jul 2020 15:05:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=/CaBlhXA2yijgvsH3mm3jiuHprEF7nJhVm/YGG9D6E0=;
        b=k6UhOFz+nib0zGqM9QjdJADzV4ETnw85AFE3a8fQmVAnzVOUP3MdzMB3SO7ijmAHaD
         TVIoNdBJ+9IWVMZfGbdj7FpEWaiWv2msfRGuSVt/2g7gTfDZumEvQZr86Sm5bDtwbqpU
         HLJrQ7iZBVB1YiLCaODGSTNBxBS7+wCka2PDGadqRisNeEak+8yRwu6UfatSF1M74tvZ
         VhM2UXbgpYTQCM8Fv0W8zGnpZiYUwLxYqMDV1ftM6qVCuMFNBxuIzN6BSS8lUcvD+DqN
         0AcQuq3KdR9Wgz9lDBJlXJvd0R3L4SQ07xU64k9DueFEuOf01+dXAUrEgSNpPTXh7JcR
         BiRA==
X-Gm-Message-State: AOAM530C4D8aGY2b3a/hOgFYxN46U91s/nOCe6uVF4EDvf7LTgdl18qn
        Q4plhQKxH4tfOUMl9FVfze7xOUljLMFlf4FIXIZLEVvDtr2i
X-Google-Smtp-Source: ABdhPJxw4I009swN2f78MR3KuA3NZ8gnTQrg86CeBZ+uoVZfurbK5Z5LAwWyL1o8A/PWzhxTCdLnxAUcxHADXOMbSg5vafI5W0xn
MIME-Version: 1.0
X-Received: by 2002:a02:7419:: with SMTP id o25mr2436097jac.46.1594677920398;
 Mon, 13 Jul 2020 15:05:20 -0700 (PDT)
Date:   Mon, 13 Jul 2020 15:05:20 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000fa0ea505aa59e284@google.com>
Subject: KMSAN: uninit-value in __tipc_nl_compat_dumpit (3)
From:   syzbot <syzbot+0e7181deafa7e0b79923@syzkaller.appspotmail.com>
To:     davem@davemloft.net, glider@google.com, jmaloy@redhat.com,
        kuba@kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        tipc-discussion@lists.sourceforge.net, ying.xue@windriver.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    f0d5ec90 kmsan: apply __no_sanitize_memory to dotraplinkag..
git tree:       https://github.com/google/kmsan.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=1206d73d100000
kernel config:  https://syzkaller.appspot.com/x/.config?x=86e4f8af239686c6
dashboard link: https://syzkaller.appspot.com/bug?extid=0e7181deafa7e0b79923
compiler:       clang version 10.0.0 (https://github.com/llvm/llvm-project/ c2443155a0fb245c8f17f2c1c72b6ea391e86e81)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15a6948f100000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=144e2047100000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+0e7181deafa7e0b79923@syzkaller.appspotmail.com

=====================================================
BUG: KMSAN: uninit-value in __nlmsg_parse include/net/netlink.h:661 [inline]
BUG: KMSAN: uninit-value in nlmsg_parse_deprecated include/net/netlink.h:706 [inline]
BUG: KMSAN: uninit-value in __tipc_nl_compat_dumpit+0x583/0x1290 net/tipc/netlink_compat.c:215
CPU: 0 PID: 8825 Comm: syz-executor230 Not tainted 5.7.0-rc4-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x1c9/0x220 lib/dump_stack.c:118
 kmsan_report+0xf7/0x1e0 mm/kmsan/kmsan_report.c:121
 __msan_warning+0x58/0xa0 mm/kmsan/kmsan_instr.c:215
 __nlmsg_parse include/net/netlink.h:661 [inline]
 nlmsg_parse_deprecated include/net/netlink.h:706 [inline]
 __tipc_nl_compat_dumpit+0x583/0x1290 net/tipc/netlink_compat.c:215
 tipc_nl_compat_dumpit+0x761/0x910 net/tipc/netlink_compat.c:308
 tipc_nl_compat_handle net/tipc/netlink_compat.c:1272 [inline]
 tipc_nl_compat_recv+0x1382/0x2940 net/tipc/netlink_compat.c:1311
 genl_family_rcv_msg_doit net/netlink/genetlink.c:673 [inline]
 genl_family_rcv_msg net/netlink/genetlink.c:718 [inline]
 genl_rcv_msg+0x20dc/0x2480 net/netlink/genetlink.c:735
 netlink_rcv_skb+0x451/0x650 net/netlink/af_netlink.c:2469
 genl_rcv+0x63/0x80 net/netlink/genetlink.c:746
 netlink_unicast_kernel net/netlink/af_netlink.c:1303 [inline]
 netlink_unicast+0xf9e/0x1100 net/netlink/af_netlink.c:1329
 netlink_sendmsg+0x1246/0x14d0 net/netlink/af_netlink.c:1918
 sock_sendmsg_nosec net/socket.c:652 [inline]
 sock_sendmsg net/socket.c:672 [inline]
 ____sys_sendmsg+0x12b6/0x1350 net/socket.c:2362
 ___sys_sendmsg net/socket.c:2416 [inline]
 __sys_sendmsg+0x623/0x750 net/socket.c:2449
 __do_sys_sendmsg net/socket.c:2458 [inline]
 __se_sys_sendmsg+0x97/0xb0 net/socket.c:2456
 __x64_sys_sendmsg+0x4a/0x70 net/socket.c:2456
 do_syscall_64+0xb8/0x160 arch/x86/entry/common.c:297
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x444219
Code: 18 89 d0 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 0f 83 1b d8 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007ffded8626b8 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00000000004002e0 RCX: 0000000000444219
RDX: 0000000000000000 RSI: 00000000200000c0 RDI: 0000000000000003
RBP: 00000000006ce018 R08: 00000000004002e0 R09: 00000000004002e0
R10: 0000000000001900 R11: 0000000000000246 R12: 0000000000401ec0
R13: 0000000000401f50 R14: 0000000000000000 R15: 0000000000000000

Uninit was created at:
 kmsan_save_stack_with_flags mm/kmsan/kmsan.c:144 [inline]
 kmsan_internal_poison_shadow+0x66/0xd0 mm/kmsan/kmsan.c:127
 kmsan_slab_alloc+0x8a/0xe0 mm/kmsan/kmsan_hooks.c:80
 slab_alloc_node mm/slub.c:2802 [inline]
 __kmalloc_node_track_caller+0xb40/0x1200 mm/slub.c:4436
 __kmalloc_reserve net/core/skbuff.c:142 [inline]
 __alloc_skb+0x2fd/0xac0 net/core/skbuff.c:210
 alloc_skb include/linux/skbuff.h:1083 [inline]
 nlmsg_new include/net/netlink.h:888 [inline]
 tipc_nl_compat_dumpit+0x6e4/0x910 net/tipc/netlink_compat.c:301
 tipc_nl_compat_handle net/tipc/netlink_compat.c:1272 [inline]
 tipc_nl_compat_recv+0x1382/0x2940 net/tipc/netlink_compat.c:1311
 genl_family_rcv_msg_doit net/netlink/genetlink.c:673 [inline]
 genl_family_rcv_msg net/netlink/genetlink.c:718 [inline]
 genl_rcv_msg+0x20dc/0x2480 net/netlink/genetlink.c:735
 netlink_rcv_skb+0x451/0x650 net/netlink/af_netlink.c:2469
 genl_rcv+0x63/0x80 net/netlink/genetlink.c:746
 netlink_unicast_kernel net/netlink/af_netlink.c:1303 [inline]
 netlink_unicast+0xf9e/0x1100 net/netlink/af_netlink.c:1329
 netlink_sendmsg+0x1246/0x14d0 net/netlink/af_netlink.c:1918
 sock_sendmsg_nosec net/socket.c:652 [inline]
 sock_sendmsg net/socket.c:672 [inline]
 ____sys_sendmsg+0x12b6/0x1350 net/socket.c:2362
 ___sys_sendmsg net/socket.c:2416 [inline]
 __sys_sendmsg+0x623/0x750 net/socket.c:2449
 __do_sys_sendmsg net/socket.c:2458 [inline]
 __se_sys_sendmsg+0x97/0xb0 net/socket.c:2456
 __x64_sys_sendmsg+0x4a/0x70 net/socket.c:2456
 do_syscall_64+0xb8/0x160 arch/x86/entry/common.c:297
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
=====================================================


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
