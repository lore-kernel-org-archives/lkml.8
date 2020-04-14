Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04EB9C2BB1D
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 04:19:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C82312072D
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 04:19:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jZ9n5jTs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405222AbgDNETB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 00:19:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2405149AbgDNESz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 00:18:55 -0400
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com [IPv6:2607:f8b0:4864:20::f44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32003C0A3BDC
        for <linux-kernel@vger.kernel.org>; Mon, 13 Apr 2020 21:18:54 -0700 (PDT)
Received: by mail-qv1-xf44.google.com with SMTP id ef12so5578720qvb.11
        for <linux-kernel@vger.kernel.org>; Mon, 13 Apr 2020 21:18:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jxMtQNMvoMrabbHJE+cCdpyhKQPV+UOYzlgDd/2dd48=;
        b=jZ9n5jTsRQx1KKPOY/BIqYO4deQ1D3aOZTJpcLBHNhcHGQ+k6nRRl0uDJ1wyY0DEN+
         W99QHwI4UF6SIP7EouL+wwhezmX9+rHVQSOnFO++nKZbO0V7U9yI/1T//uo5Y6ULHDV/
         lL7fpggSa7zVc42YUkr7AkiwQYVGCTVI2XqHOI2ojWjvTSSEpdwJsT0qtaGYdngTAwVW
         EKdUTyqpCsjkf+d4f6qogIKM722ddnlnZ7TaovLiLuVZU9RHJMC8gPNEYPSE3se047fO
         5mvufOxw9uQ3Jqm01/nDN3VFXXCla1kOJQ/xCmTxA7sGNfuLk4qcTzjSpnvYawxTpyel
         HkLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jxMtQNMvoMrabbHJE+cCdpyhKQPV+UOYzlgDd/2dd48=;
        b=npo0ujX88P331SyVUdGNeZ5PkWArmJ/GgtUW0McINFUZLuQ9b4w7prO9chsGeUGlvE
         A5o97yCrLrTJhJWRJhsuf4PTyQv4YDjSLiTz6uP4wVN4XtXmUSZNZ/oUsMqq1ntR0HTU
         KFT+q8sCe0j6DCPSQG0wdU3hzfFZIw/FatrIRsT9yflEAzH4zbFAfW98GBScBIcPZydS
         +FKB4hqlk2QITu0U/BtRa8eFMH5qy2Y4k3WWyC3ydT6RPU4j9jK3vTzdxuJCAdwTln/f
         0gDzjysT4ax1LcSKIA3ylb21fAKRjqaHO0rE1vAWe9YcKgCurhAdwVQUvOZNe6osQuQu
         9ciQ==
X-Gm-Message-State: AGi0Pub/P6awYq61yplqgEXBtO5uIzPLvSmV4DSEjJbUHQHtIXAq4C6R
        rx1n3MdhyBYy/ajX07OSFTN0trlXdh7TQs9tGW/OIQ==
X-Google-Smtp-Source: APiQypKJAjL3nLGXQU2D9cDV/4QSRIORafps5XMOqwP/KeYwWAWlyS6Z43ESRg+piiBbwnHups2iFenUlkx7yNP0Z/o=
X-Received: by 2002:a0c:f709:: with SMTP id w9mr20237182qvn.159.1586837932783;
 Mon, 13 Apr 2020 21:18:52 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000e5838c05a3152f53@google.com> <CAHbLzkpJjpOjizxhG6oS1OsbdycwaRdLeA8nb1R4Y2C4F7nV+g@mail.gmail.com>
In-Reply-To: <CAHbLzkpJjpOjizxhG6oS1OsbdycwaRdLeA8nb1R4Y2C4F7nV+g@mail.gmail.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Tue, 14 Apr 2020 06:18:40 +0200
Message-ID: <CACT4Y+bC262O4j13L+PSfToFsMRKDEuvvyyrm7uj25Wx0EJauQ@mail.gmail.com>
Subject: Re: possible deadlock in shmem_uncharge
To:     Yang Shi <shy828301@gmail.com>
Cc:     syzbot <syzbot+c8a8197c8852f566b9d9@syzkaller.appspotmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 14, 2020 at 12:10 AM Yang Shi <shy828301@gmail.com> wrote:
>
> On Sun, Apr 12, 2020 at 3:11 AM syzbot
> <syzbot+c8a8197c8852f566b9d9@syzkaller.appspotmail.com> wrote:
> >
> > Hello,
> >
> > syzbot found the following crash on:
> >
> > HEAD commit:    ae46d2aa mm/gup: Let __get_user_pages_locked() return -EIN..
> > git tree:       upstream
> > console output: https://syzkaller.appspot.com/x/log.txt?x=14a30a77e00000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=ca75979eeebf06c2
> > dashboard link: https://syzkaller.appspot.com/bug?extid=c8a8197c8852f566b9d9
> > compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15f5632be00000
> > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=132ade57e00000
> >
> > The bug was bisected to:
> >
> > commit 71725ed10c40696dc6bdccf8e225815dcef24dba
> > Author: Hugh Dickins <hughd@google.com>
> > Date:   Tue Apr 7 03:07:57 2020 +0000
> >
> >     mm: huge tmpfs: try to split_huge_page() when punching hole
> >
> > bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=120a752be00000
> > final crash:    https://syzkaller.appspot.com/x/report.txt?x=110a752be00000
> > console output: https://syzkaller.appspot.com/x/log.txt?x=160a752be00000
> >
> > IMPORTANT: if you fix the bug, please add the following tag to the commit:
> > Reported-by: syzbot+c8a8197c8852f566b9d9@syzkaller.appspotmail.com
> > Fixes: 71725ed10c40 ("mm: huge tmpfs: try to split_huge_page() when punching hole")
> >
> > =====================================================
> > WARNING: SOFTIRQ-safe -> SOFTIRQ-unsafe lock order detected
> > 5.6.0-syzkaller #0 Not tainted
> > -----------------------------------------------------
> > syz-executor428/8337 [HC0[0]:SC0[0]:HE0:SE1] is trying to acquire:
> > ffff8880a851c778 (&info->lock){....}-{2:2}, at: shmem_uncharge+0x24/0x270 mm/shmem.c:341
> >
> > and this task is already holding:
> > ffff8880a851cac8 (&xa->xa_lock#4){..-.}-{2:2}, at: spin_lock include/linux/spinlock.h:353 [inline]
> > ffff8880a851cac8 (&xa->xa_lock#4){..-.}-{2:2}, at: split_huge_page_to_list+0xad0/0x33b0 mm/huge_memory.c:2864
> > which would create a new lock dependency:
> >  (&xa->xa_lock#4){..-.}-{2:2} -> (&info->lock){....}-{2:2}
> >
> > but this new dependency connects a SOFTIRQ-irq-safe lock:
> >  (&xa->xa_lock#4){..-.}-{2:2}
>
> It looks shmem_uncharge() is just called by __split_huge_page() and
> collapse_file(). The collapse_file() has acquired xa_lock with irq
> disabled before acquiring info->lock, so it is safe.
> __split_huge_page() is called with holding xa_lock with irq enabled,
> but lru_lock is acquired with irq disabled before acquiring xa_lock.
>
> So, it is unnecessary to acquire info->lock with irq disabled in
> shmem_uncharge(). Can syzbot try the below patch?

Hi Yang,

Yes, sure, please see:
https://github.com/google/syzkaller/blob/master/docs/syzbot.md#testing-patches

> diff --git a/mm/shmem.c b/mm/shmem.c
> index d722eb8..100117b 100644
> --- a/mm/shmem.c
> +++ b/mm/shmem.c
> @@ -334,15 +334,14 @@ bool shmem_charge(struct inode *inode, long pages)
>  void shmem_uncharge(struct inode *inode, long pages)
>  {
>         struct shmem_inode_info *info = SHMEM_I(inode);
> -       unsigned long flags;
>
>         /* nrpages adjustment done by __delete_from_page_cache() or caller */
>
> -       spin_lock_irqsave(&info->lock, flags);
> +       spin_lock(&info->lock);
>         info->alloced -= pages;
>         inode->i_blocks -= pages * BLOCKS_PER_PAGE;
>         shmem_recalc_inode(inode);
> -       spin_unlock_irqrestore(&info->lock, flags);
> +       spin_unlock(&info->lock);
>
>         shmem_inode_unacct_blocks(inode, pages);
>  }
>
>
>
> >
> > ... which became SOFTIRQ-irq-safe at:
> >   lock_acquire+0x1f2/0x8f0 kernel/locking/lockdep.c:4923
> >   __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
> >   _raw_spin_lock_irqsave+0x8c/0xbf kernel/locking/spinlock.c:159
> >   test_clear_page_writeback+0x1d7/0x11e0 mm/page-writeback.c:2728
> >   end_page_writeback+0x239/0x520 mm/filemap.c:1317
> >   end_buffer_async_write+0x442/0x5c0 fs/buffer.c:384
> >   end_bio_bh_io_sync+0xe2/0x140 fs/buffer.c:3012
> >   bio_endio+0x473/0x820 block/bio.c:1422
> >   req_bio_endio block/blk-core.c:245 [inline]
> >   blk_update_request+0x3e1/0xdc0 block/blk-core.c:1472
> >   scsi_end_request+0x80/0x7b0 drivers/scsi/scsi_lib.c:575
> >   scsi_io_completion+0x1e7/0x1300 drivers/scsi/scsi_lib.c:959
> >   scsi_softirq_done+0x31e/0x3b0 drivers/scsi/scsi_lib.c:1454
> >   blk_done_softirq+0x2db/0x440 block/blk-softirq.c:37
> >   __do_softirq+0x26c/0x9f7 kernel/softirq.c:292
> >   invoke_softirq kernel/softirq.c:373 [inline]
> >   irq_exit+0x192/0x1d0 kernel/softirq.c:413
> >   exiting_irq arch/x86/include/asm/apic.h:546 [inline]
> >   do_IRQ+0xda/0x270 arch/x86/kernel/irq.c:263
> >   ret_from_intr+0x0/0x2b
> >   arch_local_irq_restore arch/x86/include/asm/paravirt.h:759 [inline]
> >   lock_acquire+0x267/0x8f0 kernel/locking/lockdep.c:4926
> >   down_write+0x8d/0x150 kernel/locking/rwsem.c:1531
> >   inode_lock include/linux/fs.h:797 [inline]
> >   process_measurement+0x68a/0x1750 security/integrity/ima/ima_main.c:228
> >   ima_file_check+0xb9/0x100 security/integrity/ima/ima_main.c:440
> >   do_open fs/namei.c:3231 [inline]
> >   path_openat+0x1997/0x27d0 fs/namei.c:3346
> >   do_filp_open+0x192/0x260 fs/namei.c:3373
> >   do_sys_openat2+0x585/0x7d0 fs/open.c:1148
> >   do_sys_open+0xc3/0x140 fs/open.c:1164
> >   do_syscall_64+0xf6/0x7d0 arch/x86/entry/common.c:295
> >   entry_SYSCALL_64_after_hwframe+0x49/0xb3
> >
> > to a SOFTIRQ-irq-unsafe lock:
> >  (shmlock_user_lock){+.+.}-{2:2}
> >
> > ... which became SOFTIRQ-irq-unsafe at:
> > ...
> >   lock_acquire+0x1f2/0x8f0 kernel/locking/lockdep.c:4923
> >   __raw_spin_lock include/linux/spinlock_api_smp.h:142 [inline]
> >   _raw_spin_lock+0x2a/0x40 kernel/locking/spinlock.c:151
> >   spin_lock include/linux/spinlock.h:353 [inline]
> >   user_shm_lock+0xab/0x230 mm/mlock.c:855
> >   hugetlb_file_setup+0x4e1/0x677 fs/hugetlbfs/inode.c:1416
> >   newseg+0x460/0xe60 ipc/shm.c:652
> >   ipcget_new ipc/util.c:344 [inline]
> >   ipcget+0xf0/0xcb0 ipc/util.c:643
> >   ksys_shmget ipc/shm.c:742 [inline]
> >   __do_sys_shmget ipc/shm.c:747 [inline]
> >   __se_sys_shmget ipc/shm.c:745 [inline]
> >   __x64_sys_shmget+0x139/0x1a0 ipc/shm.c:745
> >   do_syscall_64+0xf6/0x7d0 arch/x86/entry/common.c:295
> >   entry_SYSCALL_64_after_hwframe+0x49/0xb3
> >
> > other info that might help us debug this:
> >
> > Chain exists of:
> >   &xa->xa_lock#4 --> &info->lock --> shmlock_user_lock
> >
> >  Possible interrupt unsafe locking scenario:
> >
> >        CPU0                    CPU1
> >        ----                    ----
> >   lock(shmlock_user_lock);
> >                                local_irq_disable();
> >                                lock(&xa->xa_lock#4);
> >                                lock(&info->lock);
> >   <Interrupt>
> >     lock(&xa->xa_lock#4);
> >
> >  *** DEADLOCK ***
> >
> > 5 locks held by syz-executor428/8337:
> >  #0: ffff8880a7948450 (sb_writers#7){.+.+}-{0:0}, at: sb_start_write include/linux/fs.h:1655 [inline]
> >  #0: ffff8880a7948450 (sb_writers#7){.+.+}-{0:0}, at: do_sys_ftruncate+0x29f/0x570 fs/open.c:190
> >  #1: ffff8880a851c9d0 (&sb->s_type->i_mutex_key#16){+.+.}-{3:3}, at: inode_lock include/linux/fs.h:797 [inline]
> >  #1: ffff8880a851c9d0 (&sb->s_type->i_mutex_key#16){+.+.}-{3:3}, at: do_truncate+0x125/0x1f0 fs/open.c:62
> >  #2: ffff8880a851cb90 (&mapping->i_mmap_rwsem){++++}-{3:3}, at: i_mmap_lock_read include/linux/fs.h:541 [inline]
> >  #2: ffff8880a851cb90 (&mapping->i_mmap_rwsem){++++}-{3:3}, at: split_huge_page_to_list+0x4c3/0x33b0 mm/huge_memory.c:2825
> >  #3: ffff88812ffffcd8 (&pgdat->lru_lock){....}-{2:2}, at: split_huge_page_to_list+0x8da/0x33b0 mm/huge_memory.c:2855
> >  #4: ffff8880a851cac8 (&xa->xa_lock#4){..-.}-{2:2}, at: spin_lock include/linux/spinlock.h:353 [inline]
> >  #4: ffff8880a851cac8 (&xa->xa_lock#4){..-.}-{2:2}, at: split_huge_page_to_list+0xad0/0x33b0 mm/huge_memory.c:2864
> >
> > the dependencies between SOFTIRQ-irq-safe lock and the holding lock:
> > -> (&xa->xa_lock#4){..-.}-{2:2} {
> >    IN-SOFTIRQ-W at:
> >                     lock_acquire+0x1f2/0x8f0 kernel/locking/lockdep.c:4923
> >                     __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
> >                     _raw_spin_lock_irqsave+0x8c/0xbf kernel/locking/spinlock.c:159
> >                     test_clear_page_writeback+0x1d7/0x11e0 mm/page-writeback.c:2728
> >                     end_page_writeback+0x239/0x520 mm/filemap.c:1317
> >                     end_buffer_async_write+0x442/0x5c0 fs/buffer.c:384
> >                     end_bio_bh_io_sync+0xe2/0x140 fs/buffer.c:3012
> >                     bio_endio+0x473/0x820 block/bio.c:1422
> >                     req_bio_endio block/blk-core.c:245 [inline]
> >                     blk_update_request+0x3e1/0xdc0 block/blk-core.c:1472
> >                     scsi_end_request+0x80/0x7b0 drivers/scsi/scsi_lib.c:575
> >                     scsi_io_completion+0x1e7/0x1300 drivers/scsi/scsi_lib.c:959
> >                     scsi_softirq_done+0x31e/0x3b0 drivers/scsi/scsi_lib.c:1454
> >                     blk_done_softirq+0x2db/0x440 block/blk-softirq.c:37
> >                     __do_softirq+0x26c/0x9f7 kernel/softirq.c:292
> >                     invoke_softirq kernel/softirq.c:373 [inline]
> >                     irq_exit+0x192/0x1d0 kernel/softirq.c:413
> >                     exiting_irq arch/x86/include/asm/apic.h:546 [inline]
> >                     do_IRQ+0xda/0x270 arch/x86/kernel/irq.c:263
> >                     ret_from_intr+0x0/0x2b
> >                     arch_local_irq_restore arch/x86/include/asm/paravirt.h:759 [inline]
> >                     lock_acquire+0x267/0x8f0 kernel/locking/lockdep.c:4926
> >                     down_write+0x8d/0x150 kernel/locking/rwsem.c:1531
> >                     inode_lock include/linux/fs.h:797 [inline]
> >                     process_measurement+0x68a/0x1750 security/integrity/ima/ima_main.c:228
> >                     ima_file_check+0xb9/0x100 security/integrity/ima/ima_main.c:440
> >                     do_open fs/namei.c:3231 [inline]
> >                     path_openat+0x1997/0x27d0 fs/namei.c:3346
> >                     do_filp_open+0x192/0x260 fs/namei.c:3373
> >                     do_sys_openat2+0x585/0x7d0 fs/open.c:1148
> >                     do_sys_open+0xc3/0x140 fs/open.c:1164
> >                     do_syscall_64+0xf6/0x7d0 arch/x86/entry/common.c:295
> >                     entry_SYSCALL_64_after_hwframe+0x49/0xb3
> >    INITIAL USE at:
> >                    lock_acquire+0x1f2/0x8f0 kernel/locking/lockdep.c:4923
> >                    __raw_spin_lock_irq include/linux/spinlock_api_smp.h:128 [inline]
> >                    _raw_spin_lock_irq+0x5b/0x80 kernel/locking/spinlock.c:167
> >                    spin_lock_irq include/linux/spinlock.h:378 [inline]
> >                    __add_to_page_cache_locked+0x607/0xe00 mm/filemap.c:855
> >                    add_to_page_cache_lru+0x1aa/0x700 mm/filemap.c:921
> >                    do_read_cache_page+0x9ab/0x1810 mm/filemap.c:2755
> >                    read_mapping_page include/linux/pagemap.h:397 [inline]
> >                    read_part_sector+0xf6/0x600 block/partitions/core.c:643
> >                    adfspart_check_ICS+0x9d/0xc80 block/partitions/acorn.c:360
> >                    check_partition block/partitions/core.c:140 [inline]
> >                    blk_add_partitions+0x474/0xe50 block/partitions/core.c:571
> >                    bdev_disk_changed+0x1fb/0x380 fs/block_dev.c:1544
> >                    __blkdev_get+0xb15/0x1530 fs/block_dev.c:1647
> >                    blkdev_get+0x41/0x2b0 fs/block_dev.c:1749
> >                    register_disk block/genhd.c:763 [inline]
> >                    __device_add_disk+0xa4f/0x1170 block/genhd.c:853
> >                    add_disk include/linux/genhd.h:294 [inline]
> >                    brd_init+0x297/0x463 drivers/block/brd.c:533
> >                    do_one_initcall+0x10a/0x7d0 init/main.c:1158
> >                    do_initcall_level init/main.c:1231 [inline]
> >                    do_initcalls init/main.c:1247 [inline]
> >                    do_basic_setup init/main.c:1267 [inline]
> >                    kernel_init_freeable+0x501/0x5ae init/main.c:1451
> >                    kernel_init+0xd/0x1bb init/main.c:1358
> >                    ret_from_fork+0x24/0x30 arch/x86/entry/entry_64.S:352
> >  }
> >  ... key      at: [<ffffffff8c67b1e0>] __key.18007+0x0/0x40
> >  ... acquired at:
> >    lock_acquire+0x1f2/0x8f0 kernel/locking/lockdep.c:4923
> >    __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
> >    _raw_spin_lock_irqsave+0x8c/0xbf kernel/locking/spinlock.c:159
> >    shmem_uncharge+0x24/0x270 mm/shmem.c:341
> >    __split_huge_page mm/huge_memory.c:2613 [inline]
> >    split_huge_page_to_list+0x274b/0x33b0 mm/huge_memory.c:2886
> >    split_huge_page include/linux/huge_mm.h:204 [inline]
> >    shmem_punch_compound+0x13e/0x1e0 mm/shmem.c:814
> >    shmem_undo_range+0x5f1/0x1b80 mm/shmem.c:870
> >    shmem_truncate_range+0x27/0xa0 mm/shmem.c:980
> >    shmem_setattr+0x8b6/0xc80 mm/shmem.c:1039
> >    notify_change+0xb6d/0x1020 fs/attr.c:336
> >    do_truncate+0x134/0x1f0 fs/open.c:64
> >    do_sys_ftruncate+0x4a5/0x570 fs/open.c:195
> >    do_syscall_64+0xf6/0x7d0 arch/x86/entry/common.c:295
> >    entry_SYSCALL_64_after_hwframe+0x49/0xb3
> >
> >
> > the dependencies between the lock to be acquired
> >  and SOFTIRQ-irq-unsafe lock:
> >  -> (shmlock_user_lock){+.+.}-{2:2} {
> >     HARDIRQ-ON-W at:
> >                       lock_acquire+0x1f2/0x8f0 kernel/locking/lockdep.c:4923
> >                       __raw_spin_lock include/linux/spinlock_api_smp.h:142 [inline]
> >                       _raw_spin_lock+0x2a/0x40 kernel/locking/spinlock.c:151
> >                       spin_lock include/linux/spinlock.h:353 [inline]
> >                       user_shm_lock+0xab/0x230 mm/mlock.c:855
> >                       hugetlb_file_setup+0x4e1/0x677 fs/hugetlbfs/inode.c:1416
> >                       newseg+0x460/0xe60 ipc/shm.c:652
> >                       ipcget_new ipc/util.c:344 [inline]
> >                       ipcget+0xf0/0xcb0 ipc/util.c:643
> >                       ksys_shmget ipc/shm.c:742 [inline]
> >                       __do_sys_shmget ipc/shm.c:747 [inline]
> >                       __se_sys_shmget ipc/shm.c:745 [inline]
> >                       __x64_sys_shmget+0x139/0x1a0 ipc/shm.c:745
> >                       do_syscall_64+0xf6/0x7d0 arch/x86/entry/common.c:295
> >                       entry_SYSCALL_64_after_hwframe+0x49/0xb3
> >     SOFTIRQ-ON-W at:
> >                       lock_acquire+0x1f2/0x8f0 kernel/locking/lockdep.c:4923
> >                       __raw_spin_lock include/linux/spinlock_api_smp.h:142 [inline]
> >                       _raw_spin_lock+0x2a/0x40 kernel/locking/spinlock.c:151
> >                       spin_lock include/linux/spinlock.h:353 [inline]
> >                       user_shm_lock+0xab/0x230 mm/mlock.c:855
> >                       hugetlb_file_setup+0x4e1/0x677 fs/hugetlbfs/inode.c:1416
> >                       newseg+0x460/0xe60 ipc/shm.c:652
> >                       ipcget_new ipc/util.c:344 [inline]
> >                       ipcget+0xf0/0xcb0 ipc/util.c:643
> >                       ksys_shmget ipc/shm.c:742 [inline]
> >                       __do_sys_shmget ipc/shm.c:747 [inline]
> >                       __se_sys_shmget ipc/shm.c:745 [inline]
> >                       __x64_sys_shmget+0x139/0x1a0 ipc/shm.c:745
> >                       do_syscall_64+0xf6/0x7d0 arch/x86/entry/common.c:295
> >                       entry_SYSCALL_64_after_hwframe+0x49/0xb3
> >     INITIAL USE at:
> >                      lock_acquire+0x1f2/0x8f0 kernel/locking/lockdep.c:4923
> >                      __raw_spin_lock include/linux/spinlock_api_smp.h:142 [inline]
> >                      _raw_spin_lock+0x2a/0x40 kernel/locking/spinlock.c:151
> >                      spin_lock include/linux/spinlock.h:353 [inline]
> >                      user_shm_lock+0xab/0x230 mm/mlock.c:855
> >                      shmem_lock+0x1dd/0x2d0 mm/shmem.c:2184
> >                      shmctl_do_lock+0x73f/0x8f0 ipc/shm.c:1111
> >                      ksys_shmctl.constprop.0+0x203/0x350 ipc/shm.c:1188
> >                      do_syscall_64+0xf6/0x7d0 arch/x86/entry/common.c:295
> >                      entry_SYSCALL_64_after_hwframe+0x49/0xb3
> >   }
> >   ... key      at: [<ffffffff89a5e858>] shmlock_user_lock+0x18/0x5c0
> >   ... acquired at:
> >    __raw_spin_lock include/linux/spinlock_api_smp.h:142 [inline]
> >    _raw_spin_lock+0x2a/0x40 kernel/locking/spinlock.c:151
> >    spin_lock include/linux/spinlock.h:353 [inline]
> >    user_shm_lock+0xab/0x230 mm/mlock.c:855
> >    shmem_lock+0x1dd/0x2d0 mm/shmem.c:2184
> >    shmctl_do_lock+0x73f/0x8f0 ipc/shm.c:1111
> >    ksys_shmctl.constprop.0+0x203/0x350 ipc/shm.c:1188
> >    do_syscall_64+0xf6/0x7d0 arch/x86/entry/common.c:295
> >    entry_SYSCALL_64_after_hwframe+0x49/0xb3
> >
> > -> (&info->lock){....}-{2:2} {
> >    INITIAL USE at:
> >                    lock_acquire+0x1f2/0x8f0 kernel/locking/lockdep.c:4923
> >                    __raw_spin_lock_irq include/linux/spinlock_api_smp.h:128 [inline]
> >                    _raw_spin_lock_irq+0x5b/0x80 kernel/locking/spinlock.c:167
> >                    spin_lock_irq include/linux/spinlock.h:378 [inline]
> >                    shmem_getpage_gfp+0x937/0x2a10 mm/shmem.c:1882
> >                    shmem_getpage mm/shmem.c:154 [inline]
> >                    shmem_write_begin+0x102/0x1e0 mm/shmem.c:2483
> >                    generic_perform_write+0x20a/0x4e0 mm/filemap.c:3302
> >                    __generic_file_write_iter+0x24c/0x610 mm/filemap.c:3431
> >                    generic_file_write_iter+0x3f3/0x630 mm/filemap.c:3463
> >                    call_write_iter include/linux/fs.h:1907 [inline]
> >                    new_sync_write+0x4a2/0x700 fs/read_write.c:483
> >                    __vfs_write+0xc9/0x100 fs/read_write.c:496
> >                    vfs_write+0x268/0x5d0 fs/read_write.c:558
> >                    ksys_write+0x12d/0x250 fs/read_write.c:611
> >                    do_syscall_64+0xf6/0x7d0 arch/x86/entry/common.c:295
> >                    entry_SYSCALL_64_after_hwframe+0x49/0xb3
> >  }
> >  ... key      at: [<ffffffff8c667e80>] __key.56422+0x0/0x40
> >  ... acquired at:
> >    lock_acquire+0x1f2/0x8f0 kernel/locking/lockdep.c:4923
> >    __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
> >    _raw_spin_lock_irqsave+0x8c/0xbf kernel/locking/spinlock.c:159
> >    shmem_uncharge+0x24/0x270 mm/shmem.c:341
> >    __split_huge_page mm/huge_memory.c:2613 [inline]
> >    split_huge_page_to_list+0x274b/0x33b0 mm/huge_memory.c:2886
> >    split_huge_page include/linux/huge_mm.h:204 [inline]
> >    shmem_punch_compound+0x13e/0x1e0 mm/shmem.c:814
> >    shmem_undo_range+0x5f1/0x1b80 mm/shmem.c:870
> >    shmem_truncate_range+0x27/0xa0 mm/shmem.c:980
> >    shmem_setattr+0x8b6/0xc80 mm/shmem.c:1039
> >    notify_change+0xb6d/0x1020 fs/attr.c:336
> >    do_truncate+0x134/0x1f0 fs/open.c:64
> >    do_sys_ftruncate+0x4a5/0x570 fs/open.c:195
> >    do_syscall_64+0xf6/0x7d0 arch/x86/entry/common.c:295
> >    entry_SYSCALL_64_after_hwframe+0x49/0xb3
> >
> >
> > stack backtrace:
> > CPU: 0 PID: 8337 Comm: syz-executor428 Not tainted 5.6.0-syzkaller #0
> > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> > Call Trace:
> >  __dump_stack lib/dump_stack.c:77 [inline]
> >  dump_stack+0x188/0x20d lib/dump_stack.c:118
> >  print_bad_irq_dependency kernel/locking/lockdep.c:2132 [inline]
> >  check_irq_usage.cold+0x566/0x6de kernel/locking/lockdep.c:2330
> >  check_prev_add kernel/locking/lockdep.c:2519 [inline]
> >  check_prevs_add kernel/locking/lockdep.c:2620 [inline]
> >  validate_chain kernel/locking/lockdep.c:3237 [inline]
> >  __lock_acquire+0x2c39/0x4e00 kernel/locking/lockdep.c:4344
> >  lock_acquire+0x1f2/0x8f0 kernel/locking/lockdep.c:4923
> >  __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
> >  _raw_spin_lock_irqsave+0x8c/0xbf kernel/locking/spinlock.c:159
> >  shmem_uncharge+0x24/0x270 mm/shmem.c:341
> >  __split_huge_page mm/huge_memory.c:2613 [inline]
> >  split_huge_page_to_list+0x274b/0x33b0 mm/huge_memory.c:2886
> >  split_huge_page include/linux/huge_mm.h:204 [inline]
> >  shmem_punch_compound+0x13e/0x1e0 mm/shmem.c:814
> >  shmem_undo_range+0x5f1/0x1b80 mm/shmem.c:870
> >  shmem_truncate_range+0x27/0xa0 mm/shmem.c:980
> >  shmem_setattr+0x8b6/0xc80 mm/shmem.c:1039
> >  notify_change+0xb6d/0x1020 fs/attr.c:336
> >  do_truncate+0x134/0x1f0 fs/open.c:64
> >  do_sys_ftruncate+0x4a5/0x570 fs/open.c:195
> >  do_syscall_64+0xf6/0x7d0 arch/x86/entry/common.c:295
> >  entry_SYSCALL_64_after_hwframe+0x49/0xb3
> > RIP: 0033:0x44e769
> > Code: 4d c9 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 0f 83 1b c9 fb ff c3 66 2e 0f 1f 84 00 00 00 00
> > RSP: 002b:00007fe511b3fce8 EFLAGS: 00000246 ORIG_RAX: 000000000000004d
> > RAX: ffffffffffffffda RBX: 00000000006e1c68 RCX: 000000000044e769
> > RDX: 000000000044e769 RSI: 00000000000001ff RDI: 0000000000000006
> > RBP: 00000000006e1c60 R08: 0000000000000000 R09: 0000000000000000
> > R10: 0000000000000000 R11: 0000000000000246 R12: 00000000006e1c6c
> > R13: 00007ffce699f92f R14: 00007fe511b409c0 R15: 0000000000000000
> >
> >
> > ---
> > This bug is generated by a bot. It may contain errors.
> > See https://goo.gl/tpsmEJ for more information about syzbot.
> > syzbot engineers can be reached at syzkaller@googlegroups.com.
> >
> > syzbot will keep track of this bug report. See:
> > https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> > For information about bisection process see: https://goo.gl/tpsmEJ#bisection
> > syzbot can test patches for this bug, for details see:
> > https://goo.gl/tpsmEJ#testing-patches
> >
>
> --
> You received this message because you are subscribed to the Google Groups "syzkaller-bugs" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to syzkaller-bugs+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/syzkaller-bugs/CAHbLzkpJjpOjizxhG6oS1OsbdycwaRdLeA8nb1R4Y2C4F7nV%2Bg%40mail.gmail.com.
