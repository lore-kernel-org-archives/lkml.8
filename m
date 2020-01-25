Return-Path: <SRS0=aedO=3O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7957C2D0DB
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jan 2020 13:41:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94FE52070A
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jan 2020 13:41:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726775AbgAYNlt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Jan 2020 08:41:49 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:44528 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725821AbgAYNlt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jan 2020 08:41:49 -0500
Received: from p5b06da22.dip0.t-ipconnect.de ([91.6.218.34] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1ivLgv-00031s-5H; Sat, 25 Jan 2020 14:41:37 +0100
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id 9401F103085; Sat, 25 Jan 2020 14:41:33 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     "Luck\, Tony" <tony.luck@intel.com>
Cc:     Arvind Sankar <nivedita@alum.mit.edu>,
        "Christopherson\, Sean J" <sean.j.christopherson@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        "Yu\, Fenghua" <fenghua.yu@intel.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>,
        "Raj\, Ashok" <ashok.raj@intel.com>,
        "Shankar\, Ravi V" <ravi.v.shankar@intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>, x86 <x86@kernel.org>
Subject: Re: [PATCH v15] x86/split_lock: Enable split lock detection by kernel
In-Reply-To: <20200125024727.GA32483@agluck-desk2.amr.corp.intel.com>
References: <20200115222754.GA13804@agluck-desk2.amr.corp.intel.com> <20200115225724.GA18268@linux.intel.com> <20200122185514.GA16010@agluck-desk2.amr.corp.intel.com> <20200122224245.GA2331824@rani.riverdale.lan> <3908561D78D1C84285E8C5FCA982C28F7F54887A@ORSMSX114.amr.corp.intel.com> <20200123004507.GA2403906@rani.riverdale.lan> <20200123035359.GA23659@agluck-desk2.amr.corp.intel.com> <20200123044514.GA2453000@rani.riverdale.lan> <20200123231652.GA4457@agluck-desk2.amr.corp.intel.com> <87h80kmta4.fsf@nanos.tec.linutronix.de> <20200125024727.GA32483@agluck-desk2.amr.corp.intel.com>
Date:   Sat, 25 Jan 2020 14:41:33 +0100
Message-ID: <875zgzmz5e.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tony,

"Luck, Tony" <tony.luck@intel.com> writes:
> +
> +void switch_to_sld(struct task_struct *prev, struct task_struct *next)
> +{
> +	bool prevflag = test_tsk_thread_flag(prev, TIF_SLD);
> +	bool nextflag = test_tsk_thread_flag(next, TIF_SLD);
> +
> +	/*
> +	 * If we are switching between tasks that have the same
> +	 * need for split lock checking, then the MSR is (probably)
> +	 * right (modulo the other thread messing with it.
> +	 * Otherwise look at whether the new task needs split
> +	 * lock enabled.
> +	 */
> +	if (prevflag != nextflag)
> +		__sld_msr_set(nextflag);
> +}
> diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
> index 839b5244e3b7..b34d359c4e39 100644
> --- a/arch/x86/kernel/process.c
> +++ b/arch/x86/kernel/process.c
> @@ -650,6 +650,8 @@ void __switch_to_xtra(struct task_struct *prev_p, struct task_struct *next_p)
>  		/* Enforce MSR update to ensure consistent state */
>  		__speculation_ctrl_update(~tifn, tifn);
>  	}
> +
> +	switch_to_sld(prev_p, next_p);

This really wants to follow the logic of the other TIF checks.

        if ((tifp ^ tifn) & _TIF_SLD)
        	switch_to_sld(tifn);

and

void switch_to_sld(tifn)
{
        __sld_msr_set(tif & _TIF_SLD);
}

That reuses tifp, tifn which are ready to consume there and calls only
out of line when the bits differ. The xor/and combo turned out to result
in the most efficient code.

Thanks,

        tglx
