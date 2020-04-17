Return-Path: <SRS0=3W8M=6B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B6CBC352BE
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 12:19:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 58ED821D94
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 12:19:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ny9oPoFH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728522AbgDQMTD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Apr 2020 08:19:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726542AbgDQMTC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Apr 2020 08:19:02 -0400
Received: from merlin.infradead.org (unknown [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7897AC061A0C
        for <linux-kernel@vger.kernel.org>; Fri, 17 Apr 2020 05:19:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=z8WYNLSbZciRz0DNkmJZhpt6azhxVA7OSFKtCuzjASM=; b=ny9oPoFHJgp7D58MG9kgrlmckJ
        rF9C4/kSpaahVX8GCyYICM2eggKnDI2/S6WDuvmnP676RZbwV2rYKGsxD8hnwvDzGKRx0Rl2r9CA4
        A5Z6UQzaYr4wOYnCOya2M3dYCnRoJgKczYIUrrm1vG91mijkBj+IUJ19820q0kyVEqjuuyeqbLfQO
        5Va3U1zC+XZOUjsaCV73HfFIBpR35ON69URc7aXd1aU517UYlrLZAMGFV387EDghgsvHIOUY5inHE
        fz0segvegBT/S3TgNCFsbhgL3AAMAhqHL/XxKbCh9o9OkCUETPn0MTmH25UwgsN0FAZ4QtooPXmqZ
        VUaZeIpw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jPPx1-0007fo-Ge; Fri, 17 Apr 2020 12:18:32 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 0A830304C22;
        Fri, 17 Apr 2020 14:18:29 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id E82542B1214B1; Fri, 17 Apr 2020 14:18:28 +0200 (CEST)
Date:   Fri, 17 Apr 2020 14:18:28 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH, RFC] x86/mm/pat: Restore large pages after fragmentation
Message-ID: <20200417121828.GB20730@hirez.programming.kicks-ass.net>
References: <20200416213229.19174-1-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200416213229.19174-1-kirill.shutemov@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 17, 2020 at 12:32:29AM +0300, Kirill A. Shutemov wrote:
> Change of attributes of the pages may lead to fragmentation of direct
> mapping over time and performance degradation as result.
> 
> With current code it's one way road: kernel tries to avoid splitting
> large pages, but it doesn't restore them back even if page attributes
> got compatible again.
> 
> Any change to the mapping may potentially allow to restore large page.
> 
> Hook up into cpa_flush() path to check if there's any pages to be
> recovered in PUD_SIZE range around pages we've just touched.

What does this do to the cost of the various set_memory_*() calls? ISTR
there were performance concerns at some point, graphics drivers doing
lots of it, or something like that.

> CPUs don't like[1] to have to have TLB entries of different size for the
> same memory, but looks like it's okay as long as these entries have
> matching attributes[2]. Therefore it's critical to flush TLB before any
> following changes to the mapping.
> 
> Note that we already allow for multiple TLB entries of different sizes
> for the same memory now in split_large_page() path. It's not a new
> situation.
> 
> set_memory_4k() provides a way to use 4k pages on purpose. Kernel must
> not remap such pages as large. Re-use one of software PTE bits to
> indicate such pages.
> 
> [1] See Erratum 383 of AMD Family 10h Processors
> [2] https://lore.kernel.org/linux-mm/1da1b025-cabc-6f04-bde5-e50830d1ecf0@amd.com/

Also, we can revert:

  7af0145067bc ("x86/mm/cpa: Prevent large page split when ftrace flips RW on kernel text")

now. ftrace no longer does crazy things like that.

> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> ---
>  arch/x86/include/asm/pgtable_types.h |   2 +
>  arch/x86/mm/pat/set_memory.c         | 191 ++++++++++++++++++++++++++-
>  2 files changed, 188 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/x86/include/asm/pgtable_types.h b/arch/x86/include/asm/pgtable_types.h
> index b6606fe6cfdf..11ed34804343 100644
> --- a/arch/x86/include/asm/pgtable_types.h
> +++ b/arch/x86/include/asm/pgtable_types.h
> @@ -34,6 +34,7 @@
>  #define _PAGE_BIT_CPA_TEST	_PAGE_BIT_SOFTW1
>  #define _PAGE_BIT_UFFD_WP	_PAGE_BIT_SOFTW2 /* userfaultfd wrprotected */
>  #define _PAGE_BIT_SOFT_DIRTY	_PAGE_BIT_SOFTW3 /* software dirty tracking */
> +#define _PAGE_BIT_KERNEL_4K	_PAGE_BIT_SOFTW3 /* page must not be converted to large */
>  #define _PAGE_BIT_DEVMAP	_PAGE_BIT_SOFTW4
>  
>  /* If _PAGE_BIT_PRESENT is clear, we use these: */
> @@ -56,6 +57,7 @@
>  #define _PAGE_PAT_LARGE (_AT(pteval_t, 1) << _PAGE_BIT_PAT_LARGE)
>  #define _PAGE_SPECIAL	(_AT(pteval_t, 1) << _PAGE_BIT_SPECIAL)
>  #define _PAGE_CPA_TEST	(_AT(pteval_t, 1) << _PAGE_BIT_CPA_TEST)
> +#define _PAGE_KERNEL_4K	(_AT(pteval_t, 1) << _PAGE_BIT_KERNEL_4K)
>  #ifdef CONFIG_X86_INTEL_MEMORY_PROTECTION_KEYS
>  #define _PAGE_PKEY_BIT0	(_AT(pteval_t, 1) << _PAGE_BIT_PKEY_BIT0)
>  #define _PAGE_PKEY_BIT1	(_AT(pteval_t, 1) << _PAGE_BIT_PKEY_BIT1)
> diff --git a/arch/x86/mm/pat/set_memory.c b/arch/x86/mm/pat/set_memory.c
> index 5414fabad1ae..7cb04a436d86 100644
> --- a/arch/x86/mm/pat/set_memory.c
> +++ b/arch/x86/mm/pat/set_memory.c
> @@ -344,22 +344,56 @@ static void __cpa_flush_tlb(void *data)
>  		__flush_tlb_one_kernel(fix_addr(__cpa_addr(cpa, i)));
>  }
>  
> +static void restore_large_pages(unsigned long addr, struct list_head *pgtables);
> +
> +static void cpa_restore_large_pages(struct cpa_data *cpa,
> +		struct list_head *pgtables)

indent fail

> +{
> +	unsigned long start, addr, end;
> +	int i;
> +
> +	if (cpa->flags & CPA_PAGES_ARRAY) {
> +		for (i = 0; i < cpa->numpages; i++)
> +			restore_large_pages(__cpa_addr(cpa, i), pgtables);
> +		return;
> +	}
> +
> +	start = __cpa_addr(cpa, 0);
> +	end = start + PAGE_SIZE * cpa->numpages;
> +
> +	for (addr = start; addr >= start && addr < end; addr += PUD_SIZE)

we have within()

> +		restore_large_pages(addr, pgtables);
> +}
> +
>  static void cpa_flush(struct cpa_data *data, int cache)
>  {
> +	LIST_HEAD(pgtables);
> +	struct page *page, *tmp;

xmas fail

>  	struct cpa_data *cpa = data;
>  	unsigned int i;
>  
>  	BUG_ON(irqs_disabled() && !early_boot_irqs_disabled);
>  
> +	cpa_restore_large_pages(data, &pgtables);
> +
>  	if (cache && !static_cpu_has(X86_FEATURE_CLFLUSH)) {
>  		cpa_flush_all(cache);
> +		list_for_each_entry_safe(page, tmp, &pgtables, lru) {
> +			list_del(&page->lru);
> +			__free_page(page);
> +		}
>  		return;
>  	}
>  
> -	if (cpa->numpages <= tlb_single_page_flush_ceiling)
> -		on_each_cpu(__cpa_flush_tlb, cpa, 1);
> -	else
> +	if (cpa->numpages > tlb_single_page_flush_ceiling || !list_empty(&pgtables))
>  		flush_tlb_all();
> +	else
> +		on_each_cpu(__cpa_flush_tlb, cpa, 1);
> +
> +	list_for_each_entry_safe(page, tmp, &pgtables, lru) {
> +		list_del(&page->lru);
> +		__free_page(page);
> +	}
>  
>  	if (!cache)
>  		return;

That's a bit of a mess there, I'm thinking you can fix that with a goto.

> @@ -1075,6 +1109,153 @@ static int split_large_page(struct cpa_data *cpa, pte_t *kpte,
>  	return 0;
>  }
>  
> +static void restore_pmd_page(pmd_t *pmd, unsigned long addr,
> +		struct list_head *pgtables)

indent fail

> +{
> +	pgprot_t pgprot;
> +	pmd_t _pmd, old_pmd;
> +	pte_t *pte, first;
> +	int i = 0;

xmas failed again

> +
> +	pte = pte_offset_kernel(pmd, addr);
> +	first = *pte;
> +
> +	/* Make sure alignment is suitable */
> +	if (PFN_PHYS(pte_pfn(first)) & ~PMD_MASK)
> +		return;
> +
> +	/* The page is 4k intentionally */
> +	if (pte_flags(first) & _PAGE_KERNEL_4K)
> +		return;
> +
> +	/* Check that the rest of PTEs are compatible with the first one */
> +	for (i = 1, pte++; i < PTRS_PER_PTE; i++, pte++) {
> +		pte_t entry = *pte;
> +		if (!pte_present(entry))
> +			return;
> +		if (pte_flags(entry) != pte_flags(first))
> +			return;
> +		if (pte_pfn(entry) - pte_pfn(first) != i)

I think I'd perfer: pte_pfn(entry) != pte_pfn(first) + i

> +			return;
> +	}
> +
> +	old_pmd = *pmd;
> +
> +	/* Success: set up a large page */
> +	pgprot = pgprot_4k_2_large(pte_pgprot(first));
> +	pgprot_val(pgprot) |= _PAGE_PSE;
> +	_pmd = pfn_pmd(pte_pfn(first), pgprot);
> +	set_pmd(pmd, _pmd);
> +
> +	/* Queue the page table to be freed after TLB flush */
> +	list_add(&pmd_page(old_pmd)->lru, pgtables);
> +
> +	if (IS_ENABLED(CONFIG_X86_32) && !SHARED_KERNEL_PMD) {
> +		struct page *page;
> +
> +		/* Update all PGD tables to use the same large page */
> +		list_for_each_entry(page, &pgd_list, lru) {
> +			pgd_t *pgd = (pgd_t *)page_address(page) + pgd_index(addr);
> +			p4d_t *p4d = p4d_offset(pgd, addr);
> +			pud_t *pud = pud_offset(p4d, addr);
> +			pmd_t *pmd = pmd_offset(pud, addr);
> +			/* Something is wrong if entries doesn't match */
> +			if (WARN_ON(pmd_val(old_pmd) != pmd_val(*pmd)))
> +				continue;
> +			set_pmd(pmd, _pmd);
> +		}
> +	}
> +	pr_debug("2M restored at %#lx\n", addr);

While I appreciate it's usefulness while writing this, I do think we can
do without that print once we know it works.

> +}
> +
> +static void restore_pud_page(pud_t *pud, unsigned long addr,
> +		struct list_head *pgtables)

indent fail

> +{
> +	bool restore_pud = direct_gbpages;
> +	pmd_t *pmd, first;
> +	int i;
> +
> +	pmd = pmd_offset(pud, addr);
> +	first = *pmd;
> +
> +	/* Try to restore large page if possible */
> +	if (pmd_present(first) && !pmd_large(first)) {
> +		restore_pmd_page(pmd, addr, pgtables);
> +		first = *pmd;
> +	}
> +
> +	/*
> +	 * To restore PUD page all PMD entries must be large and
> +	 * have suitable alignment
> +	 */
> +	if (!pmd_large(first) || (PFN_PHYS(pmd_pfn(first)) & ~PUD_MASK))
> +		restore_pud = false;
> +
> +	/*
> +	 * Restore all PMD large pages when possible and track if we can
> +	 * restore PUD page.
> +	 *
> +	 * To restore PUD page, all following PMDs must be compatible with the
> +	 * first one.
> +	 */
> +	for (i = 1, pmd++, addr += PMD_SIZE; i < PTRS_PER_PMD; i++, pmd++, addr += PMD_SIZE) {
> +		pmd_t entry = *pmd;
> +		if (!pmd_present(entry)) {
> +			restore_pud = false;
> +			continue;
> +		}
> +		if (!pmd_large(entry)) {
> +			restore_pmd_page(pmd, addr, pgtables);
> +			entry = *pmd;
> +		}
> +		if (!pmd_large(entry))
> +			restore_pud = false;
> +		if (pmd_flags(entry) != pmd_flags(first))
> +			restore_pud = false;
> +		if (pmd_pfn(entry) - pmd_pfn(first) != i * PTRS_PER_PTE)

idem as above.

> +			restore_pud = false;
> +	}
> +
> +	/* Restore PUD page and queue page table to be freed after TLB flush */
> +	if (restore_pud) {
> +		list_add(&pud_page(*pud)->lru, pgtables);
> +		set_pud(pud, pfn_pud(pmd_pfn(first), pmd_pgprot(first)));
> +		pr_debug("1G restored at %#lx\n", addr - PUD_SIZE);
> +	}
> +}
> +
> +/*
> + * Restore PMD and PUD pages in the kernel mapping around the address where
> + * possible.
> + *
> + * Caller must flush TLB and free page tables queued on the list before
> + * touching the new entries. CPU must not see TLB entries of different size
> + * with different attributes.
> + */
> +static void restore_large_pages(unsigned long addr, struct list_head *pgtables)
> +{
> +	pgd_t *pgd;
> +	p4d_t *p4d;
> +	pud_t *pud;
> +
> +	addr &= PUD_MASK;
> +
> +	spin_lock(&pgd_lock);
> +	pgd = pgd_offset_k(addr);
> +	if (pgd_none(*pgd))
> +		goto out;
> +	p4d = p4d_offset(pgd, addr);
> +	if (p4d_none(*p4d))
> +		goto out;
> +	pud = pud_offset(p4d, addr);
> +	if (!pud_present(*pud) || pud_large(*pud))
> +		goto out;
> +
> +	restore_pud_page(pud, addr, pgtables);
> +out:
> +	spin_unlock(&pgd_lock);
> +}

I find this odd, at best. AFAICT this does not attempt to reconstruct a
PMD around @addr when possible. When the first PMD of the PUD can't be
reconstructed, we give up entirely.

Why not something like:

static void restore_large_pages(unsigned long addr, struct list_head *pgtables)
{
	pgd_t *pgd;
	p4d_t *p4d;
	pud_t *pud;
	pmd_t *pmd;

	spin_lock(&pgd_lock);
	pgd = pgd_offset_k(addr);
	if (pgd_none(*pgd))
		goto out;

	p4d = p4d_offset(pgd, addr);
	if (p4d_none(*p4d))
		goto out;

	pud = pud_offset(p4d, addr);
	if (!pud_present(*pud) || pud_large(*pud))
		goto out;

	pmd = pmd_offset(pud, addr);
	if (pmd_present(*pmd) && !pmd_large(*pmd)) {
		if (!restore_pmd_page(pmd, addr & PMD_MASK, pgtables))
			goto out;
	}
		
	restore_pud_page(pud, addr & PUD_MASK, pgtables);
out:
	spin_unlock(&pgd_lock);
}

That would also much simplify restore_pud_page(), it would not have to
call restore_pmd_page().

> +
>  static bool try_to_free_pte_page(pte_t *pte)
>  {
>  	int i;
> @@ -1948,8 +2129,8 @@ int set_memory_np_noalias(unsigned long addr, int numpages)
>  
>  int set_memory_4k(unsigned long addr, int numpages)
>  {
> -	return change_page_attr_set_clr(&addr, numpages, __pgprot(0),
> -					__pgprot(0), 1, 0, NULL);
> +	return change_page_attr_set_clr(&addr, numpages,
> +			__pgprot(_PAGE_KERNEL_4K), __pgprot(0), 1, 0, NULL);

indent fail

>  }
>  
>  int set_memory_nonglobal(unsigned long addr, int numpages)
> -- 
> 2.26.1
> 
