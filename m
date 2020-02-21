Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22F5EC35646
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 14:30:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2764208C4
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 14:30:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="XghI49yA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728684AbgBUOaQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 09:30:16 -0500
Received: from mail.skyhub.de ([5.9.137.197]:45302 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727096AbgBUOaQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 09:30:16 -0500
Received: from zn.tnic (p200300EC2F090A0078F81E233D8BB03D.dip0.t-ipconnect.de [IPv6:2003:ec:2f09:a00:78f8:1e23:3d8b:b03d])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id DDEC91EC0273;
        Fri, 21 Feb 2020 15:30:14 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1582295415;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=m3CzAA0upTc4DvdovRIqX50rDhiD4smPWLuDcnNh3hI=;
        b=XghI49yACn/gcqFIQMF8eX5HBJLsoCjZ3zppjRW5KHC7uz9b/MeDALHlvVIrA/jUiDB/dc
        S5LMSC+5UhBFyA9yqZa01CKgzo/qSS4KVJt2zRgnqlhTQSnl+qPfdjWgwc15xFPWuEHwdW
        iQChyalS/WKROIyigegNzaJlUch4Ffo=
Date:   Fri, 21 Feb 2020 15:30:10 +0100
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
Subject: Re: [PATCH v2 6/8] x86/fpu/xstate: Update sanitize_restored_xstate()
 for supervisor xstates
Message-ID: <20200221143010.GH25747@zn.tnic>
References: <20200121201843.12047-1-yu-cheng.yu@intel.com>
 <20200121201843.12047-7-yu-cheng.yu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200121201843.12047-7-yu-cheng.yu@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 21, 2020 at 12:18:41PM -0800, Yu-cheng Yu wrote:
> The function sanitize_restored_xstate() sanitizes user xstates of an XSAVE
> buffer by setting the buffer's header->xfeatures to the input 'xfeatures',
> effectively resetting features not in 'xfeatures' back to the init state.
> 
> When supervisor xstates are introduced, it is necessary to make sure only
> user xstates are sanitized.  This patch ensures supervisor xstates are not

Avoid having "This patch" or "This commit" in the commit message. It is
tautologically useless.

Also, do

$ git grep 'This patch' Documentation/process

for more details.

> changed by ensuring supervisor bits stay set in header->xfeatures.
> 
> To make names clear, also:
> 
> - Rename the function to sanitize_restored_user_xstate().
> - Rename input parameter 'xfeatures' to 'xfeatures_from_user'.
> - In __fpu__restore_sig(), rename 'xfeatures' to 'xfeatures_user'.

Call them all "user_xfeatures" to differentiate that it is a function
argument and not our xfeature_* macro and function names.

> Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
> Reviewed-by: Dave Hansen <dave.hansen@linux.intel.com>
> ---
>  arch/x86/kernel/fpu/signal.c | 37 +++++++++++++++++++++++-------------
>  1 file changed, 24 insertions(+), 13 deletions(-)
> 
> diff --git a/arch/x86/kernel/fpu/signal.c b/arch/x86/kernel/fpu/signal.c
> index 4afe61987e03..e3781a4a52a8 100644
> --- a/arch/x86/kernel/fpu/signal.c
> +++ b/arch/x86/kernel/fpu/signal.c
> @@ -211,9 +211,9 @@ int copy_fpstate_to_sigframe(void __user *buf, void __user *buf_fx, int size)
>  }
>  
>  static inline void
> -sanitize_restored_xstate(union fpregs_state *state,
> -			 struct user_i387_ia32_struct *ia32_env,
> -			 u64 xfeatures, int fx_only)
> +sanitize_restored_user_xstate(union fpregs_state *state,
> +			      struct user_i387_ia32_struct *ia32_env,
> +			      u64 xfeatures_from_user, int fx_only)
>  {
>  	struct xregs_state *xsave = &state->xsave;
>  	struct xstate_header *header = &xsave->header;
> @@ -226,13 +226,22 @@ sanitize_restored_xstate(union fpregs_state *state,
>  		 */
>  
>  		/*
> -		 * Init the state that is not present in the memory
> -		 * layout and not enabled by the OS.
> +		 * 'xfeatures_from_user' might have bits clear which are
> +		 * set in header->xfeatures. This represents features that
> +		 * were in init state prior to a signal delivery, and need
> +		 * to be reset back to the init state.  Clear any user
> +		 * feature bits which are set in the kernel buffer to get
> +		 * them back to the init state.
> +		 *
> +		 * Supervisor state is unchanged by input from userspace.
> +		 * Ensure that supervisor state is not modified by ensuring
> +		 * supervisor state bits stay set.

"Ensure ... by ensuring ..." Simplify pls.

>  		 */
>  		if (fx_only)
>  			header->xfeatures = XFEATURE_MASK_FPSSE;
>  		else
> -			header->xfeatures &= xfeatures;
> +			header->xfeatures &= xfeatures_from_user |
> +					     xfeatures_mask_supervisor();
>  	}
>  
>  	if (use_fxsr()) {

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
