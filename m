Return-Path: <SRS0=2gEN=4S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19FDAC3F2CE
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Mar 2020 11:20:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB16421775
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Mar 2020 11:20:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726602AbgCALUP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Mar 2020 06:20:15 -0500
Received: from mail-il1-f197.google.com ([209.85.166.197]:40786 "EHLO
        mail-il1-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725827AbgCALUO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Mar 2020 06:20:14 -0500
Received: by mail-il1-f197.google.com with SMTP id f68so8254668ilh.7
        for <linux-kernel@vger.kernel.org>; Sun, 01 Mar 2020 03:20:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=go2em9Ljthkh8bv+66gOflgqR5R40xw32D6uaPu+fbI=;
        b=dmuwv6HU0DmzzkWUwePDlRWIyIctA9VKAX9KNpTc9sdYEzEkMKOEeSR6X7FDkLz0xD
         4ErKFjhkF3290Cw2cQ7ftNcW1idWymI1pKPQDieXjH6NgZN+hmX3P6OEb2WIdU2VbmMt
         2Qq2pxqZuM5Vn6rrpqOsWGWed/CCpbQBw2oJR/55UrAF6sJl4IhTey3lcNc9o9ITvYtd
         4cnzA4rXQ1/uerEx/NwWlPU569kZf4rloCUkxLP/Bz68sByoEF44PBdAkessb6rADNBQ
         lO86NUnw7cWB67PIu366NQyFnwzdRsI29pTBPycWfb1jgFVrCi4ngI11Ibtbo4VTGZa1
         2cow==
X-Gm-Message-State: APjAAAU1WZx7iRGE7PjsU3EMIKL8Xt4GXV33NapoZG3ZEbmb9CRgOhKv
        /+dHbJa+c+nYeJqJ5O4hFGVgWGEk5fGv9V5BbS/8gF/dFcgw
X-Google-Smtp-Source: APXvYqwJxUnpzxQiBIGgDtlghCiY2StwSPCfO+F1kKjYNbYS9qb1J0ILqr5ldyu5AH+4SAYqz5qTkT3zTF5IXR8zg2oTBkLDvzGV
MIME-Version: 1.0
X-Received: by 2002:a92:8458:: with SMTP id l85mr12379683ild.296.1583061612450;
 Sun, 01 Mar 2020 03:20:12 -0800 (PST)
Date:   Sun, 01 Mar 2020 03:20:12 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000001156d8059fc94130@google.com>
Subject: KASAN: use-after-free Read in afs_deactivate_cell
From:   syzbot <syzbot+14ebf5bd30d222b5745c@syzkaller.appspotmail.com>
To:     dhowells@redhat.com, linux-afs@lists.infradead.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    bdc5461b Add linux-next specific files for 20200224
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=100c3645e00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8402e437f1eeea92
dashboard link: https://syzkaller.appspot.com/bug?extid=14ebf5bd30d222b5745c
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+14ebf5bd30d222b5745c@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: use-after-free in hlist_del_rcu include/linux/rculist.h:487 [inline]
BUG: KASAN: use-after-free in afs_deactivate_cell+0x17d/0x1e0 fs/afs/cell.c:632
Read of size 8 at addr ffff888094430468 by task kworker/1:3/18047

CPU: 1 PID: 18047 Comm: kworker/1:3 Not tainted 5.6.0-rc2-next-20200224-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Workqueue: afs afs_manage_cell
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x197/0x210 lib/dump_stack.c:118
 print_address_description.constprop.0.cold+0xd4/0x30b mm/kasan/report.c:374
 __kasan_report.cold+0x1b/0x32 mm/kasan/report.c:506
 kasan_report+0x12/0x20 mm/kasan/common.c:641
 __asan_report_load8_noabort+0x14/0x20 mm/kasan/generic_report.c:135
 hlist_del_rcu include/linux/rculist.h:487 [inline]
 afs_deactivate_cell+0x17d/0x1e0 fs/afs/cell.c:632
 afs_manage_cell+0x35e/0x1400 fs/afs/cell.c:706
 process_one_work+0xa05/0x17a0 kernel/workqueue.c:2266
 worker_thread+0x98/0xe40 kernel/workqueue.c:2412
 kthread+0x361/0x430 kernel/kthread.c:255
 ret_from_fork+0x24/0x30 arch/x86/entry/entry_64.S:352

Allocated by task 26432:
 save_stack+0x23/0x90 mm/kasan/common.c:72
 set_track mm/kasan/common.c:80 [inline]
 __kasan_kmalloc mm/kasan/common.c:515 [inline]
 __kasan_kmalloc.constprop.0+0xcf/0xe0 mm/kasan/common.c:488
 kasan_kmalloc+0x9/0x10 mm/kasan/common.c:529
 kmem_cache_alloc_trace+0x158/0x790 mm/slab.c:3551
 kmalloc include/linux/slab.h:555 [inline]
 kzalloc include/linux/slab.h:669 [inline]
 afs_alloc_cell fs/afs/cell.c:151 [inline]
 afs_lookup_cell+0x645/0x1310 fs/afs/cell.c:250
 afs_parse_source fs/afs/super.c:290 [inline]
 afs_parse_param fs/afs/super.c:326 [inline]
 afs_parse_param+0x440/0x920 fs/afs/super.c:314
 vfs_parse_fs_param+0x2b4/0x610 fs/fs_context.c:147
 vfs_parse_fs_string+0x10a/0x170 fs/fs_context.c:191
 do_new_mount fs/namespace.c:2816 [inline]
 do_mount+0x6b4/0x1b50 fs/namespace.c:3107
 __do_sys_mount fs/namespace.c:3316 [inline]
 __se_sys_mount fs/namespace.c:3293 [inline]
 __x64_sys_mount+0x192/0x230 fs/namespace.c:3293
 do_syscall_64+0xfa/0x790 arch/x86/entry/common.c:295
 entry_SYSCALL_64_after_hwframe+0x49/0xbe

Freed by task 13356:
 save_stack+0x23/0x90 mm/kasan/common.c:72
 set_track mm/kasan/common.c:80 [inline]
 kasan_set_free_info mm/kasan/common.c:337 [inline]
 __kasan_slab_free+0x102/0x150 mm/kasan/common.c:476
 kasan_slab_free+0xe/0x10 mm/kasan/common.c:485
 __cache_free mm/slab.c:3426 [inline]
 kfree+0x10a/0x2c0 mm/slab.c:3757
 afs_cell_destroy+0xf1/0x130 fs/afs/cell.c:486
 rcu_do_batch kernel/rcu/tree.c:2207 [inline]
 rcu_core+0x5e3/0x1440 kernel/rcu/tree.c:2434
 rcu_core_si+0x9/0x10 kernel/rcu/tree.c:2443
 __do_softirq+0x262/0x98c kernel/softirq.c:292

The buggy address belongs to the object at ffff888094430400
 which belongs to the cache kmalloc-512 of size 512
The buggy address is located 104 bytes inside of
 512-byte region [ffff888094430400, ffff888094430600)
The buggy address belongs to the page:
page:ffffea0002510c00 refcount:1 mapcount:0 mapping:00000000872b8291 index:0x0
flags: 0xfffe0000000200(slab)
raw: 00fffe0000000200 ffffea0002887048 ffffea00029f3fc8 ffff8880aa400a80
raw: 0000000000000000 ffff888094430000 0000000100000004 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
 ffff888094430300: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff888094430380: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>ffff888094430400: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                                          ^
 ffff888094430480: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff888094430500: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
