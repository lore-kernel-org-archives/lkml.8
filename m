Return-Path: <SRS0=5pK+=BB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90C64C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 06:08:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6B710207BB
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 06:08:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727990AbgGVGIo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 02:08:44 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:8182 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726147AbgGVGIo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 02:08:44 -0400
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 06M5WjHE026378;
        Wed, 22 Jul 2020 02:07:13 -0400
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 32bvqwa3hx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 22 Jul 2020 02:07:13 -0400
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 06M64nEL013635;
        Wed, 22 Jul 2020 06:07:11 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma04ams.nl.ibm.com with ESMTP id 32brq84p1h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 22 Jul 2020 06:07:11 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 06M679iP51445850
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 22 Jul 2020 06:07:09 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EEBC7A4054;
        Wed, 22 Jul 2020 06:07:08 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9F133A405C;
        Wed, 22 Jul 2020 06:07:07 +0000 (GMT)
Received: from linux.ibm.com (unknown [9.148.205.118])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Wed, 22 Jul 2020 06:07:07 +0000 (GMT)
Date:   Wed, 22 Jul 2020 09:07:05 +0300
From:   Mike Rapoport <rppt@linux.ibm.com>
To:     Wei Li <liwei213@huawei.com>
Cc:     catalin.marinas@arm.com, will@kernel.org,
        saberlily.xia@hisilicon.com, puck.chen@hisilicon.com,
        butao@hisilicon.com, fengbaopeng2@hisilicon.com,
        nsaenzjulienne@suse.de, steve.capper@arm.com,
        song.bao.hua@hisilicon.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, sujunfei2@hisilicon.com
Subject: Re: [PATCH] arm64: mm: free unused memmap for sparse memory model
 that define VMEMMAP
Message-ID: <20200722060705.GK802087@linux.ibm.com>
References: <20200721073203.107862-1-liwei213@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200721073203.107862-1-liwei213@huawei.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-22_02:2020-07-22,2020-07-22 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 spamscore=0
 bulkscore=0 impostorscore=0 malwarescore=0 mlxscore=0 lowpriorityscore=0
 suspectscore=5 adultscore=0 clxscore=1011 phishscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007220040
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Jul 21, 2020 at 03:32:03PM +0800, Wei Li wrote:
> For the memory hole, sparse memory model that define SPARSEMEM_VMEMMAP
> do not free the reserved memory for the page map, this patch do it.

Are there numbers showing how much memory is actually freed?

The freeing of empty memmap would become rather complex with these
changes, do the memory savings justify it?

> Signed-off-by: Wei Li <liwei213@huawei.com>
> Signed-off-by: Chen Feng <puck.chen@hisilicon.com>
> Signed-off-by: Xia Qing <saberlily.xia@hisilicon.com>
> ---
>  arch/arm64/mm/init.c | 81 +++++++++++++++++++++++++++++++++++++++++++++-------
>  1 file changed, 71 insertions(+), 10 deletions(-)
> 
> diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
> index 1e93cfc7c47a..d1b56b47d5ba 100644
> --- a/arch/arm64/mm/init.c
> +++ b/arch/arm64/mm/init.c
> @@ -441,7 +441,48 @@ void __init bootmem_init(void)
>  	memblock_dump_all();
>  }
> 
> -#ifndef CONFIG_SPARSEMEM_VMEMMAP
> +#ifdef CONFIG_SPARSEMEM_VMEMMAP
> +#define VMEMMAP_PAGE_INUSE 0xFD
> +static inline void free_memmap(unsigned long start_pfn, unsigned long end_pfn)
> +{
> +	unsigned long addr, end;
> +	unsigned long next;
> +	pmd_t *pmd;
> +	void *page_addr;
> +	phys_addr_t phys_addr;
> +
> +	addr = (unsigned long)pfn_to_page(start_pfn);
> +	end = (unsigned long)pfn_to_page(end_pfn);
> +
> +	pmd = pmd_offset(pud_offset(pgd_offset_k(addr), addr), addr);
> +	for (; addr < end; addr = next, pmd++) {
> +		next = pmd_addr_end(addr, end);
> +
> +		if (!pmd_present(*pmd))
> +			continue;
> +
> +		if (IS_ALIGNED(addr, PMD_SIZE) &&
> +			IS_ALIGNED(next, PMD_SIZE)) {
> +			phys_addr = __pfn_to_phys(pmd_pfn(*pmd));
> +			free_bootmem(phys_addr, PMD_SIZE);
> +			pmd_clear(pmd);
> +		} else {
> +			/* If here, we are freeing vmemmap pages. */
> +			memset((void *)addr, VMEMMAP_PAGE_INUSE, next - addr);
> +			page_addr = page_address(pmd_page(*pmd));
> +
> +			if (!memchr_inv(page_addr, VMEMMAP_PAGE_INUSE,
> +				PMD_SIZE)) {
> +				phys_addr = __pfn_to_phys(pmd_pfn(*pmd));
> +				free_bootmem(phys_addr, PMD_SIZE);
> +				pmd_clear(pmd);
> +			}
> +		}
> +	}
> +
> +	flush_tlb_all();
> +}
> +#else
>  static inline void free_memmap(unsigned long start_pfn, unsigned long end_pfn)
>  {
>  	struct page *start_pg, *end_pg;
> @@ -468,31 +509,53 @@ static inline void free_memmap(unsigned long start_pfn, unsigned long end_pfn)
>  		memblock_free(pg, pgend - pg);
>  }
> 
> +#endif
> +
>  /*
>   * The mem_map array can get very big. Free the unused area of the memory map.
>   */
>  static void __init free_unused_memmap(void)
>  {
> -	unsigned long start, prev_end = 0;
> +	unsigned long start, cur_start, prev_end = 0;
>  	struct memblock_region *reg;
> 
>  	for_each_memblock(memory, reg) {
> -		start = __phys_to_pfn(reg->base);
> +		cur_start = __phys_to_pfn(reg->base);
> 
>  #ifdef CONFIG_SPARSEMEM
>  		/*
>  		 * Take care not to free memmap entries that don't exist due
>  		 * to SPARSEMEM sections which aren't present.
>  		 */
> -		start = min(start, ALIGN(prev_end, PAGES_PER_SECTION));
> -#endif
> +		start = min(cur_start, ALIGN(prev_end, PAGES_PER_SECTION));
> +
>  		/*
> -		 * If we had a previous bank, and there is a space between the
> -		 * current bank and the previous, free it.
> +		 * Free memory in the case of:
> +		 * 1. if cur_start - prev_end <= PAGES_PER_SECTION,
> +		 * free pre_end ~ cur_start.
> +		 * 2. if cur_start - prev_end > PAGES_PER_SECTION,
> +		 * free pre_end ~ ALIGN(prev_end, PAGES_PER_SECTION).
>  		 */
>  		if (prev_end && prev_end < start)
>  			free_memmap(prev_end, start);
> 
> +		/*
> +		 * Free memory in the case of:
> +		 * if cur_start - prev_end > PAGES_PER_SECTION,
> +		 * free ALIGN_DOWN(cur_start, PAGES_PER_SECTION) ~ cur_start.
> +		 */
> +		if (cur_start > start &&
> +		    !IS_ALIGNED(cur_start, PAGES_PER_SECTION))
> +			free_memmap(ALIGN_DOWN(cur_start, PAGES_PER_SECTION),
> +				    cur_start);
> +#else
> +		/*
> +		 * If we had a previous bank, and there is a space between the
> +		 * current bank and the previous, free it.
> +		 */
> +		if (prev_end && prev_end < cur_start)
> +			free_memmap(prev_end, cur_start);
> +#endif
>  		/*
>  		 * Align up here since the VM subsystem insists that the
>  		 * memmap entries are valid from the bank end aligned to
> @@ -507,7 +570,6 @@ static void __init free_unused_memmap(void)
>  		free_memmap(prev_end, ALIGN(prev_end, PAGES_PER_SECTION));
>  #endif
>  }
> -#endif	/* !CONFIG_SPARSEMEM_VMEMMAP */
> 
>  /*
>   * mem_init() marks the free areas in the mem_map and tells us how much memory
> @@ -524,9 +586,8 @@ void __init mem_init(void)
> 
>  	set_max_mapnr(max_pfn - PHYS_PFN_OFFSET);
> 
> -#ifndef CONFIG_SPARSEMEM_VMEMMAP
>  	free_unused_memmap();
> -#endif
> +
>  	/* this will put all unused low memory onto the freelists */
>  	memblock_free_all();
> 
> --
> 2.15.0
> 

-- 
Sincerely yours,
Mike.
