Return-Path: <SRS0=6o4L=5Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36E2AC43331
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 17:29:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECFF720BED
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 17:29:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726339AbgCaR3X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Mar 2020 13:29:23 -0400
Received: from mail-qv1-f70.google.com ([209.85.219.70]:48098 "EHLO
        mail-qv1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726150AbgCaR3X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 13:29:23 -0400
Received: by mail-qv1-f70.google.com with SMTP id f9so10538073qvt.14
        for <linux-kernel@vger.kernel.org>; Tue, 31 Mar 2020 10:29:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=X+2kIuvjtcafipZJpngkn4MiF77ysgHkS3wIhPI43iE=;
        b=Hx4DCecy3+1qzENiIZCxvNqmrBR7JR5PMSKrgJHGdEHp6wrgqajTQpfYnDlaqI37ci
         8YUpIOWyyobx5myX13dzTkVJvzGz2alF6zMTGiNGge6YjdSSyhiBVHYmmHvXJvHUq8Tl
         /l/iosh9UqZjMVCsOn69iHTkp7SeprCjYXoKy2FZcdVjx1fKnCAoUDpXAv06BXuHhMvQ
         vE6i4F9Ddxq/mqY6jbyOgDPWps7CCmV+RteXYE7+IKQk5Hf1DkTxFGye62D8dRmU+Bt4
         mPv9y9gD02Yz4sr2LSQhUOWMC62tan/3bAxMZD2ozLTVQQKECGgk1cZIAvHH2sRVBy0+
         EfJw==
X-Gm-Message-State: ANhLgQ2rlG7clwKba9jy+6uRkPnN2OhPhmzCuDL93NTrbDo4kWZtMflt
        lFTZ17cdgMU+aZDFYzIYcyIqeNrduYx0qwu0DshAvFXiJHBH
X-Google-Smtp-Source: ADFU+vtp+WR0JNnY5dL5+eXdWMva8VLWNnRgVNh/PFPeG7U4he5n0QVoAjeo2IgJHIOA+FJi+jaKmyiDnd+9F6UOr02tT4fWdqX7
MIME-Version: 1.0
X-Received: by 2002:a02:a619:: with SMTP id c25mr16058549jam.15.1585675272393;
 Tue, 31 Mar 2020 10:21:12 -0700 (PDT)
Date:   Tue, 31 Mar 2020 10:21:12 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000571acf05a229cb2f@google.com>
Subject: possible deadlock in shmem_mfill_atomic_pte
From:   syzbot <syzbot+e27980339d305f2dbfd9@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, hughd@google.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    527630fb Merge tag 'clk-fixes-for-linus' of git://git.kern..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1214875be00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=27392dd2975fd692
dashboard link: https://syzkaller.appspot.com/bug?extid=e27980339d305f2dbfd9
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+e27980339d305f2dbfd9@syzkaller.appspotmail.com

WARNING: possible irq lock inversion dependency detected
5.6.0-rc7-syzkaller #0 Not tainted
--------------------------------------------------------
syz-executor.0/10317 just changed the state of lock:
ffff888021d16568 (&(&info->lock)->rlock){+.+.}, at: spin_lock include/linux/spinlock.h:338 [inline]
ffff888021d16568 (&(&info->lock)->rlock){+.+.}, at: shmem_mfill_atomic_pte+0x1012/0x21c0 mm/shmem.c:2407
but this lock was taken by another, SOFTIRQ-safe lock in the past:
 (&(&xa->xa_lock)->rlock#5){..-.}


and interrupts could create inverse lock ordering between them.


other info that might help us debug this:
 Possible interrupt unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&(&info->lock)->rlock);
                               local_irq_disable();
                               lock(&(&xa->xa_lock)->rlock#5);
                               lock(&(&info->lock)->rlock);
  <Interrupt>
    lock(&(&xa->xa_lock)->rlock#5);

 *** DEADLOCK ***

2 locks held by syz-executor.0/10317:
 #0: ffff888011721898 (&mm->mmap_sem#2){++++}, at: __mcopy_atomic mm/userfaultfd.c:474 [inline]
 #0: ffff888011721898 (&mm->mmap_sem#2){++++}, at: mcopy_atomic+0x185/0x2510 mm/userfaultfd.c:607
 #1: ffff888024eda280 (&(ptlock_ptr(page))->rlock#2){+.+.}, at: spin_lock include/linux/spinlock.h:338 [inline]
 #1: ffff888024eda280 (&(ptlock_ptr(page))->rlock#2){+.+.}, at: shmem_mfill_atomic_pte+0xf76/0x21c0 mm/shmem.c:2394

the shortest dependencies between 2nd lock and 1st lock:
 -> (&(&xa->xa_lock)->rlock#5){..-.} {
    IN-SOFTIRQ-W at:
                      lock_acquire+0x197/0x420 kernel/locking/lockdep.c:4484
                      __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
                      _raw_spin_lock_irqsave+0x8c/0xbf kernel/locking/spinlock.c:159
                      test_clear_page_writeback+0x1d7/0x11e0 mm/page-writeback.c:2728
                      end_page_writeback+0x239/0x520 mm/filemap.c:1317
                      end_buffer_async_write+0x6a9/0xa30 fs/buffer.c:389
                      end_bio_bh_io_sync+0xe2/0x140 fs/buffer.c:3018
                      bio_endio+0x473/0x820 block/bio.c:1872
                      req_bio_endio block/blk-core.c:245 [inline]
                      blk_update_request+0x3e1/0xdc0 block/blk-core.c:1468
                      scsi_end_request+0x80/0x7a0 drivers/scsi/scsi_lib.c:576
                      scsi_io_completion+0x1e7/0x1300 drivers/scsi/scsi_lib.c:960
                      scsi_softirq_done+0x31e/0x3b0 drivers/scsi/scsi_lib.c:1476
                      blk_done_softirq+0x2db/0x440 block/blk-softirq.c:37
                      __do_softirq+0x26c/0x99d kernel/softirq.c:292
                      invoke_softirq kernel/softirq.c:373 [inline]
                      irq_exit+0x192/0x1d0 kernel/softirq.c:413
                      exiting_irq arch/x86/include/asm/apic.h:546 [inline]
                      do_IRQ+0xde/0x280 arch/x86/kernel/irq.c:263
                      ret_from_intr+0x0/0x36
                      clear_page_erms+0x7/0x10 arch/x86/lib/clear_page_64.S:48
                      clear_page arch/x86/include/asm/page_64.h:49 [inline]
                      clear_highpage include/linux/highmem.h:214 [inline]
                      kernel_init_free_pages+0x92/0x120 mm/page_alloc.c:1118
                      prep_new_page+0x12e/0x1f0 mm/page_alloc.c:2160
                      get_page_from_freelist+0x14c7/0x3ee0 mm/page_alloc.c:3684
                      __alloc_pages_nodemask+0x2a5/0x820 mm/page_alloc.c:4731
                      alloc_pages_current+0xff/0x200 mm/mempolicy.c:2211
                      alloc_pages include/linux/gfp.h:532 [inline]
                      __page_cache_alloc+0x298/0x480 mm/filemap.c:959
                      __do_page_cache_readahead+0x1a7/0x570 mm/readahead.c:196
                      ra_submit mm/internal.h:62 [inline]
                      ondemand_readahead+0x566/0xd60 mm/readahead.c:492
                      page_cache_async_readahead mm/readahead.c:574 [inline]
                      page_cache_async_readahead+0x43d/0x7c0 mm/readahead.c:547
                      generic_file_buffered_read mm/filemap.c:2037 [inline]
                      generic_file_read_iter+0x124a/0x2b00 mm/filemap.c:2302
                      ext4_file_read_iter fs/ext4/file.c:131 [inline]
                      ext4_file_read_iter+0x1d1/0x600 fs/ext4/file.c:114
                      call_read_iter include/linux/fs.h:1896 [inline]
                      new_sync_read+0x4a2/0x790 fs/read_write.c:414
                      __vfs_read+0xc9/0x100 fs/read_write.c:427
                      integrity_kernel_read+0x143/0x200 security/integrity/iint.c:200
                      ima_calc_file_hash_tfm+0x2aa/0x3b0 security/integrity/ima/ima_crypto.c:360
                      ima_calc_file_shash security/integrity/ima/ima_crypto.c:391 [inline]
                      ima_calc_file_hash+0x199/0x540 security/integrity/ima/ima_crypto.c:456
                      ima_collect_measurement+0x4c4/0x570 security/integrity/ima/ima_api.c:249
                      process_measurement+0xc6d/0x1740 security/integrity/ima/ima_main.c:326
                      ima_bprm_check+0xde/0x210 security/integrity/ima/ima_main.c:417
                      security_bprm_check+0x89/0xb0 security/security.c:819
                      search_binary_handler+0x70/0x580 fs/exec.c:1649
                      exec_binprm fs/exec.c:1705 [inline]
                      __do_execve_file.isra.0+0x12fc/0x2270 fs/exec.c:1825
                      do_execveat_common fs/exec.c:1871 [inline]
                      do_execve fs/exec.c:1888 [inline]
                      __do_sys_execve fs/exec.c:1964 [inline]
                      __se_sys_execve fs/exec.c:1959 [inline]
                      __x64_sys_execve+0x8a/0xb0 fs/exec.c:1959
                      do_syscall_64+0xf6/0x7d0 arch/x86/entry/common.c:294
                      entry_SYSCALL_64_after_hwframe+0x49/0xbe
    INITIAL USE at:
                     lock_acquire+0x197/0x420 kernel/locking/lockdep.c:4484
                     __raw_spin_lock_irq include/linux/spinlock_api_smp.h:128 [inline]
                     _raw_spin_lock_irq+0x5b/0x80 kernel/locking/spinlock.c:167
                     spin_lock_irq include/linux/spinlock.h:363 [inline]
                     clear_inode+0x1b/0x1e0 fs/inode.c:529
                     shmem_evict_inode+0x1db/0x9f0 mm/shmem.c:1116
                     evict+0x2ed/0x650 fs/inode.c:576
                     iput_final fs/inode.c:1572 [inline]
                     iput+0x536/0x8c0 fs/inode.c:1598
                     dentry_unlink_inode+0x2c0/0x3e0 fs/dcache.c:374
                     d_delete fs/dcache.c:2451 [inline]
                     d_delete+0x117/0x150 fs/dcache.c:2440
                     vfs_unlink+0x4d5/0x620 fs/namei.c:4087
                     handle_remove+0x417/0x720 drivers/base/devtmpfs.c:332
                     handle drivers/base/devtmpfs.c:378 [inline]
                     devtmpfsd.part.0+0x302/0x750 drivers/base/devtmpfs.c:413
                     devtmpfsd+0x107/0x120 drivers/base/devtmpfs.c:403
                     kthread+0x357/0x430 kernel/kthread.c:255
                     ret_from_fork+0x24/0x30 arch/x86/entry/entry_64.S:352
  }
  ... key      at: [<ffffffff8c402aa0>] __key.17910+0x0/0x40
  ... acquired at:
   __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
   _raw_spin_lock_irqsave+0x8c/0xbf kernel/locking/spinlock.c:159
   shmem_uncharge+0x24/0x270 mm/shmem.c:341
   __split_huge_page mm/huge_memory.c:2540 [inline]
   split_huge_page_to_list+0x2751/0x33c0 mm/huge_memory.c:2813
   split_huge_page include/linux/huge_mm.h:169 [inline]
   shmem_unused_huge_shrink+0x7ba/0x13a0 mm/shmem.c:542
   shmem_unused_huge_scan+0x7a/0xb0 mm/shmem.c:574
   super_cache_scan+0x34f/0x480 fs/super.c:111
   do_shrink_slab+0x3fc/0xab0 mm/vmscan.c:512
   shrink_slab mm/vmscan.c:673 [inline]
   shrink_slab+0x16f/0x5f0 mm/vmscan.c:646
   shrink_node_memcgs mm/vmscan.c:2676 [inline]
   shrink_node+0x477/0x1b20 mm/vmscan.c:2780
   shrink_zones mm/vmscan.c:2983 [inline]
   do_try_to_free_pages+0x38d/0x13a0 mm/vmscan.c:3036
   try_to_free_pages+0x293/0x8d0 mm/vmscan.c:3275
   __perform_reclaim mm/page_alloc.c:4113 [inline]
   __alloc_pages_direct_reclaim mm/page_alloc.c:4134 [inline]
   __alloc_pages_slowpath+0x919/0x26a0 mm/page_alloc.c:4537
   __alloc_pages_nodemask+0x5e1/0x820 mm/page_alloc.c:4751
   __alloc_pages include/linux/gfp.h:496 [inline]
   __alloc_pages_node include/linux/gfp.h:509 [inline]
   alloc_pages_vma+0x3bd/0x600 mm/mempolicy.c:2155
   shmem_alloc_hugepage+0x122/0x210 mm/shmem.c:1484
   shmem_alloc_and_acct_page+0x3ba/0x980 mm/shmem.c:1522
   shmem_getpage_gfp+0xdb9/0x2860 mm/shmem.c:1835
   shmem_getpage mm/shmem.c:154 [inline]
   shmem_write_begin+0x102/0x1e0 mm/shmem.c:2488
   generic_perform_write+0x20a/0x4e0 mm/filemap.c:3287
   __generic_file_write_iter+0x24c/0x610 mm/filemap.c:3416
   generic_file_write_iter+0x3f0/0x62d mm/filemap.c:3448
   call_write_iter include/linux/fs.h:1902 [inline]
   new_sync_write+0x49c/0x700 fs/read_write.c:483
   __vfs_write+0xc9/0x100 fs/read_write.c:496
   vfs_write+0x262/0x5c0 fs/read_write.c:558
   ksys_write+0x127/0x250 fs/read_write.c:611
   do_syscall_64+0xf6/0x7d0 arch/x86/entry/common.c:294
   entry_SYSCALL_64_after_hwframe+0x49/0xbe

-> (&(&info->lock)->rlock){+.+.} {
   HARDIRQ-ON-W at:
                    lock_acquire+0x197/0x420 kernel/locking/lockdep.c:4484
                    __raw_spin_lock include/linux/spinlock_api_smp.h:142 [inline]
                    _raw_spin_lock+0x2a/0x40 kernel/locking/spinlock.c:151
                    spin_lock include/linux/spinlock.h:338 [inline]
                    shmem_mfill_atomic_pte+0x1012/0x21c0 mm/shmem.c:2407
                    shmem_mcopy_atomic_pte+0x3a/0x50 mm/shmem.c:2445
                    mfill_atomic_pte mm/userfaultfd.c:434 [inline]
                    __mcopy_atomic mm/userfaultfd.c:557 [inline]
                    mcopy_atomic+0xac7/0x2510 mm/userfaultfd.c:607
                    userfaultfd_copy fs/userfaultfd.c:1736 [inline]
                    userfaultfd_ioctl+0x4d2/0x3b10 fs/userfaultfd.c:1886
                    vfs_ioctl fs/ioctl.c:47 [inline]
                    ksys_ioctl+0x11a/0x180 fs/ioctl.c:763
                    __do_sys_ioctl fs/ioctl.c:772 [inline]
                    __se_sys_ioctl fs/ioctl.c:770 [inline]
                    __x64_sys_ioctl+0x6f/0xb0 fs/ioctl.c:770
                    do_syscall_64+0xf6/0x7d0 arch/x86/entry/common.c:294
                    entry_SYSCALL_64_after_hwframe+0x49/0xbe
   SOFTIRQ-ON-W at:
                    lock_acquire+0x197/0x420 kernel/locking/lockdep.c:4484
                    __raw_spin_lock include/linux/spinlock_api_smp.h:142 [inline]
                    _raw_spin_lock+0x2a/0x40 kernel/locking/spinlock.c:151
                    spin_lock include/linux/spinlock.h:338 [inline]
                    shmem_mfill_atomic_pte+0x1012/0x21c0 mm/shmem.c:2407
                    shmem_mcopy_atomic_pte+0x3a/0x50 mm/shmem.c:2445
                    mfill_atomic_pte mm/userfaultfd.c:434 [inline]
                    __mcopy_atomic mm/userfaultfd.c:557 [inline]
                    mcopy_atomic+0xac7/0x2510 mm/userfaultfd.c:607
                    userfaultfd_copy fs/userfaultfd.c:1736 [inline]
                    userfaultfd_ioctl+0x4d2/0x3b10 fs/userfaultfd.c:1886
                    vfs_ioctl fs/ioctl.c:47 [inline]
                    ksys_ioctl+0x11a/0x180 fs/ioctl.c:763
                    __do_sys_ioctl fs/ioctl.c:772 [inline]
                    __se_sys_ioctl fs/ioctl.c:770 [inline]
                    __x64_sys_ioctl+0x6f/0xb0 fs/ioctl.c:770
                    do_syscall_64+0xf6/0x7d0 arch/x86/entry/common.c:294
                    entry_SYSCALL_64_after_hwframe+0x49/0xbe
   INITIAL USE at:
                   lock_acquire+0x197/0x420 kernel/locking/lockdep.c:4484
                   __raw_spin_lock_irq include/linux/spinlock_api_smp.h:128 [inline]
                   _raw_spin_lock_irq+0x5b/0x80 kernel/locking/spinlock.c:167
                   spin_lock_irq include/linux/spinlock.h:363 [inline]
                   shmem_getpage_gfp+0xf10/0x2860 mm/shmem.c:1887
                   shmem_read_mapping_page_gfp+0xd3/0x170 mm/shmem.c:4218
                   shmem_read_mapping_page include/linux/shmem_fs.h:101 [inline]
                   drm_gem_get_pages+0x293/0x530 drivers/gpu/drm/drm_gem.c:578
                   drm_gem_shmem_get_pages_locked drivers/gpu/drm/drm_gem_shmem_helper.c:146 [inline]
                   drm_gem_shmem_get_pages+0x9d/0x160 drivers/gpu/drm/drm_gem_shmem_helper.c:175
                   virtio_gpu_object_attach+0x121/0x950 drivers/gpu/drm/virtio/virtgpu_vq.c:1090
                   virtio_gpu_object_create+0x26f/0x490 drivers/gpu/drm/virtio/virtgpu_object.c:150
                   virtio_gpu_gem_create+0xaa/0x1d0 drivers/gpu/drm/virtio/virtgpu_gem.c:42
                   virtio_gpu_mode_dumb_create+0x21e/0x360 drivers/gpu/drm/virtio/virtgpu_gem.c:82
                   drm_mode_create_dumb+0x27c/0x300 drivers/gpu/drm/drm_dumb_buffers.c:94
                   drm_client_buffer_create drivers/gpu/drm/drm_client.c:267 [inline]
                   drm_client_framebuffer_create+0x1b7/0x770 drivers/gpu/drm/drm_client.c:412
                   drm_fb_helper_generic_probe+0x1e4/0x810 drivers/gpu/drm/drm_fb_helper.c:2051
                   drm_fb_helper_single_fb_probe drivers/gpu/drm/drm_fb_helper.c:1600 [inline]
                   __drm_fb_helper_initial_config_and_unlock+0xb56/0x11e0 drivers/gpu/drm/drm_fb_helper.c:1758
                   drm_fb_helper_initial_config drivers/gpu/drm/drm_fb_helper.c:1853 [inline]
                   drm_fb_helper_initial_config drivers/gpu/drm/drm_fb_helper.c:1845 [inline]
                   drm_fbdev_client_hotplug+0x30f/0x580 drivers/gpu/drm/drm_fb_helper.c:2145
                   drm_fbdev_generic_setup drivers/gpu/drm/drm_fb_helper.c:2224 [inline]
                   drm_fbdev_generic_setup+0x18b/0x295 drivers/gpu/drm/drm_fb_helper.c:2197
                   virtio_gpu_probe+0x28f/0x2de drivers/gpu/drm/virtio/virtgpu_drv.c:126
                   virtio_dev_probe+0x463/0x710 drivers/virtio/virtio.c:248
                   really_probe+0x281/0x6d0 drivers/base/dd.c:551
                   driver_probe_device+0x104/0x210 drivers/base/dd.c:724
                   device_driver_attach+0x108/0x140 drivers/base/dd.c:998
                   __driver_attach+0xda/0x240 drivers/base/dd.c:1075
                   bus_for_each_dev+0x14b/0x1d0 drivers/base/bus.c:305
                   bus_add_driver+0x4a2/0x5a0 drivers/base/bus.c:622
                   driver_register+0x1c4/0x330 drivers/base/driver.c:171
                   do_one_initcall+0x10a/0x7d0 init/main.c:1152
                   do_initcall_level init/main.c:1225 [inline]
                   do_initcalls init/main.c:1241 [inline]
                   do_basic_setup init/main.c:1261 [inline]
                   kernel_init_freeable+0x501/0x5ae init/main.c:1445
                   kernel_init+0xd/0x1bb init/main.c:1352
                   ret_from_fork+0x24/0x30 arch/x86/entry/entry_64.S:352
 }
 ... key      at: [<ffffffff8c3f0420>] __key.55978+0x0/0x40
 ... acquired at:
   mark_lock_irq kernel/locking/lockdep.c:3316 [inline]
   mark_lock+0x50e/0x1220 kernel/locking/lockdep.c:3665
   mark_usage kernel/locking/lockdep.c:3583 [inline]
   __lock_acquire+0x1236/0x3ca0 kernel/locking/lockdep.c:3908
   lock_acquire+0x197/0x420 kernel/locking/lockdep.c:4484
   __raw_spin_lock include/linux/spinlock_api_smp.h:142 [inline]
   _raw_spin_lock+0x2a/0x40 kernel/locking/spinlock.c:151
   spin_lock include/linux/spinlock.h:338 [inline]
   shmem_mfill_atomic_pte+0x1012/0x21c0 mm/shmem.c:2407
   shmem_mcopy_atomic_pte+0x3a/0x50 mm/shmem.c:2445
   mfill_atomic_pte mm/userfaultfd.c:434 [inline]
   __mcopy_atomic mm/userfaultfd.c:557 [inline]
   mcopy_atomic+0xac7/0x2510 mm/userfaultfd.c:607
   userfaultfd_copy fs/userfaultfd.c:1736 [inline]
   userfaultfd_ioctl+0x4d2/0x3b10 fs/userfaultfd.c:1886
   vfs_ioctl fs/ioctl.c:47 [inline]
   ksys_ioctl+0x11a/0x180 fs/ioctl.c:763
   __do_sys_ioctl fs/ioctl.c:772 [inline]
   __se_sys_ioctl fs/ioctl.c:770 [inline]
   __x64_sys_ioctl+0x6f/0xb0 fs/ioctl.c:770
   do_syscall_64+0xf6/0x7d0 arch/x86/entry/common.c:294
   entry_SYSCALL_64_after_hwframe+0x49/0xbe


stack backtrace:
CPU: 0 PID: 10317 Comm: syz-executor.0 Not tainted 5.6.0-rc7-syzkaller #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.12.0-59-gc9ba5276e321-prebuilt.qemu.org 04/01/2014
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x188/0x20d lib/dump_stack.c:118
 print_irq_inversion_bug kernel/locking/lockdep.c:3179 [inline]
 check_usage_backwards.cold+0x1d/0x26 kernel/locking/lockdep.c:3230
 mark_lock_irq kernel/locking/lockdep.c:3316 [inline]
 mark_lock+0x50e/0x1220 kernel/locking/lockdep.c:3665
 mark_usage kernel/locking/lockdep.c:3583 [inline]
 __lock_acquire+0x1236/0x3ca0 kernel/locking/lockdep.c:3908
 lock_acquire+0x197/0x420 kernel/locking/lockdep.c:4484
 __raw_spin_lock include/linux/spinlock_api_smp.h:142 [inline]
 _raw_spin_lock+0x2a/0x40 kernel/locking/spinlock.c:151
 spin_lock include/linux/spinlock.h:338 [inline]
 shmem_mfill_atomic_pte+0x1012/0x21c0 mm/shmem.c:2407
 shmem_mcopy_atomic_pte+0x3a/0x50 mm/shmem.c:2445
 mfill_atomic_pte mm/userfaultfd.c:434 [inline]
 __mcopy_atomic mm/userfaultfd.c:557 [inline]
 mcopy_atomic+0xac7/0x2510 mm/userfaultfd.c:607
 userfaultfd_copy fs/userfaultfd.c:1736 [inline]
 userfaultfd_ioctl+0x4d2/0x3b10 fs/userfaultfd.c:1886
 vfs_ioctl fs/ioctl.c:47 [inline]
 ksys_ioctl+0x11a/0x180 fs/ioctl.c:763
 __do_sys_ioctl fs/ioctl.c:772 [inline]
 __se_sys_ioctl fs/ioctl.c:770 [inline]
 __x64_sys_ioctl+0x6f/0xb0 fs/ioctl.c:770
 do_syscall_64+0xf6/0x7d0 arch/x86/entry/common.c:294
 entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x45c6e9
Code: bd b1 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 0f 83 8b b1 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007fcff1e50c88 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 000000000072bf00 RCX: 000000000045c6e9
RDX: 00000000200a0fe0 RSI: 00000000c028aa03 RDI: 0000000000000003
RBP: 00007fcff1e516d4 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000ffffffff
R13: 00000000000005b3 R14: 00000000004af2cd R15: 00000000006ec420


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
