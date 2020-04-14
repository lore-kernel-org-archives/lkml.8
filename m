Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88A1FC2BB1D
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 05:48:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 620E92076C
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 05:48:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586843330;
	bh=dxNtBJSmXqe1DZ37vfP7M6NMjflxtXyP+i0cD5Aa+2g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=JqvBSVst850x3JFHcMeQ3eYry/YXlJU0Qgh3ZGAm/N1VuKNOKSnxMpFn8U0WTbozp
	 LB06qc/Iqt78OBf+BixPk4E76r0AW30YY5sJap9qOIKO7XSpEdQEJz8X2yj55IZA4T
	 vwfEUqXCAGZ8ATotLfR7tBA4dsYvlMTIIX5ly2rI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405609AbgDNFss (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 01:48:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:46710 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729111AbgDNFsl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 01:48:41 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A18BF20678;
        Tue, 14 Apr 2020 05:48:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586843320;
        bh=dxNtBJSmXqe1DZ37vfP7M6NMjflxtXyP+i0cD5Aa+2g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=H2bHlPj1rxVQDB8ViSd6AtK99uicW+XH+EiQmjfYXctvIn8im47nHNpVKnmx5eCAd
         wl7+tWouzn2ek62ML1pkv1BnXTJArgo1cTJVTW2nkbJc5bBHiC2n77qR0z74c1Yx6W
         RHnRPI5y2hUIlvld4l6sVRmEy+2CwyZ2yiWcSVoQ=
Date:   Tue, 14 Apr 2020 08:48:36 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>
Cc:     "H. Peter Anvin" <hpa@zytor.com>, x86 <x86@kernel.org>,
        Suresh Siddha <suresh.b.siddha@intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/apic: Fix circular locking dependency between
 console and hrtimer locks
Message-ID: <20200414054836.GA956407@unreal>
References: <20200407170925.1775019-1-leon@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200407170925.1775019-1-leon@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Any feedback?
https://lore.kernel.org/lkml/20200407170925.1775019-1-leon@kernel.org/

Thanks

On Tue, Apr 07, 2020 at 08:09:25PM +0300, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@mellanox.com>
>
> clockevents_switch_state() calls printk() from under hrtimer_bases.lock.
> That causes lock inversion on scheduler locks because printk() can call
> into the scheduler. Lockdep puts it as:
>
>  [  728.464312] ====================================================================================================
>  [  735.312580] TSC deadline timer enabled
>  [  735.324143]
>  [  735.324146] ======================================================
>  [  735.324148] WARNING: possible circular locking dependency detected
>  [  735.324150] 5.6.0-for-upstream-dbg-2020-04-03_10-44-43-70 #1 Not tainted
>  [  735.324152] ------------------------------------------------------
>  [  735.324154] swapper/3/0 is trying to acquire lock:
>  [  735.324155] ffffffff8442c858 ((console_sem).lock){-...}-{2:2}, at: down_trylock+0x13/0x70
>  [  735.324162]
>  [  735.324164] but task is already holding lock:
>  [  735.324165] ffff88842dfb9958 (hrtimer_bases.lock){-.-.}-{2:2}, at: lock_hrtimer_base+0x71/0x120
>  [  735.324171]
>  [  735.324173] which lock already depends on the new lock.
>  [  735.324174]
>  [  735.324175]
>  [  735.324177] the existing dependency chain (in reverse order) is:
>  [  735.324179]
>  [  735.324180] -> #4 (hrtimer_bases.lock){-.-.}-{2:2}:
>  [  735.324186]        _raw_spin_lock_irqsave+0x3c/0x4b
>  [  735.324187]        lock_hrtimer_base+0x71/0x120
>  [  735.324189]        hrtimer_start_range_ns+0xc6/0xaa0
>  [  735.324191]        __enqueue_rt_entity+0xc44/0xf50
>  [  735.324192]        enqueue_rt_entity+0x79/0xc0
>  [  735.324194]        enqueue_task_rt+0x5c/0x2e0
>  [  735.324195]        activate_task+0x15a/0x2c0
>  [  735.324197]        ttwu_do_activate+0xcf/0x120
>  [  735.324199]        sched_ttwu_pending+0x160/0x230
>  [  735.324200]        scheduler_ipi+0x1c0/0x530
>  [  735.324202]        reschedule_interrupt+0xf/0x20
>  [  735.324204]        tick_nohz_idle_enter+0x16c/0x250
>  [  735.324205]        do_idle+0x90/0x530
>  [  735.324207]        cpu_startup_entry+0x19/0x20
>  [  735.324208]        start_secondary+0x2ee/0x3e0
>  [  735.324210]        secondary_startup_64+0xa4/0xb0
>  [  735.324211]
>  [  735.324212] -> #3 (&rt_b->rt_runtime_lock){-...}-{2:2}:
>  [  735.324218]        _raw_spin_lock+0x25/0x30
>  [  735.324219]        rq_online_rt+0x288/0x550
>  [  735.324221]        set_rq_online+0x11f/0x190
>  [  735.324223]        sched_cpu_activate+0x1d4/0x390
>  [  735.324225]        cpuhp_invoke_callback+0x1c5/0x1560
>  [  735.324226]        cpuhp_thread_fun+0x3f8/0x6f0
>  [  735.324228]        smpboot_thread_fn+0x305/0x5f0
>  [  735.324229]        kthread+0x2f8/0x3b0
>  [  735.324231]        ret_from_fork+0x24/0x30
>  [  735.324232]
>  [  735.324233] -> #2 (&rq->lock){-.-.}-{2:2}:
>  [  735.324238]        _raw_spin_lock+0x25/0x30
>  [  735.324240]        task_fork_fair+0x34/0x430
>  [  735.324241]        sched_fork+0x48a/0xa60
>  [  735.324243]        copy_process+0x15df/0x5970
>  [  735.324244]        _do_fork+0x106/0xcd0
>  [  735.324246]        kernel_thread+0x9e/0xe0
>  [  735.324247]        rest_init+0x28/0x330
>  [  735.324249]        start_kernel+0x6ac/0x6ed
>  [  735.324251]        secondary_startup_64+0xa4/0xb0
>  [  735.324252]
>  [  735.324253] -> #1 (&p->pi_lock){-.-.}-{2:2}:
>  [  735.324258]        _raw_spin_lock_irqsave+0x3c/0x4b
>  [  735.324260]        try_to_wake_up+0x9a/0x1700
>  [  735.324261]        up+0x7a/0xb0
>  [  735.324263]        __up_console_sem+0x3c/0x70
>  [  735.324264]        console_unlock+0x4f4/0xab0
>  [  735.324266]        con_font_op+0x907/0x1010
>  [  735.324267]        vt_ioctl+0x10a6/0x2890
>  [  735.324269]        tty_ioctl+0x257/0x1240
>  [  735.324270]        ksys_ioctl+0x3e9/0x1190
>  [  735.324272]        __x64_sys_ioctl+0x6f/0xb0
>  [  735.324273]        do_syscall_64+0xe7/0x12c0
>  [  735.324275]        entry_SYSCALL_64_after_hwframe+0x49/0xb3
>  [  735.324276]
>  [  735.324277] -> #0 ((console_sem).lock){-...}-{2:2}:
>  [  735.324283]        __lock_acquire+0x374a/0x5210
>  [  735.324284]        lock_acquire+0x1b9/0x920
>  [  735.324286]        _raw_spin_lock_irqsave+0x3c/0x4b
>  [  735.324288]        down_trylock+0x13/0x70
>  [  735.324289]        __down_trylock_console_sem+0x33/0xa0
>  [  735.324291]        console_trylock+0x13/0x60
>  [  735.324292]        vprintk_emit+0xec/0x370
>  [  735.324294]        printk+0x9c/0xc3
>  [  735.324296]        lapic_timer_set_oneshot+0x4e/0x60
>  [  735.324297]        clockevents_switch_state+0x1e1/0x360
>  [  735.324299]        tick_program_event+0xae/0xc0
>  [  735.324301]        hrtimer_start_range_ns+0x4b6/0xaa0
>  [  735.324302]        tick_nohz_idle_stop_tick+0x67c/0xa90
>  [  735.324304]        do_idle+0x326/0x530
>  [  735.324305]        cpu_startup_entry+0x19/0x20
>  [  735.324307]        start_secondary+0x2ee/0x3e0
>  [  735.324309]        secondary_startup_64+0xa4/0xb0
>  [  735.324310]
>  [  735.324311] other info that might help us debug this:
>  [  735.324312]
>  [  735.324314] Chain exists of:
>  [  735.324315]   (console_sem).lock --> &rt_b->rt_runtime_lock --> hrtimer_bases.lock
>  [  735.324322]
>  [  735.324324]  Possible unsafe locking scenario:
>  [  735.324325]
>  [  735.324327]        CPU0                    CPU1
>  [  735.324328]        ----                    ----
>  [  735.324329]   lock(hrtimer_bases.lock);
>  [  735.324333]                                lock(&rt_b->rt_runtime_lock);
>  [  735.324337]                                lock(hrtimer_bases.lock);
>  [  735.324341]   lock((console_sem).lock);
>  [  735.324344]
>  [  735.324345]  *** DEADLOCK ***
>  [  735.324346]
>  [  735.324348] 1 lock held by swapper/3/0:
>  [  735.324349]  #0: ffff88842dfb9958 (hrtimer_bases.lock){-.-.}-{2:2}, at: lock_hrtimer_base+0x71/0x120
>  [  735.324356]
>  [  735.324357] stack backtrace:
>  [  735.324360] CPU: 3 PID: 0 Comm: swapper/3 Not tainted 5.6.0-for-upstream-dbg-2020-04-03_10-44-43-70 #1
>  [  735.324363] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.12.1-0-ga5cab58e9a3f-prebuilt.qemu.org 04/01/2014
>  [  735.324364] Call Trace:
>  [  735.324366]  dump_stack+0xb7/0x10b
>  [  735.324367]  check_noncircular+0x37f/0x460
>  [  735.324369]  ? arch_stack_walk+0x7c/0xd0
>  [  735.324370]  ? print_circular_bug+0x4e0/0x4e0
>  [  735.324372]  ? mark_lock+0x1a4/0xb60
>  [  735.324373]  ? __lock_acquire+0x374a/0x5210
>  [  735.324375]  __lock_acquire+0x374a/0x5210
>  [  735.324376]  ? register_lock_class+0x17e0/0x17e0
>  [  735.324378]  ? register_lock_class+0x17e0/0x17e0
>  [  735.324380]  lock_acquire+0x1b9/0x920
>  [  735.324381]  ? down_trylock+0x13/0x70
>  [  735.324383]  ? check_flags.part.29+0x450/0x450
>  [  735.324384]  ? lock_downgrade+0x760/0x760
>  [  735.324386]  ? vprintk_emit+0xec/0x370
>  [  735.324387]  _raw_spin_lock_irqsave+0x3c/0x4b
>  [  735.324389]  ? down_trylock+0x13/0x70
>  [  735.324390]  down_trylock+0x13/0x70
>  [  735.324392]  __down_trylock_console_sem+0x33/0xa0
>  [  735.324393]  console_trylock+0x13/0x60
>  [  735.324395]  vprintk_emit+0xec/0x370
>  [  735.324396]  printk+0x9c/0xc3
>  [  735.324398]  ? kmsg_dump_rewind_nolock+0xd9/0xd9
>  [  735.324399]  lapic_timer_set_oneshot+0x4e/0x60
>  [  735.324401]  clockevents_switch_state+0x1e1/0x360
>  [  735.324402]  ? enqueue_hrtimer+0x116/0x310
>  [  735.324404]  tick_program_event+0xae/0xc0
>  [  735.324406]  hrtimer_start_range_ns+0x4b6/0xaa0
>  [  735.324407]  ? hrtimer_run_softirq+0x210/0x210
>  [  735.324409]  ? rcu_read_lock_sched_held+0xab/0xe0
>  [  735.324410]  ? rcu_read_lock_bh_held+0xe0/0xe0
>  [  735.324412]  tick_nohz_idle_stop_tick+0x67c/0xa90
>  [  735.324413]  ? tsc_verify_tsc_adjust+0x71/0x290
>  [  735.324415]  do_idle+0x326/0x530
>  [  735.324416]  ? arch_cpu_idle_exit+0x40/0x40
>  [  735.324418]  cpu_startup_entry+0x19/0x20
>  [  735.324419]  start_secondary+0x2ee/0x3e0
>  [  735.324421]  ? set_cpu_sibling_map+0x2f70/0x2f70
>  [  735.324423]  secondary_startup_64+0xa4/0xb0
>  [  760.028504] ====================================================================================================
>
> Fix by using deferred variant of printk which doesn't call to the scheduler.
>
> Fixes: 279f1461432c ("x86: apic: Use tsc deadline for oneshot when available")
> Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
> ---
> It is far away from my main expertise and I'm not sure that the solution
> is correct, but it definitely fixed our regression.
> ---
>  arch/x86/kernel/apic/apic.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/x86/kernel/apic/apic.c b/arch/x86/kernel/apic/apic.c
> index d254cebdd3c3..6706b2cd9aec 100644
> --- a/arch/x86/kernel/apic/apic.c
> +++ b/arch/x86/kernel/apic/apic.c
> @@ -353,7 +353,7 @@ static void __setup_APIC_LVTT(unsigned int clocks, int oneshot, int irqen)
>  		 */
>  		asm volatile("mfence" : : : "memory");
>
> -		printk_once(KERN_DEBUG "TSC deadline timer enabled\n");
> +		printk_deferred_once(KERN_DEBUG "TSC deadline timer enabled\n");
>  		return;
>  	}
>
> --
> 2.25.1
>
