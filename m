Return-Path: <SRS0=ObIu=6N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19615C83000
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 17:01:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F06E0214AF
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 17:01:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727104AbgD2RBI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Apr 2020 13:01:08 -0400
Received: from foss.arm.com ([217.140.110.172]:42362 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726635AbgD2RBH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 13:01:07 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D65C91045;
        Wed, 29 Apr 2020 10:01:06 -0700 (PDT)
Received: from [192.168.0.14] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CE83A3F73D;
        Wed, 29 Apr 2020 10:01:03 -0700 (PDT)
Subject: Re: [PATCH v9 03/18] arm64: trans_pgd: make trans_pgd_map_page
 generic
To:     Pavel Tatashin <pasha.tatashin@soleen.com>
References: <20200326032420.27220-1-pasha.tatashin@soleen.com>
 <20200326032420.27220-4-pasha.tatashin@soleen.com>
From:   James Morse <james.morse@arm.com>
Cc:     jmorris@namei.org, sashal@kernel.org, ebiederm@xmission.com,
        kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
        corbet@lwn.net, catalin.marinas@arm.com, will@kernel.org,
        linux-arm-kernel@lists.infradead.org, maz@kernel.org,
        vladimir.murzin@arm.com, matthias.bgg@gmail.com,
        bhsharma@redhat.com, linux-mm@kvack.org, mark.rutland@arm.com,
        steve.capper@arm.com, rfontana@redhat.com, tglx@linutronix.de,
        selindag@gmail.com
Message-ID: <c857d4aa-e8ec-81f6-bdea-dff6513c52dc@arm.com>
Date:   Wed, 29 Apr 2020 18:01:02 +0100
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200326032420.27220-4-pasha.tatashin@soleen.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pavel,

On 26/03/2020 03:24, Pavel Tatashin wrote:
> kexec is going to use a different allocator, so make

> trans_pgd_map_page to accept allocator as an argument, and also
> kexec is going to use a different map protection, so also pass
> it via argument.

This trans_pgd_map_page() used to be create_single_mapping() It creates page tables that
map one page: the relocation code.

Why do you need a different pgprot? Surely PAGE_KERNEL_EXEC is exactly what you want.


> diff --git a/arch/arm64/include/asm/trans_pgd.h b/arch/arm64/include/asm/trans_pgd.h
> index 23153c13d1ce..ad5194ad178d 100644
> --- a/arch/arm64/include/asm/trans_pgd.h
> +++ b/arch/arm64/include/asm/trans_pgd.h
> @@ -12,10 +12,24 @@
>  #include <linux/types.h>
>  #include <asm/pgtable-types.h>
>  
> +/*
> + * trans_alloc_page
> + *	- Allocator that should return exactly one zeroed page, if this
> + *	 allocator fails, trans_pgd returns -ENOMEM error.

trans_pgd is what you pass in to trans_pgd_map_page() or trans_pgd_create_copy().
Do you mean what those functions return?


> + *
> + * trans_alloc_arg
> + *	- Passed to trans_alloc_page as an argument
> + */

> diff --git a/arch/arm64/kernel/hibernate.c b/arch/arm64/kernel/hibernate.c
> index 3d6f0fd73591..607bb1fbc349 100644
> --- a/arch/arm64/kernel/hibernate.c
> +++ b/arch/arm64/kernel/hibernate.c
> @@ -195,6 +200,11 @@ static int create_safe_exec_page(void *src_start, size_t length,
>  				 unsigned long dst_addr,
>  				 phys_addr_t *phys_dst_addr)
>  {
> +	struct trans_pgd_info trans_info = {
> +		.trans_alloc_page	= hibernate_page_alloc,
> +		.trans_alloc_arg	= (void *)GFP_ATOMIC,
> +	};

As you need another copy of this in the next patch, is it worth declaring this globally
and making it const?


> diff --git a/arch/arm64/mm/trans_pgd.c b/arch/arm64/mm/trans_pgd.c
> index d20e48520cef..275a79935d7e 100644
> --- a/arch/arm64/mm/trans_pgd.c
> +++ b/arch/arm64/mm/trans_pgd.c
> @@ -180,8 +185,18 @@ int trans_pgd_create_copy(pgd_t **dst_pgdp, unsigned long start,
>  	return rc;
>  }
>  
> -int trans_pgd_map_page(pgd_t *trans_pgd, void *page, unsigned long dst_addr,
> -		       pgprot_t pgprot)
> +/*
> + * Add map entry to trans_pgd for a base-size page at PTE level.
> + * info:	contains allocator and its argument
> + * trans_pgd:	page table in which new map is added.
> + * page:	page to be mapped.

> + * dst_addr:	new VA address for the pages

~s/pages/page/

This thing only maps one page.


> + * pgprot:	protection for the page.
> + *
> + * Returns 0 on success, and -ENOMEM on failure.
> + */
> +int trans_pgd_map_page(struct trans_pgd_info *info, pgd_t *trans_pgd,
> +		       void *page, unsigned long dst_addr, pgprot_t pgprot)
>  {
>  	pgd_t *pgdp;
>  	pud_t *pudp;



Thanks,

James
