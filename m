Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A81C7C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 12:52:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8FE6220708
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 12:52:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727999AbgGGMwL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 08:52:11 -0400
Received: from mx2.suse.de ([195.135.220.15]:59292 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725944AbgGGMwK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 08:52:10 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 6D2F2AD93;
        Tue,  7 Jul 2020 12:52:09 +0000 (UTC)
Date:   Tue, 7 Jul 2020 14:52:08 +0200
From:   Daniel Wagner <dwagner@suse.de>
To:     linux-kernel@vger.kernel.org
Cc:     Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>
Subject: BUG: KASAN: use-after-free in show_pwq
Message-ID: <20200707125208.2ctpuasmbisaqaet@beryllium.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

while trying to debug something completely unrelated to this report
I stumpled the KASAN splatter below. This happens with v5.8-rc4
and most of the memory debug config options enabled.


Showing busy workqueues and worker pools:
workqueue events: flags=0x0
  pwq 0: cpus=0 node=0 flags=0x0 nice=0 active=5/256 refcnt=7
    in-flight:
==================================================================
BUG: KASAN: use-after-free in show_pwq+0x1ce/0x405
Read of size 4 at addr ffff888105310910 by task swapper/0/0

CPU: 0 PID: 0 Comm: swapper/0 Tainted: G      D     E     5.8.0-rc4-default #60
Hardware name: HP ProLiant DL580 Gen9/ProLiant DL580 Gen9, BIOS U17 07/21/2019
Call Trace:
 <IRQ>
  dump_stack+0x93/0xd0
 ? kmsg_dump_rewind_nolock+0x59/0x59
 ? show_pwq+0x1ce/0x405
 kasan_report.cold+0x37/0x86
 ? show_pwq+0x1ce/0x405
 show_pwq+0x1ce/0x405
 ? __raw_spin_unlock_irq+0x10/0x10
 show_workqueue_state.cold+0x1a4/0x200
 ? print_worker_info+0x200/0x200
 ? idr_get_next_ul+0x1a0/0x1a0
 ? pr_cont_pool_info+0x5b/0xa9
 wq_watchdog_timer_fn+0x1b9/0x1c0
 ? show_workqueue_state+0x1a0/0x1a0
 ? _find_next_bit.constprop.0+0x3e/0xf0
 ? show_workqueue_state+0x1a0/0x1a0
 call_timer_fn+0x2f/0x1d0
 __run_timers.part.0+0x31e/0x4c0
 ? show_workqueue_state+0x1a0/0x1a0
 ? call_timer_fn+0x1d0/0x1d0
 ? enqueue_hrtimer+0x110/0x110
 ? _raw_spin_trylock_bh+0x100/0x100
 ? recalibrate_cpu_khz+0x10/0x10
 ? ktime_get+0x4a/0xb0
 ? lapic_next_deadline+0x22/0x30
 ? clockevents_program_event+0xd8/0x130
 __do_softirq+0x118/0x404
 asm_call_on_stack+0x12/0x20
 </IRQ>
 do_softirq_own_stack+0x39/0x50
 irq_exit_rcu+0x14f/0x160
 sysvec_apic_timer_interrupt+0x33/0xa0
 asm_sysvec_apic_timer_interrupt+0x12/0x20
RIP: 0010:cpuidle_enter_state+0xd5/0x600
Code: e8 90 61 61 ff 80 7c 24 10 00 74 17 9c 58 0f 1f 44 00 00 f6 c4 02 0f 85 f5 04 00 00 31 ff e8 c2 79 6c ff fb 66 0f 1f 44 00 00 <45> 85 ed 0f 88 e4 03 00 00 4d 63 f5 4b 8d 04 76 4e 8d 3c f5 00 00
RSP: 0018:ffffffff8f007d38 EFLAGS: 00000246
RAX: 0000000000000000 RBX: ffffe8e7a28080e8 RCX: ffffffff8d54ff45
RDX: dffffc0000000000 RSI: 000000004387e5d2 RDI: ffff88881283b160
RBP: ffffffff8f413c80 R08: 0000000000000002 R09: fffffbfff1e037e1
R10: ffffffff8f01bf07 R11: fffffbfff1e037e0 R12: 0000000000000004
R13: 0000000000000004 R14: 00000000000001a0 R15: ffffffff8f413e20
 ? sched_idle_set_state+0x25/0x30
 ? cpuidle_enter_state+0xb0/0x600
 cpuidle_enter+0x3c/0x60
 do_idle+0x396/0x4a0
 ? arch_cpu_idle_exit+0x40/0x40
 cpu_startup_entry+0x19/0x20
 start_kernel+0x73d/0x77c
 ? thread_stack_cache_init+0x6/0x6
 ? init_intel_microcode+0xb2/0xb2
 ? x86_family+0x5/0x20
 ? load_ucode_bsp+0xd5/0x164
 secondary_startup_64+0xb6/0xc0

Allocated by task 2:
 save_stack+0x1b/0x40
 __kasan_kmalloc.constprop.0+0xc2/0xd0
 kmem_cache_alloc_node+0xe7/0x330
 dup_task_struct+0x36/0x690
 copy_process+0x349/0x2ad0
 _do_fork+0xc8/0x560
 kernel_thread+0xa8/0xe0
 kthreadd+0x50f/0x590
 ret_from_fork+0x22/0x30

Freed by task 11:
 save_stack+0x1b/0x40
 __kasan_slab_free+0x117/0x160
 kmem_cache_free+0xe3/0x2e0
 rcu_do_batch+0x31c/0xaf0
 rcu_core+0x2c7/0x4e0
 __do_softirq+0x118/0x404

The buggy address belongs to the object at ffff888105310040
 which belongs to the cache task_struct of size 9920
The buggy address is located 2256 bytes inside of
 9920-byte region [ffff888105310040, ffff888105312700)
The buggy address belongs to the page:
page:ffffea000414c400 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 head:ffffea000414c400 order:3 compound_mapcount:0 compound_pincount:0
flags: 0x17ffffc0010200(slab|head)
raw: 0017ffffc0010200 ffffea000414a808 ffffea000414d008 ffff888107c32a40
raw: 0000000000000000 0000000000030003 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
 ffff888105310800: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff888105310880: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff888105310900: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                         ^
 ffff888105310980: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff888105310a00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================

Thanks,
Daniel
