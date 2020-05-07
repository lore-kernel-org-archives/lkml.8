Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4706EC38A2A
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 16:22:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 20B972053B
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 16:22:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728028AbgEGQWl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 12:22:41 -0400
Received: from foss.arm.com ([217.140.110.172]:35134 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726470AbgEGQWk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 12:22:40 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6EF1B101E;
        Thu,  7 May 2020 09:22:40 -0700 (PDT)
Received: from [192.168.0.14] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B47893F71F;
        Thu,  7 May 2020 09:22:37 -0700 (PDT)
Subject: Re: [PATCH v9 16/18] arm64: kexec: configure trans_pgd page table for
 kexec
To:     Pavel Tatashin <pasha.tatashin@soleen.com>
References: <20200326032420.27220-1-pasha.tatashin@soleen.com>
 <20200326032420.27220-17-pasha.tatashin@soleen.com>
From:   James Morse <james.morse@arm.com>
Cc:     jmorris@namei.org, sashal@kernel.org, ebiederm@xmission.com,
        kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
        corbet@lwn.net, catalin.marinas@arm.com, will@kernel.org,
        linux-arm-kernel@lists.infradead.org, maz@kernel.org,
        vladimir.murzin@arm.com, matthias.bgg@gmail.com,
        bhsharma@redhat.com, linux-mm@kvack.org, mark.rutland@arm.com,
        steve.capper@arm.com, rfontana@redhat.com, tglx@linutronix.de,
        selindag@gmail.com
Message-ID: <5ed92d16-123c-8b79-0fc1-4cefdee65d5d@arm.com>
Date:   Thu, 7 May 2020 17:22:36 +0100
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200326032420.27220-17-pasha.tatashin@soleen.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pavel,

On 26/03/2020 03:24, Pavel Tatashin wrote:
> Configure a page table located in kexec-safe memory that has
> the following mappings:
> 
> 1. identity mapping for text of relocation function with executable
>    permission.
> 2. linear mappings for all source ranges
> 3. linear mappings for all destination ranges.

Its taken this long to work out your definition of linear here doesn't match the way the
rest of the arch code uses the term.

You are using the MMU to re-assemble the scattered kexec image in VA space, so that the
relocation code doesn't have to walk the list.

While its a cool trick, I don't think this is a good idea, it makes it much harder to
debug as we have a new definition for VA->PA, instead of re-using the kernels. We should
do the least surprising thing. The person debugging a problem's first assumptions should
be correct. Doing this means any debug information printed before kexec() is suddenly
useless for debugging a problem that occurs during relocation.

...

Let me hack together what I've been describing and we can discuss whether its simpler.
(most of next week is gone already though...)

(some Nits below)

> diff --git a/arch/arm64/include/asm/kexec.h b/arch/arm64/include/asm/kexec.h
> index 0f758fd51518..8f4332ac607a 100644
> --- a/arch/arm64/include/asm/kexec.h
> +++ b/arch/arm64/include/asm/kexec.h
> @@ -108,6 +108,12 @@ extern const unsigned long kexec_el2_vectors_offset;
>   * el2_vector	If present means that relocation routine will go to EL1
>   *		from EL2 to do the copy, and then back to EL2 to do the jump
>   *		to new world.
> + * trans_ttbr0	idmap for relocation function and its argument
> + * trans_ttbr1	linear map for source/destination addresses.
> + * trans_t0sz	t0sz for idmap page in trans_ttbr0

You should be able to load the TTBR0_EL1 (and corresponding TCR_EL1.T0SZ) before kicking
off the relocation code. There should be no need to pass it in to assembly.

For example, hibernate sets TTBR0_EL1 in create_safe_exec_page().


> + * src_addr	linear map for source pages.
> + * dst_addr	linear map for destination pages.
> + * copy_len	Number of bytes that need to be copied
>   */
>  struct kern_reloc_arg {
>  	phys_addr_t head;

> @@ -70,10 +71,90 @@ static void *kexec_page_alloc(void *arg)
>  	return page_address(page);
>  }
>  
> +/*
> + * Map source segments starting from src_va, and map destination
> + * segments starting from dst_va, and return size of copy in
> + * *copy_len argument.
> + * Relocation function essentially needs to do:
> + * memcpy(dst_va, src_va, copy_len);
> + */
> +static int map_segments(struct kimage *kimage, pgd_t *pgdp,
> +			struct trans_pgd_info *info,
> +			unsigned long src_va,
> +			unsigned long dst_va,
> +			unsigned long *copy_len)
> +{
> +	unsigned long *ptr = 0;
> +	unsigned long dest = 0;
> +	unsigned long len = 0;
> +	unsigned long entry, addr;
> +	int rc;
> +
> +	for (entry = kimage->head; !(entry & IND_DONE); entry = *ptr++) {
> +		addr = entry & PAGE_MASK;
> +
> +		switch (entry & IND_FLAGS) {
> +		case IND_DESTINATION:
> +			dest = addr;
> +			break;

So we hope to always find a destination first?


> +		case IND_INDIRECTION:
> +			ptr = __va(addr);
> +			if (rc)
> +				return rc;

Where does rc come from?

> +			break;

> +		case IND_SOURCE:
> +			rc = trans_pgd_map_page(info, pgdp, __va(addr),
> +						src_va, PAGE_KERNEL);
> +			if (rc)
> +				return rc;
> +			rc = trans_pgd_map_page(info, pgdp, __va(dest),
> +						dst_va, PAGE_KERNEL);
> +			if (rc)
> +				return rc;
> +			dest += PAGE_SIZE;
> +			src_va += PAGE_SIZE;
> +			dst_va += PAGE_SIZE;
> +			len += PAGE_SIZE;
> +		}
> +	}
> +	*copy_len = len;
> +
> +	return 0;
> +}
> +
> @@ -89,9 +170,18 @@ int machine_kexec_post_load(struct kimage *kimage)
>  		kern_reloc_arg->el2_vector = __pa(reloc_code)
>  						+ kexec_el2_vectors_offset;
>  	}
> +
> +	/*
> +	 * If relocation is not needed, we do not need to enable MMU in

Strictly you aren't enabling it, but disabling it _after_ the relocation.


> +	 * relocation routine, therefore do not create page tables for
> +	 * scenarios such as crash kernel
> +	 */
> +	if (!(kimage->head & IND_DONE))
> +		rc = mmu_relocate_setup(kimage, reloc_code, kern_reloc_arg);
> +
>  	kexec_image_info(kimage);
>  
> -	return 0;
> +	return rc;
>  }


Thanks,

James
