Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D992C10DCE
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 22:25:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37F93222C3
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 22:25:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727879AbgCJWZ3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 18:25:29 -0400
Received: from mail-io1-f70.google.com ([209.85.166.70]:57248 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726402AbgCJWZO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 18:25:14 -0400
Received: by mail-io1-f70.google.com with SMTP id d13so72261ioo.23
        for <linux-kernel@vger.kernel.org>; Tue, 10 Mar 2020 15:25:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=pwxpW3NBUVmj+UoYdVurtFn8Nyxv+AbJRGbT+7AEpyE=;
        b=gfGaYhlCid8XJU6c7uoWdfM4cQRWS/VzMz1AN16VfHjPQzw8HGdgMXxjyT/pGAozSn
         Qjqz/Cmuv9eiBo8RcYLWYZQWZ1isGRHThRau0iXVmljj1l5ndqJAUsw1FGXeZUjscNRX
         UWoVlbQGZ5/toHwDAtVMOe3MBGZ8NP64OvbiQiUqT067LUayyAxa8qNRz0UytWhlvuBV
         w0Hz0QkGjhLIDzFWEVFtX0iACl6nUNrTYPcW1aKvrhVV61/WMgZKUvThamxtToh/sFmy
         NNu6uKUnOZU24QDYEnYK629gI7HLJUEwpt2t+YiD6ZQI5lI1QoiLyl4heo+OhkTmIm4q
         zAYw==
X-Gm-Message-State: ANhLgQ2VmF7M+jEX/vescC8utguMukxt3pfkARgqRJPO0Rs76GoUVmAm
        D5WKhyKAXU4gKZaHWZQX+4fiB/mrN0c8MIY5dhTto5FgwgH7
X-Google-Smtp-Source: ADFU+vtDy2Va3R8twip7JqdT4MJFD0wlO1/9jpBe2KnPNfwBQy1Nkg7YqrxLsorf/tnjSvQN2/C55V2AT42QWEZmNYnAulcvty6u
MIME-Version: 1.0
X-Received: by 2002:a6b:7c04:: with SMTP id m4mr229092iok.208.1583879113019;
 Tue, 10 Mar 2020 15:25:13 -0700 (PDT)
Date:   Tue, 10 Mar 2020 15:25:13 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e6150305a08797cc@google.com>
Subject: KMSAN: uninit-value in tcf_exts_change
From:   syzbot <syzbot+a37cda34d2b8b740a5f1@syzkaller.appspotmail.com>
To:     davem@davemloft.net, glider@google.com, jhs@mojatatu.com,
        jiri@resnulli.us, kuba@kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        xiyou.wangcong@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    8bbbc5cf kmsan: don't compile memmove
git tree:       https://github.com/google/kmsan.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=144ec945e00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=cd0e9a6b0e555cc3
dashboard link: https://syzkaller.appspot.com/bug?extid=a37cda34d2b8b740a5f1
compiler:       clang version 10.0.0 (https://github.com/llvm/llvm-project/ c2443155a0fb245c8f17f2c1c72b6ea391e86e81)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=143669fde00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13208061e00000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+a37cda34d2b8b740a5f1@syzkaller.appspotmail.com

=====================================================
BUG: KMSAN: uninit-value in tcf_exts_destroy net/sched/cls_api.c:3000 [inline]
BUG: KMSAN: uninit-value in tcf_exts_change+0xc9/0xf0 net/sched/cls_api.c:3059
CPU: 1 PID: 11450 Comm: syz-executor413 Not tainted 5.6.0-rc2-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x1c9/0x220 lib/dump_stack.c:118
 kmsan_report+0xf7/0x1e0 mm/kmsan/kmsan_report.c:118
 __msan_warning+0x58/0xa0 mm/kmsan/kmsan_instr.c:215
 tcf_exts_destroy net/sched/cls_api.c:3000 [inline]
 tcf_exts_change+0xc9/0xf0 net/sched/cls_api.c:3059
 tcindex_set_parms net/sched/cls_tcindex.c:456 [inline]
 tcindex_change+0x2fe4/0x4130 net/sched/cls_tcindex.c:518
 tc_new_tfilter+0x31a8/0x4f40 net/sched/cls_api.c:2103
 rtnetlink_rcv_msg+0xcb7/0x1570 net/core/rtnetlink.c:5429
 netlink_rcv_skb+0x451/0x650 net/netlink/af_netlink.c:2477
 rtnetlink_rcv+0x50/0x60 net/core/rtnetlink.c:5456
 netlink_unicast_kernel net/netlink/af_netlink.c:1302 [inline]
 netlink_unicast+0xf9e/0x1100 net/netlink/af_netlink.c:1328
 netlink_sendmsg+0x1246/0x14d0 net/netlink/af_netlink.c:1917
 sock_sendmsg_nosec net/socket.c:652 [inline]
 sock_sendmsg net/socket.c:672 [inline]
 ____sys_sendmsg+0x12b6/0x1350 net/socket.c:2343
 ___sys_sendmsg net/socket.c:2397 [inline]
 __sys_sendmsg+0x451/0x5f0 net/socket.c:2430
 __do_sys_sendmsg net/socket.c:2439 [inline]
 __se_sys_sendmsg+0x97/0xb0 net/socket.c:2437
 __x64_sys_sendmsg+0x4a/0x70 net/socket.c:2437
 do_syscall_64+0xb8/0x160 arch/x86/entry/common.c:296
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x441829
Code: e8 2c e8 ff ff 48 83 c4 18 c3 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 0f 83 8b 09 fc ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007fff944e1698 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 0000000000441829
RDX: 0000000000000000 RSI: 00000000200001c0 RDI: 0000000000000003
RBP: 00000000004a2b10 R08: 0000000120080522 R09: 0000000120080522
R10: 0000000120080522 R11: 0000000000000246 R12: 0000000000402640
R13: 00000000004026d0 R14: 0000000000000000 R15: 0000000000000000

Uninit was created at:
 kmsan_save_stack_with_flags+0x3c/0x90 mm/kmsan/kmsan.c:144
 kmsan_internal_alloc_meta_for_pages mm/kmsan/kmsan_shadow.c:307 [inline]
 kmsan_alloc_page+0x12a/0x310 mm/kmsan/kmsan_shadow.c:336
 __alloc_pages_nodemask+0x5712/0x5e80 mm/page_alloc.c:4775
 alloc_pages_current+0x67d/0x990 mm/mempolicy.c:2211
 alloc_pages include/linux/gfp.h:534 [inline]
 alloc_slab_page+0x111/0x12f0 mm/slub.c:1530
 allocate_slab mm/slub.c:1675 [inline]
 new_slab+0x2bc/0x1130 mm/slub.c:1741
 new_slab_objects mm/slub.c:2492 [inline]
 ___slab_alloc+0x1533/0x1f30 mm/slub.c:2643
 __slab_alloc mm/slub.c:2683 [inline]
 slab_alloc_node mm/slub.c:2757 [inline]
 slab_alloc mm/slub.c:2802 [inline]
 kmem_cache_alloc_trace+0xb0a/0xd70 mm/slub.c:2819
 kmalloc include/linux/slab.h:555 [inline]
 kzalloc include/linux/slab.h:669 [inline]
 tcindex_set_parms net/sched/cls_tcindex.c:325 [inline]
 tcindex_change+0x5bd/0x4130 net/sched/cls_tcindex.c:518
 tc_new_tfilter+0x31a8/0x4f40 net/sched/cls_api.c:2103
 rtnetlink_rcv_msg+0xcb7/0x1570 net/core/rtnetlink.c:5429
 netlink_rcv_skb+0x451/0x650 net/netlink/af_netlink.c:2477
 rtnetlink_rcv+0x50/0x60 net/core/rtnetlink.c:5456
 netlink_unicast_kernel net/netlink/af_netlink.c:1302 [inline]
 netlink_unicast+0xf9e/0x1100 net/netlink/af_netlink.c:1328
 netlink_sendmsg+0x1246/0x14d0 net/netlink/af_netlink.c:1917
 sock_sendmsg_nosec net/socket.c:652 [inline]
 sock_sendmsg net/socket.c:672 [inline]
 ____sys_sendmsg+0x12b6/0x1350 net/socket.c:2343
 ___sys_sendmsg net/socket.c:2397 [inline]
 __sys_sendmsg+0x451/0x5f0 net/socket.c:2430
 __do_sys_sendmsg net/socket.c:2439 [inline]
 __se_sys_sendmsg+0x97/0xb0 net/socket.c:2437
 __x64_sys_sendmsg+0x4a/0x70 net/socket.c:2437
 do_syscall_64+0xb8/0x160 arch/x86/entry/common.c:296
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
