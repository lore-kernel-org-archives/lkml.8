Return-Path: <SRS0=kGB5=CE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C576DC433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 09:45:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A9D172075E
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 09:45:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728146AbgHZJpZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 05:45:25 -0400
Received: from mail-io1-f72.google.com ([209.85.166.72]:50969 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727997AbgHZJpY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 05:45:24 -0400
Received: by mail-io1-f72.google.com with SMTP id k5so807801ion.17
        for <linux-kernel@vger.kernel.org>; Wed, 26 Aug 2020 02:45:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=q/7ocUNH5mLEq3j+e5woEg/rsb9z62OrfWAwmq04S0A=;
        b=mbUVKG2/DP8Tl2qiEJda6eAeX80LTUjtA8av2dhyjcXLoerBWnIBPPADdwV2zhBW1b
         SlR6IvHXGHjAAwWRQO5k7gwMtkGc25CDyJP+j6LBJHKJVV4a7Ijdnf5ov2B9iKuAaqe5
         edykzhj4j0EVVciHW9nggsXVngHcQJjWRjHhVHFcs4exJyA9UuQlNDL12VRDN2JhxvD+
         YGW09fEzUzgXFL3p5q14vo0Qsq1bleaBSjKV4KbvBKuq4gbtahQ5bnMn25Y48Phzuv8M
         tIQBLebNswLjjw3kmobqpj0NONpF8USpPZRNW9Gs17a3SRcEsA15us2s2k7uQsPj1yQD
         C2mQ==
X-Gm-Message-State: AOAM530NoPJQKQJ75XvZ3Ya5TNVC1JCfIiFYYxYoNDmnyB459AezSGBT
        O6XYz4djUPeYfkWW+y0Tfi1+tMosu2mqhOnuhXTYZ9/QMlQQ
X-Google-Smtp-Source: ABdhPJwHa3KVPBf0oGqqk3tmVJwkGx9N4v76LvBeVbExuNvGQpSYbZHnuaPyBLhvC2KjK904/iLwGMjLYMIJlqSDS6DM3YkY+3Ez
MIME-Version: 1.0
X-Received: by 2002:a6b:fd13:: with SMTP id c19mr11286158ioi.93.1598435122908;
 Wed, 26 Aug 2020 02:45:22 -0700 (PDT)
Date:   Wed, 26 Aug 2020 02:45:22 -0700
In-Reply-To: <0000000000004740cd05ac444126@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b2941205adc4ad44@google.com>
Subject: Re: KASAN: use-after-free Write in afs_manage_cell
From:   syzbot <syzbot+f59c67285cb61166a0cf@syzkaller.appspotmail.com>
To:     dhowells@redhat.com, linux-afs@lists.infradead.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has found a reproducer for the following issue on:

HEAD commit:    abb3438d Merge tag 'm68knommu-for-v5.9-rc3' of git://git.k..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1753522e900000
kernel config:  https://syzkaller.appspot.com/x/.config?x=978db74cb30aa994
dashboard link: https://syzkaller.appspot.com/bug?extid=f59c67285cb61166a0cf
compiler:       gcc (GCC) 10.1.0-syz 20200507
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13a9888e900000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=157cb346900000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+f59c67285cb61166a0cf@syzkaller.appspotmail.com

FS-Cache: N-cookie c=00000000a6a6ef54 [p=000000005b0520e2 fl=2 nc=0 na=1]
FS-Cache: N-cookie d=00000000a15022ee n=0000000040eaeaa1
FS-Cache: N-key=[5] '23ee2ea1fb'
==================================================================
BUG: KASAN: use-after-free in afs_activate_cell fs/afs/cell.c:609 [inline]
BUG: KASAN: use-after-free in afs_manage_cell+0xea0/0x11c0 fs/afs/cell.c:697
Write of size 8 at addr ffff888098036890 by task kworker/0:0/5

CPU: 0 PID: 5 Comm: kworker/0:0 Not tainted 5.9.0-rc2-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Workqueue: afs afs_manage_cell
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x18f/0x20d lib/dump_stack.c:118
 print_address_description.constprop.0.cold+0xae/0x497 mm/kasan/report.c:383
 __kasan_report mm/kasan/report.c:513 [inline]
 kasan_report.cold+0x1f/0x37 mm/kasan/report.c:530
 afs_activate_cell fs/afs/cell.c:609 [inline]
 afs_manage_cell+0xea0/0x11c0 fs/afs/cell.c:697
 process_one_work+0x94c/0x1670 kernel/workqueue.c:2269
 worker_thread+0x64c/0x1120 kernel/workqueue.c:2415
 kthread+0x3b5/0x4a0 kernel/kthread.c:292
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:294

Allocated by task 8859:
 kasan_save_stack+0x1b/0x40 mm/kasan/common.c:48
 kasan_set_track mm/kasan/common.c:56 [inline]
 __kasan_kmalloc.constprop.0+0xbf/0xd0 mm/kasan/common.c:461
 kmem_cache_alloc_trace+0x16e/0x2c0 mm/slab.c:3550
 kmalloc include/linux/slab.h:554 [inline]
 kzalloc include/linux/slab.h:666 [inline]
 afs_alloc_cell fs/afs/cell.c:151 [inline]
 afs_lookup_cell+0x5c8/0x1440 fs/afs/cell.c:262
 afs_parse_source fs/afs/super.c:290 [inline]
 afs_parse_param+0x404/0x8c0 fs/afs/super.c:326
 vfs_parse_fs_param fs/fs_context.c:117 [inline]
 vfs_parse_fs_param+0x203/0x550 fs/fs_context.c:98
 vfs_parse_fs_string+0xe6/0x150 fs/fs_context.c:161
 generic_parse_monolithic+0x16f/0x1f0 fs/fs_context.c:201
 do_new_mount fs/namespace.c:2871 [inline]
 path_mount+0x133f/0x2070 fs/namespace.c:3192
 do_mount fs/namespace.c:3205 [inline]
 __do_sys_mount fs/namespace.c:3413 [inline]
 __se_sys_mount fs/namespace.c:3390 [inline]
 __x64_sys_mount+0x27f/0x300 fs/namespace.c:3390
 do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x44/0xa9

Freed by task 3903:
 kasan_save_stack+0x1b/0x40 mm/kasan/common.c:48
 kasan_set_track+0x1c/0x30 mm/kasan/common.c:56
 kasan_set_free_info+0x1b/0x30 mm/kasan/generic.c:355
 __kasan_slab_free+0xd8/0x120 mm/kasan/common.c:422
 __cache_free mm/slab.c:3418 [inline]
 kfree+0x103/0x2c0 mm/slab.c:3756
 rcu_do_batch kernel/rcu/tree.c:2428 [inline]
 rcu_core+0x5c7/0x1190 kernel/rcu/tree.c:2656
 __do_softirq+0x2de/0xa24 kernel/softirq.c:298

Last call_rcu():
 kasan_save_stack+0x1b/0x40 mm/kasan/common.c:48
 kasan_record_aux_stack+0x82/0xb0 mm/kasan/generic.c:346
 __call_rcu kernel/rcu/tree.c:2894 [inline]
 call_rcu+0x14f/0x7e0 kernel/rcu/tree.c:2968
 afs_manage_cell+0x250/0x11c0 fs/afs/cell.c:751
 process_one_work+0x94c/0x1670 kernel/workqueue.c:2269
 worker_thread+0x64c/0x1120 kernel/workqueue.c:2415
 kthread+0x3b5/0x4a0 kernel/kthread.c:292
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:294

Second to last call_rcu():
 kasan_save_stack+0x1b/0x40 mm/kasan/common.c:48
 kasan_record_aux_stack+0x82/0xb0 mm/kasan/generic.c:346
 __call_rcu kernel/rcu/tree.c:2894 [inline]
 call_rcu+0x14f/0x7e0 kernel/rcu/tree.c:2968
 afs_manage_cell+0x250/0x11c0 fs/afs/cell.c:751
 process_one_work+0x94c/0x1670 kernel/workqueue.c:2269
 worker_thread+0x64c/0x1120 kernel/workqueue.c:2415
 kthread+0x3b5/0x4a0 kernel/kthread.c:292
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:294

The buggy address belongs to the object at ffff888098036800
 which belongs to the cache kmalloc-1k of size 1024
The buggy address is located 144 bytes inside of
 1024-byte region [ffff888098036800, ffff888098036c00)
The buggy address belongs to the page:
page:00000000a84846b4 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x98036
flags: 0xfffe0000000200(slab)
raw: 00fffe0000000200 ffffea000225ef48 ffffea000225e008 ffff8880aa040700
raw: 0000000000000000 ffff888098036000 0000000100000002 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
 ffff888098036780: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff888098036800: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff888098036880: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                         ^
 ffff888098036900: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff888098036980: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================

