Return-Path: <SRS0=kup7=A2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 775FEC433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 19:59:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4E2E02067D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 19:59:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726945AbgGOT7Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 15:59:24 -0400
Received: from mail-io1-f71.google.com ([209.85.166.71]:50895 "EHLO
        mail-io1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726491AbgGOT7X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 15:59:23 -0400
Received: by mail-io1-f71.google.com with SMTP id 14so2064583ioz.17
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jul 2020 12:59:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=mtBMVc5M2ccMmvN3MfGXxtHHEi47/V9Kf1iQ6R3hwpk=;
        b=Q6AkodHfVxV9B4JIWU0go8Oz4ipob+/udQBtsYdi91ZWA3RQUNiWgRhra5vh6AXjVv
         XEk9tajvQlCF4QqZOV+FCU196rL4Nc34aIA7BjyG9/WrZz9uXQEy/2NDgP8JWIgqh/VA
         c1Awb0cK2e5OyTvLE5yH/8mebpTROEp6Nxi1paqvy7CAi9laDKDCWn7owVwIirQCyacU
         z1ERwBaoXyn4MdjsIp8Zale7EHVg2rqE+sGjb6d0xhna4Cc1wxB424+Z1B1v+tM3qvoN
         liSV+zJR0GNM12ltfpZBVogl9AT5aCmkh3gM2GgRZk684+uhcuMyEmm5GZnCaV6jceBE
         92Cw==
X-Gm-Message-State: AOAM5300wc0QsjZ/gsnOnKePvp9O2Q8NuNVwRuntJRB0Dihi4WkkVyt1
        DGVQ1hr/KTVkGK3wx5Jz78aQs0IoPRUZIaSuySnsebm7PSrm
X-Google-Smtp-Source: ABdhPJy1Lwtf2UNSiBqf7nBueOIh1Re1L/H3vEHuvzQ4MBb01CXMsdzr7KUXR28WEudG6EzAJ+qf+KaeAgY19xP1RIWJR/jHKr35
MIME-Version: 1.0
X-Received: by 2002:a02:9182:: with SMTP id p2mr1178192jag.69.1594843161671;
 Wed, 15 Jul 2020 12:59:21 -0700 (PDT)
Date:   Wed, 15 Jul 2020 12:59:21 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000001fbbb605aa805c9b@google.com>
Subject: possible deadlock in uprobe_clear_state (2)
From:   syzbot <syzbot+e5344baa319c9a96edec@syzkaller.appspotmail.com>
To:     acme@kernel.org, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, linux-kernel@vger.kernel.org,
        mark.rutland@arm.com, mingo@redhat.com, namhyung@kernel.org,
        peterz@infradead.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    a581387e Merge tag 'io_uring-5.8-2020-07-10' of git://git...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=111a004f100000
kernel config:  https://syzkaller.appspot.com/x/.config?x=66ad203c2bb6d8b
dashboard link: https://syzkaller.appspot.com/bug?extid=e5344baa319c9a96edec
compiler:       gcc (GCC) 10.1.0-syz 20200507

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+e5344baa319c9a96edec@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
5.8.0-rc4-syzkaller #0 Not tainted
------------------------------------------------------
syz-executor.1/4807 is trying to acquire lock:
ffffffff89c3a988 (delayed_uprobe_lock){+.+.}-{3:3}, at: uprobe_clear_state+0x47/0x3b0 kernel/events/uprobes.c:1550

but task is already holding lock:
ffffffff89c6c360 (fs_reclaim){+.+.}-{0:0}, at: fs_reclaim_release mm/page_alloc.c:4202 [inline]
ffffffff89c6c360 (fs_reclaim){+.+.}-{0:0}, at: fs_reclaim_release mm/page_alloc.c:4198 [inline]
ffffffff89c6c360 (fs_reclaim){+.+.}-{0:0}, at: __perform_reclaim mm/page_alloc.c:4227 [inline]
ffffffff89c6c360 (fs_reclaim){+.+.}-{0:0}, at: __alloc_pages_direct_reclaim mm/page_alloc.c:4244 [inline]
ffffffff89c6c360 (fs_reclaim){+.+.}-{0:0}, at: __alloc_pages_slowpath.constprop.0+0x1554/0x2780 mm/page_alloc.c:4650

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #1 (fs_reclaim){+.+.}-{0:0}:
       __fs_reclaim_acquire mm/page_alloc.c:4183 [inline]
       fs_reclaim_acquire+0x2f/0x40 mm/page_alloc.c:4194
       slab_pre_alloc_hook mm/slab.h:564 [inline]
       slab_alloc mm/slab.c:3306 [inline]
       kmem_cache_alloc_trace+0x29/0x2d0 mm/slab.c:3549
       kmalloc include/linux/slab.h:555 [inline]
       kzalloc include/linux/slab.h:669 [inline]
       delayed_uprobe_add kernel/events/uprobes.c:304 [inline]
       update_ref_ctr+0x4b6/0x700 kernel/events/uprobes.c:438
       uprobe_write_opcode+0xe07/0x1650 kernel/events/uprobes.c:497
       install_breakpoint kernel/events/uprobes.c:915 [inline]
       install_breakpoint.isra.0+0x5a5/0x7c0 kernel/events/uprobes.c:897
       uprobe_mmap+0x5d7/0x1050 kernel/events/uprobes.c:1394
       mmap_region+0x5cf/0x1590 mm/mmap.c:1818
       do_mmap+0xca8/0x1170 mm/mmap.c:1545
       do_mmap_pgoff include/linux/mm.h:2596 [inline]
       vm_mmap_pgoff+0x197/0x200 mm/util.c:506
       ksys_mmap_pgoff+0x455/0x5a0 mm/mmap.c:1595
       do_syscall_64+0x60/0xe0 arch/x86/entry/common.c:384
       entry_SYSCALL_64_after_hwframe+0x44/0xa9

-> #0 (delayed_uprobe_lock){+.+.}-{3:3}:
       check_prev_add kernel/locking/lockdep.c:2496 [inline]
       check_prevs_add kernel/locking/lockdep.c:2601 [inline]
       validate_chain kernel/locking/lockdep.c:3218 [inline]
       __lock_acquire+0x2acb/0x56e0 kernel/locking/lockdep.c:4380
       lock_acquire+0x1f1/0xad0 kernel/locking/lockdep.c:4959
       __mutex_lock_common kernel/locking/mutex.c:956 [inline]
       __mutex_lock+0x134/0x10d0 kernel/locking/mutex.c:1103
       uprobe_clear_state+0x47/0x3b0 kernel/events/uprobes.c:1550
       __mmput+0x73/0x470 kernel/fork.c:1089
       mmput+0x53/0x60 kernel/fork.c:1114
       binder_alloc_free_page+0x441/0xf90 drivers/android/binder_alloc.c:950
       __list_lru_walk_one+0x178/0x5c0 mm/list_lru.c:222
       list_lru_walk_one mm/list_lru.c:266 [inline]
       list_lru_walk_node+0x67/0x2a0 mm/list_lru.c:295
       list_lru_walk include/linux/list_lru.h:215 [inline]
       binder_shrink_scan+0x123/0x190 drivers/android/binder_alloc.c:984
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
       alloc_pages_current+0x187/0x280 mm/mempolicy.c:2292
       alloc_pages include/linux/gfp.h:545 [inline]
       alloc_mmu_pages+0x7f/0x170 arch/x86/kvm/mmu/mmu.c:5671
       kvm_mmu_create+0x3cb/0x560 arch/x86/kvm/mmu/mmu.c:5704
       kvm_arch_vcpu_create+0x16d/0xb70 arch/x86/kvm/x86.c:9433
       kvm_vm_ioctl_create_vcpu arch/x86/kvm/../../../virt/kvm/kvm_main.c:3060 [inline]
       kvm_vm_ioctl+0x1547/0x23c0 arch/x86/kvm/../../../virt/kvm/kvm_main.c:3621
       vfs_ioctl fs/ioctl.c:48 [inline]
       ksys_ioctl+0x11a/0x180 fs/ioctl.c:753
       __do_sys_ioctl fs/ioctl.c:762 [inline]
       __se_sys_ioctl fs/ioctl.c:760 [inline]
       __x64_sys_ioctl+0x6f/0xb0 fs/ioctl.c:760
       do_syscall_64+0x60/0xe0 arch/x86/entry/common.c:384
       entry_SYSCALL_64_after_hwframe+0x44/0xa9

other info that might help us debug this:

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(fs_reclaim);
                               lock(delayed_uprobe_lock);
                               lock(fs_reclaim);
  lock(delayed_uprobe_lock);

 *** DEADLOCK ***

3 locks held by syz-executor.1/4807:
 #0: ffffffff89c6c360 (fs_reclaim){+.+.}-{0:0}, at: fs_reclaim_release mm/page_alloc.c:4202 [inline]
 #0: ffffffff89c6c360 (fs_reclaim){+.+.}-{0:0}, at: fs_reclaim_release mm/page_alloc.c:4198 [inline]
 #0: ffffffff89c6c360 (fs_reclaim){+.+.}-{0:0}, at: __perform_reclaim mm/page_alloc.c:4227 [inline]
 #0: ffffffff89c6c360 (fs_reclaim){+.+.}-{0:0}, at: __alloc_pages_direct_reclaim mm/page_alloc.c:4244 [inline]
 #0: ffffffff89c6c360 (fs_reclaim){+.+.}-{0:0}, at: __alloc_pages_slowpath.constprop.0+0x1554/0x2780 mm/page_alloc.c:4650
 #1: ffffffff89c46b90 (shrinker_rwsem){++++}-{3:3}, at: shrink_slab+0xc7/0x5c0 mm/vmscan.c:669
 #2: ffff88808ea481e0 (&alloc->mutex){+.+.}-{3:3}, at: binder_alloc_free_page+0x4f/0xf90 drivers/android/binder_alloc.c:923

stack backtrace:
CPU: 0 PID: 4807 Comm: syz-executor.1 Not tainted 5.8.0-rc4-syzkaller #0
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
 __mutex_lock_common kernel/locking/mutex.c:956 [inline]
 __mutex_lock+0x134/0x10d0 kernel/locking/mutex.c:1103
 uprobe_clear_state+0x47/0x3b0 kernel/events/uprobes.c:1550
 __mmput+0x73/0x470 kernel/fork.c:1089
 mmput+0x53/0x60 kernel/fork.c:1114
 binder_alloc_free_page+0x441/0xf90 drivers/android/binder_alloc.c:950
 __list_lru_walk_one+0x178/0x5c0 mm/list_lru.c:222
 list_lru_walk_one mm/list_lru.c:266 [inline]
 list_lru_walk_node+0x67/0x2a0 mm/list_lru.c:295
 list_lru_walk include/linux/list_lru.h:215 [inline]
 binder_shrink_scan+0x123/0x190 drivers/android/binder_alloc.c:984
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
 alloc_pages_current+0x187/0x280 mm/mempolicy.c:2292
 alloc_pages include/linux/gfp.h:545 [inline]
 alloc_mmu_pages+0x7f/0x170 arch/x86/kvm/mmu/mmu.c:5671
 kvm_mmu_create+0x3cb/0x560 arch/x86/kvm/mmu/mmu.c:5704
 kvm_arch_vcpu_create+0x16d/0xb70 arch/x86/kvm/x86.c:9433
 kvm_vm_ioctl_create_vcpu arch/x86/kvm/../../../virt/kvm/kvm_main.c:3060 [inline]
 kvm_vm_ioctl+0x1547/0x23c0 arch/x86/kvm/../../../virt/kvm/kvm_main.c:3621
 vfs_ioctl fs/ioctl.c:48 [inline]
 ksys_ioctl+0x11a/0x180 fs/ioctl.c:753
 __do_sys_ioctl fs/ioctl.c:762 [inline]
 __se_sys_ioctl fs/ioctl.c:760 [inline]
 __x64_sys_ioctl+0x6f/0xb0 fs/ioctl.c:760
 do_syscall_64+0x60/0xe0 arch/x86/entry/common.c:384
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x45cba9
Code: Bad RIP value.
RSP: 002b:00007f45444f8c78 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00000000004e85c0 RCX: 000000000045cba9
RDX: 0000000000000000 RSI: 000000000000ae41 RDI: 0000000000000004
RBP: 000000000078bf00 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000ffffffff
R13: 00000000000003a3 R14: 00000000004c652f R15: 00007f45444f96d4


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
