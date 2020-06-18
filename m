Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3F8DC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 13:57:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ACF5720884
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 13:57:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592488670;
	bh=LnYEKbo5XLm8oVGmH1Jg4y8ZvUiouHun1liXREq5bac=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=ubpWg3PrWX9G0MErwRtEs8eGtjygLrHdlqVnM4xj8HrQ4j0QKjwSYAw16OiOChUx/
	 sy05UOH0/ilMYNUBaP3Ich7qRhUzxW+/kvEZurQHDMJtKJBEIAjidhi/uu6K7FBQO5
	 CaiLHyHZJaad0xYjZnF75awzClkIY3MTDnfc/dGM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729035AbgFRN5t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jun 2020 09:57:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:34766 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725987AbgFRN5s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 09:57:48 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C69B12082F;
        Thu, 18 Jun 2020 13:57:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592488667;
        bh=LnYEKbo5XLm8oVGmH1Jg4y8ZvUiouHun1liXREq5bac=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=BvEtPq7yWq1HoWLreLAPoRHu9zg2dv4gVjA+/sWolyzzhzCuYfusljrsDt7PCh1Rl
         8VzOVSWJVHPKOQf8ENECav3J03US/j4/DonegZKfy7eWRDwY3D9dWQ05qwLpA4LpOi
         HaPbrU2sScJRWJ14HAyMty8l/Dv/fn0Im1rhu9eQ=
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <maz@kernel.org>)
        id 1jlv34-004BYE-2D; Thu, 18 Jun 2020 14:57:46 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 18 Jun 2020 14:57:45 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     David Brazdil <dbrazdil@google.com>
Cc:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, android-kvm@google.com,
        kernel-team@android.com
Subject: Re: [PATCH v3 02/15] arm64: kvm: Move __smccc_workaround_1_smc to
 .rodata
In-Reply-To: <20200618122537.9625-3-dbrazdil@google.com>
References: <20200618122537.9625-1-dbrazdil@google.com>
 <20200618122537.9625-3-dbrazdil@google.com>
User-Agent: Roundcube Webmail/1.4.5
Message-ID: <02322fdac903aa1786c334d0ddd7f38a@kernel.org>
X-Sender: maz@kernel.org
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: dbrazdil@google.com, will@kernel.org, catalin.marinas@arm.com, james.morse@arm.com, julien.thierry.kdev@gmail.com, suzuki.poulose@arm.com, kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, android-kvm@google.com, kernel-team@android.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David,

On 2020-06-18 13:25, David Brazdil wrote:
> This snippet of assembly is used by cpu_errata.c to overwrite parts of 
> KVM hyp
> vector. Move it to its own source file and change its ELF section to 
> .rodata.
> 
> Signed-off-by: David Brazdil <dbrazdil@google.com>
> ---
>  arch/arm64/kvm/hyp/Makefile    |  1 +
>  arch/arm64/kvm/hyp/hyp-entry.S | 16 ----------------
>  arch/arm64/kvm/hyp/smccc_wa.S  | 30 ++++++++++++++++++++++++++++++
>  3 files changed, 31 insertions(+), 16 deletions(-)
>  create mode 100644 arch/arm64/kvm/hyp/smccc_wa.S
> 
> diff --git a/arch/arm64/kvm/hyp/Makefile b/arch/arm64/kvm/hyp/Makefile
> index 8c9880783839..5d8357ddc234 100644
> --- a/arch/arm64/kvm/hyp/Makefile
> +++ b/arch/arm64/kvm/hyp/Makefile
> @@ -7,6 +7,7 @@ ccflags-y += -fno-stack-protector 
> -DDISABLE_BRANCH_PROFILING \
>  		$(DISABLE_STACKLEAK_PLUGIN)
> 
>  obj-$(CONFIG_KVM) += hyp.o
> +obj-$(CONFIG_KVM_INDIRECT_VECTORS) += smccc_wa.o
> 
>  hyp-y := vgic-v3-sr.o timer-sr.o aarch32.o vgic-v2-cpuif-proxy.o 
> sysreg-sr.o \
>  	 debug-sr.o entry.o switch.o fpsimd.o tlb.o hyp-entry.o
> diff --git a/arch/arm64/kvm/hyp/hyp-entry.S 
> b/arch/arm64/kvm/hyp/hyp-entry.S
> index 9c5cfb04170e..d362fad97cc8 100644
> --- a/arch/arm64/kvm/hyp/hyp-entry.S
> +++ b/arch/arm64/kvm/hyp/hyp-entry.S
> @@ -318,20 +318,4 @@ SYM_CODE_START(__bp_harden_hyp_vecs)
>  1:	.org __bp_harden_hyp_vecs + __BP_HARDEN_HYP_VECS_SZ
>  	.org 1b
>  SYM_CODE_END(__bp_harden_hyp_vecs)
> -
> -	.popsection

I'd be tempted to leave the .popsection in place, if only for symmetry  
with the initial .pushsection.

> -
> -SYM_CODE_START(__smccc_workaround_1_smc)
> -	esb
> -	sub	sp, sp, #(8 * 4)
> -	stp	x2, x3, [sp, #(8 * 0)]
> -	stp	x0, x1, [sp, #(8 * 2)]
> -	mov	w0, #ARM_SMCCC_ARCH_WORKAROUND_1
> -	smc	#0
> -	ldp	x2, x3, [sp, #(8 * 0)]
> -	ldp	x0, x1, [sp, #(8 * 2)]
> -	add	sp, sp, #(8 * 4)
> -1:	.org __smccc_workaround_1_smc + __SMCCC_WORKAROUND_1_SMC_SZ
> -	.org 1b
> -SYM_CODE_END(__smccc_workaround_1_smc)
>  #endif
> diff --git a/arch/arm64/kvm/hyp/smccc_wa.S 
> b/arch/arm64/kvm/hyp/smccc_wa.S
> new file mode 100644
> index 000000000000..aa25b5428e77
> --- /dev/null
> +++ b/arch/arm64/kvm/hyp/smccc_wa.S
> @@ -0,0 +1,30 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Copyright (C) 2015-2018 - ARM Ltd
> + * Author: Marc Zyngier <marc.zyngier@arm.com>
> + */
> +
> +#include <linux/arm-smccc.h>
> +
> +#include <asm/kvm_asm.h>
> +#include <asm/kvm_mmu.h>
> +
> +	/*
> +	 * This is not executed directly and is instead copied into the 
> vectors
> +	 * by install_bp_hardening_cb().
> +	 */
> +	.data
> +	.pushsection	.rodata
> +	.global		__smccc_workaround_1_smc
> +__smccc_workaround_1_smc:

You probably want to replace this with SYM_DATA_START (and SYM_DATA_END 
at the end).

> +	esb
> +	sub	sp, sp, #(8 * 4)
> +	stp	x2, x3, [sp, #(8 * 0)]
> +	stp	x0, x1, [sp, #(8 * 2)]
> +	mov	w0, #ARM_SMCCC_ARCH_WORKAROUND_1
> +	smc	#0
> +	ldp	x2, x3, [sp, #(8 * 0)]
> +	ldp	x0, x1, [sp, #(8 * 2)]
> +	add	sp, sp, #(8 * 4)
> +1:	.org __smccc_workaround_1_smc + __SMCCC_WORKAROUND_1_SMC_SZ
> +	.org 1b

Otherwise, looks good.

Thanks,

         M.
-- 
Jazz is not dead. It just smells funny...
