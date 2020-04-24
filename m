Return-Path: <SRS0=nwpL=6I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5582EC55186
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 09:22:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3AFFE20728
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 09:22:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726857AbgDXJWY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Apr 2020 05:22:24 -0400
Received: from foss.arm.com ([217.140.110.172]:58092 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726628AbgDXJWY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Apr 2020 05:22:24 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3843C1FB;
        Fri, 24 Apr 2020 02:22:23 -0700 (PDT)
Received: from C02TD0UTHF1T.local (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CECC03F73D;
        Fri, 24 Apr 2020 02:22:21 -0700 (PDT)
Date:   Fri, 24 Apr 2020 10:22:08 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Gavin Shan <gshan@redhat.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        catalin.marinas@arm.com, will@kernel.org, shan.gavin@gmail.com
Subject: Re: [PATCH] arm64/mm: Use phys_to_page() to access pgtable memory
Message-ID: <20200424092208.GA1167@C02TD0UTHF1T.local>
References: <20200424044854.15760-1-gshan@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200424044854.15760-1-gshan@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 24, 2020 at 02:48:54PM +1000, Gavin Shan wrote:
> The macros {pgd, pud, pmd}_page() retrieves the page struct of the
> corresponding page frame, which is reserved as page table. There
> is already a macro (phys_to_page), defined in memory.h, to convert
> the physical address to the page struct. So it's reasonable to
> use that in pgtable.h.
> 
> Signed-off-by: Gavin Shan <gshan@redhat.com>

It might be worth pointing out that phys_to_page() is defined as:

#define phys_to_page(phys)      (pfn_to_page(__phys_to_pfn(phys)))

... so this is obviously equivalent.

Given that, and given we already explicitly include <asm/memory.h>, this
looks like a nice cleanup to me.

With or without the commit message addition:

Reviewed-by: Mark Rutland <mark.rutland@arm.com>

Mark.

> ---
>  arch/arm64/include/asm/pgtable.h | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
> index 538c85e62f86..8c20e2bd6287 100644
> --- a/arch/arm64/include/asm/pgtable.h
> +++ b/arch/arm64/include/asm/pgtable.h
> @@ -508,7 +508,7 @@ static inline void pte_unmap(pte_t *pte) { }
>  #define pte_set_fixmap_offset(pmd, addr)	pte_set_fixmap(pte_offset_phys(pmd, addr))
>  #define pte_clear_fixmap()		clear_fixmap(FIX_PTE)
>  
> -#define pmd_page(pmd)		pfn_to_page(__phys_to_pfn(__pmd_to_phys(pmd)))
> +#define pmd_page(pmd)			phys_to_page(__pmd_to_phys(pmd))
>  
>  /* use ONLY for statically allocated translation tables */
>  #define pte_offset_kimg(dir,addr)	((pte_t *)__phys_to_kimg(pte_offset_phys((dir), (addr))))
> @@ -566,7 +566,7 @@ static inline phys_addr_t pud_page_paddr(pud_t pud)
>  #define pmd_set_fixmap_offset(pud, addr)	pmd_set_fixmap(pmd_offset_phys(pud, addr))
>  #define pmd_clear_fixmap()		clear_fixmap(FIX_PMD)
>  
> -#define pud_page(pud)		pfn_to_page(__phys_to_pfn(__pud_to_phys(pud)))
> +#define pud_page(pud)			phys_to_page(__pud_to_phys(pud))
>  
>  /* use ONLY for statically allocated translation tables */
>  #define pmd_offset_kimg(dir,addr)	((pmd_t *)__phys_to_kimg(pmd_offset_phys((dir), (addr))))
> @@ -624,7 +624,7 @@ static inline phys_addr_t pgd_page_paddr(pgd_t pgd)
>  #define pud_set_fixmap_offset(pgd, addr)	pud_set_fixmap(pud_offset_phys(pgd, addr))
>  #define pud_clear_fixmap()		clear_fixmap(FIX_PUD)
>  
> -#define pgd_page(pgd)		pfn_to_page(__phys_to_pfn(__pgd_to_phys(pgd)))
> +#define pgd_page(pgd)			phys_to_page(__pgd_to_phys(pgd))
>  
>  /* use ONLY for statically allocated translation tables */
>  #define pud_offset_kimg(dir,addr)	((pud_t *)__phys_to_kimg(pud_offset_phys((dir), (addr))))
> -- 
> 2.23.0
> 
