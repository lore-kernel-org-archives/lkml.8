Return-Path: <SRS0=8dav=5Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D247C2BA2B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 13:29:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DE402074F
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 13:29:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="s0lXNt5w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729163AbgDHN3u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Apr 2020 09:29:50 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:36439 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727049AbgDHN3t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Apr 2020 09:29:49 -0400
Received: by mail-lj1-f194.google.com with SMTP id b1so7653169ljp.3
        for <linux-kernel@vger.kernel.org>; Wed, 08 Apr 2020 06:29:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=+a+KJKLxTiLy61T642wkVgAExZQNV9YRYU5ggZvNNkw=;
        b=s0lXNt5wJUI6ElsuHm1pL6IGsQaGzq16SW7sPWVMYeue7eUikJUklhzyGAMJEPA5RR
         /E9Semkw39eZJAZbZDpPK+wpgMGbZwuTMtYmFfxJCsnbpe+hGAAI1i/IiRvCT24zJ5PF
         khCElZGPQYr4kcB42RjiJAWzFVZZ1YK40uA4kkNEWxXHovaZ+q5iNoN9eFcWgFVE0v2Y
         tM11kAeYKHfQ9G8f0ckutj0Oe8aVXkVGMwMWR5FlUgK96pnfq4CgGL//VsBAXBRNuOzu
         MXz6BiU/Zv2+PsWA+1i+gp85a/R+muCH7VlKgM/Mi3uFIILjLDTJmwA3BMDC6m6dgmLM
         nfdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+a+KJKLxTiLy61T642wkVgAExZQNV9YRYU5ggZvNNkw=;
        b=ZiYIJoRGcMz/nJarexZLVD8+/m4oUrfgEhNwDXQ9GJBQw9lRG4VTXQf7/l5y9P2Fe4
         BU6cbRhyKcIlq6QG0qFdjUoifIduD2WvJfxb8PZO49gkPlBFWCqGqBwrHADzvPuKVimR
         Grw7EzKwIsE1qGHCjNiI4Csg0gMjOk3N7S6Pfou/pXIf0zFBUOTkc/Gq2hPHUnTeO0xi
         oDz5z1F22K0JnOb9YjeSHaJ/6GNI53jVfVGXpx7F8eFkUXO862T1nuGdZ8Zb6QwjPHIb
         9eflGjfQxQcbHriitrJWshps7iYPGnu2ROKM38bZutLI8Egge4RylrcAtr3qTeL+KMpi
         ae/A==
X-Gm-Message-State: AGi0PuYa3JfUVfFVFf2AyW46Q5VIam7y0lk2hANNtN4/oqKoTQxftDRE
        xo1PlEWrwPslZWa9tMLLVexpUe6iKrY=
X-Google-Smtp-Source: APiQypIqQ4iAfPBrtr2fuadsLh8/meZtFI7YpCKPlTJXHUCo//xx7cjPCCEm4ouJKLc8D3G7sneMNQ==
X-Received: by 2002:a2e:8719:: with SMTP id m25mr5029959lji.76.1586352585406;
        Wed, 08 Apr 2020 06:29:45 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id k4sm14917472lfo.47.2020.04.08.06.29.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Apr 2020 06:29:44 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id 81508101C47; Wed,  8 Apr 2020 16:29:48 +0300 (+03)
Date:   Wed, 8 Apr 2020 16:29:48 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Yang Shi <yang.shi@linux.alibaba.com>
Cc:     akpm@linux-foundation.org, Andrea Arcangeli <aarcange@redhat.com>,
        Zi Yan <ziy@nvidia.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: Re: [PATCHv2 6/8] khugepaged: Allow to collapse PTE-mapped compound
 pages
Message-ID: <20200408132948.axaz3ytquoulaazp@box>
References: <20200403112928.19742-1-kirill.shutemov@linux.intel.com>
 <20200403112928.19742-7-kirill.shutemov@linux.intel.com>
 <10820b6f-f15a-1768-3aca-d0f464185b5e@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <10820b6f-f15a-1768-3aca-d0f464185b5e@linux.alibaba.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 06, 2020 at 02:29:35PM -0700, Yang Shi wrote:
> 
> 
> On 4/3/20 4:29 AM, Kirill A. Shutemov wrote:
> > We can collapse PTE-mapped compound pages. We only need to avoid
> > handling them more than once: lock/unlock page only once if it's present
> > in the PMD range multiple times as it handled on compound level. The
> > same goes for LRU isolation and putback.
> > 
> > Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> > ---
> >   mm/khugepaged.c | 103 ++++++++++++++++++++++++++++++++----------------
> >   1 file changed, 68 insertions(+), 35 deletions(-)
> > 
> > diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> > index 1e7e6543ebca..49e56e4e30d1 100644
> > --- a/mm/khugepaged.c
> > +++ b/mm/khugepaged.c
> > @@ -515,23 +515,37 @@ void __khugepaged_exit(struct mm_struct *mm)
> >   static void release_pte_page(struct page *page)
> >   {
> > -	dec_node_page_state(page, NR_ISOLATED_ANON + page_is_file_cache(page));
> > +	mod_node_page_state(page_pgdat(page),
> > +			NR_ISOLATED_ANON + page_is_file_cache(page),
> > +			-compound_nr(page));
> >   	unlock_page(page);
> >   	putback_lru_page(page);
> >   }
> > -static void release_pte_pages(pte_t *pte, pte_t *_pte)
> > +static void release_pte_pages(pte_t *pte, pte_t *_pte,
> > +		struct list_head *compound_pagelist)
> >   {
> > +	struct page *page, *tmp;
> > +
> >   	while (--_pte >= pte) {
> >   		pte_t pteval = *_pte;
> > -		if (!pte_none(pteval) && !is_zero_pfn(pte_pfn(pteval)))
> > -			release_pte_page(pte_page(pteval));
> > +
> > +		page = pte_page(pteval);
> > +		if (!pte_none(pteval) && !is_zero_pfn(pte_pfn(pteval)) &&
> > +				!PageCompound(page))
> > +			release_pte_page(page);
> > +	}
> > +
> > +	list_for_each_entry_safe(page, tmp, compound_pagelist, lru) {
> > +		list_del(&page->lru);
> > +		release_pte_page(page);
> >   	}
> >   }
> >   static int __collapse_huge_page_isolate(struct vm_area_struct *vma,
> >   					unsigned long address,
> > -					pte_t *pte)
> > +					pte_t *pte,
> > +					struct list_head *compound_pagelist)
> >   {
> >   	struct page *page = NULL;
> >   	pte_t *_pte;
> > @@ -561,13 +575,21 @@ static int __collapse_huge_page_isolate(struct vm_area_struct *vma,
> >   			goto out;
> >   		}
> > -		/* TODO: teach khugepaged to collapse THP mapped with pte */
> > +		VM_BUG_ON_PAGE(!PageAnon(page), page);
> > +
> >   		if (PageCompound(page)) {
> > -			result = SCAN_PAGE_COMPOUND;
> > -			goto out;
> > -		}
> > +			struct page *p;
> > +			page = compound_head(page);
> > -		VM_BUG_ON_PAGE(!PageAnon(page), page);
> > +			/*
> > +			 * Check if we have dealt with the compound page
> > +			 * already
> > +			 */
> > +			list_for_each_entry(p, compound_pagelist, lru) {
> > +				if (page == p)
> > +					goto next;
> > +			}
> > +		}
> >   		/*
> >   		 * We can do it before isolate_lru_page because the
> > @@ -597,19 +619,15 @@ static int __collapse_huge_page_isolate(struct vm_area_struct *vma,
> >   			result = SCAN_PAGE_COUNT;
> >   			goto out;
> >   		}
> > -		if (pte_write(pteval)) {
> > -			writable = true;
> > -		} else {
> > -			if (PageSwapCache(page) &&
> > -			    !reuse_swap_page(page, NULL)) {
> > -				unlock_page(page);
> > -				result = SCAN_SWAP_CACHE_PAGE;
> > -				goto out;
> > -			}
> > +		if (!pte_write(pteval) && PageSwapCache(page) &&
> > +				!reuse_swap_page(page, NULL)) {
> >   			/*
> > -			 * Page is not in the swap cache. It can be collapsed
> > -			 * into a THP.
> > +			 * Page is in the swap cache and cannot be re-used.
> > +			 * It cannot be collapsed into a THP.
> >   			 */
> > +			unlock_page(page);
> > +			result = SCAN_SWAP_CACHE_PAGE;
> > +			goto out;
> >   		}
> >   		/*
> > @@ -621,16 +639,23 @@ static int __collapse_huge_page_isolate(struct vm_area_struct *vma,
> >   			result = SCAN_DEL_PAGE_LRU;
> >   			goto out;
> >   		}
> > -		inc_node_page_state(page,
> > -				NR_ISOLATED_ANON + page_is_file_cache(page));
> > +		mod_node_page_state(page_pgdat(page),
> > +				NR_ISOLATED_ANON + page_is_file_cache(page),
> > +				compound_nr(page));
> >   		VM_BUG_ON_PAGE(!PageLocked(page), page);
> >   		VM_BUG_ON_PAGE(PageLRU(page), page);
> > +		if (PageCompound(page))
> > +			list_add_tail(&page->lru, compound_pagelist);
> > +next:
> >   		/* There should be enough young pte to collapse the page */
> >   		if (pte_young(pteval) ||
> >   		    page_is_young(page) || PageReferenced(page) ||
> >   		    mmu_notifier_test_young(vma->vm_mm, address))
> >   			referenced++;
> > +
> > +		if (pte_write(pteval))
> > +			writable = true;
> >   	}
> >   	if (likely(writable)) {
> >   		if (likely(referenced)) {
> > @@ -644,7 +669,7 @@ static int __collapse_huge_page_isolate(struct vm_area_struct *vma,
> >   	}
> >   out:
> > -	release_pte_pages(pte, _pte);
> > +	release_pte_pages(pte, _pte, compound_pagelist);
> >   	trace_mm_collapse_huge_page_isolate(page, none_or_zero,
> >   					    referenced, writable, result);
> >   	return 0;
> > @@ -653,13 +678,14 @@ static int __collapse_huge_page_isolate(struct vm_area_struct *vma,
> >   static void __collapse_huge_page_copy(pte_t *pte, struct page *page,
> >   				      struct vm_area_struct *vma,
> >   				      unsigned long address,
> > -				      spinlock_t *ptl)
> > +				      spinlock_t *ptl,
> > +				      struct list_head *compound_pagelist)
> >   {
> > +	struct page *src_page, *tmp;
> >   	pte_t *_pte;
> >   	for (_pte = pte; _pte < pte + HPAGE_PMD_NR;
> >   				_pte++, page++, address += PAGE_SIZE) {
> >   		pte_t pteval = *_pte;
> > -		struct page *src_page;
> >   		if (pte_none(pteval) || is_zero_pfn(pte_pfn(pteval))) {
> >   			clear_user_highpage(page, address);
> > @@ -679,7 +705,6 @@ static void __collapse_huge_page_copy(pte_t *pte, struct page *page,
> >   		} else {
> >   			src_page = pte_page(pteval);
> >   			copy_user_highpage(page, src_page, address, vma);
> > -			release_pte_page(src_page);
> >   			/*
> >   			 * ptl mostly unnecessary, but preempt has to
> >   			 * be disabled to update the per-cpu stats
> > @@ -693,9 +718,18 @@ static void __collapse_huge_page_copy(pte_t *pte, struct page *page,
> >   			pte_clear(vma->vm_mm, address, _pte);
> >   			page_remove_rmap(src_page, false);
> >   			spin_unlock(ptl);
> > -			free_page_and_swap_cache(src_page);
> > +			if (!PageCompound(src_page)) {
> > +				release_pte_page(src_page);
> > +				free_page_and_swap_cache(src_page);
> > +			}
> >   		}
> >   	}
> > +
> > +	list_for_each_entry_safe(src_page, tmp, compound_pagelist, lru) {
> > +		list_del(&src_page->lru);
> > +		release_pte_page(src_page);
> > +		free_page_and_swap_cache(src_page);
> > +	}
> 
> It looks this may mess up the PTE-mapped THP's refcount if it has multiple
> PTE-mapped subpages since put_page() is not called for every PTE-mapped
> subpages.

Good catch!

I *think* something like this should fix the issue (untested):

diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index bfb6155f1d69..9a96f9bff798 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -570,6 +570,7 @@ static void release_pte_pages(pte_t *pte, pte_t *_pte,
 	list_for_each_entry_safe(page, tmp, compound_pagelist, lru) {
 		list_del(&page->lru);
 		release_pte_page(page);
+		put_page(page);
 	}
 }
 
@@ -682,8 +683,10 @@ static int __collapse_huge_page_isolate(struct vm_area_struct *vma,
 		VM_BUG_ON_PAGE(!PageLocked(page), page);
 		VM_BUG_ON_PAGE(PageLRU(page), page);
 
-		if (PageCompound(page))
+		if (PageCompound(page)) {
 			list_add_tail(&page->lru, compound_pagelist);
+			get_page(page);
+		}
 next:
 		/* There should be enough young pte to collapse the page */
 		if (pte_young(pteval) ||
@@ -742,6 +745,8 @@ static void __collapse_huge_page_copy(pte_t *pte, struct page *page,
 		} else {
 			src_page = pte_page(pteval);
 			copy_user_highpage(page, src_page, address, vma);
+			if (!PageCompound(src_page))
+				release_pte_page(src_page);
 			/*
 			 * ptl mostly unnecessary, but preempt has to
 			 * be disabled to update the per-cpu stats
@@ -755,10 +760,7 @@ static void __collapse_huge_page_copy(pte_t *pte, struct page *page,
 			pte_clear(vma->vm_mm, address, _pte);
 			page_remove_rmap(src_page, false);
 			spin_unlock(ptl);
-			if (!PageCompound(src_page)) {
-				release_pte_page(src_page);
-				free_page_and_swap_cache(src_page);
-			}
+			free_page_and_swap_cache(src_page);
 		}
 	}
 
-- 
 Kirill A. Shutemov
