Return-Path: <SRS0=RI2K=4Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F748C3F2D2
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 22:34:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A76E24656
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 22:34:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726740AbgB1Wet (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Feb 2020 17:34:49 -0500
Received: from mga07.intel.com ([134.134.136.100]:45088 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725957AbgB1Wet (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Feb 2020 17:34:49 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Feb 2020 14:34:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,497,1574150400"; 
   d="scan'208";a="257263297"
Received: from iweiny-desk2.sc.intel.com ([10.3.52.157])
  by orsmga002.jf.intel.com with ESMTP; 28 Feb 2020 14:34:47 -0800
Date:   Fri, 28 Feb 2020 14:34:47 -0800
From:   Ira Weiny <ira.weiny@intel.com>
To:     Pingfan Liu <kernelfans@gmail.com>
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        John Hubbard <jhubbard@nvidia.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Keith Busch <keith.busch@intel.com>,
        Christoph Hellwig <hch@infradead.org>,
        Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCHv5 2/3] mm/gup: fix omission of check on FOLL_LONGTERM in
 gup fast path
Message-ID: <20200228223446.GA4658@iweiny-DESK2.sc.intel.com>
References: <1582889550-9101-1-git-send-email-kernelfans@gmail.com>
 <1582889550-9101-3-git-send-email-kernelfans@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1582889550-9101-3-git-send-email-kernelfans@gmail.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 28, 2020 at 07:32:29PM +0800, Pingfan Liu wrote:
> FOLL_LONGTERM suggests a pin which is going to be given to hardware and
> can't move. It would truncate CMA permanently and should be excluded.

I don't understand what is 'truncated' here?

I generally agree with Jason that this is going to be confusing to the user.

Ira

> 
> FOLL_LONGTERM has already been checked in the slow path, but not checked in
> the fast path, which means a possible leak of CMA page to longterm pinned
> requirement through this crack.
> 
> Place a check in try_get_compound_head() in the fast path.
> 
> Some note about the check:
> Huge page's subpages have the same migrate type due to either
> allocation from a free_list[] or alloc_contig_range() with param
> MIGRATE_MOVABLE. So it is enough to check on a single subpage
> by is_migrate_cma_page(subpage)
> 
> Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
> Cc: Ira Weiny <ira.weiny@intel.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Mike Rapoport <rppt@linux.ibm.com>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: Matthew Wilcox <willy@infradead.org>
> Cc: John Hubbard <jhubbard@nvidia.com>
> Cc: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
> Cc: Keith Busch <keith.busch@intel.com>
> Cc: Christoph Hellwig <hch@infradead.org>
> Cc: Shuah Khan <shuah@kernel.org>
> To: linux-mm@kvack.org
> Cc: linux-kernel@vger.kernel.org
> ---
>  mm/gup.c | 26 +++++++++++++++++++-------
>  1 file changed, 19 insertions(+), 7 deletions(-)
> 
> diff --git a/mm/gup.c b/mm/gup.c
> index cd8075e..f0d6804 100644
> --- a/mm/gup.c
> +++ b/mm/gup.c
> @@ -33,9 +33,21 @@ struct follow_page_context {
>   * Return the compound head page with ref appropriately incremented,
>   * or NULL if that failed.
>   */
> -static inline struct page *try_get_compound_head(struct page *page, int refs)
> +static inline struct page *try_get_compound_head(struct page *page, int refs,
> +	unsigned int flags)
>  {
> -	struct page *head = compound_head(page);
> +	struct page *head;
> +
> +	/*
> +	 * Huge page's subpages have the same migrate type due to either
> +	 * allocation from a free_list[] or alloc_contig_range() with param
> +	 * MIGRATE_MOVABLE. So it is enough to check on a single subpage.
> +	 */
> +	if (unlikely(flags & FOLL_LONGTERM) &&
> +		is_migrate_cma_page(page))
> +		return NULL;
> +
> +	head = compound_head(page);
>  
>  	if (WARN_ON_ONCE(page_ref_count(head) < 0))
>  		return NULL;
> @@ -1908,7 +1920,7 @@ static int gup_pte_range(pmd_t pmd, unsigned long addr, unsigned long end,
>  		VM_BUG_ON(!pfn_valid(pte_pfn(pte)));
>  		page = pte_page(pte);
>  
> -		head = try_get_compound_head(page, 1);
> +		head = try_get_compound_head(page, 1, flags);
>  		if (!head)
>  			goto pte_unmap;
>  
> @@ -2083,7 +2095,7 @@ static int gup_hugepte(pte_t *ptep, unsigned long sz, unsigned long addr,
>  	page = head + ((addr & (sz-1)) >> PAGE_SHIFT);
>  	refs = record_subpages(page, addr, end, pages + *nr);
>  
> -	head = try_get_compound_head(head, refs);
> +	head = try_get_compound_head(head, refs, flags);
>  	if (!head)
>  		return 0;
>  
> @@ -2142,7 +2154,7 @@ static int gup_huge_pmd(pmd_t orig, pmd_t *pmdp, unsigned long addr,
>  	page = pmd_page(orig) + ((addr & ~PMD_MASK) >> PAGE_SHIFT);
>  	refs = record_subpages(page, addr, end, pages + *nr);
>  
> -	head = try_get_compound_head(pmd_page(orig), refs);
> +	head = try_get_compound_head(pmd_page(orig), refs, flags);
>  	if (!head)
>  		return 0;
>  
> @@ -2174,7 +2186,7 @@ static int gup_huge_pud(pud_t orig, pud_t *pudp, unsigned long addr,
>  	page = pud_page(orig) + ((addr & ~PUD_MASK) >> PAGE_SHIFT);
>  	refs = record_subpages(page, addr, end, pages + *nr);
>  
> -	head = try_get_compound_head(pud_page(orig), refs);
> +	head = try_get_compound_head(pud_page(orig), refs, flags);
>  	if (!head)
>  		return 0;
>  
> @@ -2203,7 +2215,7 @@ static int gup_huge_pgd(pgd_t orig, pgd_t *pgdp, unsigned long addr,
>  	page = pgd_page(orig) + ((addr & ~PGDIR_MASK) >> PAGE_SHIFT);
>  	refs = record_subpages(page, addr, end, pages + *nr);
>  
> -	head = try_get_compound_head(pgd_page(orig), refs);
> +	head = try_get_compound_head(pgd_page(orig), refs, flags);
>  	if (!head)
>  		return 0;
>  
> -- 
> 2.7.5
> 
> 
