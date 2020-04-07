Return-Path: <SRS0=z/zp=5X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A9BFC2BA16
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 05:09:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46BED206F7
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 05:09:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726767AbgDGFJH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Apr 2020 01:09:07 -0400
Received: from relay10.mail.gandi.net ([217.70.178.230]:43629 "EHLO
        relay10.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726399AbgDGFJG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 01:09:06 -0400
Received: from [192.168.1.101] (lfbn-lyo-1-453-25.w2-7.abo.wanadoo.fr [2.7.45.25])
        (Authenticated sender: alex@ghiti.fr)
        by relay10.mail.gandi.net (Postfix) with ESMTPSA id 657E0240005;
        Tue,  7 Apr 2020 05:09:03 +0000 (UTC)
From:   Alex Ghiti <alex@ghiti.fr>
Subject: Re: [PATCH RFC 2/8] riscv/kaslr: introduce functions to clear page
 table
To:     Zong Li <zong.li@sifive.com>, palmer@dabbelt.com,
        paul.walmsley@sifive.com, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <cover.1584352425.git.zong.li@sifive.com>
 <286a940ef8fbc4480c63679271eea440d167a258.1584352425.git.zong.li@sifive.com>
Message-ID: <507f88a2-63c0-f615-2684-a200dd44c34a@ghiti.fr>
Date:   Tue, 7 Apr 2020 01:09:02 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <286a940ef8fbc4480c63679271eea440d167a258.1584352425.git.zong.li@sifive.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/24/20 3:30 AM, Zong Li wrote:
> In KASLR, we need to re-create page table after getting a random
> destination. Introduce clear function to clear old content. Also, the
> page table entries allow writing value when it's empty, so we have to
> clear the early page table.
> 
> This patch is a preparation to support KASLR.
> 
> Signed-off-by: Zong Li <zong.li@sifive.com>
> ---
>   arch/riscv/mm/init.c | 54 ++++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 54 insertions(+)
> 
> diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
> index ace5d74fd939..51e263c04fa2 100644
> --- a/arch/riscv/mm/init.c
> +++ b/arch/riscv/mm/init.c
> @@ -315,6 +315,7 @@ static void __init create_pmd_mapping(pmd_t *pmdp,
>   #define get_pgd_next_virt(__pa)	get_pmd_virt(__pa)
>   #define create_pgd_next_mapping(__nextp, __va, __pa, __sz, __prot)	\
>   	create_pmd_mapping(__nextp, __va, __pa, __sz, __prot)
> +#define clear_pgd_next_mapping(__nextp)	clear_pmd(__nextp)
>   #define fixmap_pgd_next		fixmap_pmd
>   #else
>   #define pgd_next_t		pte_t
> @@ -322,6 +323,7 @@ static void __init create_pmd_mapping(pmd_t *pmdp,
>   #define get_pgd_next_virt(__pa)	get_pte_virt(__pa)
>   #define create_pgd_next_mapping(__nextp, __va, __pa, __sz, __prot)	\
>   	create_pte_mapping(__nextp, __va, __pa, __sz, __prot)
> +#define clear_pgd_next_mapping(__nextp)	clear_pte(__nextp)
>   #define fixmap_pgd_next		fixmap_pte
>   #endif
>   
> @@ -361,6 +363,58 @@ static uintptr_t __init best_map_size(phys_addr_t base, phys_addr_t size)
>   	return PMD_SIZE;
>   }
>   
> +#ifdef CONFIG_RANDOMIZE_BASE
> +static void __init clear_pte(pte_t *ptep)
> +{
> +	unsigned int i;
> +
> +	for (i = 0; i < PTRS_PER_PTE; i++)
> +		if (!pte_none(ptep[i]))
> +			ptep[i] = __pte(0);
> +}
> +
> +static void __init clear_pmd(pmd_t *pmdp)
> +{
> +	unsigned int i;
> +	pte_t *ptep;
> +	phys_addr_t pte_phys;
> +	uintptr_t kaslr_offset = get_kaslr_offset();
> +
> +	for (i = 0; i < PTRS_PER_PMD; i++)
> +		if (!pmd_none(pmdp[i])) {
> +			if (pmd_leaf(pmdp[i])) {
> +				pmd_clear(&pmdp[i]);
> +			} else {
> +				pte_phys = PFN_PHYS(_pmd_pfn(pmdp[i]));
> +				ptep = get_pte_virt(pte_phys + kaslr_offset);
> +				clear_pte(ptep);
> +				pmd_clear(&pmdp[i]);
> +			}
> +		}
> +}
> +
> +static void __init clear_pgd(pgd_t *pgdp)
> +{
> +	unsigned int i;
> +	pgd_next_t *nextp;
> +	phys_addr_t next_phys;
> +	uintptr_t kaslr_offset = get_kaslr_offset();
> +
> +	for (i = 0; i < PTRS_PER_PGD; i++)
> +		if (pgd_val(pgdp[i]) != 0) {
> +			if (pgd_leaf(pgd_val(pgdp[i]))) {
> +				set_pgd(&pgdp[i], __pgd(0));
> +			} else {
> +				next_phys = PFN_PHYS(_pgd_pfn(pgdp[i]));
> +				nextp = get_pgd_next_virt(next_phys +
> +							  kaslr_offset);
> +				clear_pgd_next_mapping(nextp);
> +				set_pgd(&pgdp[i], __pgd(0));
> +			}
> +		}
> +}
> +#endif
> +
>   /*
>    * setup_vm() is called from head.S with MMU-off.
>    *
> 

If this is only for clearing early page tables, a memset is way easier 
as there is only one page per level to clear.

Alex
