Return-Path: <SRS0=4r1w=5T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C07AC43331
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 08:12:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 104E620B1F
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 08:12:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="OYmW4Y0q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390481AbgDCIMY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Apr 2020 04:12:24 -0400
Received: from mail.skyhub.de ([5.9.137.197]:34022 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727431AbgDCIMX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 04:12:23 -0400
Received: from zn.tnic (p200300EC2F0D8900AC3E2C93ADB62CA9.dip0.t-ipconnect.de [IPv6:2003:ec:2f0d:8900:ac3e:2c93:adb6:2ca9])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 343E11EC0C98;
        Fri,  3 Apr 2020 10:12:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1585901542;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=TF7RbyA03ZDQd/3oFgniRR6uVa1P565MmA4BmfaHjQc=;
        b=OYmW4Y0qrt+6jGQQw+ykjIKfkNaYoSbEdri+AioKUZvPXswbDB06UxTq9oUZu9p1/M5ix9
        oJ/gkH3IzbjThce/VPgt7F4udcWBS7umcLng3sp1gOiHo9pUEbbKlINUZABUYc08fQll8f
        aq0rwYG8f67iraZKe/GuiIjly8xGYY4=
Date:   Fri, 3 Apr 2020 10:12:17 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Ricardo Neri <ricardo.neri@intel.com>, x86@kernel.org,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>
Subject: Re: [PATCH] x86/cpufeatures: Add enumeration for serialize
 instruction
Message-ID: <20200403081217.GA20218@zn.tnic>
References: <20200403014026.19137-1-ricardo.neri-calderon@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200403014026.19137-1-ricardo.neri-calderon@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 02, 2020 at 06:40:26PM -0700, Ricardo Neri wrote:
> The serialize instruction ensures that before the next instruction is
> fetched and executed, all the modifications to flags, registers, and memory
> made by previous instructions are completed, draining all buffered writes
> to memory.
> 
> Importantly, the serialize instruction does not modify registers,
> arithmetic flags or memory.
> 
> Hence, the serialize instructions provides a better way for software
> to serialize execution than using instructions such as cpuid, which does
> modify registers and, in virtual machines, causes a VM exit.
> 
> This instruction is supported by the CPU if CPUID.7H.EDX[bit 14] is
> set.
> 
> Cc: x86@kernel.org
> Cc: "Ravi V. Shankar" <ravi.v.shankar@intel.com>
> Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
> ---
> This new instruction is documented in the latest version of the Intel
> Architecture Instruction Set Extensions and Future Features Programming
> Reference Chapter 2.1 located at
> https://software.intel.com/sites/default/files/managed/c5/15/architecture-instruction-set-extensions-programming-reference.pdf
> ---
>  arch/x86/include/asm/cpufeatures.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
> index db189945e9b0..cd9b1ec022ec 100644
> --- a/arch/x86/include/asm/cpufeatures.h
> +++ b/arch/x86/include/asm/cpufeatures.h
> @@ -364,6 +364,7 @@
>  #define X86_FEATURE_AVX512_VP2INTERSECT (18*32+ 8) /* AVX-512 Intersect for D/Q */
>  #define X86_FEATURE_MD_CLEAR		(18*32+10) /* VERW clears CPU buffers */
>  #define X86_FEATURE_TSX_FORCE_ABORT	(18*32+13) /* "" TSX_FORCE_ABORT */
> +#define X86_FEATURE_SERIALIZE		(18*32+14) /* SERIALIZE instruction */
>  #define X86_FEATURE_PCONFIG		(18*32+18) /* Intel PCONFIG */
>  #define X86_FEATURE_SPEC_CTRL		(18*32+26) /* "" Speculation Control (IBRS + IBPB) */
>  #define X86_FEATURE_INTEL_STIBP		(18*32+27) /* "" Single Thread Indirect Branch Predictors */
> -- 

Send this together with code which is using it, pls.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
