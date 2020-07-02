Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6318C433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 11:32:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CAA3B20723
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 11:32:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728657AbgGBLcP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 07:32:15 -0400
Received: from mail-il1-f200.google.com ([209.85.166.200]:49594 "EHLO
        mail-il1-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728514AbgGBLcP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 07:32:15 -0400
Received: by mail-il1-f200.google.com with SMTP id w10so11117487ilm.16
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jul 2020 04:32:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=gqcMTeQ+FRCIT8J7qxZbTwrARjZs4fiAzlO+VdOLcYI=;
        b=Wou5+JOs+RO7qwKAFeUDdmeq/YTBAIrDuIVzOc+IQylGvh9BOXDO5rsngHVnKU8j6Y
         vVmr7hUGPjLwlTmDb2FRHZ5v5BJuBxxfotikjdaISEfowRGi0tHe9JEVBB18E6Nxm5g6
         Sb36u66mflsrjasC2l98wIue29fs/jcEMe5yZP4h1DEF2XSXdF7pKmm8B3Cwa1RRIp5D
         vFB1ybtM2TMZO37SVSP2UiiK4H2oRLqZtjAoHmZ0HCYL9WkzjwJCTU/jyvrW0a7dd96p
         6nZZsx76dnlLz68e7CddtIJdFm9LFB4IiXJN02pnmdMzQANXcw5U9eoqza6jbFxe6Cza
         FCVg==
X-Gm-Message-State: AOAM531P5jY1iufJmRFBCLY5TQ5L96cU/pvupW1M2KJSJE3WZsno72KL
        YDdQRfeFt2iahd0KbeOvvom4COhjZAezFv3NezjB3QPJZ8Bb
X-Google-Smtp-Source: ABdhPJyGHuL4Dov0aHxVVLVx86Nly21B/3a6Tk8zto/xS0wRkFrz/kaFjEmfAh2y0ypj5R8aH0O961LgJO31b4kW7mabCKzeVKmZ
MIME-Version: 1.0
X-Received: by 2002:a92:9196:: with SMTP id e22mr11830117ill.147.1593689534378;
 Thu, 02 Jul 2020 04:32:14 -0700 (PDT)
Date:   Thu, 02 Jul 2020 04:32:14 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000943bd405a973c2d9@google.com>
Subject: KMSAN: uninit-value in __request_module (4)
From:   syzbot <syzbot+fe374551e2778b9ff407@syzkaller.appspotmail.com>
To:     glider@google.com, linux-kernel@vger.kernel.org, mcgrof@kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    f0d5ec90 kmsan: apply __no_sanitize_memory to dotraplinkag..
git tree:       https://github.com/google/kmsan.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=1194afad100000
kernel config:  https://syzkaller.appspot.com/x/.config?x=86e4f8af239686c6
dashboard link: https://syzkaller.appspot.com/bug?extid=fe374551e2778b9ff407
compiler:       clang version 10.0.0 (https://github.com/llvm/llvm-project/ c2443155a0fb245c8f17f2c1c72b6ea391e86e81)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+fe374551e2778b9ff407@syzkaller.appspotmail.com

=====================================================
BUG: KMSAN: uninit-value in string_nocheck lib/vsprintf.c:608 [inline]
BUG: KMSAN: uninit-value in string+0x522/0x690 lib/vsprintf.c:689
CPU: 0 PID: 4377 Comm: syz-executor.2 Not tainted 5.7.0-rc4-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x1c9/0x220 lib/dump_stack.c:118
 kmsan_report+0xf7/0x1e0 mm/kmsan/kmsan_report.c:121
 __msan_warning+0x58/0xa0 mm/kmsan/kmsan_instr.c:215
 string_nocheck lib/vsprintf.c:608 [inline]
 string+0x522/0x690 lib/vsprintf.c:689
 vsnprintf+0x207d/0x31b0 lib/vsprintf.c:2574
 __request_module+0x2ad/0x11d0 kernel/kmod.c:143
 crypto_larval_lookup crypto/api.c:230 [inline]
 crypto_alg_mod_lookup+0x24b/0xfa0 crypto/api.c:277
 crypto_has_alg+0x8a/0x270 crypto/api.c:574
 tipc_aead_key_validate+0x55/0x220 net/tipc/crypto.c:279
 __tipc_nl_node_set_key net/tipc/node.c:2834 [inline]
 tipc_nl_node_set_key+0x68f/0xcd0 net/tipc/node.c:2875
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
RIP: 0033:0x45cb19
Code: 0d b7 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 0f 83 db b6 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007fb137d74c78 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 0000000000501d80 RCX: 000000000045cb19
RDX: 0000000000000000 RSI: 0000000020000100 RDI: 0000000000000003
RBP: 000000000078bfa0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000ffffffff
R13: 0000000000000a1e R14: 00000000004ccff7 R15: 00007fb137d756d4

Uninit was created at:
 kmsan_save_stack_with_flags mm/kmsan/kmsan.c:144 [inline]
 kmsan_internal_poison_shadow+0x66/0xd0 mm/kmsan/kmsan.c:127
 kmsan_slab_alloc+0x8a/0xe0 mm/kmsan/kmsan_hooks.c:80
 slab_alloc_node mm/slub.c:2802 [inline]
 __kmalloc_node_track_caller+0xb40/0x1200 mm/slub.c:4436
 __kmalloc_reserve net/core/skbuff.c:142 [inline]
 __alloc_skb+0x2fd/0xac0 net/core/skbuff.c:210
 alloc_skb include/linux/skbuff.h:1083 [inline]
 netlink_alloc_large_skb net/netlink/af_netlink.c:1175 [inline]
 netlink_sendmsg+0x7d3/0x14d0 net/netlink/af_netlink.c:1893
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
