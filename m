Return-Path: <SRS0=xNW4=3S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8DBDC47409
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 17:14:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A7A4206F0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 17:14:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727253AbgA2ROB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jan 2020 12:14:01 -0500
Received: from foss.arm.com ([217.140.110.172]:43858 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726647AbgA2ROA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jan 2020 12:14:00 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1BF07328;
        Wed, 29 Jan 2020 09:14:00 -0800 (PST)
Received: from [10.0.2.15] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1C7C43F67D;
        Wed, 29 Jan 2020 09:13:57 -0800 (PST)
Subject: Re: [PATCH v2 6/6] arm64: use activity monitors for frequency
 invariance
To:     Ionela Voinescu <ionela.voinescu@arm.com>, catalin.marinas@arm.com,
        will@kernel.org, mark.rutland@arm.com, maz@kernel.org,
        suzuki.poulose@arm.com, sudeep.holla@arm.com,
        dietmar.eggemann@arm.com
Cc:     peterz@infradead.org, mingo@redhat.com, ggherdovich@suse.cz,
        vincent.guittot@linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20191218182607.21607-1-ionela.voinescu@arm.com>
 <20191218182607.21607-7-ionela.voinescu@arm.com>
From:   Valentin Schneider <valentin.schneider@arm.com>
Message-ID: <96fdead6-9896-5695-6744-413300d424f5@arm.com>
Date:   Wed, 29 Jan 2020 17:13:53 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20191218182607.21607-7-ionela.voinescu@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Only commenting on the bits that should be there regardless of using the
workqueues or not;

On 18/12/2019 18:26, Ionela Voinescu wrote:
> +static void cpu_amu_fie_init_workfn(struct work_struct *work)
> +{
> +	u64 core_cnt, const_cnt, ratio;
> +	struct cpu_amu_work *amu_work;
> +	int cpu = smp_processor_id();
> +
> +	if (!cpu_has_amu_feat()) {
> +		pr_debug("CPU%d: counters are not supported.\n", cpu);
> +		return;
> +	}
> +
> +	core_cnt = read_sysreg_s(SYS_AMEVCNTR0_CORE_EL0);
> +	const_cnt = read_sysreg_s(SYS_AMEVCNTR0_CONST_EL0);
> +
> +	if (unlikely(!core_cnt || !const_cnt)) {
> +		pr_err("CPU%d: cycle counters are not enabled.\n", cpu);
> +		return;
> +	}
> +
> +	amu_work = container_of(work, struct cpu_amu_work, cpu_work);
> +	if (unlikely(!(amu_work->cpuinfo_max_freq))) {
> +		pr_err("CPU%d: invalid maximum frequency.\n", cpu);
> +		return;
> +	}
> +
> +	/*
> +	 * Pre-compute the fixed ratio between the frequency of the
> +	 * constant counter and the maximum frequency of the CPU (hz).

I can't resist: s/hz/Hz/

> +	 */
> +	ratio = (u64)arch_timer_get_rate() << (2 * SCHED_CAPACITY_SHIFT);
> +	ratio = div64_u64(ratio, amu_work->cpuinfo_max_freq * 1000);

Nit: we're missing a comment somewhere that the unit of this is in kHz
(which explains the * 1000).

> +	this_cpu_write(arch_max_freq_scale, (unsigned long)ratio);
> +

Okay so what we get in the tick is:

  /\ core
  --------
  /\ const

And we want that to be SCHED_CAPACITY_SCALE when running at max freq. IOW we
want to turn

  max_freq
  ----------
  const_freq

into SCHED_CAPACITY_SCALE, so we can just multiply that by:

  const_freq
  ---------- * SCHED_CAPACITY_SCALE
  max_freq

But what the ratio you are storing here is 

                          const_freq
  arch_max_freq_scale =   ---------- * SCHED_CAPACITY_SCALE²
                           max_freq

(because x << 2 * SCHED_CAPACITY_SHIFT == x << 20)


In topology_freq_scale_tick() you end up doing

  /\ core   arch_max_freq_scale
  ------- * --------------------
  /\ const  SCHED_CAPACITY_SCALE

which gives us what we want (SCHED_CAPACITY_SCALE at max freq).


Now, the reason why we multiply our ratio by the square of
SCHED_CAPACITY_SCALE was not obvious to me, but you pointed me out that the
frequency of the arch timer can be *really* low compared to the max CPU freq.

For instance on h960:

  [    0.000000] arch_timer: cp15 timer(s) running at 1.92MHz (phys)

  $ root@valsch-h960:~# cat /sys/devices/system/cpu/cpufreq/policy4/cpuinfo_max_freq 
  2362000

So our ratio would be

  1'920'000 * 1024
  ----------------
    2'362'000'000

Which is ~0.83, so that becomes simply 0...


I had a brief look at the Arm ARM, for the arch timer it says it is
"typically in the range 1-50MHz", but then also gives an example with 20KHz
in a low-power mode.

If we take say 5GHz max CPU frequency, our lower bound for the arch timer
(with that SCHED_CAPACITY_SCALE² trick) is about ~4.768KHz. It's not *too*
far from that 20KHz, but I'm not sure we would actually be executing stuff
in that low-power mode.

Long story short, we're probably fine, but it would nice to shove some of
the above into comments (especially the SCHED_CAPACITY_SCALE² trick)
