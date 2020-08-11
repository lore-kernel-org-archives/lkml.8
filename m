Return-Path: <SRS0=vr6t=BV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8BD5C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 16:59:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8EBD62076C
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 16:59:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729349AbgHKQ7h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Aug 2020 12:59:37 -0400
Received: from mail-io1-f69.google.com ([209.85.166.69]:53753 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729125AbgHKQ7T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Aug 2020 12:59:19 -0400
Received: by mail-io1-f69.google.com with SMTP id f22so10177172iof.20
        for <linux-kernel@vger.kernel.org>; Tue, 11 Aug 2020 09:59:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=l3wlPqr6ipWe8Opm66dLPgisSNnhHiymwvjRBVgKADg=;
        b=qxt1vA3NA9BRt0ZUy4xw0mSrrojYTAmyCTxgSZl24BQEc9J+VdmfOu0EeCvQLKSJ+S
         0w1SY7Vh6RwD+E7EBFJkt9hmeHjgvdVj1QMUHtuUak6F9xTmwAVSKYo/JRuQnUm6yM6s
         UN+wUoY+jXg4fxZvOg6E82PssrtdgoYBSBv5LasNJzjlAmOgWMvCG1oL82pUGElPoSyM
         3QWK+eiy5DiLWGDgi4gA3o7d/h5+m3SpKVcGsDS+dQDqiPBthM8tMaKbiIonByfH7s+X
         w0TAomFvEd2fUK4DDUUy4gj44E6I8iMfefR9SDnb6DeRbCGjaHPM1KqDAhlqvakIrMYL
         9nYQ==
X-Gm-Message-State: AOAM530RuObBdDIsDlx0A2boDDsTfTjsBK613NEyilpL9mBLyY28ePNF
        RjHaHJc7s39qH663cxhmBmFVM9xLP5tZ02Xy5AehmsvEe5D0
X-Google-Smtp-Source: ABdhPJxJQUhNpwViTKlqIYQHdVNHdSYbUVL2IQMxAttPZayrs+KLh/wyllEFuWMrDd47AXUX6rFXx/1jkrZkBqrw35YQnudVFt++
MIME-Version: 1.0
X-Received: by 2002:a02:c919:: with SMTP id t25mr27761316jao.38.1597165157907;
 Tue, 11 Aug 2020 09:59:17 -0700 (PDT)
Date:   Tue, 11 Aug 2020 09:59:17 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e2852705ac9cfd73@google.com>
Subject: KASAN: slab-out-of-bounds Read in lock_sock_nested
From:   syzbot <syzbot+9a0875bc1b2ca466b484@syzkaller.appspotmail.com>
To:     davem@davemloft.net, johan.hedberg@gmail.com, kuba@kernel.org,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        marcel@holtmann.org, netdev@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    bfdd5aaa Merge tag 'Smack-for-5.9' of git://github.com/csc..
git tree:       net-next
console output: https://syzkaller.appspot.com/x/log.txt?x=167b4d3a900000
kernel config:  https://syzkaller.appspot.com/x/.config?x=7bb894f55faf8242
dashboard link: https://syzkaller.appspot.com/bug?extid=9a0875bc1b2ca466b484
compiler:       gcc (GCC) 10.1.0-syz 20200507

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+9a0875bc1b2ca466b484@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-out-of-bounds in __lock_acquire+0x41d0/0x5640 kernel/locking/lockdep.c:4296
Read of size 8 at addr ffff8880497850a0 by task kworker/1:2/23918

CPU: 1 PID: 23918 Comm: kworker/1:2 Not tainted 5.8.0-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Workqueue: events l2cap_chan_timeout
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x18f/0x20d lib/dump_stack.c:118
 print_address_description.constprop.0.cold+0xae/0x436 mm/kasan/report.c:383
 __kasan_report mm/kasan/report.c:513 [inline]
 kasan_report.cold+0x1f/0x37 mm/kasan/report.c:530
 __lock_acquire+0x41d0/0x5640 kernel/locking/lockdep.c:4296
 lock_acquire+0x1f1/0xad0 kernel/locking/lockdep.c:5005
 __raw_spin_lock_bh include/linux/spinlock_api_smp.h:135 [inline]
 _raw_spin_lock_bh+0x2f/0x40 kernel/locking/spinlock.c:175
 spin_lock_bh include/linux/spinlock.h:359 [inline]
 lock_sock_nested+0x3b/0x110 net/core/sock.c:3040
 l2cap_sock_teardown_cb+0x88/0x400 net/bluetooth/l2cap_sock.c:1520
 l2cap_chan_del+0xad/0x1300 net/bluetooth/l2cap_core.c:618
 l2cap_chan_close+0x118/0xb10 net/bluetooth/l2cap_core.c:823
 l2cap_chan_timeout+0x173/0x450 net/bluetooth/l2cap_core.c:436
 process_one_work+0x94c/0x1670 kernel/workqueue.c:2269
 worker_thread+0x64c/0x1120 kernel/workqueue.c:2415
 kthread+0x3b5/0x4a0 kernel/kthread.c:292
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:294

Allocated by task 3899:
 save_stack+0x1b/0x40 mm/kasan/common.c:48
 set_track mm/kasan/common.c:56 [inline]
 __kasan_kmalloc.constprop.0+0xc2/0xd0 mm/kasan/common.c:494
 __do_kmalloc mm/slab.c:3656 [inline]
 __kmalloc+0x17a/0x340 mm/slab.c:3665
 kmalloc include/linux/slab.h:560 [inline]
 tomoyo_realpath_from_path+0xc3/0x620 security/tomoyo/realpath.c:254
 tomoyo_get_realpath security/tomoyo/file.c:151 [inline]
 tomoyo_check_open_permission+0x272/0x380 security/tomoyo/file.c:771
 tomoyo_file_open security/tomoyo/tomoyo.c:313 [inline]
 tomoyo_file_open+0xa3/0xd0 security/tomoyo/tomoyo.c:308
 security_file_open+0x52/0x3f0 security/security.c:1574
 do_dentry_open+0x3a0/0x1290 fs/open.c:815
 do_open fs/namei.c:3243 [inline]
 path_openat+0x1bb9/0x2750 fs/namei.c:3360
 do_filp_open+0x17e/0x3c0 fs/namei.c:3387
 do_sys_openat2+0x16f/0x3b0 fs/open.c:1179
 do_sys_open fs/open.c:1195 [inline]
 ksys_open include/linux/syscalls.h:1390 [inline]
 __do_sys_open fs/open.c:1201 [inline]
 __se_sys_open fs/open.c:1199 [inline]
 __x64_sys_open+0x119/0x1c0 fs/open.c:1199
 do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x44/0xa9

Freed by task 3899:
 save_stack+0x1b/0x40 mm/kasan/common.c:48
 set_track mm/kasan/common.c:56 [inline]
 kasan_set_free_info mm/kasan/common.c:316 [inline]
 __kasan_slab_free+0xf5/0x140 mm/kasan/common.c:455
 __cache_free mm/slab.c:3426 [inline]
 kfree+0x103/0x2c0 mm/slab.c:3757
 tomoyo_realpath_from_path+0x191/0x620 security/tomoyo/realpath.c:291
 tomoyo_get_realpath security/tomoyo/file.c:151 [inline]
 tomoyo_check_open_permission+0x272/0x380 security/tomoyo/file.c:771
 tomoyo_file_open security/tomoyo/tomoyo.c:313 [inline]
 tomoyo_file_open+0xa3/0xd0 security/tomoyo/tomoyo.c:308
 security_file_open+0x52/0x3f0 security/security.c:1574
 do_dentry_open+0x3a0/0x1290 fs/open.c:815
 do_open fs/namei.c:3243 [inline]
 path_openat+0x1bb9/0x2750 fs/namei.c:3360
 do_filp_open+0x17e/0x3c0 fs/namei.c:3387
 do_sys_openat2+0x16f/0x3b0 fs/open.c:1179
 do_sys_open fs/open.c:1195 [inline]
 ksys_open include/linux/syscalls.h:1390 [inline]
 __do_sys_open fs/open.c:1201 [inline]
 __se_sys_open fs/open.c:1199 [inline]
 __x64_sys_open+0x119/0x1c0 fs/open.c:1199
 do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x44/0xa9

The buggy address belongs to the object at ffff888049784000
 which belongs to the cache kmalloc-4k of size 4096
The buggy address is located 160 bytes to the right of
 4096-byte region [ffff888049784000, ffff888049785000)
The buggy address belongs to the page:
page:ffffea000125e100 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 head:ffffea000125e100 order:1 compound_mapcount:0
flags: 0xfffe0000010200(slab|head)
raw: 00fffe0000010200 ffffea0001c34088 ffffea000122f088 ffff8880aa002000
raw: 0000000000000000 ffff888049784000 0000000100000001 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
 ffff888049784f80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff888049785000: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>ffff888049785080: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
                               ^
 ffff888049785100: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff888049785180: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
