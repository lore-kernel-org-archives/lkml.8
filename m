Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1100BC35647
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 14:04:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7855208C4
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 14:04:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="U3itHwo/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728848AbgBUOEj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 09:04:39 -0500
Received: from mail.skyhub.de ([5.9.137.197]:41500 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728228AbgBUOEj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 09:04:39 -0500
Received: from zn.tnic (p200300EC2F090A006DBA3D6338540E70.dip0.t-ipconnect.de [IPv6:2003:ec:2f09:a00:6dba:3d63:3854:e70])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 31BA61EC013F;
        Fri, 21 Feb 2020 15:04:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1582293877;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=x0fzHa7Cf9E295Bqa5BO51qM8xrIeqQzCJUTtrURefg=;
        b=U3itHwo/rmDus63XbCBbMMJwZLEqu+6VwdVwRnlSFt3Rhwc09OuERGY+DWgi+B26APfo1a
        9ZoZtGsyU9/AbK+lTXi0AwqYwOkjfxV3ebDvDDX8818WE4ppvJ9T1YGZlCdnmbuthbjTxS
        rbTBllQAHPzoSIl0UoSLeZKU2XjL6LU=
Date:   Fri, 21 Feb 2020 15:04:33 +0100
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
Subject: Re: [PATCH v2 4/8] x86/fpu/xstate: Define new functions for clearing
 fpregs and xstates
Message-ID: <20200221140433.GF25747@zn.tnic>
References: <20200121201843.12047-1-yu-cheng.yu@intel.com>
 <20200121201843.12047-5-yu-cheng.yu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200121201843.12047-5-yu-cheng.yu@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 21, 2020 at 12:18:39PM -0800, Yu-cheng Yu wrote:
> @@ -318,9 +313,29 @@ static inline void copy_init_fpstate_to_fpregs(void)
>   * Called by sys_execve(), by the signal handler code and by various
>   * error paths.
>   */
> -void fpu__clear(struct fpu *fpu)
> +void fpu__clear_user_states(struct fpu *fpu)
> +{
> +	WARN_ON_FPU(fpu != &current->thread.fpu);
> +
> +	if (static_cpu_has(X86_FEATURE_FPU)) {
> +		fpregs_lock();
> +		if (!fpregs_state_valid(fpu, smp_processor_id()) &&
> +		    xfeatures_mask_supervisor())
> +			copy_kernel_to_xregs(&fpu->state.xsave,
> +					     xfeatures_mask_supervisor());
> +		copy_init_fpstate_to_fpregs(xfeatures_mask_user());
> +		fpregs_mark_activate();
> +		fpregs_unlock();
> +		return;
> +	} else {
> +		fpu__drop(fpu);
> +		fpu__initialize(fpu);
> +	}
> +}
> +
> +void fpu__clear_all(struct fpu *fpu)
>  {
> -	WARN_ON_FPU(fpu != &current->thread.fpu); /* Almost certainly an anomaly */
> +	WARN_ON_FPU(fpu != &current->thread.fpu);
>  
>  	fpu__drop(fpu);
>  
> @@ -328,8 +343,12 @@ void fpu__clear(struct fpu *fpu)
>  	 * Make sure fpstate is cleared and initialized.
>  	 */
>  	fpu__initialize(fpu);
> -	if (static_cpu_has(X86_FEATURE_FPU))
> -		copy_init_fpstate_to_fpregs();
> +	if (static_cpu_has(X86_FEATURE_FPU)) {
> +		fpregs_lock();
> +		copy_init_fpstate_to_fpregs(xfeatures_mask_all);
> +		fpregs_mark_activate();
> +		fpregs_unlock();
> +	}
>  }

Why do you need two different functions which are pretty similar if you
can do

fpu__clear(struct fpu *fpu, bool user_only)
{
	...

and query that user_only variable in the fpu__clear() body to do the
respective work dependent on the its setting?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
