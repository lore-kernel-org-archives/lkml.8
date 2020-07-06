Return-Path: <SRS0=eGSO=AR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54918C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 17:12:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 38563206B6
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 17:12:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729622AbgGFRMy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jul 2020 13:12:54 -0400
Received: from foss.arm.com ([217.140.110.172]:57352 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729521AbgGFRMx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jul 2020 13:12:53 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BA69F31B;
        Mon,  6 Jul 2020 10:12:52 -0700 (PDT)
Received: from C02TD0UTHF1T.local (unknown [10.57.13.106])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B58F93F68F;
        Mon,  6 Jul 2020 10:12:50 -0700 (PDT)
Date:   Mon, 6 Jul 2020 18:12:48 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Marc Zyngier <maz@kernel.org>
Cc:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com
Subject: Re: [PATCH v2 4/4] arm64: Rework ARM_ERRATUM_1414080 handling
Message-ID: <20200706171248.GC61340@C02TD0UTHF1T.local>
References: <20200706163802.1836732-1-maz@kernel.org>
 <20200706163802.1836732-5-maz@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200706163802.1836732-5-maz@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 06, 2020 at 05:38:02PM +0100, Marc Zyngier wrote:
> The current handling of erratum 1414080 has the side effect that
> cntkctl_el1 can get changed for both 32 and 64bit tasks.
> 
> This isn't a problem so far, but if we ever need to mitigate another
> of these errata on the 64bit side, we'd better keep the messing with
> cntkctl_el1 local to 32bit tasks.
> 
> For that, make sure that on entering the kernel from a 32bit tasks,
> userspace access to cntvct gets enabled, and disabled returning to
> userspace, while it never gets changed for 64bit tasks.
> 
> Signed-off-by: Marc Zyngier <maz@kernel.org>

The asm looks sound to me. Suggestion below, but either way:

Reviewed-by: Mark Rutland <mark.rutland@arm.com>

> ---
>  arch/arm64/kernel/entry.S | 40 +++++++++++++++++++++++----------------
>  1 file changed, 24 insertions(+), 16 deletions(-)
> 
> diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
> index 5304d193c79d..8f51f3273bc7 100644
> --- a/arch/arm64/kernel/entry.S
> +++ b/arch/arm64/kernel/entry.S
> @@ -167,6 +167,19 @@ alternative_cb_end
>  	stp	x28, x29, [sp, #16 * 14]
>  
>  	.if	\el == 0
> +	.if	\regsize == 32
> +	// If we come back from a 32bit task on a system affected by
> +	// 1418040, let's reenable userspace access to the virtual counter.
> +#ifdef CONFIG_ARM64_ERRATUM_1418040
> +alternative_if_not ARM64_WORKAROUND_1418040
> +	b	.L__entry_skip_wa_1418040\@
> +alternative_else_nop_endif
> +	mrs	x0, cntkctl_el1
> +	orr	x0, x0, #2	// ARCH_TIMER_USR_VCT_ACCESS_EN
> +	msr	cntkctl_el1, x0
> +.L__entry_skip_wa_1418040\@:
> +#endif

Given this is only 3 instructions, it might be clearer to remove the branch
and label and NOP the whole thing for legibility:

| #ifdef CONFIG_ARM64_ERRATUM_1418040
| alternative_if ARM64_WORKAROUND_1418040
| 	mrs	x0. cntkctl_el1
| 	orr	x0, x0, #2	// ARCH_TIMER_USR_VCT_ACCESS_EN
| 	msr	cntkctl_el1, x0
| alternative_else_nop_endif
| #endif

... and likewise for the clearing case.

Regardless, this looks sound to me, so take your pick. :)

Mark.

> +	.endif
>  	clear_gp_regs
>  	mrs	x21, sp_el0
>  	ldr_this_cpu	tsk, __entry_task, x20
> @@ -318,7 +331,17 @@ alternative_else_nop_endif
>  	ldr	x23, [sp, #S_SP]		// load return stack pointer
>  	msr	sp_el0, x23
>  	tst	x22, #PSR_MODE32_BIT		// native task?
> -	b.eq	3f
> +	b.eq	4f
> +
> +#ifdef CONFIG_ARM64_ERRATUM_1418040
> +alternative_if_not ARM64_WORKAROUND_1418040
> +	b	3f
> +alternative_else_nop_endif
> +	mrs	x1, cntkctl_el1
> +	bic	x1, x1, #2			// ARCH_TIMER_USR_VCT_ACCESS_EN
> +	msr	cntkctl_el1, x1
> +3:
> +#endif
>  
>  #ifdef CONFIG_ARM64_ERRATUM_845719
>  alternative_if ARM64_WORKAROUND_845719
> @@ -330,22 +353,7 @@ alternative_if ARM64_WORKAROUND_845719
>  #endif
>  alternative_else_nop_endif
>  #endif
> -3:
> -#ifdef CONFIG_ARM64_ERRATUM_1418040
> -alternative_if_not ARM64_WORKAROUND_1418040
> -	b	4f
> -alternative_else_nop_endif
> -	/*
> -	 * if (x22.mode32 == cntkctl_el1.el0vcten)
> -	 *     cntkctl_el1.el0vcten = ~cntkctl_el1.el0vcten
> -	 */
> -	mrs	x1, cntkctl_el1
> -	eon	x0, x1, x22, lsr #3
> -	tbz	x0, #1, 4f
> -	eor	x1, x1, #2	// ARCH_TIMER_USR_VCT_ACCESS_EN
> -	msr	cntkctl_el1, x1
>  4:
> -#endif
>  	scs_save tsk, x0
>  
>  	/* No kernel C function calls after this as user keys are set. */
> -- 
> 2.27.0
> 
