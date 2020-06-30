Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4447C433E2
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 10:09:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8CB3720771
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 10:09:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="GUqTDJ9K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732295AbgF3KJh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 06:09:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729259AbgF3KJf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 06:09:35 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 281D0C061755
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 03:09:35 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id g2so11027806lfb.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 03:09:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=qmWg/+jpbOxQ2F1Zn/eg6jJ0YSCVNYZ/cm+95B4TJCY=;
        b=GUqTDJ9KLKN9o+dp11x/jJH6eyI5mdjgZqCufGPzCAeE0W2ZtXNIeQrA52zabXMd9k
         aNihOto2tdj+oHp8IuRNwTIJqph1SNFhyi+1nC544G+9LLbmx1NVOiaNsJrmLBopA18/
         gc5lbnRDSEbwDgP73uE38AAmenOGm5QAT9c6XtiV+lDofflh/kMhCJKDFt+uO8qs4bfb
         jWt5sSOrcTsJQBMul/qSQSRhiOvOvZG+yRAwSqoghKCe8E2SSQL4MWjLlXM+klJePrYU
         75CIcj+94wTwNNY6ImSdHqXeOXKRjSsUlWewSuoBqDKfacM1gfhmoI4BzSzy6qtaPOZq
         +L0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=qmWg/+jpbOxQ2F1Zn/eg6jJ0YSCVNYZ/cm+95B4TJCY=;
        b=A4qfHJ3Rwh+UNZt2//Oc4kcDUfDfHcijJH+jHzervs98PD7CBOARsN1t6qlrCQaOjT
         4W7jh009k4jdIrN2WEbGSvdAzBzJkGw1ObmUoql2URLJGRAuw4ORyoH8igBFPrX4ZdeF
         zpFpPMQK3bCDKlilEK3aDZc4jvrU0dmAseHqcPNdpl/914Ry1wUSAW1f/RiBRHTi7PiW
         1PqcumoreDXD99brJteSdDJN9Mn6nIxn/oV9VeUEaL6aIBA3mYNGFRTPvUBXEy2BB7+R
         /CpQuGAUTOnOAX0d5nCrAH2UIAKJoAv28ZWng/CBtFU/3p0ngu/znhg2tgVPkuA0aqif
         OS7g==
X-Gm-Message-State: AOAM532Ba48EBM72ZcGEvqDIKJma3eCINxV7rLuJfVgyBO4fXOsIFxfB
        6Q//h7Qggm4plK/ykUz7ItsC5Q==
X-Google-Smtp-Source: ABdhPJySik5PUCHYPI0zhpnvXdET33Ycn7xwDFaHIxLodpL5XimXyR5OUblyqsatUY4l9OE3msdbwg==
X-Received: by 2002:ac2:5f04:: with SMTP id 4mr11471273lfq.140.1593511773581;
        Tue, 30 Jun 2020 03:09:33 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id f5sm657759ljc.99.2020.06.30.03.09.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2020 03:09:32 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id 5793D101187; Tue, 30 Jun 2020 13:09:40 +0300 (+03)
Date:   Tue, 30 Jun 2020 13:09:40 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Bibo Mao <maobibo@loongson.cn>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Paul Burton <paulburton@kernel.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Daniel Silsby <dansilsby@gmail.com>,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH 1/3] mm: set page fault address for update_mmu_cache_pmd
Message-ID: <20200630100940.wo5l5fcs44xhrqo7@box>
References: <1592990792-1923-1-git-send-email-maobibo@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1592990792-1923-1-git-send-email-maobibo@loongson.cn>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 24, 2020 at 05:26:30PM +0800, Bibo Mao wrote:
> update_mmu_cache_pmd is used to update tlb for the pmd entry by
> software. On MIPS system, the tlb entry indexed by page fault
> address maybe exists already, only that tlb entry may be small
> page, also it may be huge page. Before updating pmd entry with
> huge page size, older tlb entry need to be invalidated.
> 
> Here page fault address is passed to function update_mmu_cache_pmd,
> rather than pmd huge page start address. The page fault address
> can be used for invalidating older tlb entry.
> 
> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
> ---
>  arch/mips/include/asm/pgtable.h | 9 +++++++++
>  mm/huge_memory.c                | 7 ++++---
>  mm/memory.c                     | 2 +-
>  3 files changed, 14 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/mips/include/asm/pgtable.h b/arch/mips/include/asm/pgtable.h
> index dd7a0f5..bd81661 100644
> --- a/arch/mips/include/asm/pgtable.h
> +++ b/arch/mips/include/asm/pgtable.h
> @@ -554,11 +554,20 @@ static inline void update_mmu_cache(struct vm_area_struct *vma,
>  #define	__HAVE_ARCH_UPDATE_MMU_TLB
>  #define update_mmu_tlb	update_mmu_cache
>  
> +extern void local_flush_tlb_page(struct vm_area_struct *vma,
> +				unsigned long page);
>  static inline void update_mmu_cache_pmd(struct vm_area_struct *vma,
>  	unsigned long address, pmd_t *pmdp)
>  {
>  	pte_t pte = *(pte_t *)pmdp;
>  
> +	/*
> +	 * If pmd_none is true, older tlb entry will be normal page.
> +	 * here to invalidate older tlb entry indexed by address
> +	 * parameter address must be page fault address rather than
> +	 * start address of pmd huge page
> +	 */
> +	local_flush_tlb_page(vma, address);

Can't say I follow what is going on.

Why local? What happens on SMP?

And don't you want to flush PMD_SIZE range around the address?

>  	__update_tlb(vma, address, pte);
>  }
>  
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index 78c84be..0f9187b 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -780,6 +780,7 @@ static void insert_pfn_pmd(struct vm_area_struct *vma, unsigned long addr,
>  		pgtable_t pgtable)
>  {
>  	struct mm_struct *mm = vma->vm_mm;
> +	unsigned long start = addr & PMD_MASK;
>  	pmd_t entry;
>  	spinlock_t *ptl;
>  
> @@ -792,7 +793,7 @@ static void insert_pfn_pmd(struct vm_area_struct *vma, unsigned long addr,
>  			}
>  			entry = pmd_mkyoung(*pmd);
>  			entry = maybe_pmd_mkwrite(pmd_mkdirty(entry), vma);
> -			if (pmdp_set_access_flags(vma, addr, pmd, entry, 1))
> +			if (pmdp_set_access_flags(vma, start, pmd, entry, 1))
>  				update_mmu_cache_pmd(vma, addr, pmd);
>  		}
>  
> @@ -813,7 +814,7 @@ static void insert_pfn_pmd(struct vm_area_struct *vma, unsigned long addr,
>  		pgtable = NULL;
>  	}
>  
> -	set_pmd_at(mm, addr, pmd, entry);
> +	set_pmd_at(mm, start, pmd, entry);
>  	update_mmu_cache_pmd(vma, addr, pmd);
>  
>  out_unlock:
> @@ -864,7 +865,7 @@ vm_fault_t vmf_insert_pfn_pmd_prot(struct vm_fault *vmf, pfn_t pfn,
>  
>  	track_pfn_insert(vma, &pgprot, pfn);
>  
> -	insert_pfn_pmd(vma, addr, vmf->pmd, pfn, pgprot, write, pgtable);
> +	insert_pfn_pmd(vma, vmf->address, vmf->pmd, pfn, pgprot, write, pgtable);
>  	return VM_FAULT_NOPAGE;
>  }
>  EXPORT_SYMBOL_GPL(vmf_insert_pfn_pmd_prot);
> diff --git a/mm/memory.c b/mm/memory.c
> index dc7f354..c703458 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -3592,7 +3592,7 @@ static vm_fault_t do_set_pmd(struct vm_fault *vmf, struct page *page)
>  
>  	set_pmd_at(vma->vm_mm, haddr, vmf->pmd, entry);
>  
> -	update_mmu_cache_pmd(vma, haddr, vmf->pmd);
> +	update_mmu_cache_pmd(vma, vmf->address, vmf->pmd);
>  
>  	/* fault is handled */
>  	ret = 0;
> -- 
> 1.8.3.1
> 
> 

-- 
 Kirill A. Shutemov
