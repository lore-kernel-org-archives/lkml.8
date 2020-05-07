Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF86DC47257
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 16:22:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B5B02208D6
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 16:22:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728008AbgEGQWf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 12:22:35 -0400
Received: from foss.arm.com ([217.140.110.172]:35100 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726308AbgEGQWe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 12:22:34 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CB8011FB;
        Thu,  7 May 2020 09:22:33 -0700 (PDT)
Received: from [192.168.0.14] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 64DEE3F71F;
        Thu,  7 May 2020 09:22:31 -0700 (PDT)
Subject: Re: [PATCH v9 14/18] arm64: kexec: offset for relocation function
To:     Pavel Tatashin <pasha.tatashin@soleen.com>
References: <20200326032420.27220-1-pasha.tatashin@soleen.com>
 <20200326032420.27220-15-pasha.tatashin@soleen.com>
From:   James Morse <james.morse@arm.com>
Cc:     jmorris@namei.org, sashal@kernel.org, ebiederm@xmission.com,
        kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
        corbet@lwn.net, catalin.marinas@arm.com, will@kernel.org,
        linux-arm-kernel@lists.infradead.org, maz@kernel.org,
        vladimir.murzin@arm.com, matthias.bgg@gmail.com,
        bhsharma@redhat.com, linux-mm@kvack.org, mark.rutland@arm.com,
        steve.capper@arm.com, rfontana@redhat.com, tglx@linutronix.de,
        selindag@gmail.com
Message-ID: <2c23b35d-d4b7-904c-9516-5f317dd963c7@arm.com>
Date:   Thu, 7 May 2020 17:22:30 +0100
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200326032420.27220-15-pasha.tatashin@soleen.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pavel,

On 26/03/2020 03:24, Pavel Tatashin wrote:
> Soon, relocation function will share the same page with EL2 vectors.

The EL2 vectors would only be executed with the MMU off, so they don't need to be mapped
anywhere in particular. (this is something hibernate probably does sloppily).


> Add offset within this page to arm64_relocate_new_kernel, and also
> the total size of relocation code which will include both the function
> and the EL2 vectors.

See arch/arm64/kernel/vmlinux.lds.S and sections.h for an example of how the idmap,
hibernate and the non-KVM hyp code do this.

If we're going to change this, I'd prefer it be the same as the other users...


> diff --git a/arch/arm64/include/asm/kexec.h b/arch/arm64/include/asm/kexec.h
> index 990185744148..d944c2e289b2 100644
> --- a/arch/arm64/include/asm/kexec.h
> +++ b/arch/arm64/include/asm/kexec.h
> @@ -90,6 +90,13 @@ static inline void crash_prepare_suspend(void) {}
>  static inline void crash_post_resume(void) {}
>  #endif
>  
> +#if defined(CONFIG_KEXEC_CORE)
> +/* The beginning and size of relcation code to stage 2 kernel */
> +extern const unsigned long kexec_relocate_code_size;
> +extern const unsigned char kexec_relocate_code_start[];
> +extern const unsigned long kexec_kern_reloc_offset;
> +#endif

This makes these things visible globally ... but drops the arm64_ prefix!


> diff --git a/arch/arm64/kernel/relocate_kernel.S b/arch/arm64/kernel/relocate_kernel.S
> index 22ccdcb106d3..aa9f2b2cd77c 100644
> --- a/arch/arm64/kernel/relocate_kernel.S
> +++ b/arch/arm64/kernel/relocate_kernel.S
> @@ -14,6 +14,9 @@
>  #include <asm/page.h>
>  #include <asm/sysreg.h>
>  
> +.globl kexec_relocate_code_start
> +kexec_relocate_code_start:

Which of the fancy new asm-annotations should this be?



> @@ -86,13 +89,16 @@ ENTRY(arm64_relocate_new_kernel)
>  .ltorg
>  END(arm64_relocate_new_kernel)
>  
> -.Lcopy_end:
> +.Lkexec_relocate_code_end:
>  .org	KEXEC_CONTROL_PAGE_SIZE
>  .align 3	/* To keep the 64-bit values below naturally aligned. */

>  /*
> - * arm64_relocate_new_kernel_size - Number of bytes to copy to the
> + * kexec_relocate_code_size - Number of bytes to copy to the
>   * control_code_page.
>   */
> -.globl arm64_relocate_new_kernel_size
> -arm64_relocate_new_kernel_size:
> -	.quad	.Lcopy_end - arm64_relocate_new_kernel
> +.globl kexec_relocate_code_size
> +kexec_relocate_code_size:
> +	.quad	.Lkexec_relocate_code_end - kexec_relocate_code_start
> +.globl kexec_kern_reloc_offset
> +kexec_kern_reloc_offset:
> +	.quad	arm64_relocate_new_kernel - kexec_relocate_code_start
> 

Can't we calculate this from the start/end markers? These variables held in assembly
generated code is pretty manky.


Thanks,

James
