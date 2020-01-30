Return-Path: <SRS0=4zup=3T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B3E8C35240
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 15:49:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26BF0214DB
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 15:49:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727313AbgA3Pt2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jan 2020 10:49:28 -0500
Received: from foss.arm.com ([217.140.110.172]:54636 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726948AbgA3Pt2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jan 2020 10:49:28 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5867731B;
        Thu, 30 Jan 2020 07:49:25 -0800 (PST)
Received: from localhost (unknown [10.1.198.81])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id ED9E53F67D;
        Thu, 30 Jan 2020 07:49:24 -0800 (PST)
Date:   Thu, 30 Jan 2020 15:49:23 +0000
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
Message-ID: <20200130154923.GB5208@arm.com>
References: <20191218182607.21607-1-ionela.voinescu@arm.com>
 <20191218182607.21607-7-ionela.voinescu@arm.com>
 <96fdead6-9896-5695-6744-413300d424f5@arm.com>
 <3ed9af08-82ef-e30c-b1ec-3a1dac0d2091@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3ed9af08-82ef-e30c-b1ec-3a1dac0d2091@arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Valentin,

On Wednesday 29 Jan 2020 at 23:39:11 (+0000), Valentin Schneider wrote:
> On 29/01/2020 17:13, Valentin Schneider wrote:
> > I had a brief look at the Arm ARM, for the arch timer it says it is
> > "typically in the range 1-50MHz", but then also gives an example with 20KHz
> > in a low-power mode.
> > 
> > If we take say 5GHz max CPU frequency, our lower bound for the arch timer
> > (with that SCHED_CAPACITY_SCALE² trick) is about ~4.768KHz. It's not *too*
> > far from that 20KHz, but I'm not sure we would actually be executing stuff
> > in that low-power mode.
> > 
> 
> I mixed up a few things in there; that low-power mode is supposed to do
> higher increments, so it would emulate a similar frequency as the non-low-power
> mode. Thus the actual frequency matters less than what is reported in CNTFRQ
> (though we hope to get the behaviour we're told we should see), so we should
> be quite safe from that ~5KHz value. Still, to make it obvious, I don't think
> something like this would hurt:
> 
> ---
> diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_arch_timer.c
> index 9a5464c625b45..a72832093575a 100644
> --- a/drivers/clocksource/arm_arch_timer.c
> +++ b/drivers/clocksource/arm_arch_timer.c
> @@ -885,6 +885,17 @@ static int arch_timer_starting_cpu(unsigned int cpu)
>  	return 0;
>  }
>  
> +static int validate_timer_rate(void)
> +{
> +	if (!arch_timer_rate)
> +		return 1;
> +
> +	/* Arch timer frequency < 1MHz is shady */
> +	WARN_ON(arch_timer_rate < 1000000);
> +
> +	return 0;
> +}
> +
>  /*
>   * For historical reasons, when probing with DT we use whichever (non-zero)
>   * rate was probed first, and don't verify that others match. If the first node
> @@ -900,7 +911,7 @@ static void arch_timer_of_configure_rate(u32 rate, struct device_node *np)
>  		arch_timer_rate = rate;
>  
>  	/* Check the timer frequency. */
> -	if (arch_timer_rate == 0)
> +	if (validate_timer_rate())
>  		pr_warn("frequency not available\n");
>  }
>  
> @@ -1594,7 +1605,7 @@ static int __init arch_timer_acpi_init(struct acpi_table_header *table)
>  	 * CNTFRQ value. This *must* be correct.
>  	 */
>  	arch_timer_rate = arch_timer_get_cntfrq();
> -	if (!arch_timer_rate) {
> +	if (validate_timer_rate()) {
>  		pr_err(FW_BUG "frequency not available.\n");
>  		return -EINVAL;
>  	}
> ---
> 

Okay, I'll add this as a separate patch to the series and put you as
author. That is if you want me to tie this check to this usecase that
proves its usefulness. Otherwise it can stand on its own as well if
you want to submit it separately.

In regards to the ratio computation for frequency invariance where this
plays a role, I'll do a check and bail out if the ratio is 0, which I'm
ashamed to not have added before :).

Thanks,
Ionela.


> > Long story short, we're probably fine, but it would nice to shove some of
> > the above into comments (especially the SCHED_CAPACITY_SCALE² trick)
> > 
