Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1A98C433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 10:18:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9BA9920772
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 10:18:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728193AbgGBKS0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 06:18:26 -0400
Received: from foss.arm.com ([217.140.110.172]:35036 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727769AbgGBKSZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 06:18:25 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E240D1FB;
        Thu,  2 Jul 2020 03:18:24 -0700 (PDT)
Received: from C02TD0UTHF1T.local (unknown [10.57.12.193])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9EA193F71E;
        Thu,  2 Jul 2020 03:18:22 -0700 (PDT)
Date:   Thu, 2 Jul 2020 11:18:19 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Marc Zyngier <maz@kernel.org>
Cc:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com
Subject: Re: [PATCH 1/3] arm64: Introduce a way to disable the 32bit vdso
Message-ID: <20200702101819.GB15391@C02TD0UTHF1T.local>
References: <20200701161824.1346732-1-maz@kernel.org>
 <20200701161824.1346732-2-maz@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200701161824.1346732-2-maz@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 01, 2020 at 05:18:22PM +0100, Marc Zyngier wrote:
> We have a class of errata (grouped under the ARM64_WORKAROUND_1418040
> banner) that force the trapping of counter access from 32bit EL0.
> 
> We would normally disable the whole vdso for such defect, except that
> it would disable it for 64bit userspace as well, which is a shame.
> 
> Instead, add a new vdso_clock_mode, which signals that the vdso
> isn't usable for compat tasks.  This gets checked in the new
> vdso_clocksource_ok() helper, now provided for the 32bit vdso.
> 
> Signed-off-by: Marc Zyngier <maz@kernel.org>

As-is this looks sound to me. It's not entirely clear to me how this
will compose with VDSO_CLOCKMODE_TIMENS, but given this series is fixing
an existing brokenness I think this has higher priority.

Minor comment below, but regardless:

Acked-by: Mark Rutland <mark.rutland@arm.com>

> ---
>  arch/arm64/include/asm/vdso/clocksource.h         | 7 +++++--
>  arch/arm64/include/asm/vdso/compat_gettimeofday.h | 8 +++++++-
>  2 files changed, 12 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/vdso/clocksource.h b/arch/arm64/include/asm/vdso/clocksource.h
> index df6ea65c1dec..b054d9febfb5 100644
> --- a/arch/arm64/include/asm/vdso/clocksource.h
> +++ b/arch/arm64/include/asm/vdso/clocksource.h
> @@ -2,7 +2,10 @@
>  #ifndef __ASM_VDSOCLOCKSOURCE_H
>  #define __ASM_VDSOCLOCKSOURCE_H
>  
> -#define VDSO_ARCH_CLOCKMODES	\
> -	VDSO_CLOCKMODE_ARCHTIMER
> +#define VDSO_ARCH_CLOCKMODES					\
> +	/* vdso clocksource for both 32 and 64bit tasks */	\
> +	VDSO_CLOCKMODE_ARCHTIMER,				\
> +	/* vdso clocksource for 64bit tasks only */		\
> +	VDSO_CLOCKMODE_ARCHTIMER_NOCOMPAT
>  
>  #endif
> diff --git a/arch/arm64/include/asm/vdso/compat_gettimeofday.h b/arch/arm64/include/asm/vdso/compat_gettimeofday.h
> index b6907ae78e53..9a625e8947ff 100644
> --- a/arch/arm64/include/asm/vdso/compat_gettimeofday.h
> +++ b/arch/arm64/include/asm/vdso/compat_gettimeofday.h
> @@ -111,7 +111,7 @@ static __always_inline u64 __arch_get_hw_counter(s32 clock_mode)
>  	 * update. Return something. Core will do another round and then
>  	 * see the mode change and fallback to the syscall.
>  	 */
> -	if (clock_mode == VDSO_CLOCKMODE_NONE)
> +	if (clock_mode != VDSO_CLOCKMODE_ARCHTIMER)
>  		return 0;
>  
>  	/*
> @@ -152,6 +152,12 @@ static __always_inline const struct vdso_data *__arch_get_vdso_data(void)
>  	return ret;
>  }
>  
> +static inline bool vdso_clocksource_ok(const struct vdso_data *vd)
> +{
> +	return vd->clock_mode == VDSO_CLOCKMODE_ARCHTIMER;
> +}
> +#define vdso_clocksource_ok	vdso_clocksource_ok

Existing issue, but it's a shame this doesn't take the clock mode
directly, then we wouldn't have to duplicate the conditions (as above,
inverted).

Mark.
