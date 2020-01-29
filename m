Return-Path: <SRS0=xNW4=3S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,URIBL_DBL_ABUSE_MALW,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC5F2C33CB2
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 12:18:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82F61207FD
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 12:18:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580300280;
	bh=djniQwpAmOkXiqKoYRepG4IzFpRTfrhyZnnTKzmOSYs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ohvHsMIOU0KHSYGBMj0dy9Ki5+uAwn/l8tJhDvnBrxgwRQGJp5KmmCRq7QIia65GS
	 iT/yVtU30S750psjFyNci0uQLdpB154H/1fEfTlpHf7mOayRnxcrriG3yL4INniWub
	 YtB+SecAkos3a1cyzEWY73Ngo7pzLCT4slkFR0/Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726824AbgA2MR7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jan 2020 07:17:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:59400 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726788AbgA2MR6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jan 2020 07:17:58 -0500
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 60B2E2071E;
        Wed, 29 Jan 2020 12:17:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580300277;
        bh=djniQwpAmOkXiqKoYRepG4IzFpRTfrhyZnnTKzmOSYs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=R7DckY2edL+G1YkQB/jXviAq1y7oMqWOu1VCCTYBH8mofjDZikpzgpKYKmKtiko9y
         1+nQQQPt9ucxk0Zd0K8zMzfhzTzKiNVQMfSS/RZTPfIfS9hzNCL+l5XkkdLQ6vnXqw
         5yduSf0orhMf4HyNk6SgTvu3MZbVoPkNfI89LLcU=
Date:   Wed, 29 Jan 2020 12:17:53 +0000
From:   Will Deacon <will@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/5] m68k,mm: Extend table allocator for multiple sizes
Message-ID: <20200129121752.GB31582@willie-the-truck>
References: <20200129103941.304769381@infradead.org>
 <20200129104345.491163937@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200129104345.491163937@infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 29, 2020 at 11:39:45AM +0100, Peter Zijlstra wrote:
> In addition to the PGD/PMD table size (128*4) add a PTE table size
> (64*4) to the table allocator. This completely removes the pte-table
> overhead compared to the old code, even for dense tables.
> 
> Notes:
> 
>  - the allocator gained __flush_page_to_ram(), since the old
>    page-based allocator had that.
> 
>  - the allocator gained a list_empty() check to deal with there not
>    being any pages at all.
> 
>  - the free mask is extended to cover more than the 8 bits required
>    for the (512 byte) PGD/PMD tables.
> 
>  - NR_PAGETABLE accounting is restored.
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>  arch/m68k/include/asm/motorola_pgalloc.h |   24 +++++-----
>  arch/m68k/mm/init.c                      |    6 +-
>  arch/m68k/mm/memory.c                    |   70 ++++++++++++++++++++-----------
>  3 files changed, 61 insertions(+), 39 deletions(-)
> 
> --- a/arch/m68k/include/asm/motorola_pgalloc.h
> +++ b/arch/m68k/include/asm/motorola_pgalloc.h
> @@ -5,61 +5,61 @@
>  #include <asm/tlb.h>
>  #include <asm/tlbflush.h>
>  
> -extern pmd_t *get_pointer_table(void);
> -extern int free_pointer_table(pmd_t *);
> +extern void *get_pointer_table(int type);

Could be prettier/obfuscated with an enum type?

> --- a/arch/m68k/mm/memory.c
> +++ b/arch/m68k/mm/memory.c
> @@ -27,24 +27,34 @@
>     arch/sparc/mm/srmmu.c ... */
>  
>  typedef struct list_head ptable_desc;
> -static LIST_HEAD(ptable_list);
> +
> +static struct list_head ptable_list[2] = {
> +	LIST_HEAD_INIT(ptable_list[0]),
> +	LIST_HEAD_INIT(ptable_list[1]),
> +};
>  
>  #define PD_PTABLE(page) ((ptable_desc *)&(virt_to_page(page)->lru))
>  #define PD_PAGE(ptable) (list_entry(ptable, struct page, lru))
> -#define PD_MARKBITS(dp) (*(unsigned char *)&PD_PAGE(dp)->index)
> +#define PD_MARKBITS(dp) (*(unsigned int *)&PD_PAGE(dp)->index)
> +
> +static const int ptable_shift[2] = {
> +	7+2, /* PGD, PMD */
> +	6+2, /* PTE */
> +};
>  
> -#define PTABLE_SIZE (PTRS_PER_PMD * sizeof(pmd_t))
> +#define ptable_size(type) (1U << ptable_shift[type])
> +#define ptable_mask(type) ((1U << (PAGE_SIZE / ptable_size(type))) - 1)
>  
> -void __init init_pointer_table(unsigned long ptable)
> +void __init init_pointer_table(unsigned long ptable, int type)
>  {
>  	ptable_desc *dp;
>  	unsigned long page = ptable & PAGE_MASK;
> -	unsigned char mask = 1 << ((ptable - page)/PTABLE_SIZE);
> +	unsigned int mask = 1U << ((ptable - page)/ptable_size(type));
>  
>  	dp = PD_PTABLE(page);
>  	if (!(PD_MARKBITS(dp) & mask)) {
> -		PD_MARKBITS(dp) = 0xff;
> -		list_add(dp, &ptable_list);
> +		PD_MARKBITS(dp) = ptable_mask(type);
> +		list_add(dp, &ptable_list[type]);
>  	}
>  
>  	PD_MARKBITS(dp) &= ~mask;
> @@ -57,12 +67,10 @@ void __init init_pointer_table(unsigned
>  	return;
>  }
>  
> -pmd_t *get_pointer_table (void)
> +void *get_pointer_table (int type)
>  {
> -	ptable_desc *dp = ptable_list.next;
> -	unsigned char mask = PD_MARKBITS (dp);
> -	unsigned char tmp;
> -	unsigned int off;
> +	ptable_desc *dp = ptable_list[type].next;
> +	unsigned int mask, tmp, off;

nit, but if you do:

	unsigned int mask = list_empty(&ptable_list[type]) ? 0 : PD_MARKBITS(dp);

then you can leave the existing mask logic as-is.

Will
