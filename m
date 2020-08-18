Return-Path: <SRS0=faA3=B4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0F0FC433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 23:18:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A4F4D20772
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 23:18:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597792739;
	bh=NvMRY2SO7jZz4Dg47GpkDTTV8NX9Vqc1LIgNUrQe3Ws=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=VU5BvBlPTt43XtTj7Xy5gTV67bQbG0t0WZXxAPTjW0T7C70erqngK75ylDHQsYbzg
	 Gv5sKDvr7+STl8NEaAF9pGPmlinlF3paFQluJx/SRk0H/jYdsTutPPhVueHOJ0e9rs
	 G9UXqv2dJqodwb0tSvvKPBkVGR5AgUCxeaLeIj0o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727042AbgHRXS6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Aug 2020 19:18:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:42680 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725554AbgHRXS6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 19:18:58 -0400
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E8F2620772;
        Tue, 18 Aug 2020 23:18:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597792737;
        bh=NvMRY2SO7jZz4Dg47GpkDTTV8NX9Vqc1LIgNUrQe3Ws=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=GlNQS6xP34KpFb3TPrqMJ5Ri9jHXJPpVuSDrj2BT5fMhiVHuKDSgbSITKE63NZJyT
         2lqasTaDh3BAKfkys1gYTaFFWdMI2EWCKOMaHZolhhkbkvJisfXF0+Yle8pbvYSUY1
         u8qs6fikAlOhLN48SnF9F+IpmaJmbjvzIhz2K/Xk=
Date:   Tue, 18 Aug 2020 16:18:56 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     syzbot <syzbot+b305848212deec86eabe@syzkaller.appspotmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        syzkaller-bugs@googlegroups.com,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>
Subject: Re: KASAN: use-after-free Write in page_counter_uncharge
Message-Id: <20200818161856.d18df24b5d10fc727ead846f@linux-foundation.org>
In-Reply-To: <00000000000014822b05ad2802a7@google.com>
References: <00000000000014822b05ad2802a7@google.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 Aug 2020 07:50:28 -0700 syzbot <syzbot+b305848212deec86eabe@syzkaller.appspotmail.com> wrote:

> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    a1d21081 Merge git://git.kernel.org/pub/scm/linux/kernel/g..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=17ceb0ce900000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=21f0d1d2df6d5fc
> dashboard link: https://syzkaller.appspot.com/bug?extid=b305848212deec86eabe
> compiler:       clang version 10.0.0 (https://github.com/llvm/llvm-project/ c2443155a0fb245c8f17f2c1c72b6ea391e86e81)

Presumably this is the same as
http://lkml.kernel.org/r/00000000000011710f05ad27fe8a@google.com.


> Unfortunately, I don't have any reproducer for this issue yet.
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+b305848212deec86eabe@syzkaller.appspotmail.com
> 
> ==================================================================
> BUG: KASAN: use-after-free in instrument_atomic_write include/linux/instrumented.h:71 [inline]
> BUG: KASAN: use-after-free in atomic64_sub_return include/asm-generic/atomic-instrumented.h:970 [inline]
> BUG: KASAN: use-after-free in atomic_long_sub_return include/asm-generic/atomic-long.h:113 [inline]
> BUG: KASAN: use-after-free in page_counter_cancel mm/page_counter.c:54 [inline]
> BUG: KASAN: use-after-free in page_counter_uncharge+0x3d/0xc0 mm/page_counter.c:155
> Write of size 8 at addr ffff8880371c0148 by task syz-executor.0/9304
> 
> CPU: 0 PID: 9304 Comm: syz-executor.0 Not tainted 5.8.0-syzkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> Call Trace:
>  __dump_stack lib/dump_stack.c:77 [inline]
>  dump_stack+0x1f0/0x31e lib/dump_stack.c:118
>  print_address_description+0x66/0x620 mm/kasan/report.c:383
>  __kasan_report mm/kasan/report.c:513 [inline]
>  kasan_report+0x132/0x1d0 mm/kasan/report.c:530
>  check_memory_region_inline mm/kasan/generic.c:183 [inline]
>  check_memory_region+0x2b5/0x2f0 mm/kasan/generic.c:192
>  instrument_atomic_write include/linux/instrumented.h:71 [inline]
>  atomic64_sub_return include/asm-generic/atomic-instrumented.h:970 [inline]
>  atomic_long_sub_return include/asm-generic/atomic-long.h:113 [inline]
>  page_counter_cancel mm/page_counter.c:54 [inline]
>  page_counter_uncharge+0x3d/0xc0 mm/page_counter.c:155
>  uncharge_batch+0x6c/0x350 mm/memcontrol.c:6764
>  uncharge_page+0x115/0x430 mm/memcontrol.c:6796
>  uncharge_list mm/memcontrol.c:6835 [inline]
>  mem_cgroup_uncharge_list+0x70/0xe0 mm/memcontrol.c:6877
>  release_pages+0x13a2/0x1550 mm/swap.c:911
>  tlb_batch_pages_flush mm/mmu_gather.c:49 [inline]
>  tlb_flush_mmu_free mm/mmu_gather.c:242 [inline]
>  tlb_flush_mmu+0x780/0x910 mm/mmu_gather.c:249
>  tlb_finish_mmu+0xcb/0x200 mm/mmu_gather.c:328
>  exit_mmap+0x296/0x550 mm/mmap.c:3185
>  __mmput+0x113/0x370 kernel/fork.c:1076
>  exit_mm+0x4cd/0x550 kernel/exit.c:483
>  do_exit+0x576/0x1f20 kernel/exit.c:793
>  do_group_exit+0x161/0x2d0 kernel/exit.c:903
>  get_signal+0x139b/0x1d30 kernel/signal.c:2743
>  arch_do_signal+0x33/0x610 arch/x86/kernel/signal.c:811
>  exit_to_user_mode_loop kernel/entry/common.c:135 [inline]
>  exit_to_user_mode_prepare+0x8d/0x1b0 kernel/entry/common.c:166
>  syscall_exit_to_user_mode+0x5e/0x1a0 kernel/entry/common.c:241
>  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> RIP: 0033:0x45d239
> Code: Bad RIP value.
> RSP: 002b:00007f3d8a21acf8 EFLAGS: 00000246 ORIG_RAX: 00000000000000ca
> RAX: 0000000000000001 RBX: 000000000118cf48 RCX: 000000000045d239
> RDX: 00000000000f4240 RSI: 0000000000000081 RDI: 000000000118cf4c
> RBP: 000000000118cf40 R08: 0000000000000009 R09: 0000000000000000
> R10: ffffffffffffffff R11: 0000000000000246 R12: 000000000118cf4c
> R13: 00007fff2711787f R14: 00007f3d8a21b9c0 R15: 000000000118cf4c
> 
> Allocated by task 9270:
>  kasan_save_stack mm/kasan/common.c:48 [inline]
>  kasan_set_track mm/kasan/common.c:56 [inline]
>  __kasan_kmalloc+0x100/0x130 mm/kasan/common.c:461
>  __do_kmalloc mm/slab.c:3655 [inline]
>  __kmalloc+0x218/0x320 mm/slab.c:3664
>  mem_cgroup_alloc mm/memcontrol.c:5210 [inline]
>  mem_cgroup_css_alloc+0x86/0x1590 mm/memcontrol.c:5278
>  css_create kernel/cgroup/cgroup.c:5128 [inline]
>  cgroup_apply_control_enable+0x581/0x1200 kernel/cgroup/cgroup.c:3059
>  cgroup_apply_control+0x37/0x6c0 kernel/cgroup/cgroup.c:3141
>  cgroup_subtree_control_write+0x95b/0x10c0 kernel/cgroup/cgroup.c:3299
>  cgroup_file_write+0x21e/0x5c0 kernel/cgroup/cgroup.c:3697
>  kernfs_fop_write+0x3f4/0x4f0 fs/kernfs/file.c:315
>  vfs_write+0x2d3/0xd10 fs/read_write.c:576
>  ksys_write+0x11b/0x220 fs/read_write.c:631
>  do_syscall_64+0x31/0x70 arch/x86/entry/common.c:46
>  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> 
> Freed by task 8108:
>  kasan_save_stack mm/kasan/common.c:48 [inline]
>  kasan_set_track+0x3d/0x70 mm/kasan/common.c:56
>  kasan_set_free_info+0x17/0x30 mm/kasan/generic.c:355
>  __kasan_slab_free+0xdd/0x110 mm/kasan/common.c:422
>  __cache_free mm/slab.c:3418 [inline]
>  kfree+0x10a/0x220 mm/slab.c:3756
>  mem_cgroup_free+0x97f/0x9b0 mm/memcontrol.c:5196
>  css_free_rwork_fn+0xe4/0x970 kernel/cgroup/cgroup.c:4941
>  process_one_work+0x789/0xfc0 kernel/workqueue.c:2269
>  worker_thread+0xaa4/0x1460 kernel/workqueue.c:2415
>  kthread+0x37e/0x3a0 drivers/block/aoe/aoecmd.c:1234
>  ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:294
> 
> Last call_rcu():
>  kasan_save_stack+0x27/0x50 mm/kasan/common.c:48
>  kasan_record_aux_stack+0x7b/0xb0 mm/kasan/generic.c:346
>  __call_rcu kernel/rcu/tree.c:2894 [inline]
>  call_rcu+0x139/0x840 kernel/rcu/tree.c:2968
>  queue_rcu_work+0x74/0x90 kernel/workqueue.c:1747
>  process_one_work+0x789/0xfc0 kernel/workqueue.c:2269
>  worker_thread+0xaa4/0x1460 kernel/workqueue.c:2415
>  kthread+0x37e/0x3a0 drivers/block/aoe/aoecmd.c:1234
>  ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:294
> 
> Second to last call_rcu():
>  kasan_save_stack+0x27/0x50 mm/kasan/common.c:48
>  kasan_record_aux_stack+0x7b/0xb0 mm/kasan/generic.c:346
>  __call_rcu kernel/rcu/tree.c:2894 [inline]
>  call_rcu+0x139/0x840 kernel/rcu/tree.c:2968
>  __percpu_ref_switch_to_atomic lib/percpu-refcount.c:192 [inline]
>  __percpu_ref_switch_mode+0x2c1/0x4f0 lib/percpu-refcount.c:237
>  percpu_ref_kill_and_confirm+0x8f/0x130 lib/percpu-refcount.c:350
>  cgroup_apply_control_disable kernel/cgroup/cgroup.c:3108 [inline]
>  cgroup_finalize_control+0x7c5/0xd60 kernel/cgroup/cgroup.c:3171
>  cgroup_subtree_control_write+0x968/0x10c0 kernel/cgroup/cgroup.c:3300
>  cgroup_file_write+0x21e/0x5c0 kernel/cgroup/cgroup.c:3697
>  kernfs_fop_write+0x3f4/0x4f0 fs/kernfs/file.c:315
>  vfs_write+0x2d3/0xd10 fs/read_write.c:576
>  ksys_write+0x11b/0x220 fs/read_write.c:631
>  do_syscall_64+0x31/0x70 arch/x86/entry/common.c:46
>  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> 
> The buggy address belongs to the object at ffff8880371c0000
>  which belongs to the cache kmalloc-4k of size 4096
> The buggy address is located 328 bytes inside of
>  4096-byte region [ffff8880371c0000, ffff8880371c1000)
> The buggy address belongs to the page:
> page:00000000cea4402b refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x371c0
> head:00000000cea4402b order:1 compound_mapcount:0
> flags: 0xfffe0000010200(slab|head)
> raw: 00fffe0000010200 ffffea0001337088 ffffea0000dc7088 ffff8880aa440900
> raw: 0000000000000000 ffff8880371c0000 0000000100000001 0000000000000000
> page dumped because: kasan: bad access detected
> 
> Memory state around the buggy address:
>  ffff8880371c0000: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>  ffff8880371c0080: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> >ffff8880371c0100: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>                                               ^
>  ffff8880371c0180: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>  ffff8880371c0200: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> ==================================================================
> 
> 
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
> 
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
