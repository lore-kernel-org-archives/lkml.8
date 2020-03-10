Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0D88C10F27
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 22:25:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94F47222C3
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 22:25:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727870AbgCJWZT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 18:25:19 -0400
Received: from mail-io1-f72.google.com ([209.85.166.72]:57252 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727733AbgCJWZQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 18:25:16 -0400
Received: by mail-io1-f72.google.com with SMTP id d13so72280ioo.23
        for <linux-kernel@vger.kernel.org>; Tue, 10 Mar 2020 15:25:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=iMEYVslbplYNLdReSoQGq40tgBRv5wh9xhPpnbQxrBw=;
        b=o66aRxpa3Q0IARVt/y+Fka5wiM/ZRnw0rnsc/WEl6ExKwHl2jIqZq8sESWdTehfqhL
         bwu+t0sQGu4hB7if3XFJL60du4Q7Ov3HAjs4bX/vIYZ1dLpKrXsKEuC8Adc/U20mPT/O
         f24ojFFxpGNQyge14cBOL3n4MoH3HxcWMSGlRItxrVR3ugixsXXO52b6MYfuQPKWy/d9
         1RFoBPoPs+TVNvsqSdPyzx+DWGlL+TtVNGog0m2J0Kctdqbz1ophynu35ypzR3WI093S
         DU6KFqO8C79eJRSAsc+dHtUiJQsd+aswxtRgri5vpExRya+EVY2a9bx1FrLFZpkTjVIG
         hjzw==
X-Gm-Message-State: ANhLgQ1anN7Tb2XnhCI4K1qNhhU7O2XEh2g69dOlfeaw0Mx3mcmoFAqm
        QJlYvtPWxlCliZDUCGPfgfdmUMZxsy0P47uQXLijcGYl/1ya
X-Google-Smtp-Source: ADFU+vta+XD7p0+MhslnsH4SQZfIU0+2oBYDLLzrj4f3mx115yDR394mdF7imKHmUk2nB8EZU3DcSc5I5TqT+a4R2u6Gyv6WCYgD
MIME-Version: 1.0
X-Received: by 2002:a92:41c7:: with SMTP id o190mr246126ila.11.1583879113643;
 Tue, 10 Mar 2020 15:25:13 -0700 (PDT)
Date:   Tue, 10 Mar 2020 15:25:13 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000efa06005a0879722@google.com>
Subject: KASAN: use-after-free Read in tcindex_dump
From:   syzbot <syzbot+653090db2562495901dc@syzkaller.appspotmail.com>
To:     davem@davemloft.net, jhs@mojatatu.com, jiri@resnulli.us,
        kuba@kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        xiyou.wangcong@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    c2003765 Merge tag 'io_uring-5.6-2020-03-07' of git://git...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1275b731e00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4527d1e2fb19fd5c
dashboard link: https://syzkaller.appspot.com/bug?extid=653090db2562495901dc
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1180ff29e00000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+653090db2562495901dc@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: use-after-free in tcindex_dump+0xb6e/0xc20 net/sched/cls_tcindex.c:637
Read of size 8 at addr ffff88807ebd0020 by task syz-executor.3/10006

CPU: 0 PID: 10006 Comm: syz-executor.3 Not tainted 5.6.0-rc4-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x188/0x20d lib/dump_stack.c:118
 print_address_description.constprop.0.cold+0xd3/0x315 mm/kasan/report.c:374
 __kasan_report.cold+0x1a/0x32 mm/kasan/report.c:506
 kasan_report+0xe/0x20 mm/kasan/common.c:641
 tcindex_dump+0xb6e/0xc20 net/sched/cls_tcindex.c:637
 tcf_fill_node+0x572/0x930 net/sched/cls_api.c:1814
 tfilter_notify+0x139/0x2a0 net/sched/cls_api.c:1840
 tc_new_tfilter+0xab2/0x20b0 net/sched/cls_api.c:2107
 rtnetlink_rcv_msg+0x810/0xad0 net/core/rtnetlink.c:5427
 netlink_rcv_skb+0x15a/0x410 net/netlink/af_netlink.c:2478
 netlink_unicast_kernel net/netlink/af_netlink.c:1303 [inline]
 netlink_unicast+0x537/0x740 net/netlink/af_netlink.c:1329
 netlink_sendmsg+0x882/0xe10 net/netlink/af_netlink.c:1918
 sock_sendmsg_nosec net/socket.c:652 [inline]
 sock_sendmsg+0xcf/0x120 net/socket.c:672
 ____sys_sendmsg+0x6b9/0x7d0 net/socket.c:2343
 ___sys_sendmsg+0x100/0x170 net/socket.c:2397
 __sys_sendmsg+0xec/0x1b0 net/socket.c:2430
 do_syscall_64+0xf6/0x7d0 arch/x86/entry/common.c:294
 entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x45c4a9
Code: ad b6 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 0f 83 7b b6 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007fb7e5f98c78 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00007fb7e5f996d4 RCX: 000000000045c4a9
RDX: 0000000000000000 RSI: 00000000200001c0 RDI: 0000000000000004
RBP: 000000000076bfc0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000ffffffff
R13: 00000000000009fa R14: 00000000004cc777 R15: 000000000076bfcc

Allocated by task 10000:
 save_stack+0x1b/0x80 mm/kasan/common.c:72
 set_track mm/kasan/common.c:80 [inline]
 __kasan_kmalloc mm/kasan/common.c:515 [inline]
 __kasan_kmalloc.constprop.0+0xbf/0xd0 mm/kasan/common.c:488
 __do_kmalloc mm/slab.c:3656 [inline]
 __kmalloc+0x161/0x7a0 mm/slab.c:3665
 kmalloc_array include/linux/slab.h:597 [inline]
 kcalloc include/linux/slab.h:608 [inline]
 tcindex_alloc_perfect_hash+0x5a/0x320 net/sched/cls_tcindex.c:281
 tcindex_set_parms+0x1568/0x1a00 net/sched/cls_tcindex.c:405
 tcindex_change+0x203/0x2e0 net/sched/cls_tcindex.c:518
 tc_new_tfilter+0xa59/0x20b0 net/sched/cls_api.c:2103
 rtnetlink_rcv_msg+0x810/0xad0 net/core/rtnetlink.c:5427
 netlink_rcv_skb+0x15a/0x410 net/netlink/af_netlink.c:2478
 netlink_unicast_kernel net/netlink/af_netlink.c:1303 [inline]
 netlink_unicast+0x537/0x740 net/netlink/af_netlink.c:1329
 netlink_sendmsg+0x882/0xe10 net/netlink/af_netlink.c:1918
 sock_sendmsg_nosec net/socket.c:652 [inline]
 sock_sendmsg+0xcf/0x120 net/socket.c:672
 ____sys_sendmsg+0x6b9/0x7d0 net/socket.c:2343
 ___sys_sendmsg+0x100/0x170 net/socket.c:2397
 __sys_sendmsg+0xec/0x1b0 net/socket.c:2430
 do_syscall_64+0xf6/0x7d0 arch/x86/entry/common.c:294
 entry_SYSCALL_64_after_hwframe+0x49/0xbe

Freed by task 262:
 save_stack+0x1b/0x80 mm/kasan/common.c:72
 set_track mm/kasan/common.c:80 [inline]
 kasan_set_free_info mm/kasan/common.c:337 [inline]
 __kasan_slab_free+0xf7/0x140 mm/kasan/common.c:476
 __cache_free mm/slab.c:3426 [inline]
 kfree+0x109/0x2b0 mm/slab.c:3757
 tcindex_partial_destroy_work+0x2e/0x50 net/sched/cls_tcindex.c:264
 process_one_work+0x94b/0x1690 kernel/workqueue.c:2264
 worker_thread+0x96/0xe20 kernel/workqueue.c:2410
 kthread+0x357/0x430 kernel/kthread.c:255
 ret_from_fork+0x24/0x30 arch/x86/entry/entry_64.S:352

The buggy address belongs to the object at ffff88807ebd0000
 which belongs to the cache kmalloc-16k of size 16384
The buggy address is located 32 bytes inside of
 16384-byte region [ffff88807ebd0000, ffff88807ebd4000)
The buggy address belongs to the page:
page:ffffea0001faf400 refcount:1 mapcount:0 mapping:ffff8880aa002380 index:0x0 compound_mapcount: 0
flags: 0xfffe0000010200(slab|head)
raw: 00fffe0000010200 ffffea0001faf208 ffffea0001faf608 ffff8880aa002380
raw: 0000000000000000 ffff88807ebd0000 0000000100000001 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
 ffff88807ebcff00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff88807ebcff80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
