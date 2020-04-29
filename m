Return-Path: <SRS0=ObIu=6N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDA4FC83003
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 09:58:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9A9042082E
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 09:58:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726787AbgD2J63 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Apr 2020 05:58:29 -0400
Received: from foss.arm.com ([217.140.110.172]:36432 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726423AbgD2J62 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 05:58:28 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6C131C14;
        Wed, 29 Apr 2020 02:58:28 -0700 (PDT)
Received: from C02TD0UTHF1T.local (unknown [10.57.5.153])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5AEE43F73D;
        Wed, 29 Apr 2020 02:58:26 -0700 (PDT)
Date:   Wed, 29 Apr 2020 10:58:17 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-m68k@lists.linux-m68k.org
Subject: Re: [PATCH 4/7] arm64: Thread mm_struct throughout page table
 allocation
Message-ID: <20200429095817.GA28631@C02TD0UTHF1T.local>
References: <20200428194449.22615-1-willy@infradead.org>
 <20200428194449.22615-5-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200428194449.22615-5-willy@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Matthew,

On Tue, Apr 28, 2020 at 12:44:46PM -0700, Matthew Wilcox wrote:
> From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
> 
> An upcoming patch will pass mm_struct to the page table constructor.
> Make sure arm64 has the appropriate mm_struct at the point it needs to
> call the constructor.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

This generally looks good ot me. I was a little scared that we'd need to
update the EFI mapping code, but I see that already passes its mm into
create_pgd_mapping(), and everything else uses init_mm today.

One small comment below.

> ---
>  arch/arm64/mm/mmu.c | 89 ++++++++++++++++++++++-----------------------
>  1 file changed, 43 insertions(+), 46 deletions(-)
> 
> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
> index a374e4f51a62..69ecc83c3be0 100644
> --- a/arch/arm64/mm/mmu.c
> +++ b/arch/arm64/mm/mmu.c
> @@ -88,7 +88,9 @@ pgprot_t phys_mem_access_prot(struct file *file, unsigned long pfn,
>  }
>  EXPORT_SYMBOL(phys_mem_access_prot);
>  
> -static phys_addr_t __init early_pgtable_alloc(int shift)
> +typedef phys_addr_t (arm_pt_alloc_t)(int size, struct mm_struct *);

Sorry to bikeshed, but for consistency with the naming scheme used here
could we please call this 'pgtable_alloc_fn' ?

We generally use 'pgtable' here, and 'fn' makes it clearer that this is
a function pointer rather than data. The 'arm_' prefix is also a bit
unusual here, and I don't think we need it.

With that:

Reviewed-by: Mark Rutland <mark.rutland@arm.com>

Mark.

> @@ -333,11 +332,9 @@ static void alloc_init_pud(pgd_t *pgdp, unsigned long addr, unsigned long end,
>  	pud_clear_fixmap();
>  }
>  
> -static void __create_pgd_mapping(pgd_t *pgdir, phys_addr_t phys,
> -				 unsigned long virt, phys_addr_t size,
> -				 pgprot_t prot,
> -				 phys_addr_t (*pgtable_alloc)(int),
> -				 int flags)
> +static void __create_pgd_mapping(struct mm_struct *mm, pgd_t *pgdir,
> +		phys_addr_t phys, unsigned long virt, phys_addr_t size,
> +		pgprot_t prot, arm_pt_alloc_t pgtable_alloc, int flags)
>  {
>  	unsigned long addr, end, next;
>  	pgd_t *pgdp = pgd_offset_raw(pgdir, virt);
> @@ -355,13 +352,13 @@ static void __create_pgd_mapping(pgd_t *pgdir, phys_addr_t phys,
>  
>  	do {
>  		next = pgd_addr_end(addr, end);
> -		alloc_init_pud(pgdp, addr, next, phys, prot, pgtable_alloc,
> +		alloc_init_pud(mm, pgdp, addr, next, phys, prot, pgtable_alloc,
>  			       flags);
>  		phys += next - addr;
>  	} while (pgdp++, addr = next, addr != end);
>  }
>  
> -static phys_addr_t __pgd_pgtable_alloc(int shift)
> +static phys_addr_t __pgd_pgtable_alloc(int shift, struct mm_struct *mm)
>  {
>  	void *ptr = (void *)__get_free_page(GFP_PGTABLE_KERNEL);
>  	BUG_ON(!ptr);
> @@ -371,9 +368,9 @@ static phys_addr_t __pgd_pgtable_alloc(int shift)
>  	return __pa(ptr);
>  }
>  
> -static phys_addr_t pgd_pgtable_alloc(int shift)
> +static phys_addr_t pgd_pgtable_alloc(int shift, struct mm_struct *mm)
>  {
> -	phys_addr_t pa = __pgd_pgtable_alloc(shift);
> +	phys_addr_t pa = __pgd_pgtable_alloc(shift, mm);
>  
>  	/*
>  	 * Call proper page table ctor in case later we need to
> @@ -404,8 +401,8 @@ static void __init create_mapping_noalloc(phys_addr_t phys, unsigned long virt,
>  			&phys, virt);
>  		return;
>  	}
> -	__create_pgd_mapping(init_mm.pgd, phys, virt, size, prot, NULL,
> -			     NO_CONT_MAPPINGS);
> +	__create_pgd_mapping(&init_mm, init_mm.pgd, phys, virt, size, prot,
> +			NULL, NO_CONT_MAPPINGS);
>  }
>  
>  void __init create_pgd_mapping(struct mm_struct *mm, phys_addr_t phys,
> @@ -419,7 +416,7 @@ void __init create_pgd_mapping(struct mm_struct *mm, phys_addr_t phys,
>  	if (page_mappings_only)
>  		flags = NO_BLOCK_MAPPINGS | NO_CONT_MAPPINGS;
>  
> -	__create_pgd_mapping(mm->pgd, phys, virt, size, prot,
> +	__create_pgd_mapping(mm, mm->pgd, phys, virt, size, prot,
>  			     pgd_pgtable_alloc, flags);
>  }
>  
> @@ -432,8 +429,8 @@ static void update_mapping_prot(phys_addr_t phys, unsigned long virt,
>  		return;
>  	}
>  
> -	__create_pgd_mapping(init_mm.pgd, phys, virt, size, prot, NULL,
> -			     NO_CONT_MAPPINGS);
> +	__create_pgd_mapping(&init_mm, init_mm.pgd, phys, virt, size, prot,
> +			NULL, NO_CONT_MAPPINGS);
>  
>  	/* flush the TLBs after updating live kernel mappings */
>  	flush_tlb_kernel_range(virt, virt + size);
> @@ -442,8 +439,8 @@ static void update_mapping_prot(phys_addr_t phys, unsigned long virt,
>  static void __init __map_memblock(pgd_t *pgdp, phys_addr_t start,
>  				  phys_addr_t end, pgprot_t prot, int flags)
>  {
> -	__create_pgd_mapping(pgdp, start, __phys_to_virt(start), end - start,
> -			     prot, early_pgtable_alloc, flags);
> +	__create_pgd_mapping(&init_mm, pgdp, start, __phys_to_virt(start),
> +			end - start, prot, early_pgtable_alloc, flags);
>  }
>  
>  void __init mark_linear_text_alias_ro(void)
> @@ -547,8 +544,8 @@ static void __init map_kernel_segment(pgd_t *pgdp, void *va_start, void *va_end,
>  	BUG_ON(!PAGE_ALIGNED(pa_start));
>  	BUG_ON(!PAGE_ALIGNED(size));
>  
> -	__create_pgd_mapping(pgdp, pa_start, (unsigned long)va_start, size, prot,
> -			     early_pgtable_alloc, flags);
> +	__create_pgd_mapping(&init_mm, pgdp, pa_start, (unsigned long)va_start,
> +			size, prot, early_pgtable_alloc, flags);
>  
>  	if (!(vm_flags & VM_NO_GUARD))
>  		size += PAGE_SIZE;
> @@ -591,8 +588,8 @@ static int __init map_entry_trampoline(void)
>  
>  	/* Map only the text into the trampoline page table */
>  	memset(tramp_pg_dir, 0, PGD_SIZE);
> -	__create_pgd_mapping(tramp_pg_dir, pa_start, TRAMP_VALIAS, PAGE_SIZE,
> -			     prot, __pgd_pgtable_alloc, 0);
> +	__create_pgd_mapping(&init_mm, tramp_pg_dir, pa_start, TRAMP_VALIAS,
> +			PAGE_SIZE, prot, __pgd_pgtable_alloc, 0);
>  
>  	/* Map both the text and data into the kernel page table */
>  	__set_fixmap(FIX_ENTRY_TRAMP_TEXT, pa_start, prot);
> @@ -1381,9 +1378,9 @@ int arch_add_memory(int nid, u64 start, u64 size,
>  	if (rodata_full || debug_pagealloc_enabled())
>  		flags = NO_BLOCK_MAPPINGS | NO_CONT_MAPPINGS;
>  
> -	__create_pgd_mapping(swapper_pg_dir, start, __phys_to_virt(start),
> -			     size, params->pgprot, __pgd_pgtable_alloc,
> -			     flags);
> +	__create_pgd_mapping(&init_mm, swapper_pg_dir, start,
> +			__phys_to_virt(start), size, params->pgprot,
> +			__pgd_pgtable_alloc, flags);
>  
>  	memblock_clear_nomap(start, size);
>  
> -- 
> 2.26.2
> 
