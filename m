Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B6AFC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 11:55:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 42CA7207ED
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 11:55:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727034AbgERLzy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 07:55:54 -0400
Received: from foss.arm.com ([217.140.110.172]:39068 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726585AbgERLzx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 07:55:53 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7A57B11FB;
        Mon, 18 May 2020 04:55:52 -0700 (PDT)
Received: from C02TD0UTHF1T.local (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 068B03F774;
        Mon, 18 May 2020 04:55:49 -0700 (PDT)
Date:   Mon, 18 May 2020 12:55:47 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Will Deacon <will@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Sami Tolvanen <samitolvanen@google.com>,
        Kees Cook <keescook@chromium.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@am.com>,
        Jann Horn <jannh@google.com>, Ard Biesheuvel <ardb@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, kernel-team@android.com
Subject: Re: [PATCH 3/6] arm64: scs: Use 'scs_sp' register alias for x18
Message-ID: <20200518115547.GC1957@C02TD0UTHF1T.local>
References: <20200515172756.27185-1-will@kernel.org>
 <20200515172756.27185-4-will@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200515172756.27185-4-will@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 15, 2020 at 06:27:53PM +0100, Will Deacon wrote:
> x18 holds the SCS stack pointer value, so introduce a register alias to
> make this easier to read in assembly code.
> 
> Signed-off-by: Will Deacon <will@kernel.org>

I scanned through arm64 for all instances of x18, and it looks like
you've covered all the relevant uses here. In kvm we save/restore x18 a
bunch becasue it might be a platform register, but we do that
unconditionally and without knowledge of what it contains, so I think
that's fine to leave as-is. Therefore:

Reviewed-by: Mark Rutland <mark.rutland@arm.com>

As an aside, the comment in entry-ftrace.S is now stale where it says
that x18 is safe to clobber. I can send a patch to clean that up, unless
you want to do that yourself.

Mark.

> ---
>  arch/arm64/include/asm/scs.h |  6 ++++--
>  arch/arm64/kernel/entry.S    | 10 +++++-----
>  arch/arm64/kernel/head.S     |  2 +-
>  3 files changed, 10 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/scs.h b/arch/arm64/include/asm/scs.h
> index 6b8cf4352fe3..d46efdd2060a 100644
> --- a/arch/arm64/include/asm/scs.h
> +++ b/arch/arm64/include/asm/scs.h
> @@ -7,12 +7,14 @@
>  #include <asm/asm-offsets.h>
>  
>  #ifdef CONFIG_SHADOW_CALL_STACK
> +	scs_sp	.req	x18
> +
>  	.macro scs_load tsk, tmp
> -	ldr	x18, [\tsk, #TSK_TI_SCS_SP]
> +	ldr	scs_sp, [\tsk, #TSK_TI_SCS_SP]
>  	.endm
>  
>  	.macro scs_save tsk, tmp
> -	str	x18, [\tsk, #TSK_TI_SCS_SP]
> +	str	scs_sp, [\tsk, #TSK_TI_SCS_SP]
>  	.endm
>  #else
>  	.macro scs_load tsk, tmp
> diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
> index cb0516e6f963..741faf0706f1 100644
> --- a/arch/arm64/kernel/entry.S
> +++ b/arch/arm64/kernel/entry.S
> @@ -394,7 +394,7 @@ alternative_insn eret, nop, ARM64_UNMAP_KERNEL_AT_EL0
>  	.macro	irq_stack_entry
>  	mov	x19, sp			// preserve the original sp
>  #ifdef CONFIG_SHADOW_CALL_STACK
> -	mov	x24, x18		// preserve the original shadow stack
> +	mov	x24, scs_sp		// preserve the original shadow stack
>  #endif
>  
>  	/*
> @@ -416,7 +416,7 @@ alternative_insn eret, nop, ARM64_UNMAP_KERNEL_AT_EL0
>  
>  #ifdef CONFIG_SHADOW_CALL_STACK
>  	/* also switch to the irq shadow stack */
> -	adr_this_cpu x18, irq_shadow_call_stack, x26
> +	adr_this_cpu scs_sp, irq_shadow_call_stack, x26
>  #endif
>  
>  9998:
> @@ -430,7 +430,7 @@ alternative_insn eret, nop, ARM64_UNMAP_KERNEL_AT_EL0
>  	.macro	irq_stack_exit
>  	mov	sp, x19
>  #ifdef CONFIG_SHADOW_CALL_STACK
> -	mov	x18, x24
> +	mov	scs_sp, x24
>  #endif
>  	.endm
>  
> @@ -1071,9 +1071,9 @@ SYM_CODE_START(__sdei_asm_handler)
>  #ifdef CONFIG_SHADOW_CALL_STACK
>  	/* Use a separate shadow call stack for normal and critical events */
>  	cbnz	w4, 3f
> -	adr_this_cpu dst=x18, sym=sdei_shadow_call_stack_normal, tmp=x6
> +	adr_this_cpu dst=scs_sp, sym=sdei_shadow_call_stack_normal, tmp=x6
>  	b	4f
> -3:	adr_this_cpu dst=x18, sym=sdei_shadow_call_stack_critical, tmp=x6
> +3:	adr_this_cpu dst=scs_sp, sym=sdei_shadow_call_stack_critical, tmp=x6
>  4:
>  #endif
>  
> diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
> index 2b01c19c5483..1293baddfd20 100644
> --- a/arch/arm64/kernel/head.S
> +++ b/arch/arm64/kernel/head.S
> @@ -426,7 +426,7 @@ SYM_FUNC_START_LOCAL(__primary_switched)
>  	mov	x29, sp
>  
>  #ifdef CONFIG_SHADOW_CALL_STACK
> -	adr_l	x18, init_shadow_call_stack	// Set shadow call stack
> +	adr_l	scs_sp, init_shadow_call_stack	// Set shadow call stack
>  #endif
>  
>  	str_l	x21, __fdt_pointer, x5		// Save FDT pointer
> -- 
> 2.26.2.761.g0e0b3e54be-goog
> 
