Return-Path: <SRS0=ObIu=6N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F4234C83000
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 16:39:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C825F20B1F
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 16:39:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="NJODSSyM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726884AbgD2QjO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Apr 2020 12:39:14 -0400
Received: from mail.skyhub.de ([5.9.137.197]:57264 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726511AbgD2QjN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 12:39:13 -0400
Received: from zn.tnic (p200300EC2F0B950044557BF5C5A01829.dip0.t-ipconnect.de [IPv6:2003:ec:2f0b:9500:4455:7bf5:c5a0:1829])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id EE8691EC0CCC;
        Wed, 29 Apr 2020 18:39:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1588178352;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=PYrW8QbWPmgOqVEyiqZLdTGs3TOGsh9OAn8MGLn5nFA=;
        b=NJODSSyMww+Qc3Kz7fsHSNqGHT3aSs1h6149Kjal3hSqfuV2mRLNk5Fes37qygIXKkh0I7
        Gz1mJgenVLvs4peXq6pCuTL8mt/TzR/pmZEHpFA0IjE9YG/rC9ZGtWF83QtMpOm96eWhBV
        0bYeGdeDhaO14r/Vr9TIwy7flJN8/TU=
Date:   Wed, 29 Apr 2020 18:39:06 +0200
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
Subject: Re: [PATCH v3 05/10] x86/fpu/xstate: Define new functions for
 clearing fpregs and xstates
Message-ID: <20200429163906.GC16407@zn.tnic>
References: <20200328164307.17497-6-yu-cheng.yu@intel.com>
 <20200429160644.28584-1-yu-cheng.yu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200429160644.28584-1-yu-cheng.yu@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 29, 2020 at 09:06:44AM -0700, Yu-cheng Yu wrote:
> From: Fenghua Yu <fenghua.yu@intel.com>
> 
> Currently, fpu__clear() clears all fpregs and xstates.  Once XSAVES
> supervisor states are introduced, supervisor settings (e.g. CET xstates)
> must remain active for signals; It is necessary to have separate functions:
> 
> - Create fpu__clear_user_states(): clear only user settings for signals;
> - Create fpu__clear_all(): clear both user and supervisor settings in
>    flush_thread().
> 
> Also modify copy_init_fpstate_to_fpregs() to take a mask from above two
> functions.
> 
> Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
> Co-developed-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
> Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
> Reviewed-by: Dave Hansen <dave.hansen@linux.intel.com>
> Reviewed-by: Tony Luck <tony.luck@intel.com>
> 
> v3:
> - Put common code into a static function fpu__clear(), with a parameter
>   user_only.
> 
> v2:
> - Fixed an issue where fpu__clear_user_states() drops supervisor xstates.
> - Revise commit log.

Try applying that patch from this mail yourself and see whether the
patch changelog will remain in the commit message or it will get
discarded.

> @@ -318,18 +313,40 @@ static inline void copy_init_fpstate_to_fpregs(void)
>   * Called by sys_execve(), by the signal handler code and by various
>   * error paths.
>   */
> -void fpu__clear(struct fpu *fpu)
> +static void fpu__clear(struct fpu *fpu, int user_only)
>  {
> -	WARN_ON_FPU(fpu != &current->thread.fpu); /* Almost certainly an anomaly */
> +	WARN_ON_FPU(fpu != &current->thread.fpu);

Why did you remove the side comment?

Is it wrong?

Why do you do such arbitrary changes which are not needed instead of
concentrating on only the changes the patch should do?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
