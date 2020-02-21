Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A70E6C35646
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 10:34:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 727A7207FD
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 10:34:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="hKOcqB6h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727803AbgBUKen (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 05:34:43 -0500
Received: from mail.skyhub.de ([5.9.137.197]:39356 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726100AbgBUKem (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 05:34:42 -0500
Received: from zn.tnic (p200300EC2F090A0091F32234A946F800.dip0.t-ipconnect.de [IPv6:2003:ec:2f09:a00:91f3:2234:a946:f800])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 1826A1EC0D01;
        Fri, 21 Feb 2020 11:34:41 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1582281281;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=hj50LFKF2rTpUxKlE9+JpaS6cXPysSYc2AuZJyeyXJg=;
        b=hKOcqB6h9nxEorPv7zsc0+5fz7AxNSE4NGtSTK248AazegvNeqyEddk+1CodcuvCRMlQUV
        Cg0vecyHrGDlir1dXqgz1Y3t/CcqFfvWflazRWGXAVYOjyC0XS5jbrLBn5ocv28As+iS8V
        XVpV1ajMLdOKkyWWOiD5A7Xv2REa7gU=
Date:   Fri, 21 Feb 2020 11:34:36 +0100
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
Subject: Re: [PATCH v2 2/8] x86/fpu/xstate: Separate user and supervisor
 xfeatures mask
Message-ID: <20200221103436.GB25747@zn.tnic>
References: <20200121201843.12047-1-yu-cheng.yu@intel.com>
 <20200121201843.12047-3-yu-cheng.yu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200121201843.12047-3-yu-cheng.yu@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 21, 2020 at 12:18:37PM -0800, Yu-cheng Yu wrote:
> diff --git a/arch/x86/kernel/fpu/signal.c b/arch/x86/kernel/fpu/signal.c
> index 400a05e1c1c5..7c7f3efa3c57 100644
> --- a/arch/x86/kernel/fpu/signal.c
> +++ b/arch/x86/kernel/fpu/signal.c
> @@ -254,11 +254,14 @@ static int copy_user_to_fpregs_zeroing(void __user *buf, u64 xbv, int fx_only)
>  {
>  	if (use_xsave()) {
>  		if (fx_only) {
> -			u64 init_bv = xfeatures_mask & ~XFEATURE_MASK_FPSSE;
> +			u64 init_bv;
> +
> +			init_bv = xfeatures_mask_user() & ~XFEATURE_MASK_FPSSE;
>  			copy_kernel_to_xregs(&init_fpstate.xsave, init_bv);
>  			return copy_user_to_fxregs(buf);
>  		} else {
> -			u64 init_bv = xfeatures_mask & ~xbv;
> +			u64 init_bv = xfeatures_mask_user() & ~xbv;
> +
>  			if (unlikely(init_bv))
>  				copy_kernel_to_xregs(&init_fpstate.xsave, init_bv);
>  			return copy_user_to_xregs(buf, xbv);

If you don't want to overflow 80 cols here in the fx_only() case, you can do:

---
diff --git a/arch/x86/kernel/fpu/signal.c b/arch/x86/kernel/fpu/signal.c
index 7c7f3efa3c57..d7e94677cd31 100644
--- a/arch/x86/kernel/fpu/signal.c
+++ b/arch/x86/kernel/fpu/signal.c
@@ -252,15 +252,16 @@ sanitize_restored_xstate(union fpregs_state *state,
  */
 static int copy_user_to_fpregs_zeroing(void __user *buf, u64 xbv, int fx_only)
 {
+	u64 init_bv;
+
 	if (use_xsave()) {
 		if (fx_only) {
-			u64 init_bv;
-
 			init_bv = xfeatures_mask_user() & ~XFEATURE_MASK_FPSSE;
+
 			copy_kernel_to_xregs(&init_fpstate.xsave, init_bv);
 			return copy_user_to_fxregs(buf);
 		} else {
-			u64 init_bv = xfeatures_mask_user() & ~xbv;
+			init_bv = xfeatures_mask_user() & ~xbv;
 
 			if (unlikely(init_bv))
 				copy_kernel_to_xregs(&init_fpstate.xsave, init_bv);

...

> @@ -210,19 +211,24 @@ void fpstate_sanitize_xstate(struct fpu *fpu)
>   */
>  void fpu__init_cpu_xstate(void)
>  {
> -	if (!boot_cpu_has(X86_FEATURE_XSAVE) || !xfeatures_mask)
> +	if (!boot_cpu_has(X86_FEATURE_XSAVE) || !xfeatures_mask_all)
>  		return;
>  	/*
>  	 * Unsupported supervisor xstates should not be found in
>  	 * the xfeatures mask.
>  	 */
> -	WARN_ONCE((xfeatures_mask & UNSUPPORTED_XFEATURES_MASK_SUPERVISOR),
> +	WARN_ONCE((xfeatures_mask_all & UNSUPPORTED_XFEATURES_MASK_SUPERVISOR),
>  		  "x86/fpu: Found unsupported supervisor xstates.\n");

Let's say which to ease debugging:

	u64 unsup_bits = xfeatures_mask_all & UNSUPPORTED_XFEATURES_MASK_SUPERVISOR;

	...

	WARN_ONCE(unsup_bits, "x86/fpu: Found unsupported supervisor xstates: 0x%llx\n",
		  unsup_bits);


>  
> -	xfeatures_mask &= ~UNSUPPORTED_XFEATURES_MASK_SUPERVISOR;
> +	xfeatures_mask_all &= ~UNSUPPORTED_XFEATURES_MASK_SUPERVISOR;
>  
>  	cr4_set_bits(X86_CR4_OSXSAVE);
> -	xsetbv(XCR_XFEATURE_ENABLED_MASK, xfeatures_mask);

<---- newline here.

> +	/*
> +	 * XCR_XFEATURE_ENABLED_MASK (aka. XCR0) sets user features
> +	 * managed by XSAVE{C, OPT, S} and XRSTOR{S}.  Only XSAVE user
> +	 * states can be set here.
> +	 */
> +	xsetbv(XCR_XFEATURE_ENABLED_MASK, xfeatures_mask_user());
>  }
>  
>  /*
> @@ -232,7 +238,7 @@ void fpu__init_cpu_xstate(void)
>   */
>  static int xfeature_enabled(enum xfeature xfeature)

static bool

>  {
> -	return !!(xfeatures_mask & (1UL << xfeature));
> +	return !!(xfeatures_mask_all & (1UL << xfeature));

	return xfeatures_mask_all & BIT(xfeature);

while at it.

>  }
>  
>  /*
> @@ -419,7 +425,7 @@ static void __init setup_init_fpu_buf(void)
>  
>  	if (boot_cpu_has(X86_FEATURE_XSAVES))
>  		init_fpstate.xsave.header.xcomp_bv = XCOMP_BV_COMPACTED_FORMAT |
> -						     xfeatures_mask;
> +						     xfeatures_mask_all;
>  
>  	/*
>  	 * Init all the features state with header.xfeatures being 0x0
> @@ -479,7 +485,7 @@ int using_compacted_format(void)
>  int validate_xstate_header(const struct xstate_header *hdr)
>  {
>  	/* No unknown or supervisor features may be set */
> -	if (hdr->xfeatures & ~(xfeatures_mask & SUPPORTED_XFEATURES_MASK_USER))
> +	if (hdr->xfeatures & ~xfeatures_mask_user())
>  		return -EINVAL;
>  
>  	/* Userspace must use the uncompacted format */
> @@ -614,7 +620,7 @@ static void do_extra_xstate_size_checks(void)
>  
>  
>  /*
> - * Get total size of enabled xstates in XCR0/xfeatures_mask.
> + * Get total size of enabled xstates in XCR0 | IA32_XSS.
>   *
>   * Note the SDM's wording here.  "sub-function 0" only enumerates
>   * the size of the *user* states.  If we use it to size a buffer
> @@ -704,7 +710,7 @@ static int __init init_xstate_size(void)
>   */
>  static void fpu__init_disable_system_xstate(void)
>  {
> -	xfeatures_mask = 0;
> +	xfeatures_mask_all = 0;
>  	cr4_clear_bits(X86_CR4_OSXSAVE);
>  	setup_clear_cpu_cap(X86_FEATURE_XSAVE);
>  }
> @@ -739,16 +745,22 @@ void __init fpu__init_system_xstate(void)
>  		return;
>  	}
>  
> +	/*
> +	 * Find user xstates supported by the processor.
> +	 */
>  	cpuid_count(XSTATE_CPUID, 0, &eax, &ebx, &ecx, &edx);
> -	xfeatures_mask = eax + ((u64)edx << 32);
> +	xfeatures_mask_all = eax + ((u64)edx << 32);
> +
> +	/* Place supervisor features in xfeatures_mask_all here */
>  

Superfluous newline.

> -	if ((xfeatures_mask & XFEATURE_MASK_FPSSE) != XFEATURE_MASK_FPSSE) {
> +	if ((xfeatures_mask_user() & XFEATURE_MASK_FPSSE) != XFEATURE_MASK_FPSSE) {
>  		/*
>  		 * This indicates that something really unexpected happened
>  		 * with the enumeration.  Disable XSAVE and try to continue
>  		 * booting without it.  This is too early to BUG().
>  		 */
> -		pr_err("x86/fpu: FP/SSE not present amongst the CPU's xstate features: 0x%llx.\n", xfeatures_mask);
> +		pr_err("x86/fpu: FP/SSE not present amongst the CPU's xstate features: 0x%llx.\n",
> +		       xfeatures_mask_all);
>  		goto out_disable;
>  	}

...

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
