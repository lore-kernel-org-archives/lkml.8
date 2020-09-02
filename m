Return-Path: <SRS0=728o=CL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C095C433E2
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 15:40:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 13F07207EA
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 15:40:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="YO7kP1OV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728160AbgIBPkn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Sep 2020 11:40:43 -0400
Received: from mail.skyhub.de ([5.9.137.197]:43942 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726526AbgIBPkY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 11:40:24 -0400
Received: from zn.tnic (p200300ec2f0d7a00acdede37bac547d6.dip0.t-ipconnect.de [IPv6:2003:ec:2f0d:7a00:acde:de37:bac5:47d6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 470581EC0246;
        Wed,  2 Sep 2020 17:40:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1599061221;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=J2ZtrCLLChAY/AVO02S7bV94bTES+irZ+l2Kh5Mnf50=;
        b=YO7kP1OV0x0zu4OiuDp2CMuP+xSsyUTCMPKm6cC1+d0SfXMjJQpJMFsHEhkhXjoj3eMbbi
        AMuf+zQuu1dSOS4828rhouHWMdZ7UVQ/hHGPI7BKMwarA9PvbZSXt2rE4rU/kaPifOELbA
        IcoHEJbe+CHKazqbLJ8Ghz20rgTeZFI=
Date:   Wed, 2 Sep 2020 17:40:18 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Feng Tang <feng.tang@intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Dave Hansen <dave.hansen@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] tools/x86: add kcpuid tool to show raw CPU features
Message-ID: <20200902154018.GA21537@zn.tnic>
References: <1598514543-90152-1-git-send-email-feng.tang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1598514543-90152-1-git-send-email-feng.tang@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 27, 2020 at 03:49:03PM +0800, Feng Tang wrote:
> output of the tool
> ------------------
> 
> 	CPUID leafs total: 28
> 
> 	cpu family	: 6
> 	model		: 13
> 	stepping	: 7

Yeah, this should dump model etc and those numbers should be in hex and
additionally in dec if people prefer them.

> 	CPU features
> 	------------
> 	 sse3
> 	 pclmlqdq
> 	 dtes64
> 	 mwait
> 	 ds_cpl
> 	 vmx
> 	 smx
> 	 eist
> 	 tm2
> 	 ssse3
> 	 cx16
> 	 pctxid
> 	 dca
> 	 sse4_1
> 	 sse4_2
> 	 x2apic
> 	 tsc_deadline_timer
> 	 aes
> 	 xsave
> 	 osxsave
> 	 avx
> 	 fpu
> 	 ...

I guess that's good for grepping. With a lot of leafs, leaf output
should probably be controlled by cmdline opts.

> [1] http://sr71.net/~dave/intel/stupid-cpuid.c
> 
> Originally-by: Borislav Petkov <bp@alien8.de>
> Suggested-by: Dave Hansen <dave.hansen@intel.com>
> Signed-off-by: Feng Tang <feng.tang@intel.com>
> ---
>  tools/arch/x86/tools/kcpuid/Makefile |  21 ++
>  tools/arch/x86/tools/kcpuid/kcpuid.c | 422 +++++++++++++++++++++++++++++++++++
>  2 files changed, 443 insertions(+)
>  create mode 100644 tools/arch/x86/tools/kcpuid/Makefile
>  create mode 100644 tools/arch/x86/tools/kcpuid/kcpuid.c

Let's drop the second "tools" from the path:

tools/arch/x86/kcpuid/Makefile
tools/arch/x86/kcpuid/kcpuid.c

> +struct reg_01_a {
> +	u32 stepping: 4;	/* bit 0 */
> +	u32 model: 4;
> +	u32 family: 4;
> +	u32 type: 2;
> +	u32 pad1: 2;
> +	u32 model_ext: 4;	/* bit 16 */
> +	u32 family_ext: 8;
> +};

Yeah, instead of defining a separate struct for each leaf I think it
would be smarter/better to have a text file in a machine parseable
format which defines your leafs.

When you need to add a new leaf, you simply extend the text file and the
tool parses it anew and has its all CPUID info uptodate. This way you
won't even have to recompile it. Adding new CPUID leafs would be adding new
lines to the file.

For example:

LEAF<num>,SUBLEAF<num>,[EAX,EBX,ECX,EDX]{[width]<Mnemonic>|<Long text>,...}

LEAF07,SUBLEAF00,EAX{[31:0]max_value|Max input value for supported subleafs}
LEAF07,SUBLEAF00,EBX{[0]FSGSBASE|RDFSBASE/RDGSBASE/WRFSBASE/WRGSBASE if 1.,
		     [1]TSC_ADJUST|IA32_TSC_ADJUST MSR is supported if 1.,
		     [2]SGX|Supports Intel® Software Guard Extensions (Intel® SGX Extensions) if 1.,
		     ...
}
LEAF07,SUBLEAF00,ECX{[0]PREFETCHWT1|(Intel® Xeon PhiTM only.),
		     [1]AVX512_VBMI|,
		     ...

This is just a dumb attempt but I hope it comes across where I'm getting
with this.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
