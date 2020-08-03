Return-Path: <SRS0=5bHT=BN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BADACC433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 12:43:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 93AB62054F
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 12:43:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="NA939e1a";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="/9epfUzX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729381AbgHCMnu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 08:43:50 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:35734 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728278AbgHCM3G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 08:29:06 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1596457743;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=RvLCSYDSP40IH/A+6SCmYBKw6wGrWKPPZ7D9/KZ9g7k=;
        b=NA939e1am+b3iGwgI0Rwq8cIEiKMStGfkzKJIDQMojIh5AcZrnltP2/8yagicIWVj/Vd9j
        MNS32FFcfMBwiUwi+StJXG34wyK/N21K5sE3cbKlHHSAh/mwUzf2T5bwo9GtCG0mlw0isE
        adzlkregFJesqalSh639+DELL2CWbOWacGETCS3gnfNBGH0JcTSIQNq23ISFcItMQPQ+eu
        i6OcpmgDNcCI4RaP8jPgRZ4vY4DQXVltUzbTUKgpFsi7Xg/hQSJc4SjZ36z3oxYxRIc+nx
        TrEeta2H6mjArjRuk8tuJa6hA19ttg7hRryKG09HR19cXzBCiiTWQHQiA/IciQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1596457743;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=RvLCSYDSP40IH/A+6SCmYBKw6wGrWKPPZ7D9/KZ9g7k=;
        b=/9epfUzXI/xZRGA93kyvyRrNxxfCRXRiZw5C3tqr/J5VmCLWRpOE8XzfVcDt9dKSFWrY+z
        VaR68GiEWbIqj2AQ==
To:     Sven Schnelle <svens@linux.ibm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc:     linux-kernel@vger.kernel.org, Sven Schnelle <svens@linux.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 2/2] s390: convert to GENERIC_VDSO
In-Reply-To: <20200803055645.79042-3-svens@linux.ibm.com>
References: <20200803055645.79042-1-svens@linux.ibm.com> <20200803055645.79042-3-svens@linux.ibm.com>
Date:   Mon, 03 Aug 2020 14:29:01 +0200
Message-ID: <87ft93ncaa.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sven Schnelle <svens@linux.ibm.com> writes:

> - CPUCLOCK_VIRT is now handled with a syscall fallback, which might
>   be slower/less accurate than the old implementation.

I can understand the slower, but why does it become less accurate?

> Performance number from my system do 100 mio gettimeofday() calls:
>
> Plain syscall: 8.6s
> Generic VDSO:  1.3s
> old ASM VDSO:  1s
>
> So it's a bit slower but still much faster than syscalls.

Where is the overhead coming from?

> +static inline u64 __arch_get_hw_counter(s32 clock_mode)
> +{
> +	const struct vdso_data *vdso = __arch_get_vdso_data();
> +	u64 adj, now;
> +	int cnt;
> +
> +	do {
> +		do {
> +			cnt = READ_ONCE(vdso->arch.tb_update_cnt);
> +		} while (cnt & 1);

                smp_rmb() ?

> +		now = get_tod_clock();
> +		adj = vdso->arch.tod_steering_end - now;
> +		if (unlikely((s64) adj > 0))
> +			now += (vdso->arch.tod_steering_delta < 0) ? (adj >> 15) : -(adj >> 15);

                smp_rmb() ?

> +	} while (cnt != READ_ONCE(vdso->arch.tb_update_cnt));
> +	return now;
>  	if (ptff_query(PTFF_QTO) && ptff(&qto, sizeof(qto), PTFF_QTO) == 0)
>  		lpar_offset = qto.tod_epoch_difference;
> @@ -599,6 +550,13 @@ static int stp_sync_clock(void *data)
>  		if (stp_info.todoff[0] || stp_info.todoff[1] ||
>  		    stp_info.todoff[2] || stp_info.todoff[3] ||
>  		    stp_info.tmd != 2) {
> +			vdso_data->arch.tb_update_cnt++;
> +			/*
> +			 * This barrier isn't really needed as we're called
> +			 * from stop_machine_cpuslocked(). However it doesn't
> +			 * hurt in case the code gets changed.
> +			 */
> +			smp_wmb();

WMB without a corresponding RMB and an explanation what's ordered
against what is voodoo at best.

>  			rc = chsc_sstpc(stp_page, STP_OP_SYNC, 0,
>  					&clock_delta);
>  			if (rc == 0) {
> @@ -609,6 +567,8 @@ static int stp_sync_clock(void *data)
>  				if (rc == 0 && stp_info.tmd != 2)
>  					rc = -EAGAIN;
>  			}
> +			smp_wmb(); /* see comment above */

See my comments above :)

Thanks,

        tglx
