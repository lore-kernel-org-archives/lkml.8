Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D018C433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 10:29:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E74802073E
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 10:29:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728425AbgGBK3G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 06:29:06 -0400
Received: from foss.arm.com ([217.140.110.172]:36076 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728376AbgGBK3F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 06:29:05 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C9CFDD6E;
        Thu,  2 Jul 2020 03:29:04 -0700 (PDT)
Received: from C02TD0UTHF1T.local (unknown [10.57.12.193])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A141E3F71E;
        Thu,  2 Jul 2020 03:29:02 -0700 (PDT)
Date:   Thu, 2 Jul 2020 11:28:59 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Marc Zyngier <maz@kernel.org>
Cc:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com
Subject: Re: [PATCH 2/3] arm64: arch_timer: Allow an workaround descriptor to
 provide vdso_clock_mode
Message-ID: <20200702102859.GC15391@C02TD0UTHF1T.local>
References: <20200701161824.1346732-1-maz@kernel.org>
 <20200701161824.1346732-3-maz@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200701161824.1346732-3-maz@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 01, 2020 at 05:18:23PM +0100, Marc Zyngier wrote:
> As we are about to disable the vdso for compat tasks in some circumstances,
> let's allow a workaround descriptor to provide the vdso_clock_mode that
> matches the platform.
> 
> Signed-off-by: Marc Zyngier <maz@kernel.org>
> ---
>  arch/arm64/include/asm/arch_timer.h  | 3 +++
>  drivers/clocksource/arm_arch_timer.c | 3 +++
>  2 files changed, 6 insertions(+)
> 
> diff --git a/arch/arm64/include/asm/arch_timer.h b/arch/arm64/include/asm/arch_timer.h
> index 7ae54d7d333a..fb8dfcbf9c01 100644
> --- a/arch/arm64/include/asm/arch_timer.h
> +++ b/arch/arm64/include/asm/arch_timer.h
> @@ -18,6 +18,8 @@
>  #include <linux/smp.h>
>  #include <linux/types.h>
>  
> +#include <vdso/clocksource.h>
> +
>  #include <clocksource/arm_arch_timer.h>
>  
>  #if IS_ENABLED(CONFIG_ARM_ARCH_TIMER_OOL_WORKAROUND)
> @@ -58,6 +60,7 @@ struct arch_timer_erratum_workaround {
>  	u64 (*read_cntvct_el0)(void);
>  	int (*set_next_event_phys)(unsigned long, struct clock_event_device *);
>  	int (*set_next_event_virt)(unsigned long, struct clock_event_device *);
> +	enum vdso_clock_mode vdso_clock_mode;
>  };
>  
>  DECLARE_PER_CPU(const struct arch_timer_erratum_workaround *,
> diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_arch_timer.c
> index ecf7b7db2d05..f828835c568f 100644
> --- a/drivers/clocksource/arm_arch_timer.c
> +++ b/drivers/clocksource/arm_arch_timer.c
> @@ -566,6 +566,9 @@ void arch_timer_enable_workaround(const struct arch_timer_erratum_workaround *wa
>  	if (wa->read_cntvct_el0) {
>  		clocksource_counter.vdso_clock_mode = VDSO_CLOCKMODE_NONE;
>  		vdso_default = VDSO_CLOCKMODE_NONE;
> +	} else {
> +		clocksource_counter.vdso_clock_mode = wa->vdso_clock_mode;
> +		vdso_default = wa->vdso_clock_mode;
>  	}

I fear that we're liable to forget to set vdso_clock_mode on new errata
that don't need a read_cntvct_el0 hook, and if so we'll happen to set
these to 0 (i.e. VDSO_CLOCKMODE_NONE).

For now could we instead have a boolan disable_compat_vdso, with this
being:

| if (wa->read_cntvct_el0) {
| 	clocksource_counter.vdso_clock_mode = VDSO_CLOCKMODE_NONE;
| 	vdso_default = VDSO_CLOCKMODE_NONE;
| } else if (wa->disable_compat_vdso) {
| 	clocksource_counter.vdso_clock_mode = VDSO_CLOCKMODE_ARCHTIMER_NOCOMPAT;
| 	vdso_default = wa->vdso_clock_mode = VDSO_CLOCKMODE_ARCHTIMER_NOCOMPAT;
| }

Do we need to handle the comination of a workaround seeting NONE and one
setting ARCHTIMER_NOCOMPAT?

Mark.
