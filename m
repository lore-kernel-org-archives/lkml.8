Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93912C38A2A
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 13:11:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 68BD120838
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 13:11:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="n51Rn83w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726464AbgEGNLw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 09:11:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725857AbgEGNLv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 09:11:51 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3623C05BD43
        for <linux-kernel@vger.kernel.org>; Thu,  7 May 2020 06:11:51 -0700 (PDT)
Received: from zn.tnic (p200300EC2F0B6A0029AA22443DE255A6.dip0.t-ipconnect.de [IPv6:2003:ec:2f0b:6a00:29aa:2244:3de2:55a6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id BD3F61EC034B;
        Thu,  7 May 2020 15:11:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1588857107;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=E20OXuV+EnYUFdXJHJBT+cw6g5yrTYVS4U7ukdVv+74=;
        b=n51Rn83wku7F/3qcyGr68GzLR+aOLw6jiMALFfXXeH8gEZVw3mnx/BfD8uYKGIYD6vTr7l
        WGXx0xU1K8JLR0D+e2ymSUB8HGMTSfdi8yneVs0RzoPoZdjybA74DBDeg5ZJS2+9O/gJpE
        kXCUFvjRcr8n5Nj4SMiKkCsucG3+j4k=
Date:   Thu, 7 May 2020 15:11:42 +0200
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
Subject: Re: [PATCH v3 06/10] x86/fpu/xstate: Update
 sanitize_restored_xstate() for supervisor xstates
Message-ID: <20200507131142.GA23026@zn.tnic>
References: <20200328164307.17497-1-yu-cheng.yu@intel.com>
 <20200328164307.17497-7-yu-cheng.yu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200328164307.17497-7-yu-cheng.yu@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 28, 2020 at 09:43:03AM -0700, Yu-cheng Yu wrote:
> The function sanitize_restored_xstate() sanitizes user xstates of an XSAVE
> buffer by setting the buffer's header->xfeatures to the input 'xfeatures',

It doesn't set them to the input xfeatures. I see a "&=" there.

> effectively resetting features not in 'xfeatures' back to the init state.
> 
> When supervisor xstates are introduced, it is necessary to make sure only
> user xstates are sanitized.  Ensure supervisor bits in header->xfeatures
> stay set and supervisor states are not modified.
> 
> To make names clear, also:
> 
> - Rename the function to sanitize_restored_user_xstate().
> - Rename input parameter 'xfeatures' to 'xfeatures_from_user'.
> - In __fpu__restore_sig(), rename 'xfeatures' to 'user_xfeatures'.
> 
> v3:
> - Change xfeatures_user to user_xfeatures.
> 
> Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
> Reviewed-by: Dave Hansen <dave.hansen@linux.intel.com>
> ---
>  arch/x86/kernel/fpu/signal.c | 37 +++++++++++++++++++++++-------------
>  1 file changed, 24 insertions(+), 13 deletions(-)
> 
> diff --git a/arch/x86/kernel/fpu/signal.c b/arch/x86/kernel/fpu/signal.c
> index cd6eafba12da..d09d72334a12 100644
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

Name those user_xfeatures too.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
