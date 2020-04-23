Return-Path: <SRS0=rw9U=6H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1F4DC2BA19
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 07:13:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 977DD21569
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 07:13:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587626001;
	bh=NCW7/xxQPZqWt/XDpNuCX5rmF0cJnZvcgG4y//LcuBY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=kDyP9Wlb6LQQ8EGX3uwFnghpHXrKipyxvneYiHPfRvXdfN1rQ5C4yVmWtEoZCQW9h
	 9aY5WGoHj7ti/l2k5MclEYbd9YD2+OI8O2isr/D/XxJ5pb5HXsl+tO2oGsvLhVcEFp
	 Fz/nH9YOmI5joHhUZm/gX0Yhq7vEqENJqVzyyVoM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726822AbgDWHNT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Apr 2020 03:13:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:55024 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725562AbgDWHNT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Apr 2020 03:13:19 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C5C19208E4;
        Thu, 23 Apr 2020 07:13:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587625998;
        bh=NCW7/xxQPZqWt/XDpNuCX5rmF0cJnZvcgG4y//LcuBY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=v4IpFZOfdMeDTnvLK/XmIkELPjTP4NC8PD5Lpn0OCHAPeqVEAD93X7SpOdFjZQyIb
         +jAQPFtlLBjVlg846x4g/DsD7dp57RBDFduk3ZpCSdRyvFttXvoG1dr+0vrX3X9RvU
         hv8FPH34klNPfCfAOZ7VGQo5veU431b2hO82xBwY=
Date:   Thu, 23 Apr 2020 10:13:14 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86 <x86@kernel.org>,
        Suresh Siddha <suresh.b.siddha@intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/apic: Fix circular locking dependency between
 console and hrtimer locks
Message-ID: <20200423071314.GA45903@unreal>
References: <20200407170925.1775019-1-leon@kernel.org>
 <20200414054836.GA956407@unreal>
 <20200414062454.GA84326@gmail.com>
 <20200414070502.GR334007@unreal>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200414070502.GR334007@unreal>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 14, 2020 at 10:05:02AM +0300, Leon Romanovsky wrote:
> On Tue, Apr 14, 2020 at 08:24:54AM +0200, Ingo Molnar wrote:
> >
> > * Leon Romanovsky <leon@kernel.org> wrote:
> >
> > > Hi,
> > >
> > > Any feedback?
> > > https://lore.kernel.org/lkml/20200407170925.1775019-1-leon@kernel.org/
> >
> > The fix definitely looks legit, lockdep is right that we shouldn't take
> > the console_sem.lock even under trylock.
> >
> > It's only a printk_once(), yet I'm wondering why in the last ~8 years
> > this never triggered. Nobody ever ran lockdep and debug console level
> > enabled on such hardware, or did something else change?
> >
> > One possibility would be that apic_check_deadline_errata() marked almost
> > all Intel systems as broken and the TSC-deadline hardware never actually
> > got activated. In that case you have triggered rarely tested code and
> > might see other weirdnesses. Just saying. :-)
>
> It is hard to say what was changed, but after -rc1, we started to see
> those lockdep splats almost in every run.

Anything that I can help to speed up this patch?
Are you expecting anything from me that I missed to do?

Our regression is flooded with ACPI splats.

Thanks

>
> But if we are talking about other weirdnesses, I have another splat in my
> QEMU machine, which is different, but from the same code area.
>
> [    1.383968] ACPI: Added _OSI(Module Device)
> [    1.385684] ACPI: Added _OSI(Processor Device)
> [    1.389345] ACPI: Added _OSI(3.0 _SCP Extensions)
> [    1.389345] ACPI: Added _OSI(Processor Aggregator Device)
> [    1.393454] ACPI: Added _OSI(Linux-Dell-Video)
> [    1.394920] ACPI: Added _OSI(Linux-Lenovo-NV-HDMI-Audio)
> [    1.396481] ACPI: Added _OSI(Linux-HPI-Hybrid-Graphics)
> [    1.793418] ACPI: 1 ACPI AML tables successfully acquired and loaded
> [    1.845452]
> [    1.846768] =============================
> [    1.849293] [ BUG: Invalid wait context ]
> [    1.849293] 5.7.0-rc1+ #1229 Not tainted
> [    1.849293] -----------------------------
> [    1.849293] swapper/1/0 is trying to lock:
> [    1.849293] ffff88806c8a4418 (&n->list_lock){-...}-{3:3}, at: deactivate_slab.isra.0+0x304/0x6d0
> [    1.849293] other info that might help us debug this:
> [    1.849293] context-{2:2}
> [    1.849293] 1 lock held by swapper/1/0:
> [    1.849293]  #0: ffffffff826cb000 (rcu_callback){....}-{0:0}, at: rcu_core+0x317/0x9e0
> [    1.849293] stack backtrace:
> [    1.849293] CPU: 1 PID: 0 Comm: swapper/1 Not tainted 5.7.0-rc1+ #1229
> [    1.849293] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.12.1-0-ga5cab58e9a3f-prebuilt.qemu.org 0
> 4/01/2014
> [    1.849293] Call Trace:
> [    1.849293]  <IRQ>
> [    1.849293]  dump_stack+0x97/0xe0
> [    1.849293]  __lock_acquire.cold+0xd6/0x354
> [    1.849293]  ? sched_clock_cpu+0x11f/0x140
> [    1.849293]  ? mark_held_locks+0x90/0x90
> [    1.849293]  ? __lock_acquire+0x8bf/0x3800
> [    1.849293]  lock_acquire+0x155/0x4f0
> [    1.849293]  ? deactivate_slab.isra.0+0x304/0x6d0
> [    1.849293]  ? lock_release+0x660/0x660
> [    1.849293]  ? sched_clock_local+0x99/0xc0
> [    1.849293]  ? sched_clock_cpu+0x11f/0x140
> [    1.849293]  _raw_spin_lock+0x31/0x80
> [    1.849293]  ? deactivate_slab.isra.0+0x304/0x6d0
> [    1.849293]  deactivate_slab.isra.0+0x304/0x6d0
> [    1.849293]  ? pvclock_clocksource_read+0xd9/0x190
> [    1.849293]  ? slub_cpu_dead+0xd0/0xd0
> [    1.849293]  flush_cpu_slab+0x36/0x50
> [    1.849293]  flush_smp_call_function_queue+0xc2/0x1e0
> [    1.849293]  smp_call_function_interrupt+0x93/0x2f0
> [    1.849293]  call_function_interrupt+0xf/0x20
> [    1.849293] RIP: 0010:quarantine_put+0xba/0x150
> [    1.849293] Code: e8 bb bb ec ff 48 8b 44 24 18 65 48 33 04 25 28 00 00 00 0f 85 a0 00 00 00 48 83 c4 20 5b 5d 41 5
> c c3 e8 39 b8 ec ff 41 54 9d <eb> d9 48 89 e6 e8 cc fe ff ff 48 c7 c7 60 e3 76 82 e8 c0 f3 6b 00
> [    1.849293] RSP: 0000:ffff88806d209db0 EFLAGS: 00000246 ORIG_RAX: ffffffffffffff03
> [    1.849293] RAX: 0000000000000000 RBX: ffff88806be33658 RCX: dffffc0000000000
> [    1.849293] RDX: 0000000000000007 RSI: 0000000000000002 RDI: ffff88806cb5876c
> [    1.849293] RBP: ffff88806c80de00 R08: ffffffff811656ed R09: 0000000000000000
> [    1.849293] R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000246
> [    1.849293] R13: ffff88806c80de00 R14: 0000000000000206 R15: 0000000000000000
> [    1.849293]  ? call_function_interrupt+0xa/0x20
> [    1.849293]  ? lockdep_hardirqs_on+0x17d/0x270
> [    1.849293]  __kasan_slab_free+0x144/0x180
> [    1.849293]  ? rcu_core+0x35c/0x9e0
> [    1.849293]  kmem_cache_free+0xc6/0x370
> [    1.849293]  ? migrate_pages+0xa70/0xa70
> [    1.849293]  rcu_core+0x35c/0x9e0
> [    1.849293]  ? rcu_core+0x317/0x9e0
> [    1.849293]  ? rcu_note_context_switch+0x300/0x300
> [    1.849293]  ? rcu_read_lock_sched_held+0xa1/0xd0
> [    1.849293]  ? rcu_read_lock_bh_held+0xb0/0xb0
> [    1.849293]  ? run_rebalance_domains+0x11d/0x140
> [    1.849293]  __do_softirq+0x11c/0x612
> [    1.849293]  ? rcu_read_lock_bh_held+0xb0/0xb0
> [    1.849293]  irq_exit+0xfb/0x100
> [    1.849293]  smp_apic_timer_interrupt+0x12e/0x360
> [    1.849293]  apic_timer_interrupt+0xf/0x20
> [    1.849293]  </IRQ>
> [    1.849293] RIP: 0010:default_idle+0x6e/0x250
> [    1.849293] Code: c7 c7 40 11 01 83 e8 f1 ec 93 ff 48 c7 c7 40 11 01 83 e8 b5 0c 94 ff 8b 05 6f a8 5f 01 85 c0 7e 0
> 7 0f 00 2d 84 f4 5f 00 fb f4 <be> 04 00 00 00 48 c7 c7 c8 bc 98 82 65 8b 2d 4f 48 60 7e e8 ba ec
> [    1.849293] RSP: 0000:ffff88806cb67dc8 EFLAGS: 00000246 ORIG_RAX: ffffffffffffff13
> [    1.849293] RAX: 0000000000000000 RBX: ffff88806cb58000 RCX: dffffc0000000000
> [    1.849293] RDX: 0000000000000003 RSI: 0000000000000004 RDI: ffffffff83011140
> [    1.849293] RBP: 0000000000000001 R08: ffffffff81a168cb R09: fffffbfff0602229
> [    1.849293] R10: 0000000000000003 R11: fffffbfff0602228 R12: ffffffff829a13f0
> [    1.849293] R13: 0000000000000000 R14: ffff88806cb58000 R15: 0000000000000000
> [    1.849293]  ? default_idle+0x5b/0x250
> [    1.849293]  ? default_idle+0x5b/0x250
> [    1.849293]  do_idle+0x321/0x380
> [    1.849293]  ? arch_cpu_idle_exit+0x40/0x40
> [    1.849293]  ? mark_held_locks+0x1d/0x90
> [    1.849293]  ? _raw_spin_unlock_irqrestore+0x3e/0x50
> [    1.849293]  cpu_startup_entry+0x19/0x20
> [    1.849293]  start_secondary+0x214/0x280
> [    1.849293]  ? set_cpu_sibling_map+0x9e0/0x9e0
> [    1.849293]  secondary_startup_64+0xa4/0xb0
> [    2.093362] ACPI: Interpreter enabled
>
> >
> > Or a bootup with "debug" specified is much more rare in production
> > systems, hence the 8 years old bug.
> >
> > > > It is far away from my main expertise and I'm not sure that the solution
> > > > is correct, but it definitely fixed our regression.
> > > > ---
> > > >  arch/x86/kernel/apic/apic.c | 2 +-
> > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > >
> > > > diff --git a/arch/x86/kernel/apic/apic.c b/arch/x86/kernel/apic/apic.c
> > > > index d254cebdd3c3..6706b2cd9aec 100644
> > > > --- a/arch/x86/kernel/apic/apic.c
> > > > +++ b/arch/x86/kernel/apic/apic.c
> > > > @@ -353,7 +353,7 @@ static void __setup_APIC_LVTT(unsigned int clocks, int oneshot, int irqen)
> > > >  		 */
> > > >  		asm volatile("mfence" : : : "memory");
> > > >
> > > > -		printk_once(KERN_DEBUG "TSC deadline timer enabled\n");
> > > > +		printk_deferred_once(KERN_DEBUG "TSC deadline timer enabled\n");
> >
> > I think we should move this essentially initialization-time message much
> > earlier during bootup, when we are not holding any hrtimer locks.
> >
> > One good place would be apic_check_deadline_errata(). This place:
> >
> >         if (boot_cpu_data.microcode >= rev)
> >                 return;
> >
> >         setup_clear_cpu_cap(X86_FEATURE_TSC_DEADLINE_TIMER);
> >         pr_err(FW_BUG "TSC_DEADLINE disabled due to Errata; "
> >                "please update microcode to version: 0x%x (or later)\n", rev);
> >
> > Could be something like:
> >
> >         if (boot_cpu_data.microcode >= rev) {
> > 		pr_debug("x86/apic: TSC deadline timer enabled.\n");
> >                 return;
> > 	}
> >
> >         setup_clear_cpu_cap(X86_FEATURE_TSC_DEADLINE_TIMER);
> >         pr_err(FW_BUG "TSC_DEADLINE disabled due to CPU errata, please update microcode to version: 0x%x (or later)\n", rev);
>
> I don't know what is x2apic_mode, but won't x2apic_mode == 1 prevent from setting timer?
> If yes, we will print "enabled" message too early.
>
> 2091 void __init init_apic_mappings(void)
> <...>
> 2095         apic_check_deadline_errata();
> 2096
> 2097         if (x2apic_mode) {
> 2098                 boot_cpu_physical_apicid = read_apic_id();
> 2099                 return;
> 2100         }
>
> >
> > (Note the small fixes I did to the errata message - we should do that and
> > also move all user-facing messages into a single line while at it.)
> >
> > Thanks,
> >
> > 	Ingo
