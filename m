Return-Path: <SRS0=7RkH=3E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C30DC33CB1
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 05:50:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 554E424656
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 05:50:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="WuomRfzE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726474AbgAOFuq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jan 2020 00:50:46 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:31502 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725962AbgAOFuq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jan 2020 00:50:46 -0500
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 47yGdY5Y7Pz9txw1;
        Wed, 15 Jan 2020 06:50:41 +0100 (CET)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=WuomRfzE; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id mfKxcG6g7OTA; Wed, 15 Jan 2020 06:50:41 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 47yGdY4FZlz9txvv;
        Wed, 15 Jan 2020 06:50:41 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1579067441; bh=PONqyG5Kwmo6UAIvhChfBPV3SHZxCs6ee9uKMcSL3Yg=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=WuomRfzENnS/htWG636a1i0bPlff4pugt/mQvNuJeB6mdXOTXUO1NrZoXElV8krfN
         8VwgMu7W4cZIFi16miIZflnhS+IHZfN0lR4gdSH4OxfJgyLv/A3wfWvWJphUTIOAUC
         3Fd0Mr4tqVEvZpHTRCcHdOS4X8s5d9VSxqosFVvs=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 5D2F28B77E;
        Wed, 15 Jan 2020 06:50:42 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id 5h25OqE_qAEg; Wed, 15 Jan 2020 06:50:42 +0100 (CET)
Received: from [172.25.230.100] (po15451.idsi0.si.c-s.fr [172.25.230.100])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 1149E8B774;
        Wed, 15 Jan 2020 06:50:42 +0100 (CET)
Subject: Re: [patch 09/15] clocksource: Add common vdso clock mode storage
To:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, John Stultz <john.stultz@linaro.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Andy Lutomirski <luto@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Sasha Levin <sashal@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paulburton@kernel.org>,
        James Hogan <jhogan@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Marc Zyngier <maz@kernel.org>
References: <20200114185237.273005683@linutronix.de>
 <20200114185947.500141436@linutronix.de>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <f6c5ce65-be49-add3-5959-85fa9cdc75a2@c-s.fr>
Date:   Wed, 15 Jan 2020 06:50:42 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <20200114185947.500141436@linutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 14/01/2020 à 19:52, Thomas Gleixner a écrit :
> All architectures which use the generic VDSO code have their own storage
> for the VDSO clock mode. That's pointless and just requires duplicate code.
> 
> Provide generic storage for it. The new Kconfig symbol is intermediate and
> will be removed once all architectures are converted over.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
>   include/linux/clocksource.h |   12 +++++++++++-
>   kernel/time/clocksource.c   |    9 +++++++++
>   kernel/time/vsyscall.c      |    7 +++++++
>   lib/vdso/Kconfig            |    3 +++
>   lib/vdso/gettimeofday.c     |   13 +++++++++++--
>   5 files changed, 41 insertions(+), 3 deletions(-)
> 
> --- a/include/linux/clocksource.h
> +++ b/include/linux/clocksource.h
> @@ -23,10 +23,19 @@
>   struct clocksource;
>   struct module;
>   
> -#ifdef CONFIG_ARCH_CLOCKSOURCE_DATA
> +#if defined(CONFIG_ARCH_CLOCKSOURCE_DATA) || \
> +    defined(CONFIG_GENERIC_VDSO_CLOCK_MODE)
>   #include <asm/clocksource.h>
>   #endif
>   
> +enum vdso_clock_mode {
> +	VDSO_CLOCKMODE_NONE,
> +#ifdef CONFIG_GENERIC_VDSO_CLOCK_MODE
> +	VDSO_ARCH_CLOCKMODES,
> +#endif
> +	VDSO_CLOCKMODE_MAX,
> +};
> +
>   /**
>    * struct clocksource - hardware abstraction for a free running counter
>    *	Provides mostly state-free accessors to the underlying hardware.
> @@ -97,6 +106,7 @@ struct clocksource {
>   	const char		*name;
>   	struct list_head	list;
>   	int			rating;
> +	enum vdso_clock_mode	vdso_clock_mode;
>   	unsigned long		flags;
>   
>   	int			(*enable)(struct clocksource *cs);
> --- a/kernel/time/clocksource.c
> +++ b/kernel/time/clocksource.c
> @@ -921,6 +921,15 @@ int __clocksource_register_scale(struct
>   
>   	clocksource_arch_init(cs);
>   
> +#ifdef CONFIG_GENERIC_VDSO_CLOCK_MODE
> +	if (cs->vdso_clock_mode < 0 ||
> +	    cs->vdso_clock_mode >= VDSO_CLOCKMODE_MAX) {
> +		pr_warn("clocksource %s registered with invalid VDSO mode %d. Disabling VDSO support.\n",
> +			cs->name, cs->vdso_clock_mode);
> +		cs->vdso_clock_mode = VDSO_CLOCKMODE_NONE;
> +	}
> +#endif
> +
>   	/* Initialize mult/shift and max_idle_ns */
>   	__clocksource_update_freq_scale(cs, scale, freq);
>   
> --- a/kernel/time/vsyscall.c
> +++ b/kernel/time/vsyscall.c
> @@ -72,12 +72,19 @@ void update_vsyscall(struct timekeeper *
>   	struct vdso_data *vdata = __arch_get_k_vdso_data();
>   	struct vdso_timestamp *vdso_ts;
>   	u64 nsec;
> +	s32 mode;

gcc will claim 'mode' is unused when CONFIG_GENERIC_VDSO_CLOCK_MODE is 
not defined.
>   
>   	/* copy vsyscall data */
>   	vdso_write_begin(vdata);
>   
> +#ifdef CONFIG_GENERIC_VDSO_CLOCK_MODE
> +	mode = tk->tkr_mono.clock->vdso_clock_mode;
> +	vdata[CS_HRES_COARSE].clock_mode	= mode;
> +	vdata[CS_RAW].clock_mode		= mode;
> +#else
>   	vdata[CS_HRES_COARSE].clock_mode	= __arch_get_clock_mode(tk);
>   	vdata[CS_RAW].clock_mode		= __arch_get_clock_mode(tk);
> +#endif

Can we do :

#ifdef CONFIG_GENERIC_VDSO_CLOCK_MODE
	mode = tk->tkr_mono.clock->vdso_clock_mode;
#else
	mode = __arch_get_clock_mode(tk);
#endif
	vdata[CS_HRES_COARSE].clock_mode	= mode;
	vdata[CS_RAW].clock_mode		= mode;

Christophe

>   
>   	/* CLOCK_REALTIME also required for time() */
>   	vdso_ts		= &vdata[CS_HRES_COARSE].basetime[CLOCK_REALTIME];
> --- a/lib/vdso/Kconfig
> +++ b/lib/vdso/Kconfig
> @@ -30,4 +30,7 @@ config GENERIC_VDSO_TIME_NS
>   	  Selected by architectures which support time namespaces in the
>   	  VDSO
>   
> +config GENERIC_VDSO_CLOCK_MODE
> +	bool
> +
>   endif
> --- a/lib/vdso/gettimeofday.c
> +++ b/lib/vdso/gettimeofday.c
> @@ -7,6 +7,7 @@
>   #include <linux/time.h>
>   #include <linux/kernel.h>
>   #include <linux/hrtimer_defs.h>
> +#include <linux/clocksource.h>
>   #include <vdso/datapage.h>
>   #include <vdso/helpers.h>
>   
> @@ -64,10 +65,14 @@ static int do_hres_timens(const struct v
>   
>   	do {
>   		seq = vdso_read_begin(vd);
> +		if (IS_ENABLED(CONFIG_GENERIC_VDSO_CLOCK_MODE) &&
> +		    vd->clock_mode == VDSO_CLOCKMODE_NONE)
> +			return -1;
>   		cycles = __arch_get_hw_counter(vd->clock_mode);
>   		ns = vdso_ts->nsec;
>   		last = vd->cycle_last;
> -		if (unlikely((s64)cycles < 0))
> +		if (!IS_ENABLED(CONFIG_GENERIC_VDSO_CLOCK_MODE) &&
> +		    unlikely((s64)cycles < 0))
>   			return -1;
>   
>   		ns += vdso_calc_delta(cycles, last, vd->mask, vd->mult);
> @@ -132,10 +137,14 @@ static __always_inline int do_hres(const
>   		}
>   		smp_rmb();
>   
> +		if (IS_ENABLED(CONFIG_GENERIC_VDSO_CLOCK_MODE) &&
> +		    vd->clock_mode == VDSO_CLOCKMODE_NONE)
> +			return -1;
>   		cycles = __arch_get_hw_counter(vd->clock_mode);
>   		ns = vdso_ts->nsec;
>   		last = vd->cycle_last;
> -		if (unlikely((s64)cycles < 0))
> +		if (!IS_ENABLED(CONFIG_GENERIC_VDSO_CLOCK_MODE) &&
> +		    unlikely((s64)cycles < 0))
>   			return -1;
>   
>   		ns += vdso_calc_delta(cycles, last, vd->mask, vd->mult);
> 
