Return-Path: <SRS0=7RkH=3E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CFF3C33CB1
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 05:58:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C3AD2187F
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 05:58:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="dio6bxBx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729077AbgAOF6e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jan 2020 00:58:34 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:60906 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726018AbgAOF6d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jan 2020 00:58:33 -0500
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 47yGpb0lccz9txw1;
        Wed, 15 Jan 2020 06:58:31 +0100 (CET)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=dio6bxBx; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id 40oHOF-MnUNq; Wed, 15 Jan 2020 06:58:31 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 47yGpZ6kvMz9txvv;
        Wed, 15 Jan 2020 06:58:30 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1579067910; bh=KwTGzVc/yyfo6uhNyJ5TjBEYcG7YtD5m2pclUdL15Bk=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=dio6bxBxIlI/6Qc4OXCmwolRa6EvYA9Zk+dth2w15eH3xj/xNj77GbT35lSw5TvrH
         h5Yh4Ow65KFwTB9VXvgugMKtii1FncFMxZBBwB3cSr0wO2Tvk/A61dvqmDt2dkz2Ms
         IzNa1pt0QscBmEU48otKa9tBGdQDWyJot0+VXidU=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id B69F68B77E;
        Wed, 15 Jan 2020 06:58:31 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id wBtF-z8B6-pm; Wed, 15 Jan 2020 06:58:31 +0100 (CET)
Received: from [172.25.230.100] (po15451.idsi0.si.c-s.fr [172.25.230.100])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 6C9A28B774;
        Wed, 15 Jan 2020 06:58:31 +0100 (CET)
Subject: Re: [patch 15/15] lib/vdso: Move VCLOCK_TIMENS to vdso_clock_modes
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
 <20200114185948.088821198@linutronix.de>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <8673fa43-97f8-2ad2-d784-f22b54fd7a2e@c-s.fr>
Date:   Wed, 15 Jan 2020 06:58:31 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <20200114185948.088821198@linutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 14/01/2020 à 19:52, Thomas Gleixner a écrit :
> Move the time namespace indicator clock mode to the other ones for
> consistency sake.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
>   include/linux/clocksource.h |    3 +++
>   include/vdso/datapage.h     |    2 --
>   kernel/time/namespace.c     |    7 ++++---
>   lib/vdso/gettimeofday.c     |   18 ++++++++++--------
>   4 files changed, 17 insertions(+), 13 deletions(-)
> 
> --- a/include/linux/clocksource.h
> +++ b/include/linux/clocksource.h
> @@ -34,6 +34,9 @@ enum vdso_clock_mode {
>   	VDSO_ARCH_CLOCKMODES,
>   #endif
>   	VDSO_CLOCKMODE_MAX,
> +
> +	/* Indicator for time namespace VDSO */ > +	VDSO_CLOCKMODE_TIMENS = INT_MAX

Can we shorten the names a bit in order to avoid code line splits ? 
WOuldn't something like VDSO_CMODE_XXX be explicit enough ?

Christophe

>   };
>   
>   /**
> --- a/include/vdso/datapage.h
> +++ b/include/vdso/datapage.h
> @@ -21,8 +21,6 @@
>   #define CS_RAW		1
>   #define CS_BASES	(CS_RAW + 1)
>   
> -#define VCLOCK_TIMENS	UINT_MAX
> -
>   /**
>    * struct vdso_timestamp - basetime per clock_id
>    * @sec:	seconds
> --- a/kernel/time/namespace.c
> +++ b/kernel/time/namespace.c
> @@ -8,6 +8,7 @@
>   #include <linux/user_namespace.h>
>   #include <linux/sched/signal.h>
>   #include <linux/sched/task.h>
> +#include <linux/clocksource.h>
>   #include <linux/seq_file.h>
>   #include <linux/proc_ns.h>
>   #include <linux/export.h>
> @@ -172,8 +173,8 @@ static struct timens_offset offset_from_
>    * for vdso_data->clock_mode is a non-issue. The task is spin waiting for the
>    * update to finish and for 'seq' to become even anyway.
>    *
> - * Timens page has vdso_data->clock_mode set to VCLOCK_TIMENS which enforces
> - * the time namespace handling path.
> + * Timens page has vdso_data->clock_mode set to VDSO_CLOCKMODE_TIMENS which
> + * enforces the time namespace handling path.
>    */
>   static void timens_setup_vdso_data(struct vdso_data *vdata,
>   				   struct time_namespace *ns)
> @@ -183,7 +184,7 @@ static void timens_setup_vdso_data(struc
>   	struct timens_offset boottime = offset_from_ts(ns->offsets.boottime);
>   
>   	vdata->seq			= 1;
> -	vdata->clock_mode		= VCLOCK_TIMENS;
> +	vdata->clock_mode		= VDSO_CLOCKMODE_TIMENS;
>   	offset[CLOCK_MONOTONIC]		= monotonic;
>   	offset[CLOCK_MONOTONIC_RAW]	= monotonic;
>   	offset[CLOCK_MONOTONIC_COARSE]	= monotonic;
> --- a/lib/vdso/gettimeofday.c
> +++ b/lib/vdso/gettimeofday.c
> @@ -116,10 +116,10 @@ static __always_inline int do_hres(const
>   
>   	do {
>   		/*
> -		 * Open coded to handle VCLOCK_TIMENS. Time namespace
> +		 * Open coded to handle VDSO_CLOCKMODE_TIMENS. Time namespace
>   		 * enabled tasks have a special VVAR page installed which
>   		 * has vd->seq set to 1 and vd->clock_mode set to
> -		 * VCLOCK_TIMENS. For non time namespace affected tasks
> +		 * VDSO_CLOCKMODE_TIMENS. For non time namespace affected tasks
>   		 * this does not affect performance because if vd->seq is
>   		 * odd, i.e. a concurrent update is in progress the extra
>   		 * check for vd->clock_mode is just a few extra
> @@ -128,7 +128,7 @@ static __always_inline int do_hres(const
>   		 */
>   		while (unlikely((seq = READ_ONCE(vd->seq)) & 1)) {
>   			if (IS_ENABLED(CONFIG_TIME_NS) &&
> -			    vd->clock_mode == VCLOCK_TIMENS)
> +			    vd->clock_mode == VDSO_CLOCKMODE_TIMENS)
>   				return do_hres_timens(vd, clk, ts);
>   			cpu_relax();
>   		}
> @@ -200,12 +200,12 @@ static __always_inline int do_coarse(con
>   
>   	do {
>   		/*
> -		 * Open coded to handle VCLOCK_TIMENS. See comment in
> +		 * Open coded to handle VDSO_CLOCK_TIMENS. See comment in
>   		 * do_hres().
>   		 */
>   		while ((seq = READ_ONCE(vd->seq)) & 1) {
>   			if (IS_ENABLED(CONFIG_TIME_NS) &&
> -			    vd->clock_mode == VCLOCK_TIMENS)
> +			    vd->clock_mode == VDSO_CLOCKMODE_TIMENS)
>   				return do_coarse_timens(vd, clk, ts);
>   			cpu_relax();
>   		}
> @@ -292,7 +292,7 @@ static __maybe_unused int
>   
>   	if (unlikely(tz != NULL)) {
>   		if (IS_ENABLED(CONFIG_TIME_NS) &&
> -		    vd->clock_mode == VCLOCK_TIMENS)
> +		    vd->clock_mode == VDSO_CLOCKMODE_TIMENS)
>   			vd = __arch_get_timens_vdso_data();
>   
>   		tz->tz_minuteswest = vd[CS_HRES_COARSE].tz_minuteswest;
> @@ -308,7 +308,8 @@ static __maybe_unused __kernel_old_time_
>   	const struct vdso_data *vd = __arch_get_vdso_data();
>   	__kernel_old_time_t t;
>   
> -	if (IS_ENABLED(CONFIG_TIME_NS) && vd->clock_mode == VCLOCK_TIMENS)
> +	if (IS_ENABLED(CONFIG_TIME_NS) &&
> +	    vd->clock_mode == VDSO_CLOCKMODE_TIMENS)
>   		vd = __arch_get_timens_vdso_data();
>   
>   	t = READ_ONCE(vd[CS_HRES_COARSE].basetime[CLOCK_REALTIME].sec);
> @@ -333,7 +334,8 @@ int __cvdso_clock_getres_common(clockid_
>   	if (unlikely((u32) clock >= MAX_CLOCKS))
>   		return -1;
>   
> -	if (IS_ENABLED(CONFIG_TIME_NS) && vd->clock_mode == VCLOCK_TIMENS)
> +	if (IS_ENABLED(CONFIG_TIME_NS) &&
> +	    vd->clock_mode == VDSO_CLOCKMODE_TIMENS)
>   		vd = __arch_get_timens_vdso_data();
>   
>   	hrtimer_res = READ_ONCE(vd[CS_HRES_COARSE].hrtimer_res);
> 
