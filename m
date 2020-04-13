Return-Path: <SRS0=sVLE=55=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 877F0C2BA2B
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 20:21:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5908520663
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 20:21:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388295AbgDMUVV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Apr 2020 16:21:21 -0400
Received: from mail-io1-f69.google.com ([209.85.166.69]:57214 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388255AbgDMUVR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Apr 2020 16:21:17 -0400
Received: by mail-io1-f69.google.com with SMTP id v3so12278628iod.23
        for <linux-kernel@vger.kernel.org>; Mon, 13 Apr 2020 13:21:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=+hxELYYS+CrlEZydhJXCDKBiHzvX48NijArFbY5MNb4=;
        b=jwaO/zHsTRBIcKKaJ9Puefvu6qHXGeZHX7ZuMq9BbIi4Az+5E5447Jd4bmp+IbnJm6
         +hQvvEvVIJDNouiBhM6pGhOuoSAanRwoUr5pceCg/ftWqNUMLz2o51dMvVzduvrphxTs
         tE23DdldUUV4V1+5r6ctqd3L6so+E8GgaWqIeCouup24D8R8cLnXuGPMvEk9hEUxZIJ5
         EyBgpsUXYk2WUxp8hda+Z2v3B+K7Ifr1/G5uB+2ItAwtyJyGoVA47VqXU2XKDjmdl1wQ
         2CRGgpNtOrlU7Ctl4L5lKaVCCiM52yFFXryJ3YSj9tjtzjX0zIY/6cfKdApqIMBV8tY6
         NCGg==
X-Gm-Message-State: AGi0PuZC3HcrFWvM+o4QCEiZtvh3CirsQlfVqyl5a2mvYzbcvbv3GWYG
        47LhmrNko1JntIE2O0XQybvhjEVoAsHDe+DVu2t23AZbryu1
X-Google-Smtp-Source: APiQypJ26UZb4yNI3pm+PbCr8m4XvngvwG7hkagbSUFzi+/QP4oCrVtVv6QMznFTRnSaYw7ZP5+8TIt+Yauhyhl87KpWboR0DjiP
MIME-Version: 1.0
X-Received: by 2002:a92:5d0f:: with SMTP id r15mr18634018ilb.251.1586809275878;
 Mon, 13 Apr 2020 13:21:15 -0700 (PDT)
Date:   Mon, 13 Apr 2020 13:21:15 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000003712b305a331d3b1@google.com>
Subject: possible deadlock in user_shm_lock
From:   syzbot <syzbot+40b71e145e73f78f81ad@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    ab6f762f printk: queue wake_up_klogd irq_work only if per-..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=17b90b2be00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=23c5a352e32a1944
dashboard link: https://syzkaller.appspot.com/bug?extid=40b71e145e73f78f81ad
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+40b71e145e73f78f81ad@syzkaller.appspotmail.com

========================================================
WARNING: possible irq lock inversion dependency detected
5.6.0-syzkaller #0 Not tainted
--------------------------------------------------------
syz-executor.0/28978 just changed the state of lock:
ffffffff89a5ee98 (shmlock_user_lock){+.+.}-{2:2}, at: spin_lock include/linux/spinlock.h:353 [inline]
ffffffff89a5ee98 (shmlock_user_lock){+.+.}-{2:2}, at: user_shm_lock+0xab/0x230 mm/mlock.c:855
but this lock was taken by another, SOFTIRQ-safe lock in the past:
 (&xa->xa_lock#4){..-.}-{2:2}


and interrupts could create inverse lock ordering between them.


other info that might help us debug this:
Chain exists of:
  &xa->xa_lock#4 --> &info->lock --> shmlock_user_lock

 Possible interrupt unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(shmlock_user_lock);
                               local_irq_disable();
                               lock(&xa->xa_lock#4);
                               lock(&info->lock);
  <Interrupt>
    lock(&xa->xa_lock#4);

 *** DEADLOCK ***

1 lock held by syz-executor.0/28978:
 #0: ffff88809ab12550 (&ids->rwsem){++++}-{3:3}, at: ipcget_new ipc/util.c:343 [inline]
 #0: ffff88809ab12550 (&ids->rwsem){++++}-{3:3}, at: ipcget+0xc6/0xcb0 ipc/util.c:643

the shortest dependencies between 2nd lock and 1st lock:
  -> (&xa->xa_lock#4){..-.}-{2:2} {
     IN-SOFTIRQ-W at:
                        lock_acquire+0x1f2/0x8f0 kernel/locking/lockdep.c:4923
                        __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
                        _raw_spin_lock_irqsave+0x8c/0xbf kernel/locking/spinlock.c:159
                        test_clear_page_writeback+0x1d7/0x11e0 mm/page-writeback.c:2728
                        end_page_writeback+0x239/0x520 mm/filemap.c:1317
                        end_buffer_async_write+0x442/0x5c0 fs/buffer.c:384
                        end_bio_bh_io_sync+0xe2/0x140 fs/buffer.c:3012
                        bio_endio+0x473/0x820 block/bio.c:1422
                        req_bio_endio block/blk-core.c:245 [inline]
                        blk_update_request+0x3e1/0xdc0 block/blk-core.c:1472
                        scsi_end_request+0x80/0x7b0 drivers/scsi/scsi_lib.c:575
                        scsi_io_completion+0x1e7/0x1300 drivers/scsi/scsi_lib.c:959
                        scsi_softirq_done+0x31e/0x3b0 drivers/scsi/scsi_lib.c:1454
                        blk_done_softirq+0x2db/0x440 block/blk-softirq.c:37
                        __do_softirq+0x26c/0x9f7 kernel/softirq.c:292
                        invoke_softirq kernel/softirq.c:373 [inline]
                        irq_exit+0x192/0x1d0 kernel/softirq.c:413
                        exiting_irq arch/x86/include/asm/apic.h:546 [inline]
                        do_IRQ+0xda/0x270 arch/x86/kernel/irq.c:263
                        ret_from_intr+0x0/0x2b
                        arch_local_irq_enable arch/x86/include/asm/paravirt.h:769 [inline]
                        __raw_spin_unlock_irq include/linux/spinlock_api_smp.h:168 [inline]
                        _raw_spin_unlock_irq+0x4b/0x80 kernel/locking/spinlock.c:199
                        do_exit+0x57b/0x2dd0 kernel/exit.c:774
                        call_usermodehelper_exec_async+0x507/0x710 kernel/umh.c:125
                        ret_from_fork+0x24/0x30 arch/x86/entry/entry_64.S:352
     INITIAL USE at:
                       lock_acquire+0x1f2/0x8f0 kernel/locking/lockdep.c:4923
                       __raw_spin_lock_irq include/linux/spinlock_api_smp.h:128 [inline]
                       _raw_spin_lock_irq+0x5b/0x80 kernel/locking/spinlock.c:167
                       spin_lock_irq include/linux/spinlock.h:378 [inline]
                       __add_to_page_cache_locked+0x607/0xe00 mm/filemap.c:855
                       add_to_page_cache_lru+0x1aa/0x700 mm/filemap.c:921
                       do_read_cache_page+0x9ab/0x1810 mm/filemap.c:2755
                       read_mapping_page include/linux/pagemap.h:397 [inline]
                       read_part_sector+0xf6/0x600 block/partitions/core.c:643
                       adfspart_check_ICS+0x9d/0xc80 block/partitions/acorn.c:360
                       check_partition block/partitions/core.c:140 [inline]
                       blk_add_partitions+0x474/0xe50 block/partitions/core.c:571
                       bdev_disk_changed+0x1fb/0x380 fs/block_dev.c:1544
                       __blkdev_get+0xb15/0x1530 fs/block_dev.c:1647
                       blkdev_get+0x41/0x2b0 fs/block_dev.c:1749
                       register_disk block/genhd.c:763 [inline]
                       __device_add_disk+0xa4f/0x1170 block/genhd.c:853
                       add_disk include/linux/genhd.h:294 [inline]
                       brd_init+0x297/0x463 drivers/block/brd.c:533
                       do_one_initcall+0x10a/0x7d0 init/main.c:1157
                       do_initcall_level init/main.c:1230 [inline]
                       do_initcalls init/main.c:1246 [inline]
                       do_basic_setup init/main.c:1266 [inline]
                       kernel_init_freeable+0x501/0x5ae init/main.c:1450
                       kernel_init+0xd/0x1bb init/main.c:1357
                       ret_from_fork+0x24/0x30 arch/x86/entry/entry_64.S:352
   }
   ... key      at: [<ffffffff8c681e60>] __key.18009+0x0/0x40
   ... acquired at:
   __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
   _raw_spin_lock_irqsave+0x8c/0xbf kernel/locking/spinlock.c:159
   shmem_uncharge+0x24/0x270 mm/shmem.c:341
   __split_huge_page mm/huge_memory.c:2613 [inline]
   split_huge_page_to_list+0x274b/0x33b0 mm/huge_memory.c:2886
   split_huge_page include/linux/huge_mm.h:204 [inline]
   shmem_punch_compound+0x13e/0x1e0 mm/shmem.c:814
   shmem_undo_range+0x5f1/0x1b80 mm/shmem.c:870
   shmem_truncate_range+0x27/0xa0 mm/shmem.c:980
   shmem_setattr+0x8b6/0xc80 mm/shmem.c:1039
   notify_change+0xb6d/0x1020 fs/attr.c:336
   do_truncate+0x134/0x1f0 fs/open.c:64
   do_sys_ftruncate+0x4a5/0x570 fs/open.c:195
   do_syscall_64+0xf6/0x7d0 arch/x86/entry/common.c:295
   entry_SYSCALL_64_after_hwframe+0x49/0xb3

 -> (&info->lock){....}-{2:2} {
    INITIAL USE at:
                     lock_acquire+0x1f2/0x8f0 kernel/locking/lockdep.c:4923
                     __raw_spin_lock_irq include/linux/spinlock_api_smp.h:128 [inline]
                     _raw_spin_lock_irq+0x5b/0x80 kernel/locking/spinlock.c:167
                     spin_lock_irq include/linux/spinlock.h:378 [inline]
                     shmem_getpage_gfp+0x937/0x2a10 mm/shmem.c:1882
                     shmem_getpage mm/shmem.c:154 [inline]
                     shmem_write_begin+0x102/0x1e0 mm/shmem.c:2483
                     generic_perform_write+0x20a/0x4e0 mm/filemap.c:3302
                     __generic_file_write_iter+0x24c/0x610 mm/filemap.c:3431
                     generic_file_write_iter+0x3f3/0x630 mm/filemap.c:3463
                     call_write_iter include/linux/fs.h:1907 [inline]
                     new_sync_write+0x4a2/0x700 fs/read_write.c:484
                     __vfs_write+0xc9/0x100 fs/read_write.c:497
                     vfs_write+0x268/0x5d0 fs/read_write.c:559
                     ksys_write+0x12d/0x250 fs/read_write.c:612
                     do_syscall_64+0xf6/0x7d0 arch/x86/entry/common.c:295
                     entry_SYSCALL_64_after_hwframe+0x49/0xb3
  }
  ... key      at: [<ffffffff8c66eb00>] __key.56434+0x0/0x40
  ... acquired at:
   __raw_spin_lock include/linux/spinlock_api_smp.h:142 [inline]
   _raw_spin_lock+0x2a/0x40 kernel/locking/spinlock.c:151
   spin_lock include/linux/spinlock.h:353 [inline]
   user_shm_lock+0xab/0x230 mm/mlock.c:855
   shmem_lock+0x1dd/0x2d0 mm/shmem.c:2184
   shmctl_do_lock+0x73f/0x8f0 ipc/shm.c:1111
   ksys_shmctl.constprop.0+0x203/0x350 ipc/shm.c:1188
   do_syscall_64+0xf6/0x7d0 arch/x86/entry/common.c:295
   entry_SYSCALL_64_after_hwframe+0x49/0xb3

-> (shmlock_user_lock){+.+.}-{2:2} {
   HARDIRQ-ON-W at:
                    lock_acquire+0x1f2/0x8f0 kernel/locking/lockdep.c:4923
                    __raw_spin_lock include/linux/spinlock_api_smp.h:142 [inline]
                    _raw_spin_lock+0x2a/0x40 kernel/locking/spinlock.c:151
                    spin_lock include/linux/spinlock.h:353 [inline]
                    user_shm_lock+0xab/0x230 mm/mlock.c:855
                    hugetlb_file_setup+0x4e1/0x677 fs/hugetlbfs/inode.c:1416
                    newseg+0x460/0xe60 ipc/shm.c:652
                    ipcget_new ipc/util.c:344 [inline]
                    ipcget+0xf0/0xcb0 ipc/util.c:643
                    ksys_shmget ipc/shm.c:742 [inline]
                    __do_sys_shmget ipc/shm.c:747 [inline]
                    __se_sys_shmget ipc/shm.c:745 [inline]
                    __x64_sys_shmget+0x139/0x1a0 ipc/shm.c:745
                    do_syscall_64+0xf6/0x7d0 arch/x86/entry/common.c:295
                    entry_SYSCALL_64_after_hwframe+0x49/0xb3
   SOFTIRQ-ON-W at:
                    lock_acquire+0x1f2/0x8f0 kernel/locking/lockdep.c:4923
                    __raw_spin_lock include/linux/spinlock_api_smp.h:142 [inline]
                    _raw_spin_lock+0x2a/0x40 kernel/locking/spinlock.c:151
                    spin_lock include/linux/spinlock.h:353 [inline]
                    user_shm_lock+0xab/0x230 mm/mlock.c:855
                    hugetlb_file_setup+0x4e1/0x677 fs/hugetlbfs/inode.c:1416
                    newseg+0x460/0xe60 ipc/shm.c:652
                    ipcget_new ipc/util.c:344 [inline]
                    ipcget+0xf0/0xcb0 ipc/util.c:643
                    ksys_shmget ipc/shm.c:742 [inline]
                    __do_sys_shmget ipc/shm.c:747 [inline]
                    __se_sys_shmget ipc/shm.c:745 [inline]
                    __x64_sys_shmget+0x139/0x1a0 ipc/shm.c:745
                    do_syscall_64+0xf6/0x7d0 arch/x86/entry/common.c:295
                    entry_SYSCALL_64_after_hwframe+0x49/0xb3
   INITIAL USE at:
                   lock_acquire+0x1f2/0x8f0 kernel/locking/lockdep.c:4923
                   __raw_spin_lock include/linux/spinlock_api_smp.h:142 [inline]
                   _raw_spin_lock+0x2a/0x40 kernel/locking/spinlock.c:151
                   spin_lock include/linux/spinlock.h:353 [inline]
                   user_shm_lock+0xab/0x230 mm/mlock.c:855
                   shmem_lock+0x1dd/0x2d0 mm/shmem.c:2184
                   shmctl_do_lock+0x73f/0x8f0 ipc/shm.c:1111
                   ksys_shmctl.constprop.0+0x203/0x350 ipc/shm.c:1188
                   do_syscall_64+0xf6/0x7d0 arch/x86/entry/common.c:295
                   entry_SYSCALL_64_after_hwframe+0x49/0xb3
 }
 ... key      at: [<ffffffff89a5ee98>] shmlock_user_lock+0x18/0x5c0
 ... acquired at:
   mark_lock_irq kernel/locking/lockdep.c:3585 [inline]
   mark_lock+0x624/0xf10 kernel/locking/lockdep.c:3935
   mark_usage kernel/locking/lockdep.c:3852 [inline]
   __lock_acquire+0x990/0x4e00 kernel/locking/lockdep.c:4298
   lock_acquire+0x1f2/0x8f0 kernel/locking/lockdep.c:4923
   __raw_spin_lock include/linux/spinlock_api_smp.h:142 [inline]
   _raw_spin_lock+0x2a/0x40 kernel/locking/spinlock.c:151
   spin_lock include/linux/spinlock.h:353 [inline]
   user_shm_lock+0xab/0x230 mm/mlock.c:855
   hugetlb_file_setup+0x4e1/0x677 fs/hugetlbfs/inode.c:1416
   newseg+0x460/0xe60 ipc/shm.c:652
   ipcget_new ipc/util.c:344 [inline]
   ipcget+0xf0/0xcb0 ipc/util.c:643
   ksys_shmget ipc/shm.c:742 [inline]
   __do_sys_shmget ipc/shm.c:747 [inline]
   __se_sys_shmget ipc/shm.c:745 [inline]
   __x64_sys_shmget+0x139/0x1a0 ipc/shm.c:745
   do_syscall_64+0xf6/0x7d0 arch/x86/entry/common.c:295
   entry_SYSCALL_64_after_hwframe+0x49/0xb3


stack backtrace:
CPU: 0 PID: 28978 Comm: syz-executor.0 Not tainted 5.6.0-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x188/0x20d lib/dump_stack.c:118
 print_irq_inversion_bug kernel/locking/lockdep.c:3448 [inline]
 check_usage_backwards.cold+0x1d/0x26 kernel/locking/lockdep.c:3499
 mark_lock_irq kernel/locking/lockdep.c:3585 [inline]
 mark_lock+0x624/0xf10 kernel/locking/lockdep.c:3935
 mark_usage kernel/locking/lockdep.c:3852 [inline]
 __lock_acquire+0x990/0x4e00 kernel/locking/lockdep.c:4298
 lock_acquire+0x1f2/0x8f0 kernel/locking/lockdep.c:4923
 __raw_spin_lock include/linux/spinlock_api_smp.h:142 [inline]
 _raw_spin_lock+0x2a/0x40 kernel/locking/spinlock.c:151
 spin_lock include/linux/spinlock.h:353 [inline]
 user_shm_lock+0xab/0x230 mm/mlock.c:855
 hugetlb_file_setup+0x4e1/0x677 fs/hugetlbfs/inode.c:1416
 newseg+0x460/0xe60 ipc/shm.c:652
 ipcget_new ipc/util.c:344 [inline]
 ipcget+0xf0/0xcb0 ipc/util.c:643
 ksys_shmget ipc/shm.c:742 [inline]
 __do_sys_shmget ipc/shm.c:747 [inline]
 __se_sys_shmget ipc/shm.c:745 [inline]
 __x64_sys_shmget+0x139/0x1a0 ipc/shm.c:745
 do_syscall_64+0xf6/0x7d0 arch/x86/entry/common.c:295
 entry_SYSCALL_64_after_hwframe+0x49/0xb3
RIP: 0033:0x45c889
Code: ad b6 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 0f 83 7b b6 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007f8090c57c78 EFLAGS: 00000246 ORIG_RAX: 000000000000001d
RAX: ffffffffffffffda RBX: 00007f8090c586d4 RCX: 000000000045c889
RDX: 0000000078000e02 RSI: 0000000000003000 RDI: 0400000000000000
RBP: 000000000076bf00 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000020ff2000 R11: 0000000000000246 R12: 00000000ffffffff
R13: 0000000000000b5d R14: 00000000004cd951 R15: 000000000076bf0c


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
