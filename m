Return-Path: <SRS0=VwT+=6S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38483C3A5A9
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 17:40:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0E1152068E
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 17:40:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730086AbgEDRks (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 May 2020 13:40:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:43440 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729597AbgEDRkr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 13:40:47 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6C8E220663;
        Mon,  4 May 2020 17:40:44 +0000 (UTC)
Date:   Mon, 4 May 2020 13:40:42 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Joerg Roedel <jroedel@suse.de>
Cc:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@alien8.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shile Zhang <shile.zhang@linux.alibaba.com>,
        Andy Lutomirski <luto@amacapital.net>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Tzvetomir Stoyanov <tz.stoyanov@gmail.com>
Subject: Re: [PATCH] percpu: Sync vmalloc mappings in pcpu_alloc() and
 free_percpu()
Message-ID: <20200504134042.178409c3@gandalf.local.home>
In-Reply-To: <20200504151236.GI8135@suse.de>
References: <20200429054857.66e8e333@oasis.local.home>
        <20200429105941.GQ30814@suse.de>
        <20200429082854.6e1796b5@oasis.local.home>
        <20200429100731.201312a9@gandalf.local.home>
        <20200430141120.GA8135@suse.de>
        <20200430121136.6d7aeb22@gandalf.local.home>
        <20200430191434.GC8135@suse.de>
        <20200430211308.74a994dc@oasis.local.home>
        <1902703609.78863.1588300015661.JavaMail.zimbra@efficios.com>
        <20200430223919.50861011@gandalf.local.home>
        <20200504151236.GI8135@suse.de>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 4 May 2020 17:12:36 +0200
Joerg Roedel <jroedel@suse.de> wrote:

> On Thu, Apr 30, 2020 at 10:39:19PM -0400, Steven Rostedt wrote:
> > What's so damn special about alloc_percpu()? It's definitely not a fast
> > path. And it's not used often.  
> 
> Okay, I fixed it in the percpu code. It is definitly not a nice
> solution, but having to call vmalloc_sync_mappings/unmappings() is not a
> nice solution at any place in the code. Here is the patch which fixes
> this issue for me. I am also not sure what to put in the Fixes tag, as
> it is related to tracing code accessing per-cpu data from the page-fault
> handler, not sure when this got introduced. Maybe someone else can
> provide a meaningful Fixes- or stable tag.
> 
> I also have an idea in mind how to make this all more robust and get rid
> of the vmalloc_sync_mappings/unmappings() interface, will show more when
> I know it works the way I think it does.
> 
>

Seems that your patch caused a lockdep splat on my box:

 ========================================================
 WARNING: possible irq lock inversion dependency detected
 5.7.0-rc3-test+ #249 Not tainted
 --------------------------------------------------------
 swapper/4/0 just changed the state of lock:
 ffff9a580fdd75a0 (&ndev->lock){++.-}-{2:2}, at: mld_ifc_timer_expire+0x3c/0x350
 but this lock took another, SOFTIRQ-unsafe lock in the past:
  (pgd_lock){+.+.}-{2:2}
 
 
 and interrupts could create inverse lock ordering between them.
 
 
 other info that might help us debug this:
  Possible interrupt unsafe locking scenario:
 
        CPU0                    CPU1
        ----                    ----
   lock(pgd_lock);
                                local_irq_disable();
                                lock(&ndev->lock);
                                lock(pgd_lock);
   <Interrupt>
     lock(&ndev->lock);
 
  *** DEADLOCK ***
 
 1 lock held by swapper/4/0:
  #0: ffff9a581ab05e70 ((&idev->mc_ifc_timer)){+.-.}-{0:0}, at: call_timer_fn+0x5/0x2f0
 
 the shortest dependencies between 2nd lock and 1st lock:
  -> (pgd_lock){+.+.}-{2:2} {
     HARDIRQ-ON-W at:
                       lock_acquire+0xda/0x3d0
                       _raw_spin_lock+0x2f/0x40
                       sync_global_pgds_l4+0x77/0x180
                       pcpu_alloc+0x1fd/0x7b0
                       __kmem_cache_create+0x358/0x540
                       create_cache+0xe1/0x1f0
                       kmem_cache_create_usercopy+0x1a5/0x270
                       kmem_cache_create+0x12/0x20
                       acpi_os_create_cache+0x18/0x30
                       acpi_ut_create_caches+0x47/0xab
                       acpi_ut_init_globals+0xa/0x21a
                       acpi_initialize_subsystem+0x30/0xa5
                       acpi_early_init+0x62/0xd6
                       start_kernel+0x797/0x86a
                       secondary_startup_64+0xa4/0xb0
     SOFTIRQ-ON-W at:
                       lock_acquire+0xda/0x3d0
                       _raw_spin_lock+0x2f/0x40
                       sync_global_pgds_l4+0x77/0x180
                       pcpu_alloc+0x1fd/0x7b0
                       __kmem_cache_create+0x358/0x540
                       create_cache+0xe1/0x1f0
                       kmem_cache_create_usercopy+0x1a5/0x270
                       kmem_cache_create+0x12/0x20
                       acpi_os_create_cache+0x18/0x30
                       acpi_ut_create_caches+0x47/0xab
                       acpi_ut_init_globals+0xa/0x21a
                       acpi_initialize_subsystem+0x30/0xa5
                       acpi_early_init+0x62/0xd6
                       start_kernel+0x797/0x86a
                       secondary_startup_64+0xa4/0xb0
     INITIAL USE at:
   }
   ... key      at: [<ffffffffb96340b8>] pgd_lock+0x18/0x40
   ... acquired at:
    _raw_spin_lock+0x2f/0x40
    sync_global_pgds_l4+0x77/0x180
    pcpu_alloc+0x1fd/0x7b0
    fib_nh_common_init+0x53/0x110
    fib6_nh_init+0x10c/0x700
    ip6_route_info_create+0x344/0x440
    ip6_route_add+0x18/0x90
    addrconf_prefix_route.isra.48+0x17b/0x210
    addrconf_notify+0x743/0x8c0
    notifier_call_chain+0x47/0x70
    __dev_notify_flags+0x9d/0x150
    dev_change_flags+0x48/0x60
    do_setlink+0x39d/0x1080
    rtnl_setlink+0x116/0x190
    rtnetlink_rcv_msg+0x188/0x4b0
    netlink_rcv_skb+0x75/0x140
    netlink_unicast+0x1ae/0x280
    netlink_sendmsg+0x253/0x490
    sock_sendmsg+0x5b/0x60
    __sys_sendto+0x12c/0x190
    __x64_sys_sendto+0x24/0x30
    do_syscall_64+0x60/0x230
    entry_SYSCALL_64_after_hwframe+0x49/0xb3
 
 -> (&ndev->lock){++.-}-{2:2} {
    HARDIRQ-ON-W at:
                     lock_acquire+0xda/0x3d0
                     _raw_write_lock_bh+0x34/0x40
                     ipv6_mc_init_dev+0x19/0xc0
                     ipv6_add_dev+0x2e5/0x490
                     addrconf_init+0x7f/0x250
                     inet6_init+0x1c3/0x373
                     do_one_initcall+0x70/0x340
                     kernel_init_freeable+0x249/0x2ca
                     kernel_init+0xa/0x10a
                     ret_from_fork+0x3a/0x50
    HARDIRQ-ON-R at:
                     lock_acquire+0xda/0x3d0
                     _raw_read_lock_bh+0x37/0x50
                     addrconf_dad_work+0xc6/0x560
                     process_one_work+0x25e/0x5c0
                     worker_thread+0x30/0x380
                     kthread+0x139/0x160
                     ret_from_fork+0x3a/0x50
    IN-SOFTIRQ-R at:
                     lock_acquire+0xda/0x3d0
                     _raw_read_lock_bh+0x37/0x50
                     mld_ifc_timer_expire+0x3c/0x350
                     call_timer_fn+0xa5/0x2f0
                     run_timer_softirq+0x1dd/0x580
                     __do_softirq+0xf8/0x4be
                     irq_exit+0xf1/0x100
                     smp_apic_timer_interrupt+0xd0/0x2a0
                     apic_timer_interrupt+0xf/0x20
                     cpuidle_enter_state+0xcd/0x440
                     cpuidle_enter+0x29/0x40
                     do_idle+0x24a/0x290
                     cpu_startup_entry+0x19/0x20
                     start_secondary+0x195/0x1e0
                     secondary_startup_64+0xa4/0xb0
    INITIAL USE at:
                    lock_acquire+0xda/0x3d0
                    _raw_write_lock_bh+0x34/0x40
                    ipv6_mc_init_dev+0x19/0xc0
                    ipv6_add_dev+0x2e5/0x490
                    addrconf_init+0x7f/0x250
                    inet6_init+0x1c3/0x373
                    do_one_initcall+0x70/0x340
                    kernel_init_freeable+0x249/0x2ca
                    kernel_init+0xa/0x10a
                    ret_from_fork+0x3a/0x50
  }
  ... key      at: [<ffffffffbaf727f0>] __key.78650+0x0/0x10
  ... acquired at:
    mark_lock+0x22e/0x740
    __lock_acquire+0x9e1/0x1c30
    lock_acquire+0xda/0x3d0
    _raw_read_lock_bh+0x37/0x50
    mld_ifc_timer_expire+0x3c/0x350
    call_timer_fn+0xa5/0x2f0
    run_timer_softirq+0x1dd/0x580
    __do_softirq+0xf8/0x4be
    irq_exit+0xf1/0x100
    smp_apic_timer_interrupt+0xd0/0x2a0
    apic_timer_interrupt+0xf/0x20
    cpuidle_enter_state+0xcd/0x440
    cpuidle_enter+0x29/0x40
    do_idle+0x24a/0x290
    cpu_startup_entry+0x19/0x20
    start_secondary+0x195/0x1e0
    secondary_startup_64+0xa4/0xb0
 
 
 stack backtrace:
 CPU: 4 PID: 0 Comm: swapper/4 Not tainted 5.7.0-rc3-test+ #249
 Hardware name: Hewlett-Packard HP Compaq Pro 6300 SFF/339A, BIOS K01 v03.03 07/14/2016
 Call Trace:
  <IRQ>
  dump_stack+0x8f/0xd0
  check_usage_forwards.cold.61+0x1e/0x27
  mark_lock+0x22e/0x740
  ? check_usage_backwards+0x1e0/0x1e0
  __lock_acquire+0x9e1/0x1c30
  lock_acquire+0xda/0x3d0
  ? mld_ifc_timer_expire+0x3c/0x350
  ? mld_dad_timer_expire+0xb0/0xb0
  ? mld_dad_timer_expire+0xb0/0xb0
  _raw_read_lock_bh+0x37/0x50
  ? mld_ifc_timer_expire+0x3c/0x350
  mld_ifc_timer_expire+0x3c/0x350
  ? mld_dad_timer_expire+0xb0/0xb0
  ? mld_dad_timer_expire+0xb0/0xb0
  call_timer_fn+0xa5/0x2f0
  ? mld_dad_timer_expire+0xb0/0xb0
  run_timer_softirq+0x1dd/0x580
  __do_softirq+0xf8/0x4be
  irq_exit+0xf1/0x100
  smp_apic_timer_interrupt+0xd0/0x2a0
  apic_timer_interrupt+0xf/0x20
  </IRQ>
 RIP: 0010:cpuidle_enter_state+0xcd/0x440
 Code: 80 7c 24 13 00 74 17 9c 58 0f 1f 44 00 00 f6 c4 02 0f 85 0c 03 00 00 31 ff e8 6f 35 8b ff e8 1a 52 92 ff fb 66 0f 1f 44 00 00 <85> ed 0f 88 74 02 00 00 48 63 c5 4c 8b 3c 24 4c 2b 7c 24 08 48 8d
 RSP: 0018:ffff9a581981fe70 EFLAGS: 00000246 ORIG_RAX: ffffffffffffff13
 RAX: 0000000000e2cf41 RBX: ffff9a581ab37400 RCX: 0000000000000000
 RDX: ffff9a581982d100 RSI: 0000000000000006 RDI: ffff9a581982d100
 RBP: 0000000000000004 R08: 0000000000000001 R09: 0000000000000000
 R10: 0000000000000000 R11: 0000000000000000 R12: ffffffffb96f14c0
 R13: ffffffffb96f1678 R14: 0000000000000004 R15: 0000000000000004
  cpuidle_enter+0x29/0x40
  do_idle+0x24a/0x290
  cpu_startup_entry+0x19/0x20
  start_secondary+0x195/0x1e0
  secondary_startup_64+0xa4/0xb0


-- Steve
