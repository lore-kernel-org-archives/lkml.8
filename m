Return-Path: <SRS0=xbEg=53=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 745CBC2BA19
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Apr 2020 05:16:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 454662083E
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Apr 2020 05:16:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725934AbgDKFQP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Apr 2020 01:16:15 -0400
Received: from mail-il1-f197.google.com ([209.85.166.197]:45328 "EHLO
        mail-il1-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725866AbgDKFQO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Apr 2020 01:16:14 -0400
Received: by mail-il1-f197.google.com with SMTP id f75so1315256ilh.12
        for <linux-kernel@vger.kernel.org>; Fri, 10 Apr 2020 22:16:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=/kYUXOT2betcs2p+6SrtlCQjaoLX2ndv29him/vG9B0=;
        b=tb38a3GSYDZKeq/MvZCgEFH0Allb2t3Tg058nMgIn4+uFAtouNQrWGJZKKLr5Pa9E8
         v7YrH4ZQsEm/ZGnA2dbO06k0j6fK2NiWgZyeO55E1rC600eSaxgILypYGTJ82o7SKxC2
         oLNW2FJJmT2Hhf/s+NBHVa1O2fZBY0567x2rYFK4h/VGKkJQ66UeRc2WyJInW1fS5DuA
         5ua45Ea89ygKbWkgoWY0AFgVlLFy6cxy9PzBiVeTm+6kopqrVegEWfCt9mZJIuhJeBKg
         WGlYpiqKwI+U0EzYm3nGlBiXfJWmO/zXsN/84fuuVUv37GbDg8bBMRao5kPhhrKL9Opg
         aVEA==
X-Gm-Message-State: AGi0PuZKQQFnh3QkMqnJZrM78S3wIPFp8ks876Bfn5oUoGhxEWkuhWe3
        74+SJ++Pg2uV3Wtp0cxujPtbMJGq15jAYWPZir0VPHIwhswA
X-Google-Smtp-Source: APiQypL0QxNQa9OdJQ90Q04958mghrxmuli4qcQdaChIT/J4yYemkn/I41OkndcN/UbPEYITTo7uStXfKLO0PqmtKqBRIdx0wt5s
MIME-Version: 1.0
X-Received: by 2002:a92:99c2:: with SMTP id t63mr8617823ilk.261.1586582172413;
 Fri, 10 Apr 2020 22:16:12 -0700 (PDT)
Date:   Fri, 10 Apr 2020 22:16:12 -0700
In-Reply-To: <000000000000571acf05a229cb2f@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000cb36d505a2fcf27b@google.com>
Subject: Re: possible deadlock in shmem_mfill_atomic_pte
From:   syzbot <syzbot+e27980339d305f2dbfd9@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, hughd@google.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has found a reproducer for the following crash on:

HEAD commit:    ab6f762f printk: queue wake_up_klogd irq_work only if per-..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=158a6b5de00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3010ccb0f380f660
dashboard link: https://syzkaller.appspot.com/bug?extid=e27980339d305f2dbfd9
compiler:       clang version 10.0.0 (https://github.com/llvm/llvm-project/ c2443155a0fb245c8f17f2c1c72b6ea391e86e81)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12d3c5afe00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15e7f51be00000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+e27980339d305f2dbfd9@syzkaller.appspotmail.com

========================================================
WARNING: possible irq lock inversion dependency detected
5.6.0-syzkaller #0 Not tainted
--------------------------------------------------------
syz-executor941/7000 just changed the state of lock:
ffff88808d9b18d8 (&info->lock){+.+.}-{2:2}, at: spin_lock include/linux/spinlock.h:353 [inline]
ffff88808d9b18d8 (&info->lock){+.+.}-{2:2}, at: shmem_mfill_atomic_pte+0x13f4/0x1e10 mm/shmem.c:2402
but this lock was taken by another, SOFTIRQ-safe lock in the past:
 (&xa->xa_lock#4){..-.}-{2:2}


and interrupts could create inverse lock ordering between them.


other info that might help us debug this:
 Possible interrupt unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&info->lock);
                               local_irq_disable();
                               lock(&xa->xa_lock#4);
                               lock(&info->lock);
  <Interrupt>
    lock(&xa->xa_lock#4);

 *** DEADLOCK ***

2 locks held by syz-executor941/7000:
 #0: ffff88809edf10e8 (&mm->mmap_sem#2){++++}-{3:3}, at: __mcopy_atomic mm/userfaultfd.c:491 [inline]
 #0: ffff88809edf10e8 (&mm->mmap_sem#2){++++}-{3:3}, at: mcopy_atomic+0x17a/0x1ba0 mm/userfaultfd.c:632
 #1: ffff888098e211f8 (ptlock_ptr(page)#2){+.+.}-{2:2}, at: spin_lock include/linux/spinlock.h:353 [inline]
 #1: ffff888098e211f8 (ptlock_ptr(page)#2){+.+.}-{2:2}, at: shmem_mfill_atomic_pte+0xf73/0x1e10 mm/shmem.c:2389

the shortest dependencies between 2nd lock and 1st lock:
 -> (&xa->xa_lock#4){..-.}-{2:2} {
    IN-SOFTIRQ-W at:
                      lock_acquire+0x169/0x480 kernel/locking/lockdep.c:4923
                      __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
                      _raw_spin_lock_irqsave+0x9e/0xc0 kernel/locking/spinlock.c:159
                      test_clear_page_writeback+0x2d8/0xac0 mm/page-writeback.c:2728
                      end_page_writeback+0x212/0x390 mm/filemap.c:1317
                      end_bio_bh_io_sync+0xb1/0x110 fs/buffer.c:3012
                      req_bio_endio block/blk-core.c:245 [inline]
                      blk_update_request+0x437/0x1070 block/blk-core.c:1472
                      scsi_end_request+0x7a/0x7f0 drivers/scsi/scsi_lib.c:575
                      scsi_io_completion+0x178/0x1be0 drivers/scsi/scsi_lib.c:959
                      blk_done_softirq+0x2f2/0x360 block/blk-softirq.c:37
                      __do_softirq+0x268/0x80c kernel/softirq.c:292
                      invoke_softirq kernel/softirq.c:373 [inline]
                      irq_exit+0x223/0x230 kernel/softirq.c:413
                      exiting_irq arch/x86/include/asm/apic.h:546 [inline]
                      do_IRQ+0xfb/0x1d0 arch/x86/kernel/irq.c:263
                      ret_from_intr+0x0/0x2b
                      orc_find arch/x86/kernel/unwind_orc.c:164 [inline]
                      unwind_next_frame+0x20b/0x1cf0 arch/x86/kernel/unwind_orc.c:407
                      arch_stack_walk+0xb4/0xe0 arch/x86/kernel/stacktrace.c:25
                      stack_trace_save+0xad/0x150 kernel/stacktrace.c:123
                      save_stack mm/kasan/common.c:49 [inline]
                      set_track mm/kasan/common.c:57 [inline]
                      __kasan_kmalloc+0x114/0x160 mm/kasan/common.c:495
                      __do_kmalloc mm/slab.c:3656 [inline]
                      __kmalloc+0x24b/0x330 mm/slab.c:3665
                      kmalloc include/linux/slab.h:560 [inline]
                      tomoyo_realpath_from_path+0xd8/0x630 security/tomoyo/realpath.c:252
                      tomoyo_get_realpath security/tomoyo/file.c:151 [inline]
                      tomoyo_check_open_permission+0x1b6/0x900 security/tomoyo/file.c:771
                      security_file_open+0x50/0xc0 security/security.c:1548
                      do_dentry_open+0x35d/0x10b0 fs/open.c:784
                      do_open fs/namei.c:3229 [inline]
                      path_openat+0x2790/0x38b0 fs/namei.c:3346
                      do_filp_open+0x191/0x3a0 fs/namei.c:3373
                      do_sys_openat2+0x463/0x770 fs/open.c:1148
                      do_sys_open fs/open.c:1164 [inline]
                      ksys_open include/linux/syscalls.h:1386 [inline]
                      __do_sys_open fs/open.c:1170 [inline]
                      __se_sys_open fs/open.c:1168 [inline]
                      __x64_sys_open+0x1af/0x1e0 fs/open.c:1168
                      do_syscall_64+0xf3/0x1b0 arch/x86/entry/common.c:295
                      entry_SYSCALL_64_after_hwframe+0x49/0xb3
    INITIAL USE at:
                     lock_acquire+0x169/0x480 kernel/locking/lockdep.c:4923
                     __raw_spin_lock_irq include/linux/spinlock_api_smp.h:128 [inline]
                     _raw_spin_lock_irq+0x67/0x80 kernel/locking/spinlock.c:167
                     spin_lock_irq include/linux/spinlock.h:378 [inline]
                     __add_to_page_cache_locked+0x53d/0xc70 mm/filemap.c:855
                     add_to_page_cache_lru+0x17f/0x4d0 mm/filemap.c:921
                     do_read_cache_page+0x209/0xd00 mm/filemap.c:2755
                     read_mapping_page include/linux/pagemap.h:397 [inline]
                     read_part_sector+0xd8/0x2d0 block/partitions/core.c:643
                     adfspart_check_ICS+0x45/0x640 block/partitions/acorn.c:360
                     check_partition block/partitions/core.c:140 [inline]
                     blk_add_partitions+0x3ce/0x1240 block/partitions/core.c:571
                     bdev_disk_changed+0x446/0x5d0 fs/block_dev.c:1544
                     __blkdev_get+0xb2b/0x13d0 fs/block_dev.c:1647
                     register_disk block/genhd.c:763 [inline]
                     __device_add_disk+0x95f/0x1040 block/genhd.c:853
                     add_disk include/linux/genhd.h:294 [inline]
                     brd_init+0x349/0x42a drivers/block/brd.c:533
                     do_one_initcall+0x14b/0x350 init/main.c:1157
                     do_initcall_level+0x101/0x14c init/main.c:1230
                     do_initcalls+0x59/0x9b init/main.c:1246
                     kernel_init_freeable+0x2fa/0x418 init/main.c:1450
                     kernel_init+0xd/0x290 init/main.c:1357
                     ret_from_fork+0x24/0x30 arch/x86/entry/entry_64.S:352
  }
  ... key      at: [<ffffffff8b5afa68>] xa_init_flags.__key+0x0/0x10
  ... acquired at:
   lock_acquire+0x169/0x480 kernel/locking/lockdep.c:4923
   __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
   _raw_spin_lock_irqsave+0x9e/0xc0 kernel/locking/spinlock.c:159
   shmem_uncharge+0x34/0x4c0 mm/shmem.c:341
   __split_huge_page+0xda8/0x1900 mm/huge_memory.c:2613
   split_huge_page_to_list+0x10a4/0x15f0 mm/huge_memory.c:2886
   split_huge_page include/linux/huge_mm.h:204 [inline]
   shmem_punch_compound+0x17d/0x1c0 mm/shmem.c:814
   shmem_undo_range+0x5da/0x1d00 mm/shmem.c:870
   shmem_truncate_range mm/shmem.c:980 [inline]
   shmem_setattr+0x4e3/0x8a0 mm/shmem.c:1039
   notify_change+0xad5/0xfb0 fs/attr.c:336
   do_truncate fs/open.c:64 [inline]
   do_sys_ftruncate+0x55f/0x690 fs/open.c:195
   do_syscall_64+0xf3/0x1b0 arch/x86/entry/common.c:295
   entry_SYSCALL_64_after_hwframe+0x49/0xb3

-> (&info->lock){+.+.}-{2:2} {
   HARDIRQ-ON-W at:
                    lock_acquire+0x169/0x480 kernel/locking/lockdep.c:4923
                    __raw_spin_lock include/linux/spinlock_api_smp.h:142 [inline]
                    _raw_spin_lock+0x2a/0x40 kernel/locking/spinlock.c:151
                    spin_lock include/linux/spinlock.h:353 [inline]
                    shmem_mfill_atomic_pte+0x13f4/0x1e10 mm/shmem.c:2402
                    shmem_mcopy_atomic_pte+0x3a/0x50 mm/shmem.c:2440
                    mfill_atomic_pte mm/userfaultfd.c:449 [inline]
                    __mcopy_atomic mm/userfaultfd.c:582 [inline]
                    mcopy_atomic+0x84f/0x1ba0 mm/userfaultfd.c:632
                    userfaultfd_copy fs/userfaultfd.c:1743 [inline]
                    userfaultfd_ioctl+0x2289/0x4890 fs/userfaultfd.c:1941
                    vfs_ioctl fs/ioctl.c:47 [inline]
                    ksys_ioctl fs/ioctl.c:763 [inline]
                    __do_sys_ioctl fs/ioctl.c:772 [inline]
                    __se_sys_ioctl+0xf9/0x160 fs/ioctl.c:770
                    do_syscall_64+0xf3/0x1b0 arch/x86/entry/common.c:295
                    entry_SYSCALL_64_after_hwframe+0x49/0xb3
   SOFTIRQ-ON-W at:
                    lock_acquire+0x169/0x480 kernel/locking/lockdep.c:4923
                    __raw_spin_lock include/linux/spinlock_api_smp.h:142 [inline]
                    _raw_spin_lock+0x2a/0x40 kernel/locking/spinlock.c:151
                    spin_lock include/linux/spinlock.h:353 [inline]
                    shmem_mfill_atomic_pte+0x13f4/0x1e10 mm/shmem.c:2402
                    shmem_mcopy_atomic_pte+0x3a/0x50 mm/shmem.c:2440
                    mfill_atomic_pte mm/userfaultfd.c:449 [inline]
                    __mcopy_atomic mm/userfaultfd.c:582 [inline]
                    mcopy_atomic+0x84f/0x1ba0 mm/userfaultfd.c:632
                    userfaultfd_copy fs/userfaultfd.c:1743 [inline]
                    userfaultfd_ioctl+0x2289/0x4890 fs/userfaultfd.c:1941
                    vfs_ioctl fs/ioctl.c:47 [inline]
                    ksys_ioctl fs/ioctl.c:763 [inline]
                    __do_sys_ioctl fs/ioctl.c:772 [inline]
                    __se_sys_ioctl+0xf9/0x160 fs/ioctl.c:770
                    do_syscall_64+0xf3/0x1b0 arch/x86/entry/common.c:295
                    entry_SYSCALL_64_after_hwframe+0x49/0xb3
   INITIAL USE at:
                   lock_acquire+0x169/0x480 kernel/locking/lockdep.c:4923
                   __raw_spin_lock_irq include/linux/spinlock_api_smp.h:128 [inline]
                   _raw_spin_lock_irq+0x67/0x80 kernel/locking/spinlock.c:167
                   spin_lock_irq include/linux/spinlock.h:378 [inline]
                   shmem_getpage_gfp+0x2160/0x3120 mm/shmem.c:1882
                   shmem_getpage mm/shmem.c:154 [inline]
                   shmem_write_begin+0xcd/0x1a0 mm/shmem.c:2483
                   generic_perform_write+0x23b/0x4e0 mm/filemap.c:3302
                   __generic_file_write_iter+0x22b/0x4e0 mm/filemap.c:3431
                   generic_file_write_iter+0x4a6/0x650 mm/filemap.c:3463
                   call_write_iter include/linux/fs.h:1907 [inline]
                   new_sync_write fs/read_write.c:484 [inline]
                   __vfs_write+0x54c/0x710 fs/read_write.c:497
                   vfs_write+0x274/0x580 fs/read_write.c:559
                   ksys_write+0x11b/0x220 fs/read_write.c:612
                   do_syscall_64+0xf3/0x1b0 arch/x86/entry/common.c:295
                   entry_SYSCALL_64_after_hwframe+0x49/0xb3
 }
 ... key      at: [<ffffffff8b59f840>] shmem_get_inode.__key+0x0/0x10
 ... acquired at:
   mark_lock_irq kernel/locking/lockdep.c:3585 [inline]
   mark_lock+0x529/0x1b00 kernel/locking/lockdep.c:3935
   mark_usage kernel/locking/lockdep.c:3852 [inline]
   __lock_acquire+0xb95/0x2b90 kernel/locking/lockdep.c:4298
   lock_acquire+0x169/0x480 kernel/locking/lockdep.c:4923
   __raw_spin_lock include/linux/spinlock_api_smp.h:142 [inline]
   _raw_spin_lock+0x2a/0x40 kernel/locking/spinlock.c:151
   spin_lock include/linux/spinlock.h:353 [inline]
   shmem_mfill_atomic_pte+0x13f4/0x1e10 mm/shmem.c:2402
   shmem_mcopy_atomic_pte+0x3a/0x50 mm/shmem.c:2440
   mfill_atomic_pte mm/userfaultfd.c:449 [inline]
   __mcopy_atomic mm/userfaultfd.c:582 [inline]
   mcopy_atomic+0x84f/0x1ba0 mm/userfaultfd.c:632
   userfaultfd_copy fs/userfaultfd.c:1743 [inline]
   userfaultfd_ioctl+0x2289/0x4890 fs/userfaultfd.c:1941
   vfs_ioctl fs/ioctl.c:47 [inline]
   ksys_ioctl fs/ioctl.c:763 [inline]
   __do_sys_ioctl fs/ioctl.c:772 [inline]
   __se_sys_ioctl+0xf9/0x160 fs/ioctl.c:770
   do_syscall_64+0xf3/0x1b0 arch/x86/entry/common.c:295
   entry_SYSCALL_64_after_hwframe+0x49/0xb3


stack backtrace:
CPU: 1 PID: 7000 Comm: syz-executor941 Not tainted 5.6.0-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x1e9/0x30e lib/dump_stack.c:118
 print_irq_inversion_bug+0xb67/0xe90 kernel/locking/lockdep.c:3447
 check_usage_backwards+0x13f/0x240 kernel/locking/lockdep.c:3499
 mark_lock_irq kernel/locking/lockdep.c:3585 [inline]
 mark_lock+0x529/0x1b00 kernel/locking/lockdep.c:3935
 mark_usage kernel/locking/lockdep.c:3852 [inline]
 __lock_acquire+0xb95/0x2b90 kernel/locking/lockdep.c:4298
 lock_acquire+0x169/0x480 kernel/locking/lockdep.c:4923
 __raw_spin_lock include/linux/spinlock_api_smp.h:142 [inline]
 _raw_spin_lock+0x2a/0x40 kernel/locking/spinlock.c:151
 spin_lock include/linux/spinlock.h:353 [inline]
 shmem_mfill_atomic_pte+0x13f4/0x1e10 mm/shmem.c:2402
 shmem_mcopy_atomic_pte+0x3a/0x50 mm/shmem.c:2440
 mfill_atomic_pte mm/userfaultfd.c:449 [inline]
 __mcopy_atomic mm/userfaultfd.c:582 [inline]
 mcopy_atomic+0x84f/0x1ba0 mm/userfaultfd.c:632
 userfaultfd_copy fs/userfaultfd.c:1743 [inline]
 userfaultfd_ioctl+0x2289/0x4890 fs/userfaultfd.c:1941
 vfs_ioctl fs/ioctl.c:47 [inline]
 ksys_ioctl fs/ioctl.c:763 [inline]
 __do_sys_ioctl fs/ioctl.c:772 [inline]
 __se_sys_ioctl+0xf9/0x160 fs/ioctl.c:770
 do_syscall_64+0xf3/0x1b0 arch/x86/entry/common.c:295
 entry_SYSCALL_64_after_hwframe+0x49/0xb3
RIP: 0033:0x444399
Code: 0d d8 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 0f 83 db d7 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007ffd0974a4a8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00000000004002e0 RCX: 0000000000444399
RDX: 00000000200a0fe0 RSI: 00000000c028aa03 RDI: 0000000000000004
RBP: 00000000006cf018 R08: 00000000004002e0 R09: 00000000004002e0
R10: 00000000004002e0 R11: 0000000000000246 R12: 0000000000402000
R13: 0000000000402090 R14: 0000000000000000 R15: 0000000000000000

