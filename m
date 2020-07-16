Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03B6FC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 18:08:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D34722070E
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 18:08:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728947AbgGPSIY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 14:08:24 -0400
Received: from mail-io1-f72.google.com ([209.85.166.72]:54016 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728257AbgGPSIX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 14:08:23 -0400
Received: by mail-io1-f72.google.com with SMTP id g11so4083969ioc.20
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jul 2020 11:08:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=SyFRYH38AbxdGG8YhsFqsJe3A32MYR05LhqTmyXFUfw=;
        b=OosKtw80rt32Gi8h6PVL5vrskLFSOLvs+RniU5mdCeNuWxwyi22RJ5rFjvrADS65qa
         +96FVO+X6Eb7QvVzkBSzWNItoDmlGUM91O472Sb47Hw6Q1R4j9amzYCKZ0OviOkZHu+7
         wIkizxHc7fouwVJlK0W7lX/T5vQuQflV6ZGKWHdxns4rmA1Cz7tvj5/666dTpAEyrjC9
         hzcRaqxlGXNbM8IK/xe0W7FOSDiFmGbJosn4roWE6xmmffOX7QgcJTSO17F2ZV2Qaen1
         GofW9nNbjJLNHHFU5aUF4Yfb+HsqkWnPl8zEYxlR/kXOXm0fsODSHgJJCflnfdgQQ6Da
         5MoQ==
X-Gm-Message-State: AOAM532ZghLUkSOF2IOr74Y2fBwupTUnKhhJ7ZLGAbe2/FW/0bvIPmvE
        JAByLITGZZAkMTY85R+whfMcpuE7OWGFuuKqhlU6Mpyimfxf
X-Google-Smtp-Source: ABdhPJzdNygBUlghhbz34SGcB/qFOaqeRDNmtEri0Ca8NWCM4Y243yX7jWgBfk5QpfDvKUWveqk2ycvIPiY9cs4Sb3HdEYTeTfxU
MIME-Version: 1.0
X-Received: by 2002:a92:8b51:: with SMTP id i78mr5564034ild.179.1594922900973;
 Thu, 16 Jul 2020 11:08:20 -0700 (PDT)
Date:   Thu, 16 Jul 2020 11:08:20 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f4ef6a05aa92ec6c@google.com>
Subject: KASAN: slab-out-of-bounds Read in get_block
From:   syzbot <syzbot+7d3e463b43b093527e84@syzkaller.appspotmail.com>
To:     danarag@gmail.com, jack@suse.cz, linux-kernel@vger.kernel.org,
        pombredanne@nexb.com, syzkaller-bugs@googlegroups.com,
        tglx@linutronix.de, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    0aea6d5c Merge tag 'for-linus-5.8b-rc5-tag' of git://git.k..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=14af114f100000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b1a5a263f7a540cb
dashboard link: https://syzkaller.appspot.com/bug?extid=7d3e463b43b093527e84
compiler:       clang version 10.0.0 (https://github.com/llvm/llvm-project/ c2443155a0fb245c8f17f2c1c72b6ea391e86e81)

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+7d3e463b43b093527e84@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-out-of-bounds in add_chain fs/minix/itree_common.c:14 [inline]
BUG: KASAN: slab-out-of-bounds in get_branch fs/minix/itree_common.c:52 [inline]
BUG: KASAN: slab-out-of-bounds in get_block+0x69a/0x1600 fs/minix/itree_common.c:160
Read of size 2 at addr ffff8880a91b018a by task syz-executor.1/28305

CPU: 0 PID: 28305 Comm: syz-executor.1 Not tainted 5.8.0-rc4-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x1f0/0x31e lib/dump_stack.c:118
 print_address_description+0x66/0x5a0 mm/kasan/report.c:383
 __kasan_report mm/kasan/report.c:513 [inline]
 kasan_report+0x132/0x1d0 mm/kasan/report.c:530
 add_chain fs/minix/itree_common.c:14 [inline]
 get_branch fs/minix/itree_common.c:52 [inline]
 get_block+0x69a/0x1600 fs/minix/itree_common.c:160
 __block_write_begin_int+0x708/0x1a00 fs/buffer.c:2012
 __block_write_begin fs/buffer.c:2062 [inline]
 block_write_begin+0x59/0x280 fs/buffer.c:2121
 minix_write_begin+0x38/0x1f0 fs/minix/inode.c:412
 generic_perform_write+0x23b/0x4e0 mm/filemap.c:3318
 __generic_file_write_iter+0x22b/0x4e0 mm/filemap.c:3447
 generic_file_write_iter+0x4a6/0x650 mm/filemap.c:3479
 call_write_iter include/linux/fs.h:1908 [inline]
 new_sync_write fs/read_write.c:503 [inline]
 __kernel_write+0x85b/0xa60 fs/read_write.c:530
 do_acct_process+0xec6/0x12b0 kernel/acct.c:522
 slow_acct_process kernel/acct.c:581 [inline]
 acct_process+0x398/0x4a0 kernel/acct.c:607
 do_exit+0x593/0x1f80 kernel/exit.c:795
 do_group_exit+0x161/0x2d0 kernel/exit.c:903
 get_signal+0x139b/0x1d30 kernel/signal.c:2743
 do_signal+0x33/0x610 arch/x86/kernel/signal.c:810
 exit_to_usermode_loop arch/x86/entry/common.c:235 [inline]
 __prepare_exit_to_usermode+0xd7/0x1e0 arch/x86/entry/common.c:269
 do_syscall_64+0x7f/0xe0 arch/x86/entry/common.c:393
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x45cba9
Code: Bad RIP value.
RSP: 002b:00007f0364adcc78 EFLAGS: 00000246 ORIG_RAX: 00000000000000a3
RAX: 0000000000000000 RBX: 00000000004da400 RCX: 000000000045cba9
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000020000480
RBP: 000000000078bfa0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000ffffffff
R13: 000000000000001c R14: 00000000004c2f71 R15: 00007f0364add6d4

Allocated by task 28189:
 save_stack mm/kasan/common.c:48 [inline]
 set_track mm/kasan/common.c:56 [inline]
 __kasan_kmalloc+0x103/0x140 mm/kasan/common.c:494
 slab_post_alloc_hook mm/slab.h:586 [inline]
 slab_alloc mm/slab.c:3320 [inline]
 kmem_cache_alloc+0x1f5/0x2d0 mm/slab.c:3484
 skb_clone+0x1b2/0x370 net/core/skbuff.c:1447
 __netlink_deliver_tap_skb net/netlink/af_netlink.c:287 [inline]
 __netlink_deliver_tap net/netlink/af_netlink.c:312 [inline]
 netlink_deliver_tap+0x478/0x810 net/netlink/af_netlink.c:325
 netlink_deliver_tap_kernel net/netlink/af_netlink.c:334 [inline]
 netlink_unicast_kernel net/netlink/af_netlink.c:1302 [inline]
 netlink_unicast+0x75c/0x940 net/netlink/af_netlink.c:1329
 netlink_sendmsg+0xa57/0xd70 net/netlink/af_netlink.c:1918
 sock_sendmsg_nosec net/socket.c:652 [inline]
 sock_sendmsg net/socket.c:672 [inline]
 ____sys_sendmsg+0x519/0x800 net/socket.c:2352
 ___sys_sendmsg net/socket.c:2406 [inline]
 __sys_sendmmsg+0x45b/0x680 net/socket.c:2496
 __do_sys_sendmmsg net/socket.c:2525 [inline]
 __se_sys_sendmmsg net/socket.c:2522 [inline]
 __x64_sys_sendmmsg+0x9c/0xb0 net/socket.c:2522
 do_syscall_64+0x73/0xe0 arch/x86/entry/common.c:384
 entry_SYSCALL_64_after_hwframe+0x44/0xa9

Freed by task 28189:
 save_stack mm/kasan/common.c:48 [inline]
 set_track mm/kasan/common.c:56 [inline]
 kasan_set_free_info mm/kasan/common.c:316 [inline]
 __kasan_slab_free+0x114/0x170 mm/kasan/common.c:455
 __cache_free mm/slab.c:3426 [inline]
 kmem_cache_free+0x7e/0xf0 mm/slab.c:3694
 nlmon_xmit+0x8d/0xb0 drivers/net/nlmon.c:14
 __netdev_start_xmit include/linux/netdevice.h:4611 [inline]
 netdev_start_xmit include/linux/netdevice.h:4625 [inline]
 xmit_one net/core/dev.c:3556 [inline]
 dev_hard_start_xmit+0x1bd/0x3d0 net/core/dev.c:3572
 __dev_queue_xmit+0x1bda/0x2940 net/core/dev.c:4131
 __netlink_deliver_tap_skb net/netlink/af_netlink.c:294 [inline]
 __netlink_deliver_tap net/netlink/af_netlink.c:312 [inline]
 netlink_deliver_tap+0x5be/0x810 net/netlink/af_netlink.c:325
 netlink_deliver_tap_kernel net/netlink/af_netlink.c:334 [inline]
 netlink_unicast_kernel net/netlink/af_netlink.c:1302 [inline]
 netlink_unicast+0x75c/0x940 net/netlink/af_netlink.c:1329
 netlink_sendmsg+0xa57/0xd70 net/netlink/af_netlink.c:1918
 sock_sendmsg_nosec net/socket.c:652 [inline]
 sock_sendmsg net/socket.c:672 [inline]
 ____sys_sendmsg+0x519/0x800 net/socket.c:2352
 ___sys_sendmsg net/socket.c:2406 [inline]
 __sys_sendmmsg+0x45b/0x680 net/socket.c:2496
 __do_sys_sendmmsg net/socket.c:2525 [inline]
 __se_sys_sendmmsg net/socket.c:2522 [inline]
 __x64_sys_sendmmsg+0x9c/0xb0 net/socket.c:2522
 do_syscall_64+0x73/0xe0 arch/x86/entry/common.c:384
 entry_SYSCALL_64_after_hwframe+0x44/0xa9

The buggy address belongs to the object at ffff8880a91b0080
 which belongs to the cache skbuff_head_cache of size 224
The buggy address is located 42 bytes to the right of
 224-byte region [ffff8880a91b0080, ffff8880a91b0160)
The buggy address belongs to the page:
page:ffffea0002a46c00 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0
flags: 0xfffe0000000200(slab)
raw: 00fffe0000000200 ffffea00024781c8 ffffea00012e3688 ffff88821bb6b700
raw: 0000000000000000 ffff8880a91b0080 000000010000000c 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
 ffff8880a91b0080: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff8880a91b0100: fb fb fb fb fb fb fb fb fb fb fb fb fc fc fc fc
>ffff8880a91b0180: fc fc fc fc fc fc fc fc fb fb fb fb fb fb fb fb
                      ^
 ffff8880a91b0200: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff8880a91b0280: fb fb fb fb fc fc fc fc fc fc fc fc fc fc fc fc
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
