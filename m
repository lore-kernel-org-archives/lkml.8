Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0897C433E5
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 03:07:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D0921217D9
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 03:07:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727019AbgGNDHR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jul 2020 23:07:17 -0400
Received: from mail-io1-f70.google.com ([209.85.166.70]:43768 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726435AbgGNDHQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 23:07:16 -0400
Received: by mail-io1-f70.google.com with SMTP id f13so9512621iok.10
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jul 2020 20:07:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=CImQQPkNzCU37gU91u+NKjQNkiALiZr5IDmxG884hmA=;
        b=fEByMTB17AdQH18A5SJq8sEpx8lZzAtolGgPKq43aSIhd5eDgFCUVJLn2NqSnXH10S
         y6LvSqS2w9kkrS8HO2WnBPtVFeMEtAqMOSuCH5czIX59ZLAGzGnypHdT8nYBjPNSg0O5
         JT5SGY5pYcEAQViiXC7XHz2Nph4KLNY7ssJRiDjmo9PXQoIBlpj136tJXE++e9Lupj3u
         EsQ3tfUcYie2p1nkv0UVPuAXIYqHJxDE8Q9YAmtUddw6FQ4DI8SfYoFdlc7PgAaHAgG2
         yPI/dfQ0hPpWHTmmLkuRqFlRsQc4n13NcSY36nSWa94Ys97xCVk2wdxwDxJoC9tZOZGQ
         Us+Q==
X-Gm-Message-State: AOAM5318TfepGlbuT/6GVmt3B1W698qaBUGZYcBkv3D15/9TwHrkoYZv
        DSpeaJut7k4ukKrOeYlZgZidBJqZew/Nd95WUwmwUAjvVJCk
X-Google-Smtp-Source: ABdhPJwjNA+uyaNgP2m65nUhSW08tT3ZjMNxC+298sH99oc4goBcR/8XSqI96Fs0ZseEY31aPHTG2LED+IzZBtPi4nAhLtcHoVLa
MIME-Version: 1.0
X-Received: by 2002:a05:6638:1409:: with SMTP id k9mr3644747jad.125.1594696035394;
 Mon, 13 Jul 2020 20:07:15 -0700 (PDT)
Date:   Mon, 13 Jul 2020 20:07:15 -0700
In-Reply-To: <0000000000000b5f9d059aa2037f@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b6e94b05aa5e1a1c@google.com>
Subject: Re: possible deadlock in shmem_fallocate (4)
From:   syzbot <syzbot+7a0d9d0b26efefe61780@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, arve@android.com, christian@brauner.io,
        devel@driverdev.osuosl.org, ebiggers@kernel.org,
        gregkh@linuxfoundation.org, hdanton@sina.com, hughd@google.com,
        joel@joelfernandes.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, maco@android.com,
        syzkaller-bugs@googlegroups.com, tkjos@android.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has found a reproducer for the following crash on:

HEAD commit:    11ba4688 Linux 5.8-rc5
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=175391fb100000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a160d1053fc89af5
dashboard link: https://syzkaller.appspot.com/bug?extid=7a0d9d0b26efefe61780
compiler:       gcc (GCC) 10.1.0-syz 20200507
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=104d9c77100000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1343e95d100000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+7a0d9d0b26efefe61780@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
5.8.0-rc5-syzkaller #0 Not tainted
------------------------------------------------------
khugepaged/1158 is trying to acquire lock:
ffff8882071865b0 (&sb->s_type->i_mutex_key#15){+.+.}-{3:3}, at: inode_lock include/linux/fs.h:800 [inline]
ffff8882071865b0 (&sb->s_type->i_mutex_key#15){+.+.}-{3:3}, at: shmem_fallocate+0x153/0xd90 mm/shmem.c:2707

but task is already holding lock:
ffffffff89c6c260 (fs_reclaim){+.+.}-{0:0}, at: fs_reclaim_release mm/page_alloc.c:4202 [inline]
ffffffff89c6c260 (fs_reclaim){+.+.}-{0:0}, at: fs_reclaim_release mm/page_alloc.c:4198 [inline]
ffffffff89c6c260 (fs_reclaim){+.+.}-{0:0}, at: __perform_reclaim mm/page_alloc.c:4227 [inline]
ffffffff89c6c260 (fs_reclaim){+.+.}-{0:0}, at: __alloc_pages_direct_reclaim mm/page_alloc.c:4244 [inline]
ffffffff89c6c260 (fs_reclaim){+.+.}-{0:0}, at: __alloc_pages_slowpath.constprop.0+0x1554/0x2780 mm/page_alloc.c:4650

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #1 (fs_reclaim){+.+.}-{0:0}:
       __fs_reclaim_acquire mm/page_alloc.c:4183 [inline]
       fs_reclaim_acquire mm/page_alloc.c:4194 [inline]
       prepare_alloc_pages mm/page_alloc.c:4780 [inline]
       __alloc_pages_nodemask+0x3d1/0x930 mm/page_alloc.c:4832
       alloc_pages_vma+0xdd/0x720 mm/mempolicy.c:2255
       shmem_alloc_page+0x11f/0x1f0 mm/shmem.c:1502
       shmem_alloc_and_acct_page+0x161/0x8a0 mm/shmem.c:1527
       shmem_getpage_gfp+0x511/0x2450 mm/shmem.c:1823
       shmem_getpage mm/shmem.c:153 [inline]
       shmem_write_begin+0xf9/0x1d0 mm/shmem.c:2459
       generic_perform_write+0x20a/0x4f0 mm/filemap.c:3318
       __generic_file_write_iter+0x24b/0x610 mm/filemap.c:3447
       generic_file_write_iter+0x3a6/0x5c0 mm/filemap.c:3479
       call_write_iter include/linux/fs.h:1908 [inline]
       new_sync_write+0x422/0x650 fs/read_write.c:503
       vfs_write+0x59d/0x6b0 fs/read_write.c:578
       ksys_write+0x12d/0x250 fs/read_write.c:631
       do_syscall_64+0x60/0xe0 arch/x86/entry/common.c:384
       entry_SYSCALL_64_after_hwframe+0x44/0xa9

-> #0 (&sb->s_type->i_mutex_key#15){+.+.}-{3:3}:
       check_prev_add kernel/locking/lockdep.c:2496 [inline]
       check_prevs_add kernel/locking/lockdep.c:2601 [inline]
       validate_chain kernel/locking/lockdep.c:3218 [inline]
       __lock_acquire+0x2acb/0x56e0 kernel/locking/lockdep.c:4380
       lock_acquire+0x1f1/0xad0 kernel/locking/lockdep.c:4959
       down_write+0x8d/0x150 kernel/locking/rwsem.c:1531
       inode_lock include/linux/fs.h:800 [inline]
       shmem_fallocate+0x153/0xd90 mm/shmem.c:2707
       ashmem_shrink_scan.part.0+0x2e9/0x490 drivers/staging/android/ashmem.c:490
       ashmem_shrink_scan+0x6c/0xa0 drivers/staging/android/ashmem.c:473
       do_shrink_slab+0x3c6/0xab0 mm/vmscan.c:518
       shrink_slab+0x16f/0x5c0 mm/vmscan.c:679
       shrink_node_memcgs mm/vmscan.c:2658 [inline]
       shrink_node+0x519/0x1b60 mm/vmscan.c:2770
       shrink_zones mm/vmscan.c:2973 [inline]
       do_try_to_free_pages+0x38b/0x1340 mm/vmscan.c:3026
       try_to_free_pages+0x29a/0x8b0 mm/vmscan.c:3265
       __perform_reclaim mm/page_alloc.c:4223 [inline]
       __alloc_pages_direct_reclaim mm/page_alloc.c:4244 [inline]
       __alloc_pages_slowpath.constprop.0+0x949/0x2780 mm/page_alloc.c:4650
       __alloc_pages_nodemask+0x68f/0x930 mm/page_alloc.c:4863
       __alloc_pages include/linux/gfp.h:509 [inline]
       __alloc_pages_node include/linux/gfp.h:522 [inline]
       khugepaged_alloc_page+0xa0/0x170 mm/khugepaged.c:867
       collapse_huge_page mm/khugepaged.c:1056 [inline]
       khugepaged_scan_pmd mm/khugepaged.c:1349 [inline]
       khugepaged_scan_mm_slot mm/khugepaged.c:2110 [inline]
       khugepaged_do_scan mm/khugepaged.c:2193 [inline]
       khugepaged+0x3093/0x5a10 mm/khugepaged.c:2238
       kthread+0x3b5/0x4a0 kernel/kthread.c:291
       ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:293

other info that might help us debug this:

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(fs_reclaim);
                               lock(&sb->s_type->i_mutex_key#15);
                               lock(fs_reclaim);
  lock(&sb->s_type->i_mutex_key#15);

 *** DEADLOCK ***

2 locks held by khugepaged/1158:
 #0: ffffffff89c6c260 (fs_reclaim){+.+.}-{0:0}, at: fs_reclaim_release mm/page_alloc.c:4202 [inline]
 #0: ffffffff89c6c260 (fs_reclaim){+.+.}-{0:0}, at: fs_reclaim_release mm/page_alloc.c:4198 [inline]
 #0: ffffffff89c6c260 (fs_reclaim){+.+.}-{0:0}, at: __perform_reclaim mm/page_alloc.c:4227 [inline]
 #0: ffffffff89c6c260 (fs_reclaim){+.+.}-{0:0}, at: __alloc_pages_direct_reclaim mm/page_alloc.c:4244 [inline]
 #0: ffffffff89c6c260 (fs_reclaim){+.+.}-{0:0}, at: __alloc_pages_slowpath.constprop.0+0x1554/0x2780 mm/page_alloc.c:4650
 #1: ffffffff89c46a90 (shrinker_rwsem){++++}-{3:3}, at: shrink_slab+0xc7/0x5c0 mm/vmscan.c:669

stack backtrace:
CPU: 1 PID: 1158 Comm: khugepaged Not tainted 5.8.0-rc5-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x18f/0x20d lib/dump_stack.c:118
 check_noncircular+0x324/0x3e0 kernel/locking/lockdep.c:1827
 check_prev_add kernel/locking/lockdep.c:2496 [inline]
 check_prevs_add kernel/locking/lockdep.c:2601 [inline]
 validate_chain kernel/locking/lockdep.c:3218 [inline]
 __lock_acquire+0x2acb/0x56e0 kernel/locking/lockdep.c:4380
 lock_acquire+0x1f1/0xad0 kernel/locking/lockdep.c:4959
 down_write+0x8d/0x150 kernel/locking/rwsem.c:1531
 inode_lock include/linux/fs.h:800 [inline]
 shmem_fallocate+0x153/0xd90 mm/shmem.c:2707
 ashmem_shrink_scan.part.0+0x2e9/0x490 drivers/staging/android/ashmem.c:490
 ashmem_shrink_scan+0x6c/0xa0 drivers/staging/android/ashmem.c:473
 do_shrink_slab+0x3c6/0xab0 mm/vmscan.c:518
 shrink_slab+0x16f/0x5c0 mm/vmscan.c:679
 shrink_node_memcgs mm/vmscan.c:2658 [inline]
 shrink_node+0x519/0x1b60 mm/vmscan.c:2770
 shrink_zones mm/vmscan.c:2973 [inline]
 do_try_to_free_pages+0x38b/0x1340 mm/vmscan.c:3026
 try_to_free_pages+0x29a/0x8b0 mm/vmscan.c:3265
 __perform_reclaim mm/page_alloc.c:4223 [inline]
 __alloc_pages_direct_reclaim mm/page_alloc.c:4244 [inline]
 __alloc_pages_slowpath.constprop.0+0x949/0x2780 mm/page_alloc.c:4650
 __alloc_pages_nodemask+0x68f/0x930 mm/page_alloc.c:4863
 __alloc_pages include/linux/gfp.h:509 [inline]
 __alloc_pages_node include/linux/gfp.h:522 [inline]
 khugepaged_alloc_page+0xa0/0x170 mm/khugepaged.c:867
 collapse_huge_page mm/khugepaged.c:1056 [inline]
 khugepaged_scan_pmd mm/khugepaged.c:1349 [inline]
 khugepaged_scan_mm_slot mm/khugepaged.c:2110 [inline]
 khugepaged_do_scan mm/khugepaged.c:2193 [inline]
 khugepaged+0x3093/0x5a10 mm/khugepaged.c:2238
 kthread+0x3b5/0x4a0 kernel/kthread.c:291
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:293

