Return-Path: <SRS0=xNW4=3S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E646CC35240
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 17:52:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE00E20716
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 17:52:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727385AbgA2Rw0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jan 2020 12:52:26 -0500
Received: from foss.arm.com ([217.140.110.172]:44164 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727297AbgA2RwZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jan 2020 12:52:25 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0EFCC328;
        Wed, 29 Jan 2020 09:52:25 -0800 (PST)
Received: from localhost (unknown [10.1.198.81])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A465B3F67D;
        Wed, 29 Jan 2020 09:52:24 -0800 (PST)
Date:   Wed, 29 Jan 2020 17:52:23 +0000
From:   Ionela Voinescu <ionela.voinescu@arm.com>
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     catalin.marinas@arm.com, will@kernel.org, mark.rutland@arm.com,
        maz@kernel.org, suzuki.poulose@arm.com, sudeep.holla@arm.com,
        dietmar.eggemann@arm.com, peterz@infradead.org, mingo@redhat.com,
        ggherdovich@suse.cz, vincent.guittot@linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 6/6] arm64: use activity monitors for frequency
 invariance
Message-ID: <20200129175223.GA26494@arm.com>
References: <20191218182607.21607-1-ionela.voinescu@arm.com>
 <20191218182607.21607-7-ionela.voinescu@arm.com>
 <96fdead6-9896-5695-6744-413300d424f5@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <96fdead6-9896-5695-6744-413300d424f5@arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Valentin,

On Wednesday 29 Jan 2020 at 17:13:53 (+0000), Valentin Schneider wrote:
> Only commenting on the bits that should be there regardless of using the
> workqueues or not;
> 
> On 18/12/2019 18:26, Ionela Voinescu wrote:
> > +static void cpu_amu_fie_init_workfn(struct work_struct *work)
> > +{
> > +	u64 core_cnt, const_cnt, ratio;
> > +	struct cpu_amu_work *amu_work;
> > +	int cpu = smp_processor_id();
> > +
> > +	if (!cpu_has_amu_feat()) {
> > +		pr_debug("CPU%d: counters are not supported.\n", cpu);
> > +		return;
> > +	}
> > +
> > +	core_cnt = read_sysreg_s(SYS_AMEVCNTR0_CORE_EL0);
> > +	const_cnt = read_sysreg_s(SYS_AMEVCNTR0_CONST_EL0);
> > +
> > +	if (unlikely(!core_cnt || !const_cnt)) {
> > +		pr_err("CPU%d: cycle counters are not enabled.\n", cpu);
> > +		return;
> > +	}
> > +
> > +	amu_work = container_of(work, struct cpu_amu_work, cpu_work);
> > +	if (unlikely(!(amu_work->cpuinfo_max_freq))) {
> > +		pr_err("CPU%d: invalid maximum frequency.\n", cpu);
> > +		return;
> > +	}
> > +
> > +	/*
> > +	 * Pre-compute the fixed ratio between the frequency of the
> > +	 * constant counter and the maximum frequency of the CPU (hz).
> 
> I can't resist: s/hz/Hz/
> 
> > +	 */
> > +	ratio = (u64)arch_timer_get_rate() << (2 * SCHED_CAPACITY_SHIFT);
> > +	ratio = div64_u64(ratio, amu_work->cpuinfo_max_freq * 1000);
> 
> Nit: we're missing a comment somewhere that the unit of this is in kHz
> (which explains the * 1000).
> 

Will do! The previous comment that explained this was ".. while
ensuring max_freq is converted to HZ.", but I believed it as too
clear and replaced it with the obscure "(hz)". I'll revert :).

> > +	this_cpu_write(arch_max_freq_scale, (unsigned long)ratio);
> > +
> 
> Okay so what we get in the tick is:
> 
>   /\ core
>   --------
>   /\ const
> 
> And we want that to be SCHED_CAPACITY_SCALE when running at max freq. IOW we
> want to turn
> 
>   max_freq
>   ----------
>   const_freq
> 
> into SCHED_CAPACITY_SCALE, so we can just multiply that by:
> 
>   const_freq
>   ---------- * SCHED_CAPACITY_SCALE
>   max_freq
> 
> But what the ratio you are storing here is 
> 
>                           const_freq
>   arch_max_freq_scale =   ---------- * SCHED_CAPACITY_SCALE²
>                            max_freq
> 
> (because x << 2 * SCHED_CAPACITY_SHIFT == x << 20)
> 
> 
> In topology_freq_scale_tick() you end up doing
> 
>   /\ core   arch_max_freq_scale
>   ------- * --------------------
>   /\ const  SCHED_CAPACITY_SCALE
> 
> which gives us what we want (SCHED_CAPACITY_SCALE at max freq).
> 
> 
> Now, the reason why we multiply our ratio by the square of
> SCHED_CAPACITY_SCALE was not obvious to me, but you pointed me out that the
> frequency of the arch timer can be *really* low compared to the max CPU freq.
> 
> For instance on h960:
> 
>   [    0.000000] arch_timer: cp15 timer(s) running at 1.92MHz (phys)
> 
>   $ root@valsch-h960:~# cat /sys/devices/system/cpu/cpufreq/policy4/cpuinfo_max_freq 
>   2362000
> 
> So our ratio would be
> 
>   1'920'000 * 1024
>   ----------------
>     2'362'000'000
> 
> Which is ~0.83, so that becomes simply 0...
> 
> 
> I had a brief look at the Arm ARM, for the arch timer it says it is
> "typically in the range 1-50MHz", but then also gives an example with 20KHz
> in a low-power mode.
> 
> If we take say 5GHz max CPU frequency, our lower bound for the arch timer
> (with that SCHED_CAPACITY_SCALE² trick) is about ~4.768KHz. It's not *too*
> far from that 20KHz, but I'm not sure we would actually be executing stuff
> in that low-power mode.
> 
> Long story short, we're probably fine, but it would nice to shove some of
> the above into comments (especially the SCHED_CAPACITY_SCALE² trick)

Okay, I'll add some of this documentation as comments in the patches. I
thought about doing it but I was not sure it justified the line count.
But if it saves people at least the hassle to unpack this computation to
understand the logic, it will be worth it.

Thank you for the thorough review,
Ionela.
