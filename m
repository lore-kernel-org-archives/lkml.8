Return-Path: <SRS0=9JlO=3L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEEF9C2D0DB
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 19:04:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9C2321835
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 19:04:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="AUZgPIjr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727453AbgAVTEM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jan 2020 14:04:12 -0500
Received: from mail.skyhub.de ([5.9.137.197]:52082 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725884AbgAVTEM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 14:04:12 -0500
Received: from zn.tnic (p200300EC2F0CAE00056060D90DED3C9A.dip0.t-ipconnect.de [IPv6:2003:ec:2f0c:ae00:560:60d9:ded:3c9a])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 359B21EC0AED;
        Wed, 22 Jan 2020 20:04:11 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1579719851;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=wKwYXnD4hrxTlq9fUkfhFcHJhlVAxIee9p3i/YwFeSk=;
        b=AUZgPIjreHuJZvMO3dGShI3gZrIEr/qaE/gcVowL161NVM+UYpM9aNwVZ3LnMxnfoYElIy
        51uxG0b3KQEaLX8Ta+XjrdWLC4O4qDO2Ce2S8Jii4nADP84rDpJRAM5uIeDNypzX/qfVJz
        Og/B4fGCwu4UR3A2wIW0buDLw2G+qcg=
Date:   Wed, 22 Jan 2020 20:04:05 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     "Luck, Tony" <tony.luck@intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Ingo Molnar <mingo@redhat.com>, H Peter Anvin <hpa@zytor.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>, x86 <x86@kernel.org>
Subject: Re: [PATCH v12] x86/split_lock: Enable split lock detection by kernel
Message-ID: <20200122190405.GA23947@zn.tnic>
References: <20191122105141.GY4114@hirez.programming.kicks-ass.net>
 <20191122152715.GA1909@hirez.programming.kicks-ass.net>
 <20191123003056.GA28761@agluck-desk2.amr.corp.intel.com>
 <20191125161348.GA12178@linux.intel.com>
 <20191212085948.GS2827@hirez.programming.kicks-ass.net>
 <20200110192409.GA23315@agluck-desk2.amr.corp.intel.com>
 <20200114055521.GI14928@linux.intel.com>
 <20200115222754.GA13804@agluck-desk2.amr.corp.intel.com>
 <20200115225724.GA18268@linux.intel.com>
 <20200122185514.GA16010@agluck-desk2.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200122185514.GA16010@agluck-desk2.amr.corp.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 22, 2020 at 10:55:14AM -0800, Luck, Tony wrote:
> diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
> index e9b62498fe75..c3edd2bba184 100644
> --- a/arch/x86/include/asm/cpufeatures.h
> +++ b/arch/x86/include/asm/cpufeatures.h
> @@ -220,6 +220,7 @@
>  #define X86_FEATURE_ZEN			( 7*32+28) /* "" CPU is AMD family 0x17 (Zen) */
>  #define X86_FEATURE_L1TF_PTEINV		( 7*32+29) /* "" L1TF workaround PTE inversion */
>  #define X86_FEATURE_IBRS_ENHANCED	( 7*32+30) /* Enhanced IBRS */
> +#define X86_FEATURE_SPLIT_LOCK_DETECT	( 7*32+31) /* #AC for split lock */

That word is already full in tip:

...
#define X86_FEATURE_MSR_IA32_FEAT_CTL   ( 7*32+31) /* "" MSR IA32_FEAT_CTL configured */

use word 11 instead.

> +#define MSR_TEST_CTRL				0x00000033
> +#define MSR_TEST_CTRL_SPLIT_LOCK_DETECT_BIT	29
> +#define MSR_TEST_CTRL_SPLIT_LOCK_DETECT		BIT(MSR_TEST_CTRL_SPLIT_LOCK_DETECT_BIT)
> +
>  #define MSR_IA32_SPEC_CTRL		0x00000048 /* Speculation Control */
>  #define SPEC_CTRL_IBRS			BIT(0)	   /* Indirect Branch Restricted Speculation */
>  #define SPEC_CTRL_STIBP_SHIFT		1	   /* Single Thread Indirect Branch Predictor (STIBP) bit */
> @@ -70,6 +74,10 @@
>   */
>  #define MSR_IA32_UMWAIT_CONTROL_TIME_MASK	(~0x03U)
>  
> +#define MSR_IA32_CORE_CAPABILITIES			  0x000000cf
> +#define MSR_IA32_CORE_CAPABILITIES_SPLIT_LOCK_DETECT_BIT  5
> +#define MSR_IA32_CORE_CAPABILITIES_SPLIT_LOCK_DETECT	  BIT(MSR_IA32_CORE_CAPABILITIES_SPLIT_LOCK_DETECT_BIT)

Any chance making those shorter?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
