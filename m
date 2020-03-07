Return-Path: <SRS0=IBMW=4Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28BCCC10F00
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Mar 2020 21:43:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E680620684
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Mar 2020 21:43:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583617405;
	bh=EuZ8FGAG/nlMwc0huc4bMVpwKK827PeKRrSlxik5lsA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=OzQXcVtiw5eK9p0zxuQ+CrKlnI+T4LQq+MGIA3iAUgcGtyY6oCQEbOsfFMVw1r01E
	 NLSaBgaqM/3PMifCMQ9wYqDf74/AMHOSEzbw/n+uyJgqBWY5jRsiydUpr0mLbgpHdW
	 Elkxumg9+XI804vJ17CTdnJSG6p/0AaICMy4UK1Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726264AbgCGVnO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Mar 2020 16:43:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:36212 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725911AbgCGVnN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Mar 2020 16:43:13 -0500
Received: from sol.localdomain (c-107-3-166-239.hsd1.ca.comcast.net [107.3.166.239])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1D6FD20684;
        Sat,  7 Mar 2020 21:43:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583617392;
        bh=EuZ8FGAG/nlMwc0huc4bMVpwKK827PeKRrSlxik5lsA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Xh/hOuKOvQI3hjau5VbTwhsjvZSv6Y/ZHJb3HSn9OtZiOjjWP2/4XAnCaqWr/Xw/N
         1VMYhb7B7VWmE0ATg79iR64VUbtGCi7M50/ZxK+l3TrkyW92eqB17WvJfqbW+q9JX9
         kMFqAFTsjDlwXnJJ26lsZzsBDPK9cJpAzrDQDaw0=
Date:   Sat, 7 Mar 2020 13:43:10 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Christian Brauner <christian@brauner.io>,
        devel@driverdev.osuosl.org
Cc:     syzbot <syzbot+7a0d9d0b26efefe61780@syzkaller.appspotmail.com>,
        akpm@linux-foundation.org, hughd@google.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        syzkaller-bugs@googlegroups.com
Subject: Re: [ashmem] possible deadlock in shmem_fallocate (4)
Message-ID: <20200307214310.GP15444@sol.localdomain>
References: <0000000000000b5f9d059aa2037f@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0000000000000b5f9d059aa2037f@google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ashmem is calling shmem_fallocate() during memory reclaim, which can deadlock on
inode_lock().  +Cc maintainers of drivers/staging/android/ashmem.c.

On Thu, Dec 26, 2019 at 01:25:09PM -0800, syzbot wrote:
> Hello,
> 
> syzbot found the following crash on:
> 
> HEAD commit:    46cf053e Linux 5.5-rc3
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=162124aee00000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=ed9d672709340e35
> dashboard link: https://syzkaller.appspot.com/bug?extid=7a0d9d0b26efefe61780
> compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> 
> Unfortunately, I don't have any reproducer for this crash yet.
> 
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+7a0d9d0b26efefe61780@syzkaller.appspotmail.com
> 
> ======================================================
> WARNING: possible circular locking dependency detected
> 5.5.0-rc3-syzkaller #0 Not tainted
> ------------------------------------------------------
> kswapd0/1852 is trying to acquire lock:
> ffff888098919cd8 (&sb->s_type->i_mutex_key#13){+.+.}, at: inode_lock
> include/linux/fs.h:791 [inline]
> ffff888098919cd8 (&sb->s_type->i_mutex_key#13){+.+.}, at:
> shmem_fallocate+0x15a/0xd40 mm/shmem.c:2735
> 
> but task is already holding lock:
> ffffffff89a41e00 (fs_reclaim){+.+.}, at: __fs_reclaim_acquire+0x0/0x30
> mm/page_alloc.c:4922
> 
> which lock already depends on the new lock.
> 
> 
> the existing dependency chain (in reverse order) is:
> 
> -> #1 (fs_reclaim){+.+.}:
>        __fs_reclaim_acquire mm/page_alloc.c:4084 [inline]
>        fs_reclaim_acquire.part.0+0x24/0x30 mm/page_alloc.c:4095
>        fs_reclaim_acquire mm/page_alloc.c:4695 [inline]
>        prepare_alloc_pages mm/page_alloc.c:4692 [inline]
>        __alloc_pages_nodemask+0x52d/0x910 mm/page_alloc.c:4744
>        alloc_pages_vma+0xdd/0x620 mm/mempolicy.c:2170
>        shmem_alloc_page+0xc0/0x180 mm/shmem.c:1499
>        shmem_alloc_and_acct_page+0x165/0x990 mm/shmem.c:1524
>        shmem_getpage_gfp+0x56d/0x29a0 mm/shmem.c:1838
>        shmem_getpage mm/shmem.c:154 [inline]
>        shmem_write_begin+0x105/0x1e0 mm/shmem.c:2487
>        generic_perform_write+0x23b/0x540 mm/filemap.c:3309
>        __generic_file_write_iter+0x25e/0x630 mm/filemap.c:3438
>        generic_file_write_iter+0x420/0x68e mm/filemap.c:3470
>        call_write_iter include/linux/fs.h:1902 [inline]
>        new_sync_write+0x4d3/0x770 fs/read_write.c:483
>        __vfs_write+0xe1/0x110 fs/read_write.c:496
>        vfs_write+0x268/0x5d0 fs/read_write.c:558
>        ksys_write+0x14f/0x290 fs/read_write.c:611
>        __do_sys_write fs/read_write.c:623 [inline]
>        __se_sys_write fs/read_write.c:620 [inline]
>        __x64_sys_write+0x73/0xb0 fs/read_write.c:620
>        do_syscall_64+0xfa/0x790 arch/x86/entry/common.c:294
>        entry_SYSCALL_64_after_hwframe+0x49/0xbe
> 
> -> #0 (&sb->s_type->i_mutex_key#13){+.+.}:
>        check_prev_add kernel/locking/lockdep.c:2476 [inline]
>        check_prevs_add kernel/locking/lockdep.c:2581 [inline]
>        validate_chain kernel/locking/lockdep.c:2971 [inline]
>        __lock_acquire+0x2596/0x4a00 kernel/locking/lockdep.c:3955
>        lock_acquire+0x190/0x410 kernel/locking/lockdep.c:4485
>        down_write+0x93/0x150 kernel/locking/rwsem.c:1534
>        inode_lock include/linux/fs.h:791 [inline]
>        shmem_fallocate+0x15a/0xd40 mm/shmem.c:2735
>        ashmem_shrink_scan drivers/staging/android/ashmem.c:462 [inline]
>        ashmem_shrink_scan+0x370/0x510 drivers/staging/android/ashmem.c:437
>        do_shrink_slab+0x40f/0xad0 mm/vmscan.c:526
>        shrink_slab mm/vmscan.c:687 [inline]
>        shrink_slab+0x19a/0x680 mm/vmscan.c:660
>        shrink_node_memcgs mm/vmscan.c:2687 [inline]
>        shrink_node+0x46a/0x1ad0 mm/vmscan.c:2791
>        kswapd_shrink_node mm/vmscan.c:3539 [inline]
>        balance_pgdat+0x7c8/0x11f0 mm/vmscan.c:3697
>        kswapd+0x5c3/0xf30 mm/vmscan.c:3948
>        kthread+0x361/0x430 kernel/kthread.c:255
>        ret_from_fork+0x24/0x30 arch/x86/entry/entry_64.S:352
> 
> other info that might help us debug this:
> 
>  Possible unsafe locking scenario:
> 
>        CPU0                    CPU1
>        ----                    ----
>   lock(fs_reclaim);
>                                lock(&sb->s_type->i_mutex_key#13);
>                                lock(fs_reclaim);
>   lock(&sb->s_type->i_mutex_key#13);
> 
>  *** DEADLOCK ***
> 
> 2 locks held by kswapd0/1852:
>  #0: ffffffff89a41e00 (fs_reclaim){+.+.}, at: __fs_reclaim_acquire+0x0/0x30
> mm/page_alloc.c:4922
>  #1: ffffffff89a1f948 (shrinker_rwsem){++++}, at: shrink_slab
> mm/vmscan.c:677 [inline]
>  #1: ffffffff89a1f948 (shrinker_rwsem){++++}, at: shrink_slab+0xe6/0x680
> mm/vmscan.c:660
> 
> stack backtrace:
> CPU: 0 PID: 1852 Comm: kswapd0 Not tainted 5.5.0-rc3-syzkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> Google 01/01/2011
> Call Trace:
>  __dump_stack lib/dump_stack.c:77 [inline]
>  dump_stack+0x197/0x210 lib/dump_stack.c:118
>  print_circular_bug.isra.0.cold+0x163/0x172 kernel/locking/lockdep.c:1685
>  check_noncircular+0x32e/0x3e0 kernel/locking/lockdep.c:1809
>  check_prev_add kernel/locking/lockdep.c:2476 [inline]
>  check_prevs_add kernel/locking/lockdep.c:2581 [inline]
>  validate_chain kernel/locking/lockdep.c:2971 [inline]
>  __lock_acquire+0x2596/0x4a00 kernel/locking/lockdep.c:3955
>  lock_acquire+0x190/0x410 kernel/locking/lockdep.c:4485
>  down_write+0x93/0x150 kernel/locking/rwsem.c:1534
>  inode_lock include/linux/fs.h:791 [inline]
>  shmem_fallocate+0x15a/0xd40 mm/shmem.c:2735
>  ashmem_shrink_scan drivers/staging/android/ashmem.c:462 [inline]
>  ashmem_shrink_scan+0x370/0x510 drivers/staging/android/ashmem.c:437
>  do_shrink_slab+0x40f/0xad0 mm/vmscan.c:526
>  shrink_slab mm/vmscan.c:687 [inline]
>  shrink_slab+0x19a/0x680 mm/vmscan.c:660
>  shrink_node_memcgs mm/vmscan.c:2687 [inline]
>  shrink_node+0x46a/0x1ad0 mm/vmscan.c:2791
>  kswapd_shrink_node mm/vmscan.c:3539 [inline]
>  balance_pgdat+0x7c8/0x11f0 mm/vmscan.c:3697
>  kswapd+0x5c3/0xf30 mm/vmscan.c:3948
>  kthread+0x361/0x430 kernel/kthread.c:255
>  ret_from_fork+0x24/0x30 arch/x86/entry/entry_64.S:352
> 
> 
> ---
> This bug is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
> 
> syzbot will keep track of this bug report. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> 
> -- 
