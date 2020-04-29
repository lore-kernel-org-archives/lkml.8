Return-Path: <SRS0=ObIu=6N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 958A0C83003
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 08:15:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6D161206D9
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 08:15:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726635AbgD2IPO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Apr 2020 04:15:14 -0400
Received: from mx2.suse.de ([195.135.220.15]:50174 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726355AbgD2IPO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 04:15:14 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 5DA56AB8F;
        Wed, 29 Apr 2020 08:15:11 +0000 (UTC)
Message-ID: <1588148110.21179.63.camel@suse.cz>
Subject: Re: [PATCH] x86: move turbo_disabled() out of
 intel_set_max_freq_ratio
From:   Giovanni Gherdovich <ggherdovich@suse.cz>
To:     Li RongQing <lirongqing@baidu.com>, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, hpa@zytor.com, x86@kernel.org,
        peterz@infradead.org, linux-kernel@vger.kernel.org,
        rafael.j.wysocki@intel.com
Date:   Wed, 29 Apr 2020 10:15:10 +0200
In-Reply-To: <1588125007-8799-1-git-send-email-lirongqing@baidu.com>
References: <1588125007-8799-1-git-send-email-lirongqing@baidu.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2020-04-29 at 09:50 +0800, Li RongQing wrote:
> move the turbo_disabled before intel_set_max_freq_ratio,
> when turbo is disabled, the max frequency ratio is a const
> value, it is unnecessary to read MSR_TURBO_RATIO* msr to
> compute
> 
> Signed-off-by: Li RongQing <lirongqing@baidu.com>
> ---
>  arch/x86/kernel/smpboot.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
> index fe3ab9632f3b..8979c459df2f 100644
> --- a/arch/x86/kernel/smpboot.c
> +++ b/arch/x86/kernel/smpboot.c
> @@ -1987,7 +1987,7 @@ static bool intel_set_max_freq_ratio(void)
>  out:
>  	arch_turbo_freq_ratio = div_u64(turbo_freq * SCHED_CAPACITY_SCALE,
>  					base_freq);
> -	arch_set_max_freq_ratio(turbo_disabled());
> +	arch_set_max_freq_ratio(false);
>  	return true;
>  }
>  
> @@ -2009,6 +2009,9 @@ static void init_freq_invariance(void)
>  	if (smp_processor_id() != 0 || !boot_cpu_has(X86_FEATURE_APERFMPERF))
>  		return;
>  
> +	if (turbo_disabled())
> +		return;
> +
>  	if (boot_cpu_data.x86_vendor == X86_VENDOR_INTEL)
>  		ret = intel_set_max_freq_ratio();
>

Hello,

the problem is that turbo can be enabled/disabled by the firmware at runtime,
after the machine has booted.

This happens for example with the Dell XPS 13, where turbo gets disabled by the
firmware if the machine is disconnected from AC power and runs on battery. The
laptop could boot on battery (turbo disabled), then after some time the user
connects the AC power supply, turbo gets enabled, and with your patch we
wouldn't know what is the turbo_freq/base_freq ratio to do frequency
invariance (we skipped reading MSR_TURBO_RATIO_LIMIT at boot because turbo was
disabled at that timed).

This behavior was requested by reviewers in this thread:
https://lore.kernel.org/lkml/1906426.HDqaVa71mF@kreacher/
and implemented with 918229cdd5ab ("x86/intel_pstate: Handle runtime turbo
disablement/enablement in frequency invariance").


Thanks,
Giovanni Gherdovich
