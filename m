Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 961CBC433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 16:35:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6E5DD207F9
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 16:35:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WxD6ycMb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732413AbgGAQfQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 12:35:16 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:42983 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1732161AbgGAQfO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 12:35:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1593621312;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=350KtRkwkJRUDTG4ICYjlGSwav6RFv9afGxlrk9Fti0=;
        b=WxD6ycMb6v6Ow2b6jE8pSVQkQ0NiXb8IpSG+4uTppMhy3DfaYUsQCKFY2n6W1xngtZhd8u
        IQCgRQFetZMdvVF6yq091V3T6MczNouQC4m5T61Q/mLa0iZ0wNR56YFYpJbr+2k5MrU95q
        olQJ34NyueCRk4dDQZeCDhRV61tl6PA=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-439-1of7EXfdO6y-3S9fMs28kg-1; Wed, 01 Jul 2020 12:35:08 -0400
X-MC-Unique: 1of7EXfdO6y-3S9fMs28kg-1
Received: by mail-wr1-f69.google.com with SMTP id i10so21439944wrn.21
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jul 2020 09:35:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=350KtRkwkJRUDTG4ICYjlGSwav6RFv9afGxlrk9Fti0=;
        b=dgjg1g/OQBrwgo/K04+bdIxsTrb4XzS94ulO57Cu8VY82+cQu1TyXVY6sKYfPyy/1n
         YD7Xj1sLFYIbsMSzyARU3y4s3MapWWrUTqWg6V79imJx4SRkE8UrmnMg2+ly7W7QeU7B
         sVYkKSqRcoFqjOpGpUvhnd9YaCkTJSdO0EC+Sdh+tP24ikA27W6CcvpsctjdfM1Q0/9X
         ByL8elogMLbhwFOC8Rh5CfCSRvxS66ruyQ4CVWSMzMQIm9iQOyCjofU09njdmFhN5K3D
         1aTG02z4YYsRWWFVMPGer3rjmVg9D24lepj8FGCPcgeXcar6I/VZ6hRLAd3hzCB/z4aM
         MkPw==
X-Gm-Message-State: AOAM530rvG8LNhePwQ+I/Z/gWw2h4F3jhO6hNBMw0ARhij7E1/ZUwlOz
        5FJqRIwaBIOBbhKfn+BNAt6749FudJTVKsKPXPaAaPqZUKr0nj+v97zdS2oq+mFLBVPFHrqHdgH
        LkaDdJfCT+R9KmadrbUKB9f3J
X-Received: by 2002:adf:db09:: with SMTP id s9mr26836640wri.256.1593621306902;
        Wed, 01 Jul 2020 09:35:06 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz2YbSsQYZ8LPOUMFmDkAfKK3IAgAhvhlKwITwhNXuOE2Sjd19vKg+ZQCwAbr9AwF351MfqmQ==
X-Received: by 2002:adf:db09:: with SMTP id s9mr26836624wri.256.1593621306598;
        Wed, 01 Jul 2020 09:35:06 -0700 (PDT)
Received: from localhost.localdomain ([151.29.8.241])
        by smtp.gmail.com with ESMTPSA id w14sm7885568wrt.55.2020.07.01.09.35.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2020 09:35:06 -0700 (PDT)
Date:   Wed, 1 Jul 2020 18:35:04 +0200
From:   Juri Lelli <juri.lelli@redhat.com>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Anna-Maria Gleixner <anna-maria@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RFC PATCH 01/10] timer: Prevent base->clk from moving backward
Message-ID: <20200701163504.GD9670@localhost.localdomain>
References: <20200701011030.14324-1-frederic@kernel.org>
 <20200701011030.14324-2-frederic@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200701011030.14324-2-frederic@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Thanks for the set, first of all. Reviewing and testing it.

On 01/07/20 03:10, Frederic Weisbecker wrote:
> When a timer is enqueued with a negative delta (ie: expiry is below
> base->clk), it gets added to the wheel as expiring now (base->clk).
> 
> Yet the value that gets stored in base->next_expiry, while calling
> trigger_dyntick_cpu(), is the initial timer->expires value. The
> resulting state becomes:
> 
> 	base->next_expiry < base->clk
> 
> On the next timer enqueue, forward_timer_base() may accidentally
> rewind base->clk. As a possible outcome, timers may expire way too
> early, the worst case being that the highest wheel levels get spuriously
> processed again.
> 
> To prevent from that, make sure that base->next_expiry doesn't get below
> base->clk.
> 
> Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Anna-Maria Gleixner <anna-maria@linutronix.de>
> Cc: Juri Lelli <juri.lelli@redhat.com>
> ---
>  kernel/time/timer.c | 17 ++++++++++++++---
>  1 file changed, 14 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/time/timer.c b/kernel/time/timer.c
> index 398e6eadb861..9a838d38dbe6 100644
> --- a/kernel/time/timer.c
> +++ b/kernel/time/timer.c
> @@ -584,7 +584,15 @@ trigger_dyntick_cpu(struct timer_base *base, struct timer_list *timer)
>  	 * Set the next expiry time and kick the CPU so it can reevaluate the
>  	 * wheel:
>  	 */
> -	base->next_expiry = timer->expires;
> +	if (time_before(timer->expires, base->clk)) {
> +		/*
> +		 * Prevent from forward_timer_base() moving the base->clk
> +		 * backward
> +		 */
> +		base->next_expiry = base->clk;
> +	} else {
> +		base->next_expiry = timer->expires;
> +	}
>  	wake_up_nohz_cpu(base->cpu);
>  }
>  
> @@ -896,10 +904,13 @@ static inline void forward_timer_base(struct timer_base *base)
>  	 * If the next expiry value is > jiffies, then we fast forward to
>  	 * jiffies otherwise we forward to the next expiry value.
>  	 */
> -	if (time_after(base->next_expiry, jnow))
> +	if (time_after(base->next_expiry, jnow)) {
>  		base->clk = jnow;
> -	else
> +	} else {
> +		if (WARN_ON_ONCE(time_before(base->next_expiry, base->clk)))
> +			return;

I actually ported it to latest RT tree (v5.6.17-rt10) w/o conflicts,
but hit this one above:

 ...
 000: Kernel command line: BOOT_IMAGE=(hd0,msdos1)/vmlinuz-5.6.17-rt10 root=/dev/mapper/rhel_rt--qe--04-root ro crashkernel=auto resume=/dev/mapper/rhel_rt--qe--04-swap rd.lvm.lv=rhel_rt-qe-04/root rd.lvm.lv=rhel_rt-qe-04/swap console=ttyS0,115200
 000: mem auto-init: stack:off, heap alloc:off, heap free:off
 000: Memory: 2102240K/134089036K available (12292K kernel code, 2449K rwdata, 4332K rodata, 2248K init, 15392K bss, 2278548K reserved, 0K cma-reserved)
 000: random: get_random_u64 called from cache_random_seq_create+0x7c/0x140 with crng_init=0
 000: SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=24, Nodes=2
 000: Kernel/User page tables isolation: enabled
 000: ftrace: allocating 37680 entries in 148 pages
 000: ftrace: allocated 148 pages with 3 groups
 000: rcu: Preemptible hierarchical RCU implementation.
 000: rcu:        RCU restricting CPUs from NR_CPUS=8192 to nr_cpu_ids=24.
 000: rcu:        RCU priority boosting: priority 1 delay 500 ms.
 000: rcu:        RCU_SOFTIRQ processing moved to rcuc kthreads.
 000:     No expedited grace period (rcu_normal_after_boot).
 000:     Tasks RCU enabled.
 000: rcu: RCU calculated value of scheduler-enlistment delay is 100 jiffies.
 000: rcu: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=24
 000: NR_IRQS: 524544, nr_irqs: 1432, preallocated irqs: 16
 000: random: crng done (trusting CPU's manufacturer)
 000: Console: colour VGA+ 80x25
 000: printk: console [ttyS0] enabled
 000: ACPI: Core revision 20200110
 000: clocksource: hpet: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 133484882848 ns
 000: APIC: Switch to symmetric I/O mode setup
 000: DMAR: Host address width 46
 000: DMAR: DRHD base: 0x000000fbffc000 flags: 0x0
 000: DMAR: dmar0: reg_base_addr fbffc000 ver 1:0 cap d2078c106f0466 ecap f020df
 000: DMAR: DRHD base: 0x000000c7ffc000 flags: 0x1
 000: DMAR: dmar1: reg_base_addr c7ffc000 ver 1:0 cap d2078c106f0466 ecap f020df
 000: DMAR: RMRR base: 0x00000079190000 end: 0x00000079192fff
 000: DMAR: RMRR base: 0x000000791f4000 end: 0x000000791f7fff
 000: DMAR: RMRR base: 0x000000791de000 end: 0x000000791f3fff
 000: DMAR: RMRR base: 0x000000791cb000 end: 0x000000791dbfff
 000: DMAR: RMRR base: 0x000000791dc000 end: 0x000000791ddfff
 000: DMAR: RMRR base: 0x0000005a661000 end: 0x0000005a6a0fff
 000: DMAR-IR: IOAPIC id 10 under DRHD base  0xfbffc000 IOMMU 0
 000: DMAR-IR: IOAPIC id 8 under DRHD base  0xc7ffc000 IOMMU 1
 000: DMAR-IR: IOAPIC id 9 under DRHD base  0xc7ffc000 IOMMU 1
 000: DMAR-IR: HPET id 0 under DRHD base 0xc7ffc000
 000: DMAR-IR: Queued invalidation will be enabled to support x2apic and Intr-remapping.
 000: DMAR-IR: Enabled IRQ remapping in x2apic mode
 000: x2apic enabled
 000: Switched APIC routing to cluster x2apic.
 000: ..TIMER: vector=0x30 apic1=0 pin1=2 apic2=-1 pin2=-1
 000: clocksource: tsc-early: mask: 0xffffffffffffffff max_cycles: 0x228d095820e, max_idle_ns: 440795295198 ns
 000: ------------[ cut here ]------------
 000: WARNING: CPU: 0 PID: 0 at kernel/time/timer.c:897 add_timer_on+0x129/0x140
 000: Modules linked in:
 000: CPU: 0 PID: 0 Comm: swapper/0 Not tainted 5.6.17-rt10 #1
 000: Hardware name: HP ProLiant DL380 Gen9/ProLiant DL380 Gen9, BIOS P89 10/25/2017
 000: RIP: 0010:add_timer_on+0x129/0x140
 000: Code: 24 48 89 ef e8 e8 ca 7d 00 48 8b 44 24 08 65 48 33 04 25 28 00 00 00 75 1f 48 83 c4 10 5b 5d 41 5c c3 48 89 45 48 eb ca 0f 0b <0f> 0b eb c4 e8 53 94 e9 ff e9 7b ff ff ff e8 64 c4 f6 ff 0f 1f 40
 000: RSP: 0000:ffffffffb2c03e80 EFLAGS: 00010083
 000: RAX: 00000000fffb6c25 RBX: ffffffffb3886540 RCX: 0000000000000000
 000: RDX: 00000000fffb6c20 RSI: ffffffffb2c03e80 RDI: 0000000000000001
 000: RBP: ffff92687fa19300 R08: 0000000000000000 R09: 0000000000000001
 000: R10: ffffffffb2c5b4e0 R11: 3235393730343420 R12: 0000000000000000
 000: R13: ffffffffb2cd42c0 R14: 0000000000000000 R15: ffff92687fa27f40
 000: FS:  0000000000000000(0000) GS:ffff92687fa00000(0000) knlGS:0000000000000000
 000: CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
 000: CR2: ffff92610ac01000 CR3: 00000008c920e001 CR4: 00000000000606b0
 000: Call Trace:
 000:  clocksource_select_watchdog+0x144/0x1a0
 000:  __clocksource_register_scale+0x88/0xf0
 000:  tsc_init+0x1a1/0x268
 000:  start_kernel+0x4ae/0x56e
 000:  secondary_startup_64+0xb6/0xc0
 000: ---[ end trace 0000000000000001 ]---

Guess you might be faster to understand what I'm missing. :-)

Best,

Juri

