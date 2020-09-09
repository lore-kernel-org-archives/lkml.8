Return-Path: <SRS0=iZCi=CS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCE8BC43461
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 16:46:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6FBD02166E
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 16:46:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="HczSgJRS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730500AbgIIQqP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Sep 2020 12:46:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730484AbgIIQHz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 12:07:55 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71513C061365
        for <linux-kernel@vger.kernel.org>; Wed,  9 Sep 2020 07:09:10 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id u4so3689322ljd.10
        for <linux-kernel@vger.kernel.org>; Wed, 09 Sep 2020 07:09:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=0OuReL96pduvZef4YXnsjWurAzqpAupCoua2FW6WcPA=;
        b=HczSgJRSWKsoHnCRVSJDQrulRxxpJga+ElvTiLFUrM+VN57dSLfj5R6ZKfDF6pnpDL
         oIEbXTmC4Ez7iH0gMlkN6bhQcL/fNUoxa3JqI/OpWVSF8gU1jFMG7FRSzmCxuseEIAiC
         QTRnq+NrJ7Za+uwsVp/Vd7xp8zwUk2KetObqW8pXFbsyINe6xaxhz+aofAnu7mAlDa0k
         yX2MkDXt/R7Wypsh1t0bYVJpWqmt3q32niW9Dx4uxpIkFR8H6OBJq9FKK0jJb9Tl24G1
         RdzakE58p3pYMPnwKD3FjhIF2kuwUBhW3YfsHal52tRcJU1c9yK6NnHDLMmbCI7qXUK5
         AX0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=0OuReL96pduvZef4YXnsjWurAzqpAupCoua2FW6WcPA=;
        b=FaoXxQ/d3AnxqNWSqT7rU5ZAIx51LBh5Xjbxy6jXlI+irKt00P5HIS5mN1hVUR/Hie
         NpW+BxGI+eP7ua3LVaTMW1lYFA6X1q54Gktnan50bDz41QfKWyIJVe7QbPMIEzZgyqOQ
         XjqSE662xd3nJSCl8n8uHtDPv+vOmpxDgL3zZ9CD27hZhdBkHZfPZMyWyhFyVfQS5BfX
         IElWLuaUt47NcTK9LC4oNF3rJeiDRNy2TotKIhjiBNnjkGHlpYNNm459JgYG3U+yW+hp
         jkSgi0hRVGEIvobScXywerfRUovTlRhu0EIHYcTfio7fhwWwOdvkBfi1OsDEXWkKzlzS
         8coA==
X-Gm-Message-State: AOAM5306h3HKGlSW80bU+liPb5oFay9qkivZm2lDJCDICz3SgPsbMroL
        5KeNt5e5YkZXyQfQK7H8HbgXog==
X-Google-Smtp-Source: ABdhPJwJhR00C7Iv8G72Izb0RiDyA7tnnlhwxuhq3975Uu2CQDvGjFKQDNmjuz5c0WPJbkJbUkDkEw==
X-Received: by 2002:a2e:5357:: with SMTP id t23mr1897315ljd.31.1599660548782;
        Wed, 09 Sep 2020 07:09:08 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id t5sm760400ljg.111.2020.09.09.07.09.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2020 07:09:07 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id 19EB71036AE; Wed,  9 Sep 2020 17:09:12 +0300 (+03)
Date:   Wed, 9 Sep 2020 17:09:12 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Zi Yan <ziy@nvidia.com>
Cc:     linux-mm@kvack.org, Roman Gushchin <guro@fb.com>,
        Rik van Riel <riel@surriel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Shakeel Butt <shakeelb@google.com>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        David Nellans <dnellans@nvidia.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 05/16] mm: thp: handling 1GB THP reference bit.
Message-ID: <20200909140912.g2s4y22li2xwfttr@box>
References: <20200902180628.4052244-1-zi.yan@sent.com>
 <20200902180628.4052244-6-zi.yan@sent.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200902180628.4052244-6-zi.yan@sent.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 02, 2020 at 02:06:17PM -0400, Zi Yan wrote:
> From: Zi Yan <ziy@nvidia.com>
> 
> Add PUD-level TLB flush ops and teach page_vma_mapped_talk about 1GB
> THPs.
> 
> Signed-off-by: Zi Yan <ziy@nvidia.com>
> ---
>  arch/x86/include/asm/pgtable.h |  3 +++
>  arch/x86/mm/pgtable.c          | 13 +++++++++++++
>  include/linux/mmu_notifier.h   | 13 +++++++++++++
>  include/linux/pgtable.h        | 14 ++++++++++++++
>  include/linux/rmap.h           |  1 +
>  mm/page_vma_mapped.c           | 33 +++++++++++++++++++++++++++++----
>  mm/rmap.c                      | 12 +++++++++---
>  7 files changed, 82 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/x86/include/asm/pgtable.h b/arch/x86/include/asm/pgtable.h
> index 26255cac78c0..15334f5ba172 100644
> --- a/arch/x86/include/asm/pgtable.h
> +++ b/arch/x86/include/asm/pgtable.h
> @@ -1127,6 +1127,9 @@ extern int pudp_test_and_clear_young(struct vm_area_struct *vma,
>  extern int pmdp_clear_flush_young(struct vm_area_struct *vma,
>  				  unsigned long address, pmd_t *pmdp);
>  
> +#define __HAVE_ARCH_PUDP_CLEAR_YOUNG_FLUSH
> +extern int pudp_clear_flush_young(struct vm_area_struct *vma,
> +				  unsigned long address, pud_t *pudp);
>  
>  #define pmd_write pmd_write
>  static inline int pmd_write(pmd_t pmd)
> diff --git a/arch/x86/mm/pgtable.c b/arch/x86/mm/pgtable.c
> index 7be73aee6183..e4a2dffcc418 100644
> --- a/arch/x86/mm/pgtable.c
> +++ b/arch/x86/mm/pgtable.c
> @@ -633,6 +633,19 @@ int pmdp_clear_flush_young(struct vm_area_struct *vma,
>  
>  	return young;
>  }
> +int pudp_clear_flush_young(struct vm_area_struct *vma,
> +			   unsigned long address, pud_t *pudp)
> +{
> +	int young;
> +
> +	VM_BUG_ON(address & ~HPAGE_PUD_MASK);
> +
> +	young = pudp_test_and_clear_young(vma, address, pudp);
> +	if (young)
> +		flush_tlb_range(vma, address, address + HPAGE_PUD_SIZE);
> +
> +	return young;
> +}
>  #endif
>  
>  /**
> diff --git a/include/linux/mmu_notifier.h b/include/linux/mmu_notifier.h
> index b8200782dede..4ffa179e654f 100644
> --- a/include/linux/mmu_notifier.h
> +++ b/include/linux/mmu_notifier.h
> @@ -557,6 +557,19 @@ static inline void mmu_notifier_range_init_migrate(
>  	__young;							\
>  })
>  
> +#define pudp_clear_flush_young_notify(__vma, __address, __pudp)		\
> +({									\
> +	int __young;							\
> +	struct vm_area_struct *___vma = __vma;				\
> +	unsigned long ___address = __address;				\
> +	__young = pudp_clear_flush_young(___vma, ___address, __pudp);	\
> +	__young |= mmu_notifier_clear_flush_young(___vma->vm_mm,	\
> +						  ___address,		\
> +						  ___address +		\
> +							PUD_SIZE);	\
> +	__young;							\
> +})
> +
>  #define ptep_clear_young_notify(__vma, __address, __ptep)		\
>  ({									\
>  	int __young;							\
> diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
> index 255275d5b73e..8ef358c386af 100644
> --- a/include/linux/pgtable.h
> +++ b/include/linux/pgtable.h
> @@ -240,6 +240,20 @@ static inline int pmdp_clear_flush_young(struct vm_area_struct *vma,
>  #endif /* CONFIG_TRANSPARENT_HUGEPAGE */
>  #endif
>  
> +#ifndef __HAVE_ARCH_PUDP_CLEAR_YOUNG_FLUSH
> +#ifdef CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD
> +extern int pudp_clear_flush_young(struct vm_area_struct *vma,
> +				  unsigned long address, pud_t *pudp);
> +#else
> +int pudp_clear_flush_young(struct vm_area_struct *vma,
> +				  unsigned long address, pud_t *pudp)
> +{
> +	BUILD_BUG();
> +	return 0;
> +}
> +#endif /* CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD  */
> +#endif
> +
>  #ifndef __HAVE_ARCH_PTEP_GET_AND_CLEAR
>  static inline pte_t ptep_get_and_clear(struct mm_struct *mm,
>  				       unsigned long address,
> diff --git a/include/linux/rmap.h b/include/linux/rmap.h
> index 3a6adfa70fb0..0af61dd193d2 100644
> --- a/include/linux/rmap.h
> +++ b/include/linux/rmap.h
> @@ -206,6 +206,7 @@ struct page_vma_mapped_walk {
>  	struct page *page;
>  	struct vm_area_struct *vma;
>  	unsigned long address;
> +	pud_t *pud;
>  	pmd_t *pmd;
>  	pte_t *pte;
>  	spinlock_t *ptl;
> diff --git a/mm/page_vma_mapped.c b/mm/page_vma_mapped.c
> index 5e77b269c330..d9d39ec06e21 100644
> --- a/mm/page_vma_mapped.c
> +++ b/mm/page_vma_mapped.c
> @@ -145,9 +145,12 @@ bool page_vma_mapped_walk(struct page_vma_mapped_walk *pvmw)
>  	struct page *page = pvmw->page;
>  	pgd_t *pgd;
>  	p4d_t *p4d;
> -	pud_t *pud;
> +	pud_t pude;
>  	pmd_t pmde;
>  
> +	if (!pvmw->pte && !pvmw->pmd && pvmw->pud)
> +		return not_found(pvmw);
> +
>  	/* The only possible pmd mapping has been handled on last iteration */
>  	if (pvmw->pmd && !pvmw->pte)
>  		return not_found(pvmw);
> @@ -174,10 +177,31 @@ bool page_vma_mapped_walk(struct page_vma_mapped_walk *pvmw)
>  	p4d = p4d_offset(pgd, pvmw->address);
>  	if (!p4d_present(*p4d))
>  		return false;
> -	pud = pud_offset(p4d, pvmw->address);
> -	if (!pud_present(*pud))
> +	pvmw->pud = pud_offset(p4d, pvmw->address);
> +
> +	/*
> +	 * Make sure the pud value isn't cached in a register by the
> +	 * compiler and used as a stale value after we've observed a
> +	 * subsequent update.
> +	 */
> +	pude = READ_ONCE(*pvmw->pud);
> +	if (pud_trans_huge(pude)) {
> +		pvmw->ptl = pud_lock(mm, pvmw->pud);
> +		if (likely(pud_trans_huge(*pvmw->pud))) {
> +			if (pvmw->flags & PVMW_MIGRATION)
> +				return not_found(pvmw);
> +			if (pud_page(*pvmw->pud) != page)
> +				return not_found(pvmw);
> +			return true;
> +		} else {
> +			/* THP pud was split under us: handle on pmd level */
> +			spin_unlock(pvmw->ptl);
> +			pvmw->ptl = NULL;

Hm. What makes you sure the pmd table is established here?

I have not looked at PUD THP handling of  MADV_DONTNEED yet, but for PMD
THP can became pmd_none() at any point (unless ptl is locked).

> +		}
> +	} else if (!pud_present(pude))
>  		return false;
> -	pvmw->pmd = pmd_offset(pud, pvmw->address);
> +
> +	pvmw->pmd = pmd_offset(pvmw->pud, pvmw->address);
>  	/*
>  	 * Make sure the pmd value isn't cached in a register by the
>  	 * compiler and used as a stale value after we've observed a
> @@ -213,6 +237,7 @@ bool page_vma_mapped_walk(struct page_vma_mapped_walk *pvmw)
>  	} else if (!pmd_present(pmde)) {
>  		return false;
>  	}
> +
>  	if (!map_pte(pvmw))
>  		goto next_pte;
>  	while (1) {
> diff --git a/mm/rmap.c b/mm/rmap.c

Why?

> index 10195a2421cf..77cec0658b76 100644
> --- a/mm/rmap.c
> +++ b/mm/rmap.c
> @@ -803,9 +803,15 @@ static bool page_referenced_one(struct page *page, struct vm_area_struct *vma,
>  					referenced++;
>  			}
>  		} else if (IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE)) {
> -			if (pmdp_clear_flush_young_notify(vma, address,
> -						pvmw.pmd))
> -				referenced++;
> +			if (pvmw.pmd) {
> +				if (pmdp_clear_flush_young_notify(vma, address,
> +							pvmw.pmd))
> +					referenced++;
> +			} else if (pvmw.pud) {
> +				if (pudp_clear_flush_young_notify(vma, address,
> +							pvmw.pud))
> +					referenced++;
> +			}
>  		} else {
>  			/* unexpected pmd-mapped page? */
>  			WARN_ON_ONCE(1);
> -- 
> 2.28.0
> 
> 

-- 
 Kirill A. Shutemov
