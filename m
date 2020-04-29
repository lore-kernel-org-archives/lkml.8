Return-Path: <SRS0=ObIu=6N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D920C83003
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 09:27:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EAE8C20787
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 09:27:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="GVsO25Fm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726564AbgD2J1z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Apr 2020 05:27:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726423AbgD2J1y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 05:27:54 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8972FC03C1AD
        for <linux-kernel@vger.kernel.org>; Wed, 29 Apr 2020 02:27:54 -0700 (PDT)
Received: from zn.tnic (p200300EC2F0B9500F107CEE1E1E2B6BF.dip0.t-ipconnect.de [IPv6:2003:ec:2f0b:9500:f107:cee1:e1e2:b6bf])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 4A7661EC0C77;
        Wed, 29 Apr 2020 11:27:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1588152472;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=DrGwM1kYHwl+AZjo5HyYbhiUN3fFeAiO6sqppkogEjQ=;
        b=GVsO25Fm12j8NYVq8vJvLOEQrqQNQeGVvr2rFD8kLl/3gqHi4wE+VJ37KxU4F1KXpRnc9x
        HBv0bFMCEngAkQ9CQXCHB+hnBoiIT2yqgK4n+j4RRSLb50ITM6ih1ShZkznXqOugCpsccB
        fhhjt3kd8IkuqUKQmP/Pllw+hW0eXfY=
Date:   Wed, 29 Apr 2020 11:27:35 +0200
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
Message-ID: <20200429092735.GA16407@zn.tnic>
References: <20200328164307.17497-1-yu-cheng.yu@intel.com>
 <20200328164307.17497-6-yu-cheng.yu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200328164307.17497-6-yu-cheng.yu@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 28, 2020 at 09:43:02AM -0700, Yu-cheng Yu wrote:
> @@ -318,18 +313,40 @@ static inline void copy_init_fpstate_to_fpregs(void)
>   * Called by sys_execve(), by the signal handler code and by various
>   * error paths.
>   */
> -void fpu__clear(struct fpu *fpu)
> +static void fpu__clear(struct fpu *fpu, int clear_user_only)

I said:

"fpu__clear(struct fpu *fpu, bool user_only)"
			     ^^^^^^^^^^^^^^

you made it

		     ..., int clear_user_only)

Why?

If you agree with the review comment, then please do it as suggested. If
you don't, then say why you don't.

Why would you do something in-between?

>  {
> -	WARN_ON_FPU(fpu != &current->thread.fpu); /* Almost certainly an anomaly */

Why are you moving this into the callers when *both* do it?

> +	if (static_cpu_has(X86_FEATURE_FPU)) {

Flip this logic:

	if (!static_cpu_has(X86_FEATURE_FPU)) {
                fpu__drop(fpu);
                fpu__initialize(fpu);
		return;
	}

	fpregs_lock();
	...

to save an indentation level and make the important case more readable
and locking more prominent.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
