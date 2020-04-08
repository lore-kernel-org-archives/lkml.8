Return-Path: <SRS0=8dav=5Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9947FC2BA2B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 10:28:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 760CB20768
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 10:28:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728129AbgDHK2R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Apr 2020 06:28:17 -0400
Received: from mail-il1-f200.google.com ([209.85.166.200]:53970 "EHLO
        mail-il1-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727982AbgDHK2Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Apr 2020 06:28:16 -0400
Received: by mail-il1-f200.google.com with SMTP id a15so6236468ilh.20
        for <linux-kernel@vger.kernel.org>; Wed, 08 Apr 2020 03:28:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=UfZi/Vr4kO5/IMcq6GWR9ww1EyoQ0i7NEwranC9/flA=;
        b=OZOauAZCAab8Pa/5Y3pSr7P0LIZEIGmMZrzTnJyafbeBzJ2aGf/JeyfExkMahMPIxw
         dsfLYmUwsTf2apnGfwfm9kCWNLE1mIGi6CpjXRt8/b0iWMMYas+1zIZF4iSJiw0JBSz6
         LqjcAC2pmpn6fFyEw9XrL3ShSE6gZ7x45vtXiH+yYpRAvTPzLXeMymK/1WELLgUZ+vjt
         l8EnxpvV2BlQO7Q8FGj8ClDce/l1Uyd0kuLdAV7YCZeXAX0PFBuwG2TUp0PrEZkbJdA+
         ivGeDiyQLlTKFGDVJwYQ8TCei1iEvO3XNjrOcNjxta7cfyaV5s6WUbukAv7acCgPC17B
         ouqg==
X-Gm-Message-State: AGi0PuaFo5MCxpNGpQ9rTZJAfk0uKGo5g6OxS13sDAJHYevENniN2VX3
        NHHbPCmbKOGaTliFMuOrW/waBMZppulEWM+rMOzrQMieWudG
X-Google-Smtp-Source: APiQypLUIn6OyV0pjdvSPlMJE340RXW1Q8tHyAumQy2et5hDfRvhTu430FDvnyXYZ5Le+LeUxWhXGzJ2gzC7Ng233i3GtoVmCnu9
MIME-Version: 1.0
X-Received: by 2002:a92:d0d:: with SMTP id 13mr7408236iln.170.1586341695143;
 Wed, 08 Apr 2020 03:28:15 -0700 (PDT)
Date:   Wed, 08 Apr 2020 03:28:15 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000003b42f305a2c4f5e9@google.com>
Subject: WARNING: bad unlock balance in get_user_pages_unlocked
From:   syzbot <syzbot+291a90a202a1a4a7b0c1@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    bef7b2a7 Merge tag 'devicetree-for-5.7' of git://git.kerne..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1507d2e7e00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=91b674b8f0368e69
dashboard link: https://syzkaller.appspot.com/bug?extid=291a90a202a1a4a7b0c1
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+291a90a202a1a4a7b0c1@syzkaller.appspotmail.com

=====================================
WARNING: bad unlock balance detected!
5.6.0-syzkaller #0 Not tainted
-------------------------------------
syz-executor.2/13432 is trying to release lock (&mm->mmap_sem) at:
[<ffffffff819f2464>] get_user_pages_unlocked+0x4a4/0x610 mm/gup.c:2032
but there are no more locks to release!

other info that might help us debug this:
no locks held by syz-executor.2/13432.

stack backtrace:
CPU: 0 PID: 13432 Comm: syz-executor.2 Not tainted 5.6.0-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x188/0x20d lib/dump_stack.c:118
 __lock_release kernel/locking/lockdep.c:4633 [inline]
 lock_release+0x586/0x800 kernel/locking/lockdep.c:4941
 up_read+0x79/0x750 kernel/locking/rwsem.c:1573
 get_user_pages_unlocked+0x4a4/0x610 mm/gup.c:2032
 __gup_longterm_unlocked mm/gup.c:2735 [inline]
 internal_get_user_pages_fast+0x44a/0x4e0 mm/gup.c:2776
 get_user_pages_fast+0x49/0x70 mm/gup.c:2824
 iov_iter_get_pages+0x29f/0x10c0 lib/iov_iter.c:1322
 __bio_iov_iter_get_pages block/bio.c:989 [inline]
 bio_iov_iter_get_pages+0x1c6/0xa50 block/bio.c:1045
 __blkdev_direct_IO fs/block_dev.c:387 [inline]
 blkdev_direct_IO+0x991/0x1360 fs/block_dev.c:477
 generic_file_read_iter+0x30a/0x2b10 mm/filemap.c:2276
 blkdev_read_iter+0x11b/0x180 fs/block_dev.c:2053
 call_read_iter include/linux/fs.h:1901 [inline]
 aio_read+0x258/0x3b0 fs/aio.c:1543
 __io_submit_one fs/aio.c:1829 [inline]
 io_submit_one+0xff9/0x2ec0 fs/aio.c:1878
 __do_sys_io_submit fs/aio.c:1937 [inline]
 __se_sys_io_submit fs/aio.c:1907 [inline]
 __x64_sys_io_submit+0x1bd/0x540 fs/aio.c:1907
 do_syscall_64+0xf6/0x7d0 arch/x86/entry/common.c:295
 entry_SYSCALL_64_after_hwframe+0x49/0xb3
RIP: 0033:0x45c849
Code: ad b6 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 0f 83 7b b6 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007fd221794c78 EFLAGS: 00000246 ORIG_RAX: 00000000000000d1
RAX: ffffffffffffffda RBX: 00007fd2217956d4 RCX: 000000000045c849
RDX: 00000000200000c0 RSI: 0000000000000008 RDI: 00007fd221774000
RBP: 000000000076bf00 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000ffffffff
R13: 00000000000001f9 R14: 00000000004c422b R15: 000000000076bf0c
------------[ cut here ]------------
DEBUG_RWSEMS_WARN_ON(tmp < 0): count = 0xffffffffffffff00, magic = 0xffff8880959003f8, owner = 0x1, curr 0xffff88804e98c340, list empty
WARNING: CPU: 1 PID: 13432 at kernel/locking/rwsem.c:1435 __up_read kernel/locking/rwsem.c:1435 [inline]
WARNING: CPU: 1 PID: 13432 at kernel/locking/rwsem.c:1435 up_read+0x5f9/0x750 kernel/locking/rwsem.c:1574


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
