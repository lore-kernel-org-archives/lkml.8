Return-Path: <SRS0=7RkH=3E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17A1FC33CB1
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 05:54:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE7C62187F
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 05:54:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="eJDgCUne"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726559AbgAOFy2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jan 2020 00:54:28 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:37566 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725962AbgAOFy1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jan 2020 00:54:27 -0500
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 47yGjs0BBsz9vJB3;
        Wed, 15 Jan 2020 06:54:25 +0100 (CET)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=eJDgCUne; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id kPi0Z_OddoC8; Wed, 15 Jan 2020 06:54:24 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 47yGjr61ldz9vJB2;
        Wed, 15 Jan 2020 06:54:24 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1579067664; bh=wbSdI9HItOrxYVyTAN11WYXVXCt/akBxl4BYEVnadHA=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=eJDgCUne5jXjWmp5hzOZIoLnjINbHoblYv6LNNQhoBlLfP4B8bSXIHCVN1u6wH7Ke
         akuDZ+Uf1rWyYuA3M8/PcmMK3by6mM90WBA0ZizDasL9QuCUH6luda29vIIizcbzCV
         wJf2Yc+2q5Y2vdqfOC3mogBl5OCxRXrw+TAWh0ZU=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 991358B77E;
        Wed, 15 Jan 2020 06:54:25 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id Ky73qmDsAd-G; Wed, 15 Jan 2020 06:54:25 +0100 (CET)
Received: from [172.25.230.100] (po15451.idsi0.si.c-s.fr [172.25.230.100])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 58BCF8B774;
        Wed, 15 Jan 2020 06:54:25 +0100 (CET)
Subject: Re: [patch 14/15] lib/vdso: Avoid highres update if clocksource is
 not VDSO capable
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
 <20200114185947.996078385@linutronix.de>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <665c43c3-7f53-90d1-ac43-2fb7691d6b12@c-s.fr>
Date:   Wed, 15 Jan 2020 06:54:25 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <20200114185947.996078385@linutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 14/01/2020 à 19:52, Thomas Gleixner a écrit :
> If the current clocksource is not VDSO capable there is no point in
> updating the high resolution parts of the VDSO data.
> 
> Replace the architecture specific check with a check for a VDSO capable
> clocksource and skip the update if there is none.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
>   arch/arm/include/asm/vdso/vsyscall.h |    7 -------
>   include/asm-generic/vdso/vsyscall.h  |    7 -------
>   kernel/time/vsyscall.c               |   14 +++++++-------
>   3 files changed, 7 insertions(+), 21 deletions(-)
> 
> --- a/arch/arm/include/asm/vdso/vsyscall.h
> +++ b/arch/arm/include/asm/vdso/vsyscall.h
> @@ -22,13 +22,6 @@ struct vdso_data *__arm_get_k_vdso_data(
>   #define __arch_get_k_vdso_data __arm_get_k_vdso_data
>   
>   static __always_inline
> -bool __arm_update_vdso_data(void)
> -{
> -	return cntvct_ok;
> -}
> -#define __arch_update_vdso_data __arm_update_vdso_data
> -
> -static __always_inline
>   void __arm_sync_vdso_data(struct vdso_data *vdata)
>   {
>   	flush_dcache_page(virt_to_page(vdata));
> --- a/include/asm-generic/vdso/vsyscall.h
> +++ b/include/asm-generic/vdso/vsyscall.h
> @@ -11,13 +11,6 @@ static __always_inline struct vdso_data
>   }
>   #endif /* __arch_get_k_vdso_data */
>   
> -#ifndef __arch_update_vdso_data
> -static __always_inline bool __arch_update_vdso_data(void)
> -{
> -	return true;
> -}
> -#endif /* __arch_update_vdso_data */
> -
>   #ifndef __arch_update_vsyscall
>   static __always_inline void __arch_update_vsyscall(struct vdso_data *vdata,
>   						   struct timekeeper *tk)
> --- a/kernel/time/vsyscall.c
> +++ b/kernel/time/vsyscall.c
> @@ -71,15 +71,15 @@ void update_vsyscall(struct timekeeper *
>   {
>   	struct vdso_data *vdata = __arch_get_k_vdso_data();
>   	struct vdso_timestamp *vdso_ts;
> +	s32 clock_mode;
>   	u64 nsec;
> -	s32 mode;

Can we name is clock_mode in patch 9 instead of changing name here ?

Christophe

>   
>   	/* copy vsyscall data */
>   	vdso_write_begin(vdata);
>   
> -	mode = tk->tkr_mono.clock->vdso_clock_mode;
> -	vdata[CS_HRES_COARSE].clock_mode	= mode;
> -	vdata[CS_RAW].clock_mode		= mode;
> +	clock_mode = tk->tkr_mono.clock->vdso_clock_mode;
> +	vdata[CS_HRES_COARSE].clock_mode	= clock_mode;
> +	vdata[CS_RAW].clock_mode		= clock_mode;
>   
>   	/* CLOCK_REALTIME also required for time() */
>   	vdso_ts		= &vdata[CS_HRES_COARSE].basetime[CLOCK_REALTIME];
> @@ -105,10 +105,10 @@ void update_vsyscall(struct timekeeper *
>   	WRITE_ONCE(vdata[CS_HRES_COARSE].hrtimer_res, hrtimer_resolution);
>   
>   	/*
> -	 * Architectures can opt out of updating the high resolution part
> -	 * of the VDSO.
> +	 * If the current clocksource is not VDSO capable, then spare the
> +	 * update of the high reolution parts.
>   	 */
> -	if (__arch_update_vdso_data())
> +	if (clock_mode != VDSO_CLOCKMODE_NONE)
>   		update_vdso_data(vdata, tk);
>   
>   	__arch_update_vsyscall(vdata, tk);
> 
