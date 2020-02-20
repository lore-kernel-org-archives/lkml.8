Return-Path: <SRS0=NukP=4I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0B46C11D04
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 11:47:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9534E20659
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 11:47:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="jHrzk5Ns"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727938AbgBTLrU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Feb 2020 06:47:20 -0500
Received: from mail.skyhub.de ([5.9.137.197]:41898 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726921AbgBTLrU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 06:47:20 -0500
Received: from zn.tnic (p200300EC2F0ADE008C2E3AE544E50E0D.dip0.t-ipconnect.de [IPv6:2003:ec:2f0a:de00:8c2e:3ae5:44e5:e0d])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 87B811EC0304;
        Thu, 20 Feb 2020 12:47:18 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1582199238;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=0MD+9fFNXTuMWu81/KO9VPDu9Nw1MgQLDJAbVPJBUXU=;
        b=jHrzk5Ns2tZlTZAetpNNXjFWfauU3PdopKHDlWC2YW82hOeB2+SXBmHpsK8ATfFzgOVksN
        gyt0/22RQanxmECicOKZuU8Mo+FmdegupqgOcUSfwmOLvki7RRze8J3+eVnQPlCNmYgt4X
        6O8f9HlkrQJVjq/0yKjv/cTuHW/RKbg=
Date:   Thu, 20 Feb 2020 12:47:13 +0100
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
Subject: Re: [PATCH v2 1/8] x86/fpu/xstate: Define new macros for supervisor
 and user xstates
Message-ID: <20200220114713.GB30188@zn.tnic>
References: <20200121201843.12047-1-yu-cheng.yu@intel.com>
 <20200121201843.12047-2-yu-cheng.yu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200121201843.12047-2-yu-cheng.yu@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 21, 2020 at 12:18:36PM -0800, Yu-cheng Yu wrote:
> From: Fenghua Yu <fenghua.yu@intel.com>
> 
> XCNTXT_MASK is 'all supported xfeatures' before introducing supervisor
> xstates.  Rename it to SUPPORTED_XFEATURES_MASK_USER to make clear that
> these are user xstates.
> 
> XFEATURE_MASK_SUPERVISOR is replaced with the following:
> - SUPPORTED_XFEATURES_MASK_SUPERVISOR: Currently nothing.  ENQCMD and
>   Control-flow Enforcement Technology (CET) will be introduced in separate
>   series.
> - UNSUPPORTED_XFEATURES_MASK_SUPERVISOR: Currently only Processor Trace.
> - ALL_XFEATURES_MASK_SUPERVISOR: the combination of above.
> 
> Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
> Co-developed-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
> Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
> Reviewed-by: Dave Hansen <dave.hansen@linux.intel.com>
> Reviewed-by: Tony Luck <tony.luck@intel.com>
> ---
>  arch/x86/include/asm/fpu/xstate.h | 36 ++++++++++++++++++++-----------
>  arch/x86/kernel/fpu/init.c        |  3 ++-
>  arch/x86/kernel/fpu/xstate.c      | 26 +++++++++++-----------
>  3 files changed, 38 insertions(+), 27 deletions(-)
> 
> diff --git a/arch/x86/include/asm/fpu/xstate.h b/arch/x86/include/asm/fpu/xstate.h
> index c6136d79f8c0..014c386deaa3 100644
> --- a/arch/x86/include/asm/fpu/xstate.h
> +++ b/arch/x86/include/asm/fpu/xstate.h
> @@ -21,19 +21,29 @@
>  #define XSAVE_YMM_SIZE	    256
>  #define XSAVE_YMM_OFFSET    (XSAVE_HDR_SIZE + XSAVE_HDR_OFFSET)
>  
> -/* Supervisor features */
> -#define XFEATURE_MASK_SUPERVISOR (XFEATURE_MASK_PT)
> -
> -/* All currently supported features */
> -#define XCNTXT_MASK		(XFEATURE_MASK_FP | \
> -				 XFEATURE_MASK_SSE | \
> -				 XFEATURE_MASK_YMM | \
> -				 XFEATURE_MASK_OPMASK | \
> -				 XFEATURE_MASK_ZMM_Hi256 | \
> -				 XFEATURE_MASK_Hi16_ZMM	 | \
> -				 XFEATURE_MASK_PKRU | \
> -				 XFEATURE_MASK_BNDREGS | \
> -				 XFEATURE_MASK_BNDCSR)
> +/* All currently supported user features */
> +#define SUPPORTED_XFEATURES_MASK_USER (XFEATURE_MASK_FP | \
> +				       XFEATURE_MASK_SSE | \
> +				       XFEATURE_MASK_YMM | \
> +				       XFEATURE_MASK_OPMASK | \
> +				       XFEATURE_MASK_ZMM_Hi256 | \
> +				       XFEATURE_MASK_Hi16_ZMM	 | \
> +				       XFEATURE_MASK_PKRU | \
> +				       XFEATURE_MASK_BNDREGS | \
> +				       XFEATURE_MASK_BNDCSR)
> +
> +/* All currently supported supervisor features */
> +#define SUPPORTED_XFEATURES_MASK_SUPERVISOR (0)
> +
> +/*
> + * Unsupported supervisor features. When a supervisor feature in this mask is
> + * supported in the future, move it to the supported supervisor feature mask.
> + */
> +#define UNSUPPORTED_XFEATURES_MASK_SUPERVISOR (XFEATURE_MASK_PT)
> +
> +/* All supervisor states including supported and unsupported states. */
> +#define ALL_XFEATURES_MASK_SUPERVISOR (SUPPORTED_XFEATURES_MASK_SUPERVISOR | \
> +				       UNSUPPORTED_XFEATURES_MASK_SUPERVISOR)

So frankly having the namespace prepended in those macros makes it more
readable to me: you know that those masks all belong together if you had
this:

XFEATURE_MASK_SUPERVISOR
XFEATURE_MASK_SUPERVISOR_SUPPORTED
XFEATURE_MASK_SUPERVISOR_UNSUPPORTED
XFEATURE_MASK_SUPERVISOR_ALL
XFEATURE_MASK_USER_SUPPORTED

Now they all begin with different words: "ALL", "UNSUPPORTED",
"SUPPORTED", ... and makes you go and look up the mask to make sure it
is the correct type of mask used.

Even more so if the single feature masks also start with
"XFEATURE_MASK_" so it is only logical to have them all start with
XFEATURE_MASK_ IMO.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
