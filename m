Return-Path: <SRS0=iZC5=5S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50578C10F26
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 10:19:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A0F42077D
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 10:19:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="IUpg5kiP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387965AbgDBKTX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Apr 2020 06:19:23 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:32103 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728135AbgDBKTW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 06:19:22 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 48tJvW28wWz9txXF;
        Thu,  2 Apr 2020 12:19:19 +0200 (CEST)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=IUpg5kiP; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id Yjz7IgmAzaAj; Thu,  2 Apr 2020 12:19:19 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 48tJvW0xcFz9txX0;
        Thu,  2 Apr 2020 12:19:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1585822759; bh=PlmUTdpMIrJzpaiSJTBQgMj7cnXxamyWLnCDK47mlYI=;
        h=Subject:From:To:Cc:References:Date:In-Reply-To:From;
        b=IUpg5kiPE+r/VtM0RhTVmrfOVaC/i8EsaaiY08m7L4iZ5O9iF7WdPqRhGOGwczMvu
         SwhamkcG6i9QuE00Q4GspqSefvoNd0Q+/yHPJOiHwAc+J8IEZH6Mp6fgBPfWFhxoZM
         bYcAWbk25ic6SJ7YiZIjHbIIl7ppHxlaq53ZksCk=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 37E1F8B8C6;
        Thu,  2 Apr 2020 12:19:20 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id pM3YlHv-9AW2; Thu,  2 Apr 2020 12:19:20 +0200 (CEST)
Received: from [192.168.4.90] (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 9462A8B75E;
        Thu,  2 Apr 2020 12:19:19 +0200 (CEST)
Subject: Re: [PATCH v1 06/46] powerpc/kasan: Refactor update of early shadow
 mappings
From:   Christophe Leroy <christophe.leroy@c-s.fr>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <cover.1584360343.git.christophe.leroy@c-s.fr>
 <5eb93a773184aa0d36faa93c096b21cbe0a069c9.1584360344.git.christophe.leroy@c-s.fr>
Message-ID: <18fb9f4b-d110-ee41-af44-09a1f5072ecf@c-s.fr>
Date:   Thu, 2 Apr 2020 12:19:13 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <5eb93a773184aa0d36faa93c096b21cbe0a069c9.1584360344.git.christophe.leroy@c-s.fr>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Michael,

Le 16/03/2020 à 13:35, Christophe Leroy a écrit :
> kasan_remap_early_shadow_ro() and kasan_unmap_early_shadow_vmalloc()
> are both updating the early shadow mapping: the first one sets
> the mapping read-only while the other clears the mapping.
> 
> Refactor and create kasan_update_early_region()

There is a trivial conflict with this patch on powerpc/next.
Do you plan to take this series for 5.7 ? I so, I can repost the series 
now with the fix, or just this patch ?

Otherwise, what are your plans ? This series (Patches 18 and 19) will 
conflict with the 40x removal series as both do things about that 
PTE_ATOMIC_UPDATE stuff. Which series would go first ?

Thanks
Christophe

> 
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
> ---
>   arch/powerpc/mm/kasan/kasan_init_32.c | 39 +++++++++++++--------------
>   1 file changed, 18 insertions(+), 21 deletions(-)
> 
> diff --git a/arch/powerpc/mm/kasan/kasan_init_32.c b/arch/powerpc/mm/kasan/kasan_init_32.c
> index c9d053078c37..65fd8b891f8e 100644
> --- a/arch/powerpc/mm/kasan/kasan_init_32.c
> +++ b/arch/powerpc/mm/kasan/kasan_init_32.c
> @@ -79,45 +79,42 @@ static int __init kasan_init_region(void *start, size_t size)
>   	return 0;
>   }
>   
> -static void __init kasan_remap_early_shadow_ro(void)
> +static void __init
> +kasan_update_early_region(unsigned long k_start, unsigned long k_end, pte_t pte)
>   {
> -	pgprot_t prot = kasan_prot_ro();
> -	unsigned long k_start = KASAN_SHADOW_START;
> -	unsigned long k_end = KASAN_SHADOW_END;
>   	unsigned long k_cur;
>   	phys_addr_t pa = __pa(kasan_early_shadow_page);
>   
> -	kasan_populate_pte(kasan_early_shadow_pte, prot);
> -
> -	for (k_cur = k_start & PAGE_MASK; k_cur < k_end; k_cur += PAGE_SIZE) {
> +	for (k_cur = k_start; k_cur < k_end; k_cur += PAGE_SIZE) {
>   		pmd_t *pmd = pmd_ptr_k(k_cur);
>   		pte_t *ptep = pte_offset_kernel(pmd, k_cur);
>   
>   		if ((pte_val(*ptep) & PTE_RPN_MASK) != pa)
>   			continue;
>   
> -		__set_pte_at(&init_mm, k_cur, ptep, pfn_pte(PHYS_PFN(pa), prot), 0);
> +		__set_pte_at(&init_mm, k_cur, ptep, pte, 0);
>   	}
> -	flush_tlb_kernel_range(KASAN_SHADOW_START, KASAN_SHADOW_END);
> +
> +	flush_tlb_kernel_range(k_start, k_end);
>   }
>   
> -static void __init kasan_unmap_early_shadow_vmalloc(void)
> +static void __init kasan_remap_early_shadow_ro(void)
>   {
> -	unsigned long k_start = (unsigned long)kasan_mem_to_shadow((void *)VMALLOC_START);
> -	unsigned long k_end = (unsigned long)kasan_mem_to_shadow((void *)VMALLOC_END);
> -	unsigned long k_cur;
> +	pgprot_t prot = kasan_prot_ro();
>   	phys_addr_t pa = __pa(kasan_early_shadow_page);
>   
> -	for (k_cur = k_start & PAGE_MASK; k_cur < k_end; k_cur += PAGE_SIZE) {
> -		pmd_t *pmd = pmd_offset(pud_offset(pgd_offset_k(k_cur), k_cur), k_cur);
> -		pte_t *ptep = pte_offset_kernel(pmd, k_cur);
> +	kasan_populate_pte(kasan_early_shadow_pte, prot);
>   
> -		if ((pte_val(*ptep) & PTE_RPN_MASK) != pa)
> -			continue;
> +	kasan_update_early_region(KASAN_SHADOW_START, KASAN_SHADOW_END,
> +				  pfn_pte(PHYS_PFN(pa), prot));
> +}
>   
> -		__set_pte_at(&init_mm, k_cur, ptep, __pte(0), 0);
> -	}
> -	flush_tlb_kernel_range(k_start, k_end);
> +static void __init kasan_unmap_early_shadow_vmalloc(void)
> +{
> +	unsigned long k_start = (unsigned long)kasan_mem_to_shadow((void *)VMALLOC_START);
> +	unsigned long k_end = (unsigned long)kasan_mem_to_shadow((void *)VMALLOC_END);
> +
> +	kasan_update_early_region(k_start, k_end, __pte(0));
>   }
>   
>   static void __init kasan_mmu_init(void)
> 
