Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFD08C47257
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 16:22:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D31B12084D
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 16:22:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727834AbgEGQWS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 12:22:18 -0400
Received: from foss.arm.com ([217.140.110.172]:35006 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726308AbgEGQWR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 12:22:17 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 09FB3101E;
        Thu,  7 May 2020 09:22:17 -0700 (PDT)
Received: from [192.168.0.14] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3C5BD3F71F;
        Thu,  7 May 2020 09:22:14 -0700 (PDT)
Subject: Re: [PATCH v9 11/18] arm64: kexec: arm64_relocate_new_kernel
 clean-ups
To:     Pavel Tatashin <pasha.tatashin@soleen.com>
References: <20200326032420.27220-1-pasha.tatashin@soleen.com>
 <20200326032420.27220-12-pasha.tatashin@soleen.com>
From:   James Morse <james.morse@arm.com>
Cc:     jmorris@namei.org, sashal@kernel.org, ebiederm@xmission.com,
        kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
        corbet@lwn.net, catalin.marinas@arm.com, will@kernel.org,
        linux-arm-kernel@lists.infradead.org, maz@kernel.org,
        vladimir.murzin@arm.com, matthias.bgg@gmail.com,
        bhsharma@redhat.com, linux-mm@kvack.org, mark.rutland@arm.com,
        steve.capper@arm.com, rfontana@redhat.com, tglx@linutronix.de,
        selindag@gmail.com
Message-ID: <dc47bee6-69ee-2ece-12d4-258bd964b954@arm.com>
Date:   Thu, 7 May 2020 17:22:13 +0100
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200326032420.27220-12-pasha.tatashin@soleen.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pavel,

On 26/03/2020 03:24, Pavel Tatashin wrote:
> Remove excessive empty lines from arm64_relocate_new_kernel.

To make it harder to read? Or just for the churn ...

> Also, use comments on the same lines with instructions where
> appropriate.

Churn,


> Change ENDPROC to END it never returns.

It might be more useful to convert this to the new style annotations, which should be a
separate patch. See Documentation/asm-annotations.rst


> copy_page(dest, src, tmps...)
> Increments dest and src by PAGE_SIZE, so no need to store dest
> prior to calling copy_page and increment it after. Also, src is not
> used after a copy, not need to copy either.

This bit sounds like cleanup, but I can't isolate it from the noise below....


> Call raw_dcache_line_size()  only when relocation is actually going to
> happen.

Why?

The pattern in this code is to setup register that don't change at the top, then do all
the work. I think this was an attempt to make it more readable.

Nothing branches back to that label, so this is fine, its just less obviously correct.


> Since '.align 3' is intended to align globals at the end of the file,
> move it there.


Please don't make noisy changes to whitespace and comments, its never worth it.


Thanks,

James


> diff --git a/arch/arm64/kernel/relocate_kernel.S b/arch/arm64/kernel/relocate_kernel.S
> index c1d7db71a726..e9c974ea4717 100644
> --- a/arch/arm64/kernel/relocate_kernel.S
> +++ b/arch/arm64/kernel/relocate_kernel.S
> @@ -8,7 +8,6 @@
>  
>  #include <linux/kexec.h>
>  #include <linux/linkage.h>
> -
>  #include <asm/assembler.h>
>  #include <asm/kexec.h>
>  #include <asm/page.h>
> @@ -17,25 +16,21 @@
>  /*
>   * arm64_relocate_new_kernel - Put a 2nd stage image in place and boot it.
>   *
> - * The memory that the old kernel occupies may be overwritten when coping the
> + * The memory that the old kernel occupies may be overwritten when copying the
>   * new image to its final location.  To assure that the
>   * arm64_relocate_new_kernel routine which does that copy is not overwritten,
>   * all code and data needed by arm64_relocate_new_kernel must be between the
>   * symbols arm64_relocate_new_kernel and arm64_relocate_new_kernel_end.  The
>   * machine_kexec() routine will copy arm64_relocate_new_kernel to the kexec
> - * control_code_page, a special page which has been set up to be preserved
> - * during the copy operation.
> + * safe memory that has been set up to be preserved during the copy operation.
>   */
>  ENTRY(arm64_relocate_new_kernel)
> -
>  	/* Setup the list loop variables. */
>  	mov	x18, x2				/* x18 = dtb address */
>  	mov	x17, x1				/* x17 = kimage_start */
>  	mov	x16, x0				/* x16 = kimage_head */
> -	raw_dcache_line_size x15, x0		/* x15 = dcache line size */
>  	mov	x14, xzr			/* x14 = entry ptr */
>  	mov	x13, xzr			/* x13 = copy dest */
> -
>  	/* Clear the sctlr_el2 flags. */
>  	mrs	x0, CurrentEL
>  	cmp	x0, #CurrentEL_EL2
> @@ -46,14 +41,11 @@ ENTRY(arm64_relocate_new_kernel)
>  	pre_disable_mmu_workaround
>  	msr	sctlr_el2, x0
>  	isb
> -1:
> -
> -	/* Check if the new image needs relocation. */
> +1:	/* Check if the new image needs relocation. */
>  	tbnz	x16, IND_DONE_BIT, .Ldone
> -
> +	raw_dcache_line_size x15, x1		/* x15 = dcache line size */
>  .Lloop:
>  	and	x12, x16, PAGE_MASK		/* x12 = addr */
> -
>  	/* Test the entry flags. */
>  .Ltest_source:
>  	tbz	x16, IND_SOURCE_BIT, .Ltest_indirection
> @@ -69,34 +61,18 @@ ENTRY(arm64_relocate_new_kernel)
>  	b.lo    2b
>  	dsb     sy
>  
> -	mov x20, x13
> -	mov x21, x12
> -	copy_page x20, x21, x0, x1, x2, x3, x4, x5, x6, x7
> -
> -	/* dest += PAGE_SIZE */
> -	add	x13, x13, PAGE_SIZE
> +	copy_page x13, x12, x0, x1, x2, x3, x4, x5, x6, x7
>  	b	.Lnext
> -
>  .Ltest_indirection:
>  	tbz	x16, IND_INDIRECTION_BIT, .Ltest_destination
> -
> -	/* ptr = addr */
> -	mov	x14, x12
> +	mov	x14, x12			/* ptr = addr */
>  	b	.Lnext
> -
>  .Ltest_destination:
>  	tbz	x16, IND_DESTINATION_BIT, .Lnext
> -
> -	/* dest = addr */
> -	mov	x13, x12
> -
> +	mov	x13, x12			/* dest = addr */
>  .Lnext:
> -	/* entry = *ptr++ */
> -	ldr	x16, [x14], #8
> -
> -	/* while (!(entry & DONE)) */
> -	tbz	x16, IND_DONE_BIT, .Lloop
> -
> +	ldr	x16, [x14], #8			/* entry = *ptr++ */
> +	tbz	x16, IND_DONE_BIT, .Lloop	/* while (!(entry & DONE)) */
>  .Ldone:
>  	/* wait for writes from copy_page to finish */
>  	dsb	nsh
> @@ -110,16 +86,12 @@ ENTRY(arm64_relocate_new_kernel)
>  	mov	x2, xzr
>  	mov	x3, xzr
>  	br	x17
> -
> -ENDPROC(arm64_relocate_new_kernel)
> -
>  .ltorg
> -
> -.align 3	/* To keep the 64-bit values below naturally aligned. */
> +END(arm64_relocate_new_kernel)
>  
>  .Lcopy_end:
>  .org	KEXEC_CONTROL_PAGE_SIZE
> -
> +.align 3	/* To keep the 64-bit values below naturally aligned. */
>  /*
>   * arm64_relocate_new_kernel_size - Number of bytes to copy to the
>   * control_code_page.
> 

