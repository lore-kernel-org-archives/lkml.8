Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E95CC2BA83
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 11:54:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69EAE2187F
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 11:54:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728658AbgBNLyz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 06:54:55 -0500
Received: from foss.arm.com ([217.140.110.172]:60226 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726635AbgBNLyz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 06:54:55 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E00611FB;
        Fri, 14 Feb 2020 03:54:54 -0800 (PST)
Received: from [192.168.1.18] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2823C3F68F;
        Fri, 14 Feb 2020 03:54:52 -0800 (PST)
Subject: Re: [patch V2 03/17] lib/vdso: Allow the high resolution parts to be
 compiled out
To:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, John Stultz <john.stultz@linaro.org>,
        Andy Lutomirski <luto@kernel.org>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Juergen Gross <jgross@suse.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Sasha Levin <sashal@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paulburton@kernel.org>,
        James Hogan <jhogan@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Marc Zyngier <maz@kernel.org>, Andrei Vagin <avagin@gmail.com>
References: <20200207123847.339896630@linutronix.de>
 <20200207124402.530143168@linutronix.de>
From:   Vincenzo Frascino <vincenzo.frascino@arm.com>
Message-ID: <0be20895-766b-b391-218b-bc70fa314b82@arm.com>
Date:   Fri, 14 Feb 2020 11:54:59 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200207124402.530143168@linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/7/20 12:38 PM, Thomas Gleixner wrote:
> From: Thomas Gleixner <tglx@linutronix.de>
> 
> If the architecture knows at compile time that there is no VDSO capable
> clocksource supported it makes sense to optimize the guts of the high
> resolution parts of the VDSO out at build time. Add a helper function to
> check whether the VDSO should be high resolution capable and provide a stub
> which can be overridden by an architecture.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> 

Reviewed-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
Tested-by: Vincenzo Frascino <vincenzo.frascino@arm.com>

> ---
>  lib/vdso/gettimeofday.c |   11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> --- a/lib/vdso/gettimeofday.c
> +++ b/lib/vdso/gettimeofday.c
> @@ -38,6 +38,13 @@ u64 vdso_calc_delta(u64 cycles, u64 last
>  }
>  #endif
>  
> +#ifndef __arch_vdso_hres_capable
> +static inline bool __arch_vdso_hres_capable(void)
> +{
> +	return true;
> +}
> +#endif
> +
>  #ifdef CONFIG_TIME_NS
>  static int do_hres_timens(const struct vdso_data *vdns, clockid_t clk,
>  			  struct __kernel_timespec *ts)
> @@ -101,6 +108,10 @@ static __always_inline int do_hres(const
>  	u64 cycles, last, sec, ns;
>  	u32 seq;
>  
> +	/* Allows to compile the high resolution parts out */
> +	if (!__arch_vdso_hres_capable())
> +		return -1;
> +
>  	do {
>  		/*
>  		 * Open coded to handle VCLOCK_TIMENS. Time namespace
> 

-- 
Regards,
Vincenzo
