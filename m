Return-Path: <SRS0=3W8M=6B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2603C2D0EF
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 00:52:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7A55821841
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 00:52:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=NextfourGroupOy.onmicrosoft.com header.i=@NextfourGroupOy.onmicrosoft.com header.b="ckV3f4XP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728653AbgDQAwh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 20:52:37 -0400
Received: from mail-eopbgr00079.outbound.protection.outlook.com ([40.107.0.79]:48862
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728485AbgDQAwg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 20:52:36 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b8dLNxXg0YGPgg1lgZ6mj9r61iZUrbxrQyLXicTiiBHWX6u9GMrIqZo6KSdqfBJ0/JqEnV/8YrOjc9VVdNN6Wn0PgMNtEAPb8OY7D7BRRYJznC+PgFBCXm/HxcIlaO03mYM3LKQ1yFgbsstWQ0FRmQGdbvtYIetCSzvL0y7zzjxMd9XWWT55pDW2ltxSvDgmzeqtC1wQKmWLXSWckxG/UW4qmf4SoHU79M5dEjqtdKKC4y80aZGdg+Ab5jeD5hyWzI3nikRBZM82tHVq8rN1Jdwo1Kk118t60IP3k30O9n9MAUHMOjhAR4BhR/qZPNmASIiM4FunzM9DGXNVsABjhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sx58auSit2PpFQd9HvQHzcUCuKLnVNwupO5QCV6BA40=;
 b=THe6HO+hwWQuwQdbJY2ipVHqdy8/oOZcHO+Z/OWYv89w9IaO8I/N+KpcnAcDoQaVcqcyTjpODeaQixcUCxCG3ToEHUj8bVkV5ikGKEqUPbAB1or49X6YiA9vnWxjMQMWj8n0FoQJnWzhFhE9cdei8Zmduflv9vY4PdoGQa4Q1gTzjfYb0dKy2UQx4u0wnP0y5OtukPVPukHBZvr8NUWHLDDTXEj9j5iBXRSaADU8pAH0hjSLpIFJgM5EEkguBTfJ7KQVAPNanokedUHHwCuPZI6um01LmFuUueQ91hKsKcEQ2qtICufpKlvqF8uu9anJ/mlmW4GxTuQB5snGf36/PA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nextfour.com; dmarc=pass action=none header.from=nextfour.com;
 dkim=pass header.d=nextfour.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=NextfourGroupOy.onmicrosoft.com;
 s=selector2-NextfourGroupOy-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sx58auSit2PpFQd9HvQHzcUCuKLnVNwupO5QCV6BA40=;
 b=ckV3f4XPB4BfYkE3b75RYk4cE7DS/mBRl04rhNZ2ITJBm596Xtn3wpF0AVCI1VadWf7S/v2XeuStRmXJGJX2W2uFIkuMvN0vBGYgAH49ogmZArYouQOMb8W8qywwaSdR+9/Lg1ko8WaCUkSJm9BlqUA1d2pGSNxPBKw3tuPkHs8=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=mika.penttila@nextfour.com; 
Received: from HE1PR0302MB2682.eurprd03.prod.outlook.com (2603:10a6:3:f5::14)
 by HE1PR0302MB2796.eurprd03.prod.outlook.com (2603:10a6:3:e9::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.25; Fri, 17 Apr
 2020 00:52:30 +0000
Received: from HE1PR0302MB2682.eurprd03.prod.outlook.com
 ([fe80::b10a:8b9d:1a18:6b2]) by HE1PR0302MB2682.eurprd03.prod.outlook.com
 ([fe80::b10a:8b9d:1a18:6b2%9]) with mapi id 15.20.2900.028; Fri, 17 Apr 2020
 00:52:30 +0000
Subject: Re: [PATCH, RFC] x86/mm/pat: Restore large pages after fragmentation
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>
Cc:     x86@kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20200416213229.19174-1-kirill.shutemov@linux.intel.com>
From:   =?UTF-8?Q?Mika_Penttil=c3=a4?= <mika.penttila@nextfour.com>
Message-ID: <0a28e6e8-3f18-0bbb-a4d0-ee88060f7e90@nextfour.com>
Date:   Fri, 17 Apr 2020 03:52:28 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
In-Reply-To: <20200416213229.19174-1-kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: HE1P195CA0008.EURP195.PROD.OUTLOOK.COM (2603:10a6:3:fd::18)
 To HE1PR0302MB2682.eurprd03.prod.outlook.com (2603:10a6:3:f5::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.121] (91.145.109.188) by HE1P195CA0008.EURP195.PROD.OUTLOOK.COM (2603:10a6:3:fd::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.25 via Frontend Transport; Fri, 17 Apr 2020 00:52:29 +0000
X-Originating-IP: [91.145.109.188]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9605fac6-cff8-4811-79a4-08d7e2699b2c
X-MS-TrafficTypeDiagnostic: HE1PR0302MB2796:
X-Microsoft-Antispam-PRVS: <HE1PR0302MB2796774468C6876F8144CFF783D90@HE1PR0302MB2796.eurprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3826;
X-Forefront-PRVS: 0376ECF4DD
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0302MB2682.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10009020)(39830400003)(396003)(346002)(366004)(136003)(376002)(52116002)(86362001)(4326008)(31696002)(2616005)(2906002)(186003)(26005)(16526019)(6486002)(956004)(508600001)(966005)(36756003)(16576012)(7416002)(8676002)(81156014)(31686004)(316002)(66476007)(66556008)(110136005)(8936002)(66946007)(5660300002);DIR:OUT;SFP:1101;
Received-SPF: None (protection.outlook.com: nextfour.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TQw6vg+bCH+pP1DUzWPcXjyFP4s8F2IinOa0B3nG8AgYl5CCPj6XlfeU5/D0mPpUPCmnoN1bCDajpy+ehCZ4GvUIkb5Z6n9/smpqrIqzYYsjTQ5bDQYIg6ut5lKi/gX6a7wmMi9bw7EDHRvCtTPPtJSbZw1lMh/xsAYsCfE+dXYMq7vCOI2vQFJnSaM2NdV7sy/bUUDiiY6mOLsDNGYTN4IceH7LrhdWtb5GUSHHA/4wzkG2mzwAmIWosgXVnQtih9nklSYixSCNjSYPn+Z//GlCsBsJSyZWLfK//IR0Ubw4l3peBBytpdbEbHLyDxuP0yWFlkUYk9ZsXPWRNJA8fAQaTpjU3QMLrGlfeWyQdsRP1R5y3AhRTwJpxpCXZSe0MXO6q1kT374QiV7NV/2AO59Ju5P3gIyooWTxaJ+fTb8RaVp2uuIPUYRV1ufey/SgMYUURiPL3jfhxUh45rTJLIcB/2FH3C42V3te56fmkZm0brDczKqdX2lnTyC4FOrvMRgoVuTM4Bo5PWrfvytDVQ==
X-MS-Exchange-AntiSpam-MessageData: P5vGhhhXUrJpfMJbg03rnz8oZfsHDpug/IWaHKEElvfMwplcZOSXq+3Xm0w0fKvbyDWc9Fofn8Fu0YBvhjO2pI1Lm3xU53yFr2IR2wybUjCdcnK5FkWpXmaRR2yXakOLTXT8B1y2E6QQcMrZe8+Ygg==
X-OriginatorOrg: nextfour.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9605fac6-cff8-4811-79a4-08d7e2699b2c
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2020 00:52:30.1310
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 972e95c2-9290-4a02-8705-4014700ea294
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VOPViH13XhiRe7+EUfA3on+eyBYR8bi7msOEWUj0QG07QAueYQPab/8UIfhS1W4ZKnSfV2QlH47Rd92hQ1N2OaBPXzDh4M9Fgz2GERCfeQc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0302MB2796
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

On 17.4.2020 0.32, Kirill A. Shutemov wrote:
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
>
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
>
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> ---
>   arch/x86/include/asm/pgtable_types.h |   2 +
>   arch/x86/mm/pat/set_memory.c         | 191 ++++++++++++++++++++++++++-
>   2 files changed, 188 insertions(+), 5 deletions(-)
>
> diff --git a/arch/x86/include/asm/pgtable_types.h b/arch/x86/include/asm/pgtable_types.h
> index b6606fe6cfdf..11ed34804343 100644
> --- a/arch/x86/include/asm/pgtable_types.h
> +++ b/arch/x86/include/asm/pgtable_types.h
> @@ -34,6 +34,7 @@
>   #define _PAGE_BIT_CPA_TEST	_PAGE_BIT_SOFTW1
>   #define _PAGE_BIT_UFFD_WP	_PAGE_BIT_SOFTW2 /* userfaultfd wrprotected */
>   #define _PAGE_BIT_SOFT_DIRTY	_PAGE_BIT_SOFTW3 /* software dirty tracking */
> +#define _PAGE_BIT_KERNEL_4K	_PAGE_BIT_SOFTW3 /* page must not be converted to large */
>   #define _PAGE_BIT_DEVMAP	_PAGE_BIT_SOFTW4
>   
>   /* If _PAGE_BIT_PRESENT is clear, we use these: */
> @@ -56,6 +57,7 @@
>   #define _PAGE_PAT_LARGE (_AT(pteval_t, 1) << _PAGE_BIT_PAT_LARGE)
>   #define _PAGE_SPECIAL	(_AT(pteval_t, 1) << _PAGE_BIT_SPECIAL)
>   #define _PAGE_CPA_TEST	(_AT(pteval_t, 1) << _PAGE_BIT_CPA_TEST)
> +#define _PAGE_KERNEL_4K	(_AT(pteval_t, 1) << _PAGE_BIT_KERNEL_4K)
>   #ifdef CONFIG_X86_INTEL_MEMORY_PROTECTION_KEYS
>   #define _PAGE_PKEY_BIT0	(_AT(pteval_t, 1) << _PAGE_BIT_PKEY_BIT0)
>   #define _PAGE_PKEY_BIT1	(_AT(pteval_t, 1) << _PAGE_BIT_PKEY_BIT1)
> diff --git a/arch/x86/mm/pat/set_memory.c b/arch/x86/mm/pat/set_memory.c
> index 5414fabad1ae..7cb04a436d86 100644
> --- a/arch/x86/mm/pat/set_memory.c
> +++ b/arch/x86/mm/pat/set_memory.c
> @@ -344,22 +344,56 @@ static void __cpa_flush_tlb(void *data)
>   		__flush_tlb_one_kernel(fix_addr(__cpa_addr(cpa, i)));
>   }
>   
> +static void restore_large_pages(unsigned long addr, struct list_head *pgtables);
> +
> +static void cpa_restore_large_pages(struct cpa_data *cpa,
> +		struct list_head *pgtables)
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
> +		restore_large_pages(addr, pgtables);
> +}
> +
>   static void cpa_flush(struct cpa_data *data, int cache)
>   {
> +	LIST_HEAD(pgtables);
> +	struct page *page, *tmp;
>   	struct cpa_data *cpa = data;
>   	unsigned int i;
>   
>   	BUG_ON(irqs_disabled() && !early_boot_irqs_disabled);
>   
> +	cpa_restore_large_pages(data, &pgtables);
> +
>   	if (cache && !static_cpu_has(X86_FEATURE_CLFLUSH)) {
>   		cpa_flush_all(cache);
> +		list_for_each_entry_safe(page, tmp, &pgtables, lru) {
> +			list_del(&page->lru);
> +			__free_page(page);
> +		}
>   		return;
>   	}
>   
> -	if (cpa->numpages <= tlb_single_page_flush_ceiling)
> -		on_each_cpu(__cpa_flush_tlb, cpa, 1);
> -	else
> +	if (cpa->numpages > tlb_single_page_flush_ceiling || !list_empty(&pgtables))
>   		flush_tlb_all();
> +	else
> +		on_each_cpu(__cpa_flush_tlb, cpa, 1);
> +
> +	list_for_each_entry_safe(page, tmp, &pgtables, lru) {
> +		list_del(&page->lru);
> +		__free_page(page);
> +	}


The pagetable pages are freed here but ren't you leaking the leaf 4K 
pages (except the first which is made large)?


>   
>   	if (!cache)
>   		return;
> @@ -1075,6 +1109,153 @@ static int split_large_page(struct cpa_data *cpa, pte_t *kpte,
>   	return 0;
>   }
>   
> +static void restore_pmd_page(pmd_t *pmd, unsigned long addr,
> +		struct list_head *pgtables)
> +{
> +	pgprot_t pgprot;
> +	pmd_t _pmd, old_pmd;
> +	pte_t *pte, first;
> +	int i = 0;
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
> +}
> +
> +static void restore_pud_page(pud_t *pud, unsigned long addr,
> +		struct list_head *pgtables)
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
> +
>   static bool try_to_free_pte_page(pte_t *pte)
>   {
>   	int i;
> @@ -1948,8 +2129,8 @@ int set_memory_np_noalias(unsigned long addr, int numpages)
>   
>   int set_memory_4k(unsigned long addr, int numpages)
>   {
> -	return change_page_attr_set_clr(&addr, numpages, __pgprot(0),
> -					__pgprot(0), 1, 0, NULL);
> +	return change_page_attr_set_clr(&addr, numpages,
> +			__pgprot(_PAGE_KERNEL_4K), __pgprot(0), 1, 0, NULL);
>   }
>   
>   int set_memory_nonglobal(unsigned long addr, int numpages)

--Mika



