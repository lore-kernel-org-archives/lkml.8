Return-Path: <SRS0=KWFo=BR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF6D7C433E1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 07:07:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C2DDD20866
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 07:07:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726615AbgHGHH3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Aug 2020 03:07:29 -0400
Received: from mail-io1-f71.google.com ([209.85.166.71]:38801 "EHLO
        mail-io1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726249AbgHGHHR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Aug 2020 03:07:17 -0400
Received: by mail-io1-f71.google.com with SMTP id a65so984869iog.5
        for <linux-kernel@vger.kernel.org>; Fri, 07 Aug 2020 00:07:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=p96+8eivvECQ6gB2pMJM1gOA5q/X+IfS62pER3Ikwjc=;
        b=HeBF/ZvJOnxtEDOnoTTNL09AKAV21608Rmi7YVKeUozO9A2qxAB2F7CBngJc6AlQ0B
         sFguHK0Bv2uaYkEoXkNm8RvokGkAdhcR3DJRD9kUby06hgLdKk0OjqMkQf7y3KLwxpHu
         gkb57rTFBiRwCWvG4uatFWEUfBff4uNvDjrK4Kxq44xbA/7bFAAly+6eokOkI3jZtP8o
         Xh67ACvRTSNRT7iVlek4QCVSaKbEImwt7Cpks+jUBXH/Rfi30gI5RRhWm+/eovapFse4
         p+iLe+IH1XUAmvnThIFceJ9UV7+yLx9gVZlKLq1JjyluNQzNbb6M/CqknjWsp7NNLJWN
         GRzQ==
X-Gm-Message-State: AOAM532J49aLyK7AMzQuLtvcL9W8V62Tq8ZKJxNuhIEGFi9w9jDQ73sz
        n7QMbsCVQt+8B4ESgCOkQW1mc5BzF74atovDd30CeHsjNmw5
X-Google-Smtp-Source: ABdhPJzPfM2I+0d4pil+xyqfPnF98jniuzjJF0QmomQhPU/65w25n4YTGgrl360bm+CiGfgLQKcPazPb12i/mr3E0/o+gbbhMkJl
MIME-Version: 1.0
X-Received: by 2002:a02:b610:: with SMTP id h16mr3429002jam.74.1596784036494;
 Fri, 07 Aug 2020 00:07:16 -0700 (PDT)
Date:   Fri, 07 Aug 2020 00:07:16 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000004740cd05ac444126@google.com>
Subject: KASAN: use-after-free Write in afs_manage_cell
From:   syzbot <syzbot+f59c67285cb61166a0cf@syzkaller.appspotmail.com>
To:     dhowells@redhat.com, linux-afs@lists.infradead.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    fffe3ae0 Merge tag 'for-linus-hmm' of git://git.kernel.org..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1053efea900000
kernel config:  https://syzkaller.appspot.com/x/.config?x=18bb86f2e4ebfda2
dashboard link: https://syzkaller.appspot.com/bug?extid=f59c67285cb61166a0cf
compiler:       gcc (GCC) 10.1.0-syz 20200507

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+f59c67285cb61166a0cf@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: use-after-free in afs_activate_cell fs/afs/cell.c:626 [inline]
BUG: KASAN: use-after-free in afs_manage_cell+0xf72/0x11c0 fs/afs/cell.c:697
Write of size 8 at addr ffff88808ecf5888 by task kworker/1:2/2576

CPU: 1 PID: 2576 Comm: kworker/1:2 Not tainted 5.8.0-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Workqueue: afs afs_manage_cell
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x18f/0x20d lib/dump_stack.c:118
 print_address_description.constprop.0.cold+0xae/0x436 mm/kasan/report.c:383
 __kasan_report mm/kasan/report.c:513 [inline]
 kasan_report.cold+0x1f/0x37 mm/kasan/report.c:530
 afs_activate_cell fs/afs/cell.c:626 [inline]
 afs_manage_cell+0xf72/0x11c0 fs/afs/cell.c:697
 process_one_work+0x94c/0x1670 kernel/workqueue.c:2269
 worker_thread+0x64c/0x1120 kernel/workqueue.c:2415
 kthread+0x3b5/0x4a0 kernel/kthread.c:292
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:294

Allocated by task 16538:
 save_stack+0x1b/0x40 mm/kasan/common.c:48
 set_track mm/kasan/common.c:56 [inline]
 __kasan_kmalloc.constprop.0+0xc2/0xd0 mm/kasan/common.c:494
 kmem_cache_alloc_trace+0x14f/0x2d0 mm/slab.c:3551
 kmalloc include/linux/slab.h:555 [inline]
 kzalloc include/linux/slab.h:669 [inline]
 afs_alloc_cell fs/afs/cell.c:151 [inline]
 afs_lookup_cell+0x5c8/0x1440 fs/afs/cell.c:262
 afs_parse_source fs/afs/super.c:290 [inline]
 afs_parse_param+0x404/0x8c0 fs/afs/super.c:326
 vfs_parse_fs_param fs/fs_context.c:117 [inline]
 vfs_parse_fs_param+0x203/0x550 fs/fs_context.c:98
 vfs_parse_fs_string+0xe6/0x150 fs/fs_context.c:161
 do_new_mount fs/namespace.c:2869 [inline]
 do_mount+0x658/0x1fe0 fs/namespace.c:3200
 __do_sys_mount fs/namespace.c:3410 [inline]
 __se_sys_mount fs/namespace.c:3387 [inline]
 __x64_sys_mount+0x18f/0x230 fs/namespace.c:3387
 do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x44/0xa9

Freed by task 7033:
 save_stack+0x1b/0x40 mm/kasan/common.c:48
 set_track mm/kasan/common.c:56 [inline]
 kasan_set_free_info mm/kasan/common.c:316 [inline]
 __kasan_slab_free+0xf5/0x140 mm/kasan/common.c:455
 __cache_free mm/slab.c:3426 [inline]
 kfree+0x103/0x2c0 mm/slab.c:3757
 rcu_do_batch kernel/rcu/tree.c:2427 [inline]
 rcu_core+0x5c7/0x1190 kernel/rcu/tree.c:2655
 __do_softirq+0x2de/0xa24 kernel/softirq.c:298

The buggy address belongs to the object at ffff88808ecf5800
 which belongs to the cache kmalloc-1k of size 1024
The buggy address is located 136 bytes inside of
 1024-byte region [ffff88808ecf5800, ffff88808ecf5c00)
The buggy address belongs to the page:
page:ffffea00023b3d40 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0
flags: 0xfffe0000000200(slab)
raw: 00fffe0000000200 ffffea0002896a48 ffffea0002784e88 ffff8880aa000c40
raw: 0000000000000000 ffff88808ecf5000 0000000100000002 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
 ffff88808ecf5780: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff88808ecf5800: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff88808ecf5880: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                      ^
 ffff88808ecf5900: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff88808ecf5980: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
