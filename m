Return-Path: <SRS0=ObIu=6N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55DABC83000
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 17:35:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2E5D1208FE
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 17:35:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588181711;
	bh=HCu4rd3iGFe31INEB+mn0hoOQeWn8CQzYZyDgXLQLoQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=ps3l1B/M6RlXdvzKx9TV9R+cfiQCC5blHfrVVgZeHZNfucrRhg1qgG9LGhRQBKHjJ
	 JvaQOUc+mPIkp0Fo1uVEgfbcYabSytVnwpoxm6xvxcydRHG2KXwWLa9g9w7aU9Se56
	 xp+/FuGYWo9zpBQT/Bcuy0I57tnWfBUwZw3371oc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726869AbgD2RfK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Apr 2020 13:35:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:48864 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726456AbgD2RfJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 13:35:09 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7B7B520757;
        Wed, 29 Apr 2020 17:35:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588181708;
        bh=HCu4rd3iGFe31INEB+mn0hoOQeWn8CQzYZyDgXLQLoQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Mbct03VHiVYz9/BwCDjssF+MlW4jv2b7iou5lYdSYCAiqKANc8LJzvh3woRim0zs8
         +MsGtan1eBFjRTw+3rbZWUE0ukpEXR8Y95G5tm1BNU2P4dMcNIeEjCVXRqpoz7g1mr
         aLSyzRRAChfojm9onMKIobgPbAEVFgHmgvjFVNYQ=
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <maz@kernel.org>)
        id 1jTqby-007mdk-PK; Wed, 29 Apr 2020 18:35:06 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 29 Apr 2020 18:35:06 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     Pavel Tatashin <pasha.tatashin@soleen.com>
Cc:     jmorris@namei.org, sashal@kernel.org, ebiederm@xmission.com,
        kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
        corbet@lwn.net, catalin.marinas@arm.com, will@kernel.org,
        linux-arm-kernel@lists.infradead.org, james.morse@arm.com,
        vladimir.murzin@arm.com, matthias.bgg@gmail.com,
        bhsharma@redhat.com, linux-mm@kvack.org, mark.rutland@arm.com,
        steve.capper@arm.com, rfontana@redhat.com, tglx@linutronix.de,
        selindag@gmail.com
Subject: Re: [PATCH v9 15/18] arm64: kexec: kexec EL2 vectors
In-Reply-To: <20200326032420.27220-16-pasha.tatashin@soleen.com>
References: <20200326032420.27220-1-pasha.tatashin@soleen.com>
 <20200326032420.27220-16-pasha.tatashin@soleen.com>
User-Agent: Roundcube Webmail/1.4.3
Message-ID: <e5f1ee17f8e4ac3a5f5077d85318e0ed@kernel.org>
X-Sender: maz@kernel.org
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: pasha.tatashin@soleen.com, jmorris@namei.org, sashal@kernel.org, ebiederm@xmission.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, corbet@lwn.net, catalin.marinas@arm.com, will@kernel.org, linux-arm-kernel@lists.infradead.org, james.morse@arm.com, vladimir.murzin@arm.com, matthias.bgg@gmail.com, bhsharma@redhat.com, linux-mm@kvack.org, mark.rutland@arm.com, steve.capper@arm.com, rfontana@redhat.com, tglx@linutronix.de, selindag@gmail.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-03-26 03:24, Pavel Tatashin wrote:
> If we have a EL2 mode without VHE, the EL2 vectors are needed in order
> to switch to EL2 and jump to new world with hyperivsor privileges.
> 
> Signed-off-by: Pavel Tatashin <pasha.tatashin@soleen.com>
> ---
>  arch/arm64/include/asm/kexec.h      |  5 +++++
>  arch/arm64/kernel/asm-offsets.c     |  1 +
>  arch/arm64/kernel/machine_kexec.c   |  5 +++++
>  arch/arm64/kernel/relocate_kernel.S | 35 +++++++++++++++++++++++++++++
>  4 files changed, 46 insertions(+)
> 
> diff --git a/arch/arm64/include/asm/kexec.h 
> b/arch/arm64/include/asm/kexec.h
> index d944c2e289b2..0f758fd51518 100644
> --- a/arch/arm64/include/asm/kexec.h
> +++ b/arch/arm64/include/asm/kexec.h
> @@ -95,6 +95,7 @@ static inline void crash_post_resume(void) {}
>  extern const unsigned long kexec_relocate_code_size;
>  extern const unsigned char kexec_relocate_code_start[];
>  extern const unsigned long kexec_kern_reloc_offset;
> +extern const unsigned long kexec_el2_vectors_offset;
>  #endif
> 
>  /*
> @@ -104,6 +105,9 @@ extern const unsigned long kexec_kern_reloc_offset;
>   *		kernel, or purgatory entry address).
>   * kern_arg0	first argument to kernel is its dtb address. The other
>   *		arguments are currently unused, and must be set to 0
> + * el2_vector	If present means that relocation routine will go to EL1
> + *		from EL2 to do the copy, and then back to EL2 to do the jump
> + *		to new world.
>   */
>  struct kern_reloc_arg {
>  	phys_addr_t head;
> @@ -112,6 +116,7 @@ struct kern_reloc_arg {
>  	phys_addr_t kern_arg1;
>  	phys_addr_t kern_arg2;
>  	phys_addr_t kern_arg3;
> +	phys_addr_t el2_vector;
>  };
> 
>  #define ARCH_HAS_KIMAGE_ARCH
> diff --git a/arch/arm64/kernel/asm-offsets.c 
> b/arch/arm64/kernel/asm-offsets.c
> index 448230684749..ff974b648347 100644
> --- a/arch/arm64/kernel/asm-offsets.c
> +++ b/arch/arm64/kernel/asm-offsets.c
> @@ -136,6 +136,7 @@ int main(void)
>    DEFINE(KEXEC_KRELOC_KERN_ARG1,	offsetof(struct kern_reloc_arg, 
> kern_arg1));
>    DEFINE(KEXEC_KRELOC_KERN_ARG2,	offsetof(struct kern_reloc_arg, 
> kern_arg2));
>    DEFINE(KEXEC_KRELOC_KERN_ARG3,	offsetof(struct kern_reloc_arg, 
> kern_arg3));
> +  DEFINE(KEXEC_KRELOC_EL2_VECTOR,	offsetof(struct kern_reloc_arg, 
> el2_vector));
>  #endif
>    return 0;
>  }
> diff --git a/arch/arm64/kernel/machine_kexec.c
> b/arch/arm64/kernel/machine_kexec.c
> index ab571fca9bd1..bd398def7627 100644
> --- a/arch/arm64/kernel/machine_kexec.c
> +++ b/arch/arm64/kernel/machine_kexec.c
> @@ -84,6 +84,11 @@ int machine_kexec_post_load(struct kimage *kimage)
>  	kern_reloc_arg->head = kimage->head;
>  	kern_reloc_arg->entry_addr = kimage->start;
>  	kern_reloc_arg->kern_arg0 = kimage->arch.dtb_mem;
> +	/* Setup vector table only when EL2 is available, but no VHE */
> +	if (is_hyp_mode_available() && !is_kernel_in_hyp_mode()) {
> +		kern_reloc_arg->el2_vector = __pa(reloc_code)
> +						+ kexec_el2_vectors_offset;
> +	}
>  	kexec_image_info(kimage);
> 
>  	return 0;
> diff --git a/arch/arm64/kernel/relocate_kernel.S
> b/arch/arm64/kernel/relocate_kernel.S
> index aa9f2b2cd77c..6fd2fc0ef373 100644
> --- a/arch/arm64/kernel/relocate_kernel.S
> +++ b/arch/arm64/kernel/relocate_kernel.S
> @@ -89,6 +89,38 @@ ENTRY(arm64_relocate_new_kernel)
>  .ltorg
>  END(arm64_relocate_new_kernel)
> 
> +.macro el1_sync_64
> +	br	x4			/* Jump to new world from el2 */
> +	.fill 31, 4, 0			/* Set other 31 instr to zeroes */
> +.endm

The common idiom to write this is to align the beginning of the
macro, and not to bother about what follows:

.macro whatever
         .align 7
         br      x4
.endm

Specially given that 0 is an undefined instruction, and I really hate to 
see
those in the actual text. On the contrary, .align generates NOPs.

> +
> +.macro invalid_vector label
> +\label:
> +	b \label
> +	.fill 31, 4, 0			/* Set other 31 instr to zeroes */
> +.endm
> +
> +/* el2 vectors - switch el2 here while we restore the memory image. */
> +	.align 11
> +ENTRY(kexec_el2_vectors)

Please see commit 617a2f392c92 ("arm64: kvm: Annotate assembly using 
modern
annoations"), and follow the same pattern.

> +	invalid_vector el2_sync_invalid_sp0	/* Synchronous EL2t */
> +	invalid_vector el2_irq_invalid_sp0	/* IRQ EL2t */
> +	invalid_vector el2_fiq_invalid_sp0	/* FIQ EL2t */
> +	invalid_vector el2_error_invalid_sp0	/* Error EL2t */
> +	invalid_vector el2_sync_invalid_spx	/* Synchronous EL2h */
> +	invalid_vector el2_irq_invalid_spx	/* IRQ EL2h */
> +	invalid_vector el2_fiq_invalid_spx	/* FIQ EL2h */
> +	invalid_vector el2_error_invalid_spx	/* Error EL2h */
> +		el1_sync_64			/* Synchronous 64-bit EL1 */
> +	invalid_vector el1_irq_invalid_64	/* IRQ 64-bit EL1 */
> +	invalid_vector el1_fiq_invalid_64	/* FIQ 64-bit EL1 */
> +	invalid_vector el1_error_invalid_64	/* Error 64-bit EL1 */
> +	invalid_vector el1_sync_invalid_32	/* Synchronous 32-bit EL1 */
> +	invalid_vector el1_irq_invalid_32	/* IRQ 32-bit EL1 */
> +	invalid_vector el1_fiq_invalid_32	/* FIQ 32-bit EL1 */
> +	invalid_vector el1_error_invalid_32	/* Error 32-bit EL1 */
> +END(kexec_el2_vectors)

Please write the vectors in 4 groups of 4, as this makes it a lot easier
to follow what is what.

> +
>  .Lkexec_relocate_code_end:
>  .org	KEXEC_CONTROL_PAGE_SIZE
>  .align 3	/* To keep the 64-bit values below naturally aligned. */
> @@ -102,3 +134,6 @@ kexec_relocate_code_size:
>  .globl kexec_kern_reloc_offset
>  kexec_kern_reloc_offset:
>  	.quad	arm64_relocate_new_kernel - kexec_relocate_code_start
> +.globl kexec_el2_vectors_offset
> +kexec_el2_vectors_offset:
> +	.quad	kexec_el2_vectors - kexec_relocate_code_start

Thanks,

         M.
-- 
Jazz is not dead. It just smells funny...
