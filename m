Return-Path: <SRS0=EnQK=B5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E221C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 14:50:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 08E2D20885
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 14:50:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="aNIPYl/q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728160AbgHSOua (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 10:50:30 -0400
Received: from mail.skyhub.de ([5.9.137.197]:54200 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726578AbgHSOu2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 10:50:28 -0400
Received: from zn.tnic (p200300ec2f26be00329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ec:2f26:be00:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 86A521EC0246;
        Wed, 19 Aug 2020 16:50:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1597848626;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=zfgqjDL3wMsihT1LjZEPze5peMiaUv389dpHBHHb2Ck=;
        b=aNIPYl/qzmq4gH8+HVGo2Yw2Gn2Cj0g2T9qd+BdQdGmCRz/htPyuPwOZdDQEbPKcr94XyD
        MseUctl91d5+wwbfUW4NMxJnj6RgD3bukByiLxuWTSFTagdpRAaiwG8CNBxVB+FqmArcDw
        h+Ww29CL4umedhwSY/V+qQXS485sa9o=
Date:   Wed, 19 Aug 2020 16:50:21 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Chris Down <chris@chrisdown.name>
Cc:     linux-kernel@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>, kernel-team@fb.com,
        sean.j.christopherson@intel.com, tony.luck@intel.com,
        torvalds@linux-foundation.org, x86@kernel.org
Subject: Re: [PATCH 1/2] x86: Prevent userspace MSR access from dominating
 the console
Message-ID: <20200819144914.GB19351@zn.tnic>
References: <cover.1597677395.git.chris@chrisdown.name>
 <8ebda3f90bca583f12969892e0f0e97166c4d492.1597677395.git.chris@chrisdown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <8ebda3f90bca583f12969892e0f0e97166c4d492.1597677395.git.chris@chrisdown.name>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 17, 2020 at 04:24:29PM +0100, Chris Down wrote:
> Applications which manipulate MSRs from userspace often do so
> infrequently, and all at once. As such, the default printk ratelimit
> architecture supplied by pr_err_ratelimited doesn't do enough to prevent
> kmsg becoming completely overwhelmed with their messages and pushing
> other salient information out of the circular buffer. In one case, I saw
> over 80% of kmsg being filled with these messages, and the default kmsg
> buffer being completely filled less than 5 minutes after boot(!).
> 
> This change makes things much less aggressive, while still achieving the

s/This change makes/Make/

> original goal of fiter_write(). Operators will still get warnings that
> MSRs are being manipulated from userspace, but they won't have other
> also potentially useful messages pushed out of the kmsg buffer.
> 
> Of course, one can boot with `allow_writes=1` to avoid these messages at
> all, but that then has the downfall that one doesn't get _any_
> notification at all about these problems in the first place, and so is
> much less likely to forget to fix it. One might rather it was less
> binary: it was still logged, just less often, so that application
> developers _do_ have the incentive to improve their current methods,
> without us having to push other useful stuff out of the kmsg buffer.
> 
> This one example isn't the point, of course: I'm sure there are plenty
> of other non-ideal-but-pragmatic cases where people are writing to MSRs
> from userspace right now, and it will take time for those people to find
> other solutions.
> 
> Overall, this patch keeps the intent of the original patch, while

Avoid having "This patch" or "This commit" in the commit message. It is
tautologically useless.

Also, do

$ git grep 'This patch' Documentation/process

for more details.

> mitigating its sometimes heavy effects on kmsg composition.
> 
> Signed-off-by: Chris Down <chris@chrisdown.name>
> Cc: Borislav Petkov <bp@suse.de>
> Cc: Jakub Kicinski <kuba@kernel.org>
> ---
>  arch/x86/kernel/msr.c | 17 +++++++++++++----
>  1 file changed, 13 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/x86/kernel/msr.c b/arch/x86/kernel/msr.c
> index 49dcfb85e773..3babb0e58b0e 100644
> --- a/arch/x86/kernel/msr.c
> +++ b/arch/x86/kernel/msr.c
> @@ -80,18 +80,27 @@ static ssize_t msr_read(struct file *file, char __user *buf,
>  
>  static int filter_write(u32 reg)
>  {
> +	/*
> +	 * Banging MSRs usually happens all at once, and can easily saturate

Yeah we have a lot of non-native speakers so "Banging" might be
confusing - please formulate less colloquial.

> +	 * kmsg. Only allow 1 MSR message every 30 seconds.
> +	 *
> +	 * We could be smarter here and do it per-MSR, or whatever, but it would

Please avoid the "we" in text as it is ambiguous - try formulating
passively like your commit message.

> +	 * certainly be more complex, and this is enough at least to stop
> +	 * completely saturating the ring buffer.
> +	 */
> +	static DEFINE_RATELIMIT_STATE(fw_rs, 30 * HZ, 1);
> +
>  	switch (allow_writes) {
>  	case MSR_WRITES_ON:  return 0;
>  	case MSR_WRITES_OFF: return -EPERM;
>  	default: break;
>  	}
>  
> -	if (reg == MSR_IA32_ENERGY_PERF_BIAS)
> +	if (!__ratelimit(&fw_rs) || reg == MSR_IA32_ENERGY_PERF_BIAS)
>  		return 0;

Let's keep those two tests separate:

	if (!__ratelimit(&fw_rs))
		return 0;

	if (reg == MSR_IA32_ENERGY_PERF_BIAS)
		return 0;

>  
> -	pr_err_ratelimited("Write to unrecognized MSR 0x%x by %s\n"
> -			   "Please report to x86@kernel.org\n",
> -			   reg, current->comm);
> +	pr_err("Write to unrecognized MSR 0x%x by %s\n"
> +	       "Please report to x86@kernel.org\n", reg, current->comm);
>  
>  	return 0;
>  }
> -- 
> 2.28.0
> 

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
