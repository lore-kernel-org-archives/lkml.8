Return-Path: <SRS0=CVC0=7X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CB77C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 08:42:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DE50E20812
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 08:42:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591778554;
	bh=wjjPmI+WG54Mz1EL7HwR233NE+u8BMlzD5wxbDmEoOM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=fqzWckAsPmQNq1kzpaL+3bkFjzRDqYN/dV/UeYc/4InEdZXJqHR9y9DgrQkCCryZK
	 uP8Co1U4Wj27vl4q5/Em3agZWE11G5n+rooZOoiPm8A2Y6DSOzh1yNZ9Yw70zavnc2
	 32skvjhx7j1t0mLl0nNXRXHAEAMvGwNabwJh6Mm8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726874AbgFJImd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jun 2020 04:42:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:53442 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726424AbgFJIma (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 04:42:30 -0400
Received: from kernel.org (unknown [87.70.26.44])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CD9A320734;
        Wed, 10 Jun 2020 08:42:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591778550;
        bh=wjjPmI+WG54Mz1EL7HwR233NE+u8BMlzD5wxbDmEoOM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oIJl3PxAd6TD5nHzwj0UKLRZMXYmocYU4/TUG9EvAfB4xNNfdmxYRGV0shFVvn3Pk
         URWZzVLrf1BNkBqOD4VV3l4aP2i+WGka8F5JjZ7ztm7TgcoAaC8sYeVJSgWcFvTatG
         HPGyY4wcqKg3LD+WQrlEMnuJcnMtmBEjLG5R9qw0=
Date:   Wed, 10 Jun 2020 11:42:23 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Tony Luck <tony.luck@intel.com>, x86@kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Dave Hansen <dave.hansen@intel.com>, stable@vger.kernel.org
Subject: Re: [PATCHv2 2/2] x86/boot/KASLR: Fix boot with some memory above
 MAXMEM
Message-ID: <20200610084223.GE1151302@kernel.org>
References: <20200608125424.70198-1-kirill.shutemov@linux.intel.com>
 <20200608125424.70198-3-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200608125424.70198-3-kirill.shutemov@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 08, 2020 at 03:54:24PM +0300, Kirill A. Shutemov wrote:
> A 5-level paging capable machine can have memory above 46-bit in the
> physical address space. This memory is only addressable in the 5-level
> paging mode: we don't have enough virtual address space to create direct
> mapping for such memory in the 4-level paging mode
> 
> Teach KASLR to avoid memory regions above MAXMEM or truncate the region
> if the end is above MAXMEM.
> 
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Reviewed-by: Dave Hansen <dave.hansen@intel.com>
> Cc: stable@vger.kernel.org # v4.14

Reviewed-by: Mike Rapoport <rppt@linux.ibm.com>

> ---
>  arch/x86/boot/compressed/kaslr.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/arch/x86/boot/compressed/kaslr.c b/arch/x86/boot/compressed/kaslr.c
> index d7408af55738..99db18eeb40e 100644
> --- a/arch/x86/boot/compressed/kaslr.c
> +++ b/arch/x86/boot/compressed/kaslr.c
> @@ -695,7 +695,18 @@ static bool process_mem_region(struct mem_vector *region,
>  			       unsigned long long minimum,
>  			       unsigned long long image_size)
>  {
> +	unsigned long long end;
>  	int i;
> +
> +	/* Cannot access memory region above MAXMEM: skip it. */
> +	if (region->start >= MAXMEM)
> +		return 0;
> +
> +	/* Truncate the region if the end is above MAXMEM */
> +	end = region->start + region->size;
> +	end = min_t(unsigned long long, end, MAXMEM - 1);
> +	region->size = end - region->start;
> +
>  	/*
>  	 * If no immovable memory found, or MEMORY_HOTREMOVE disabled,
>  	 * use @region directly.
> -- 
> 2.26.2
> 
> 

-- 
Sincerely yours,
Mike.
