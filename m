Return-Path: <SRS0=8wH5=AU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCD6BC433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 10:17:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A291E20674
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 10:17:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726801AbgGIKRi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jul 2020 06:17:38 -0400
Received: from foss.arm.com ([217.140.110.172]:48602 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726340AbgGIKRh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 06:17:37 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 986C331B;
        Thu,  9 Jul 2020 03:17:36 -0700 (PDT)
Received: from localhost (unknown [10.1.198.53])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 397913F887;
        Thu,  9 Jul 2020 03:17:36 -0700 (PDT)
Date:   Thu, 9 Jul 2020 11:17:34 +0100
From:   Ionela Voinescu <ionela.voinescu@arm.com>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: topology: Don't support AMU without cpufreq
Message-ID: <20200709101734.GB5623@arm.com>
References: <a710fc4e4e0f1d2e561320130b99bcb5167d73b4.1594277563.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a710fc4e4e0f1d2e561320130b99bcb5167d73b4.1594277563.git.viresh.kumar@linaro.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Viresh,

On Thursday 09 Jul 2020 at 12:22:45 (+0530), Viresh Kumar wrote:
> The commit cd0ed03a8903 ("arm64: use activity monitors for frequency
> invariance"), mentions that:
> 
>   "if CONFIG_CPU_FREQ is not enabled, the use of counters is
>    enabled on all CPUs only if all possible CPUs correctly support
>    the necessary counters"
> 

Yes, this part of the commit message is wrong. I could go easy on myself
and say that the comment in the code is correct, but it would not make
this part of the commit message less wrong. 

So the "if CONFIG_CPU_FREQ is not enabled" should have been replaced by
"if we are not restricted by cpufreq policies", which is different,
as described below.

Comment in code:
"""
* If we are not restricted by cpufreq policies, we only enable
* the use of the AMU feature for FIE if all CPUs support AMU.
"""

> But that's not really true as validate_cpu_freq_invariance_counters()
> fails if max_freq_hz is returned as 0 (in case there is no policy for
> the CPU). And the AMUs won't be supported in that case.
> 
> Make the code reflect this reality.
> 

It seems to me that validate_cpu_freq_invariance_counters() already does
this filtering. max_freq_hz would need to have a valid value before AMUs
can be marked as supported.

Functionally, what would happen, is the following:

> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  arch/arm64/kernel/topology.c | 19 +++----------------
>  1 file changed, 3 insertions(+), 16 deletions(-)
> 
> diff --git a/arch/arm64/kernel/topology.c b/arch/arm64/kernel/topology.c
> index 0801a0f3c156..b7da372819fc 100644
> --- a/arch/arm64/kernel/topology.c
> +++ b/arch/arm64/kernel/topology.c
> @@ -187,14 +187,13 @@ static int validate_cpu_freq_invariance_counters(int cpu)
>  	return 0;
>  }
>  
> -static inline bool
> -enable_policy_freq_counters(int cpu, cpumask_var_t valid_cpus)
> +static inline void update_amu_fie_cpus(int cpu, cpumask_var_t valid_cpus)
>  {
>  	struct cpufreq_policy *policy = cpufreq_cpu_get(cpu);
>  
>  	if (!policy) {
>  		pr_debug("CPU%d: No cpufreq policy found.\n", cpu);
> -		return false;
> +		return;
>  	}
>  
>  	if (cpumask_subset(policy->related_cpus, valid_cpus))
> @@ -202,8 +201,6 @@ enable_policy_freq_counters(int cpu, cpumask_var_t valid_cpus)
>  			   amu_fie_cpus);
>  
>  	cpufreq_cpu_put(policy);
> -
> -	return true;
>  }
>  
>  static DEFINE_STATIC_KEY_FALSE(amu_fie_key);
> @@ -212,7 +209,6 @@ static DEFINE_STATIC_KEY_FALSE(amu_fie_key);
>  static int __init init_amu_fie(void)
>  {
>  	cpumask_var_t valid_cpus;
> -	bool have_policy = false;
>  	int ret = 0;
>  	int cpu;
>  
> @@ -228,18 +224,9 @@ static int __init init_amu_fie(void)
>  		if (validate_cpu_freq_invariance_counters(cpu))
>  			continue;

If max_freq_hz happens to be 0 (either !CONFIG_CPU_FREQ or
CONFIG_CPU_FREQ=y && !policy, etc),
validate_cpu_freq_invariance_counters(cpu) will return -EINVAL,
so we'll continue with the next CPU, without adding this cpu to
valid_cpus.

Therefore it would not be marked as a valid AMU supporting CPU, so we
won't call enable_policy_freq_counters() for it.

>  		cpumask_set_cpu(cpu, valid_cpus);
> -		have_policy |= enable_policy_freq_counters(cpu, valid_cpus);
> +		update_amu_fie_cpus(cpu, valid_cpus);

I see this as two different pieces of functionality:
 - (1) validate_cpu_freq_invariance_counters(cpu) has the job of validating
   the CPU support, including max_freq_hz.
 - (2) enable_policy_freq_counters() has the job to restrict AMU enablement
   for the CPUs in a policy if all CPUs in the policy support AMUs.

So both of them, separately, support the case of !CONFIG_CPU_FREQ.

>  	}
>  
> -	/*
> -	 * If we are not restricted by cpufreq policies, we only enable
> -	 * the use of the AMU feature for FIE if all CPUs support AMU.
> -	 * Otherwise, enable_policy_freq_counters has already enabled
> -	 * policy cpus.
> -	 */
> -	if (!have_policy && cpumask_equal(valid_cpus, cpu_present_mask))

This is meant to have the following logic: if for some reason we're not
restricted by policies (according to 2), but all AMU validation was
successful (according to 1), there is no reason not to enable fully AMU
enabled frequency invariance.

I agree that this happening is a cornercase and a reason for which
cpufreq_get_hw_max_freq() was made weak. If some platform has entirely
firmware driven frequency control, but it enables CONFIG_CPU_FREQ
(as is the default) and it defines its own cpufreq_get_hw_max_freq(),
it could benefit from AMU use.

So I did believe it was best for these checks to be decoupled, for this
reason, and potential other reasons in the future, involving more
decoupling from cpufreq.

I do have code in progress to clean the overall interaction between
cpufreq and AMUs, started at [1]. Bear with me on this, it is all
connected :).

[1]
https://lore.kernel.org/lkml/20200701090751.7543-1-ionela.voinescu@arm.com/

Regards,
Ionela.

> -		cpumask_or(amu_fie_cpus, amu_fie_cpus, valid_cpus);
> -
>  	if (!cpumask_empty(amu_fie_cpus)) {
>  		pr_info("CPUs[%*pbl]: counters will be used for FIE.",
>  			cpumask_pr_args(amu_fie_cpus));
> -- 
> 2.25.0.rc1.19.g042ed3e048af
> 
