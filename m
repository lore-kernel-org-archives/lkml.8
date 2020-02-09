Return-Path: <SRS0=6uoK=35=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B669C35250
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Feb 2020 11:05:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4062207FF
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Feb 2020 11:05:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="Qw9UMzcj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727496AbgBILFU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Feb 2020 06:05:20 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:52363 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727131AbgBILFU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Feb 2020 06:05:20 -0500
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 48FmQz3zZBz9tySS;
        Sun,  9 Feb 2020 12:05:15 +0100 (CET)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=Qw9UMzcj; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id wdzNqoxRiBnb; Sun,  9 Feb 2020 12:05:15 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 48FmQz2cFXz9tySM;
        Sun,  9 Feb 2020 12:05:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1581246315; bh=mrAy96DdN5jD7Y6nw4oukJ3Td2B0N27N3fUyvkGcR60=;
        h=Subject:From:To:Cc:References:Date:In-Reply-To:From;
        b=Qw9UMzcjyyxy4mRIwfp34wbLghNhCY7IAmgM84CJKAIHl+a616gDp4QVTZtWcupqB
         /LSSf5r7VCTuGKnyEAO4B1IgHSorac19FQ8ehwZmqEU6pO+qZhPj13ept1QhY1PW6g
         GVsRqLJws4DT3o+aYbNlruTNty4qa4AbzUoyYWlo=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 66B398B76F;
        Sun,  9 Feb 2020 12:05:18 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id NbJ8fhf_lVMn; Sun,  9 Feb 2020 12:05:18 +0100 (CET)
Received: from [192.168.4.90] (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id E11548B755;
        Sun,  9 Feb 2020 12:05:17 +0100 (CET)
Subject: Re: [PATCH] powerpc/hugetlb: Fix 8M hugepages on 8xx
From:   Christophe Leroy <christophe.leroy@c-s.fr>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        aneesh.kumar@linux.ibm.com
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <e744db1529271d11a3fdcdf641617846907b6ffd.1580997012.git.christophe.leroy@c-s.fr>
Message-ID: <c55a9b41-bc6f-4521-f556-c3ddc6c5d968@c-s.fr>
Date:   Sun, 9 Feb 2020 12:05:17 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <e744db1529271d11a3fdcdf641617846907b6ffd.1580997012.git.christophe.leroy@c-s.fr>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 06/02/2020 à 14:50, Christophe Leroy a écrit :
> Commit 55c8fc3f4930 ("powerpc/8xx: reintroduce 16K pages with HW
> assistance") redefined pte_t as a struct of 4 pte_basic_t, because
> in 16K pages mode there are four identical entries in the page table.
> But hugepd entries for 8k pages require only one entrie of size
> pte_basic_t. So there is no point in creating a cache for 4 entries
> page tables.
> 
> Also, with HW assistance the entries must be 4k aligned, the 8xx
> drops the last 12 bits. Redefine HUGEPD_SHIFT_MASK to mask them out.
> 
> Calculate PTE_T_ORDER using the size of pte_basic_t instead of pte_t.
> 
> In 16k mode, define a specific set_huge_pte_at() function which writes
> the pte in a single entry instead of using set_pte_at() which writes
> 4 identical entries. Define set_pte_filter() inline otherwise GCC
> doesn't inline it anymore because it is now used twice, and that gives
> a pretty suboptimal code because of pte_t being a struct of 4 entries.
> This function is also used for 512k pages which only require one entry
> as well allthough replicating it four times is harmless as 512k pages
> entries are spread every 128 bytes in the table.

That's not enough. We also need to change huge_ptep_set_access_flags(), 
huge_pte_clear(), huge_ptep_set_wrprotect() and huge_ptep_get_and_clear()

Will leave it as is at the time being, in parallele I'm working on 
getting rid of CONFIG_PPC_MM_SLICES for the 8xx and that fix that.

Christophe

> 
> Fixes: 22569b881d37 ("powerpc/8xx: Enable 8M hugepage support with HW assistance")
> Cc: stable@vger.kernel.org
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
> ---
>   arch/powerpc/include/asm/hugetlb.h |  5 +++++
>   arch/powerpc/include/asm/page.h    |  5 +++++
>   arch/powerpc/mm/hugetlbpage.c      |  3 ++-
>   arch/powerpc/mm/pgtable.c          | 19 ++++++++++++++++++-
>   4 files changed, 30 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/powerpc/include/asm/hugetlb.h b/arch/powerpc/include/asm/hugetlb.h
> index bd6504c28c2f..f43cfbcf014f 100644
> --- a/arch/powerpc/include/asm/hugetlb.h
> +++ b/arch/powerpc/include/asm/hugetlb.h
> @@ -64,6 +64,11 @@ static inline void arch_clear_hugepage_flags(struct page *page)
>   {
>   }
>   
> +#if defined(CONFIG_PPC_8xx) && defined(CONFIG_PPC_16K_PAGES)
> +#define __HAVE_ARCH_HUGE_SET_HUGE_PTE_AT
> +void set_huge_pte_at(struct mm_struct *mm, unsigned long addr, pte_t *ptep, pte_t pte);
> +#endif
> +
>   #include <asm-generic/hugetlb.h>
>   
>   #else /* ! CONFIG_HUGETLB_PAGE */
> diff --git a/arch/powerpc/include/asm/page.h b/arch/powerpc/include/asm/page.h
> index 86332080399a..080a0bf8e54b 100644
> --- a/arch/powerpc/include/asm/page.h
> +++ b/arch/powerpc/include/asm/page.h
> @@ -295,8 +295,13 @@ static inline bool pfn_valid(unsigned long pfn)
>   /*
>    * Some number of bits at the level of the page table that points to
>    * a hugepte are used to encode the size.  This masks those bits.
> + * On 8xx, HW assistance requires 4k alignment for the hugepte.
>    */
> +#ifdef CONFIG_PPC_8xx
> +#define HUGEPD_SHIFT_MASK     0xfff
> +#else
>   #define HUGEPD_SHIFT_MASK     0x3f
> +#endif
>   
>   #ifndef __ASSEMBLY__
>   
> diff --git a/arch/powerpc/mm/hugetlbpage.c b/arch/powerpc/mm/hugetlbpage.c
> index 73d4873fc7f8..c61032580185 100644
> --- a/arch/powerpc/mm/hugetlbpage.c
> +++ b/arch/powerpc/mm/hugetlbpage.c
> @@ -30,7 +30,8 @@ bool hugetlb_disabled = false;
>   
>   #define hugepd_none(hpd)	(hpd_val(hpd) == 0)
>   
> -#define PTE_T_ORDER	(__builtin_ffs(sizeof(pte_t)) - __builtin_ffs(sizeof(void *)))
> +#define PTE_T_ORDER	(__builtin_ffs(sizeof(pte_basic_t)) - \
> +			 __builtin_ffs(sizeof(void *)))
>   
>   pte_t *huge_pte_offset(struct mm_struct *mm, unsigned long addr, unsigned long sz)
>   {
> diff --git a/arch/powerpc/mm/pgtable.c b/arch/powerpc/mm/pgtable.c
> index e3759b69f81b..7a38eaa6ca72 100644
> --- a/arch/powerpc/mm/pgtable.c
> +++ b/arch/powerpc/mm/pgtable.c
> @@ -100,7 +100,7 @@ static pte_t set_pte_filter_hash(pte_t pte) { return pte; }
>    * as we don't have two bits to spare for _PAGE_EXEC and _PAGE_HWEXEC so
>    * instead we "filter out" the exec permission for non clean pages.
>    */
> -static pte_t set_pte_filter(pte_t pte)
> +static inline pte_t set_pte_filter(pte_t pte)
>   {
>   	struct page *pg;
>   
> @@ -259,6 +259,23 @@ int huge_ptep_set_access_flags(struct vm_area_struct *vma,
>   	return changed;
>   #endif
>   }
> +
> +#if defined(CONFIG_PPC_8xx) && defined(CONFIG_PPC_16K_PAGES)
> +void set_huge_pte_at(struct mm_struct *mm, unsigned long addr, pte_t *ptep, pte_t pte)
> +{
> +	/*
> +	 * Make sure hardware valid bit is not set. We don't do
> +	 * tlb flush for this update.
> +	 */
> +	VM_WARN_ON(pte_hw_valid(*ptep) && !pte_protnone(*ptep));
> +
> +	pte = pte_mkpte(pte);
> +
> +	pte = set_pte_filter(pte);
> +
> +	ptep->pte = pte_val(pte);
> +}
> +#endif
>   #endif /* CONFIG_HUGETLB_PAGE */
>   
>   #ifdef CONFIG_DEBUG_VM
> 
