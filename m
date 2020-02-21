Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85B52C35646
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 17:59:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F4D72467D
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 17:59:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="NxTtQnyd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729130AbgBUR7E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 12:59:04 -0500
Received: from mail.skyhub.de ([5.9.137.197]:51008 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725947AbgBUR7E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 12:59:04 -0500
Received: from zn.tnic (p200300EC2F090A002034B94CF5910173.dip0.t-ipconnect.de [IPv6:2003:ec:2f09:a00:2034:b94c:f591:173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id EC4D51EC0626;
        Fri, 21 Feb 2020 18:59:02 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1582307943;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=Yl/JWudIPhOxz6sh1sr6Z13z20VCXJUgZD0CIJjLRG0=;
        b=NxTtQnydfGWn58I4CU40HCo8jGPAceXpsjte/rIMCXeSY2vPxUWSAGbyCpXRFxY9AoT3Jl
        SSgumkwSbUoyCgf63byR0KQNEfmXKFNaBOrps0qKMv1G+F3FlQqJlNQ6nnbJJKPK2701Wd
        dO+drrVhEckKQF7FDg2HN2QEp5LYXj8=
Date:   Fri, 21 Feb 2020 18:58:59 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Yu-cheng Yu <yu-cheng.yu@intel.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Rik van Riel <riel@surriel.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v2 8/8] x86/fpu/xstate: Restore supervisor xstates for
 __fpu__restore_sig()
Message-ID: <20200221175859.GL25747@zn.tnic>
References: <20200121201843.12047-1-yu-cheng.yu@intel.com>
 <20200121201843.12047-9-yu-cheng.yu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200121201843.12047-9-yu-cheng.yu@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 21, 2020 at 12:18:43PM -0800, Yu-cheng Yu wrote:
> When returning from a signal, there is user state in a userspace memory
> buffer and supervisor state in registers.  The in-kernel buffer has neither
> valid user or supervisor state.  To restore both, save supervisor fpregs

The correct formulation is "neither ... nor ... "

> first (and protect them across context switches), then restore it along

s/it/them/

> with user state.
> 
> This patch introduces saving and restoring of supervisor xstates for a

Avoid having "This patch" or "This commit" in the commit message. It is
tautologically useless.

Also, do

$ git grep 'This patch' Documentation/process

for more details.

> sigreturn in the following steps:
> 
> - Preserve supervisor register values by saving the whole fpu xstates.
>   Saving the whole is necessary because doing XSAVES with a partial
>   requested-feature bitmap (RFBM) changes xcomp_bv.  Since user xstates are
>   to be restored from a user buffer, saved user xstates are discarded.
> 
> - Set TIF_NEED_FPU_LOAD, and do __fpu_invalidate_fpregs_state().
>   This prevents a context switch from corrupting the saved xstates,
>   and xstate is considered to be loaded again on return to userland.

s/considered/going to/

> - Under fpregs_lock(), restore user xstates (from the user buffer), and
>   then supervisor xstates (from previously saved content).
> 
> - When both parts of the restoration succeed, mark fpregs as valid.
> 
> Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
> Reviewed-by: Dave Hansen <dave.hansen@linux.intel.com>
> ---
>  arch/x86/kernel/fpu/signal.c | 26 +++++++++++++++++++++-----
>  1 file changed, 21 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/x86/kernel/fpu/signal.c b/arch/x86/kernel/fpu/signal.c
> index e3781a4a52a8..0d3e06a772b0 100644
> --- a/arch/x86/kernel/fpu/signal.c
> +++ b/arch/x86/kernel/fpu/signal.c
> @@ -327,14 +327,22 @@ static int __fpu__restore_sig(void __user *buf, void __user *buf_fx, int size)
>  	}
>  
>  	/*
> -	 * The current state of the FPU registers does not matter. By setting
> -	 * TIF_NEED_FPU_LOAD unconditionally it is ensured that the our xstate
> -	 * is not modified on context switch and that the xstate is considered
> +	 * Supervisor xstates are not modified by user space input, and
> +	 * need to be saved and restored.  Save the whole because doing
> +	 * partial XSAVES changes xcomp_bv.
> +	 * By setting TIF_NEED_FPU_LOAD it is ensured that our xstate is
> +	 * not modified on context switch and that the xstate is considered

Reflow those comments to 80 cols. There's room to the right.

>  	 * to be loaded again on return to userland (overriding last_cpu avoids
>  	 * the optimisation).
>  	 */
> -	set_thread_flag(TIF_NEED_FPU_LOAD);
> +	fpregs_lock();
> +	if (!test_thread_flag(TIF_NEED_FPU_LOAD)) {
> +		if (xfeatures_mask_supervisor())
> +			copy_xregs_to_kernel(&fpu->state.xsave);
> +		set_thread_flag(TIF_NEED_FPU_LOAD);

So the code sets TIF_NEED_FPU_LOAD unconditionally, why are you changing
this?

Why don't you simply do:

		set_thread_flag(TIF_NEED_FPU_LOAD);
		fpregs_lock();
		if (xfeatures_mask_supervisor())
			copy_xregs_to_kernel(&fpu->state.xsave);
		fpregs_unlock();


> +	}
>  	__fpu_invalidate_fpregs_state(fpu);
> +	fpregs_unlock();
>  
>  	if ((unsigned long)buf_fx % 64)
>  		fx_only = 1;
> @@ -360,6 +368,9 @@ static int __fpu__restore_sig(void __user *buf, void __user *buf_fx, int size)
>  		ret = copy_user_to_fpregs_zeroing(buf_fx, xfeatures_user, fx_only);
>  		pagefault_enable();

<--- comment here why you're doing this. That function is an abomination
and needs commenting at least.

>  		if (!ret) {
> +			if (xfeatures_mask_supervisor())
> +				copy_kernel_to_xregs(&fpu->state.xsave,
> +						     xfeatures_mask_supervisor());
>  			fpregs_mark_activate();
>  			fpregs_unlock();
>  			return 0;
> @@ -389,7 +400,12 @@ static int __fpu__restore_sig(void __user *buf, void __user *buf_fx, int size)
>  		fpregs_lock();
>  		if (unlikely(init_bv))
>  			copy_kernel_to_xregs(&init_fpstate.xsave, init_bv);
> -		ret = copy_kernel_to_xregs_err(&fpu->state.xsave, xfeatures_user);
> +		/*
> +		 * Restore previously saved supervisor xstates along with
> +		 * copied-in user xstates.
> +		 */
> +		ret = copy_kernel_to_xregs_err(&fpu->state.xsave,
> +					       xfeatures_user | xfeatures_mask_supervisor());
>  
>  	} else if (use_fxsr()) {
>  		ret = __copy_from_user(&fpu->state.fxsave, buf_fx, state_size);
> -- 
> 2.21.0
> 

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
