Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 907C2C38A2A
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 16:22:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 760E02083B
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 16:22:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727964AbgEGQWW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 12:22:22 -0400
Received: from foss.arm.com ([217.140.110.172]:35042 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726308AbgEGQWV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 12:22:21 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 03F271045;
        Thu,  7 May 2020 09:22:21 -0700 (PDT)
Received: from [192.168.0.14] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 58EBD3F71F;
        Thu,  7 May 2020 09:22:18 -0700 (PDT)
Subject: Re: [PATCH v9 13/18] arm64: kexec: add expandable argument to
 relocation function
To:     Pavel Tatashin <pasha.tatashin@soleen.com>
References: <20200326032420.27220-1-pasha.tatashin@soleen.com>
 <20200326032420.27220-14-pasha.tatashin@soleen.com>
From:   James Morse <james.morse@arm.com>
Cc:     jmorris@namei.org, sashal@kernel.org, ebiederm@xmission.com,
        kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
        corbet@lwn.net, catalin.marinas@arm.com, will@kernel.org,
        linux-arm-kernel@lists.infradead.org, maz@kernel.org,
        vladimir.murzin@arm.com, matthias.bgg@gmail.com,
        bhsharma@redhat.com, linux-mm@kvack.org, mark.rutland@arm.com,
        steve.capper@arm.com, rfontana@redhat.com, tglx@linutronix.de,
        selindag@gmail.com
Message-ID: <012e19d9-97d6-805a-bfec-8c6e7104f852@arm.com>
Date:   Thu, 7 May 2020 17:22:17 +0100
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200326032420.27220-14-pasha.tatashin@soleen.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pavel,

On 26/03/2020 03:24, Pavel Tatashin wrote:
> Currently, kexec relocation function (arm64_relocate_new_kernel) accepts
> the following arguments:
> 
> head:		start of array that contains relocation information.
> entry:		entry point for new kernel or purgatory.
> dtb_mem:	first and only argument to entry.

> The number of arguments cannot be easily expended, because this
> function is also called from HVC_SOFT_RESTART, which preserves only
> three arguments. And, also arm64_relocate_new_kernel is written in
> assembly but called without stack, thus no place to move extra
> arguments to free registers.
> 
> Soon, we will need to pass more arguments: once we enable MMU we
> will need to pass information about page tables.


> Another benefit of allowing this function to accept more arguments, is that
> kernel can actually accept up to 4 arguments (x0-x3), however currently
> only one is used, but if in the future we will need for more (for example,
> pass information about when previous kernel exited to have a precise
> measurement in time spent in purgatory), we won't be easilty do that
> if arm64_relocate_new_kernel can't accept more arguments.

This is a niche debug hack.
We really don't want an ABI with purgatory. I think the register values it gets were added
early for compatibility with kexec_file_load().


> So, add a new struct: kern_reloc_arg, and place it in kexec safe page (i.e
> memory that is not overwritten during relocation).
> Thus, make arm64_relocate_new_kernel to only take one argument, that
> contains all the needed information.

Do we really not have enough registers?

The PCS[0] gives you 8 arguments. In this patch you use 6.


If this is really about the hyp-stub abi, please state that.


> diff --git a/arch/arm64/kernel/machine_kexec.c b/arch/arm64/kernel/machine_kexec.c
> index cee3be586384..b1122eea627e 100644
> --- a/arch/arm64/kernel/machine_kexec.c
> +++ b/arch/arm64/kernel/machine_kexec.c
> @@ -59,13 +60,35 @@ void machine_kexec_cleanup(struct kimage *kimage)

>  int machine_kexec_post_load(struct kimage *kimage)
>  {
>  	void *reloc_code = page_to_virt(kimage->control_code_page);
> +	struct kern_reloc_arg *kern_reloc_arg = kexec_page_alloc(kimage);
> +
> +	if (!kern_reloc_arg)
> +		return -ENOMEM;
>  
>  	memcpy(reloc_code, arm64_relocate_new_kernel,
>  	       arm64_relocate_new_kernel_size);
>  	kimage->arch.kern_reloc = __pa(reloc_code);
> +	kimage->arch.kern_reloc_arg = __pa(kern_reloc_arg);
> +	kern_reloc_arg->head = kimage->head;
> +	kern_reloc_arg->entry_addr = kimage->start;
> +	kern_reloc_arg->kern_arg0 = kimage->arch.dtb_mem;

These kern_reloc_arg values are written via the cacheable linear map.
They are read in arm64_relocate_new_kernel() where the MMU is disabled an all memory
access are non-cacheable.

To ensure you read the values you wrote, you must clean kern_reloc_arg to the PoC.


>  	kexec_image_info(kimage);
>  
>  	return 0;Thanks,

James

[0]
https://developer.arm.com/docs/ihi0055/d/procedure-call-standard-for-the-arm-64-bit-architecture
